#!/usr/bin/env python3
"""
Pre-commit hook: Terraform env variables consistency checker.

For every terraform folder (module directory) that has an 'env' subfolder:
  1. Parse the parent 99_variables.tf to extract all declared variable names
  2. For each env subfolder (dev, prod, uat, etc.), check the terraform.tfvars file
  3. If a TOP-LEVEL variable is set in terraform.tfvars but NOT defined in 99_variables.tf,
     remove it (modifies in-place)
  4. Report violations and modified files

IMPORTANT: Only TOP-LEVEL variable assignments are checked. Nested properties within
objects/maps/lists are never considered as separate variables and are always preserved.

For example:
  ✗ REMOVED: config = {...} (if "config" is not declared)
  ✓ PRESERVED: All properties inside {key = value} blocks (they are part of the value)
"""

import os
import re
import subprocess
import sys
from pathlib import Path
from typing import List, Set, Tuple

# Root of the repository
REPO_ROOT = Path(__file__).resolve().parent.parent

# Directory names to skip entirely during traversal
EXCLUDED_DIRS = {".git", ".terraform", ".venv", "__pycache__"}

# Matches a `variable "name" {` block opener to extract variable names
VARIABLE_BLOCK_RE = re.compile(r'^\s*variable\s+"([^"]+)"\s*\{', re.MULTILINE)

# Pattern to match variable assignment in terraform.tfvars files
# Matches: variable_name = value (can be multiline for complex values)
# This captures the full assignment including complex types
VAR_ASSIGNMENT_RE = re.compile(
  r'^\s*([a-zA-Z_][a-zA-Z0-9_]*)\s*=\s*',
  re.MULTILINE
)


def is_module_dir(path: Path) -> bool:
  """Return True if *path* contains at least one .tf file at its root."""
  return any(p.suffix == ".tf" for p in path.iterdir() if p.is_file())


def find_module_dirs(root: Path) -> List[Path]:
  """
  Walk *root* recursively and return all module directories found.
  Skips hidden directories, directories named `tests`, and entries in EXCLUDED_DIRS.
  """
  modules: List[Path] = []

  for dirpath, dirnames, _ in os.walk(root):
    current = Path(dirpath)

    # Prune traversal in-place: remove dirs we never want to descend into.
    dirnames[:] = sorted(
      d
      for d in dirnames
      if d not in EXCLUDED_DIRS and not d.startswith(".") and d != "tests"
    )

    if current == root:
      continue  # Don't treat the repo root itself as a module

    if is_module_dir(current):
      modules.append(current)

  return sorted(modules)


def read_file(path: Path) -> str:
  """Read file content safely."""
  try:
    return path.read_text(encoding="utf-8")
  except OSError as exc:
    print(f"  WARNING: cannot read {path}: {exc}", file=sys.stderr)
    return ""


def extract_declared_variables(variables_file: Path) -> Set[str]:
  """Extract all variable names declared in a 99_variables.tf file."""
  if not variables_file.is_file():
    return set()

  content = read_file(variables_file)
  matches = VARIABLE_BLOCK_RE.findall(content)
  return set(matches)


def extract_assigned_variables(tfvars_file: Path) -> Set[str]:
  """
  Extract all top-level variable names assigned in a terraform.tfvars file.
  Only extracts variables that start at column 0 (no leading whitespace),
  ignoring nested properties within objects/maps/lists.
  """
  if not tfvars_file.is_file():
    return set()

  content = read_file(tfvars_file)
  assigned_vars = set()

  # Split into lines and only check those with no leading whitespace
  for line in content.split('\n'):
    # Skip empty lines and comments
    if not line or line.lstrip().startswith('#'):
      continue

    # Only match assignments that start at column 0 (no leading spaces)
    if line and line[0] not in (' ', '\t'):
      match = re.match(r'^([a-zA-Z_][a-zA-Z0-9_]*)\s*=\s*', line)
      if match:
        assigned_vars.add(match.group(1))

  return assigned_vars


def parse_tfvars_structured(content: str) -> dict:
  """
  Parse terraform.tfvars into a structured format to understand value boundaries.
  Returns a dict mapping variable_name -> (start_pos, end_pos, full_text)
  """
  assignments = {}
  lines = content.split('\n')
  i = 0

  while i < len(lines):
    line = lines[i]
    stripped = line.lstrip()

    # Skip empty lines and comments
    if not stripped or stripped.startswith('#'):
      i += 1
      continue

    # Check if this line starts a variable assignment
    match = re.match(r'^([a-zA-Z_][a-zA-Z0-9_]*)\s*=\s*', stripped)
    if match:
      var_name = match.group(1)
      start_line = i
      start_pos = len(line) - len(stripped)  # Leading whitespace

      # Find the end of this assignment (handle multiline values)
      assignment_lines = [stripped]
      i += 1
      brace_depth = stripped.count('{') - stripped.count('}')
      bracket_depth = stripped.count('[') - stripped.count(']')
      in_string = False
      escape_next = False

      while i < len(lines) and (brace_depth > 0 or bracket_depth > 0 or
                                (
                                  not in_string and not stripped.strip().endswith(
                                  ',') and not stripped.strip() == '}')):
        line = lines[i]
        stripped = line.strip()
        if not stripped or stripped.startswith('#'):
          i += 1
          continue

        assignment_lines.append(line)
        brace_depth += stripped.count('{') - stripped.count('}')
        bracket_depth += stripped.count('[') - stripped.count(']')
        i += 1

      end_line = i - 1
      full_text = '\n'.join(assignment_lines)
      assignments[var_name] = (start_line, end_line, full_text)
    else:
      i += 1

  return assignments


def count_brackets_and_braces_excluding_comments(line: str) -> Tuple[int, int]:
  """
  Count brackets and braces in a line, excluding those in comments.
  Returns (brace_net, bracket_net) where net = opens - closes.
  """
  # Find the comment start
  comment_idx = line.find('#')
  if comment_idx >= 0:
    # Only count brackets/braces before the comment
    line = line[:comment_idx]

  brace_net = line.count('{') - line.count('}')
  bracket_net = line.count('[') - line.count(']')
  return brace_net, bracket_net


def remove_variables_from_tfvars(tfvars_file: Path,
                                 vars_to_remove: Set[str]) -> bool:
  """
  Remove specified top-level variables from terraform.tfvars file.
  Only removes variables that start at column 0.
  Returns True if file was modified.
  """
  if not tfvars_file.is_file() or not vars_to_remove:
    return False

  content = read_file(tfvars_file)
  original_content = content
  lines = content.split('\n')
  result_lines = []
  i = 0

  while i < len(lines):
    line = lines[i]

    # Empty lines and comment-only lines always pass through
    if not line or line.lstrip().startswith('#'):
      result_lines.append(line)
      i += 1
      continue

    # Check if this is a top-level variable assignment (no leading whitespace)
    if line and line[0] not in (' ', '\t'):
      match = re.match(r'^([a-zA-Z_][a-zA-Z0-9_]*)\s*=\s*', line)
      if match:
        var_name = match.group(1)

        if var_name in vars_to_remove:
          # Skip this variable and all its continuation lines
          # Count opening braces/brackets to know when the value is complete
          brace_depth, bracket_depth = count_brackets_and_braces_excluding_comments(
            line)
          i += 1

          # Keep consuming continuation lines until braces/brackets are balanced
          while i < len(lines) and (brace_depth > 0 or bracket_depth > 0):
            next_line = lines[i]

            # Update depth counts, excluding comments
            brace_delta, bracket_delta = count_brackets_and_braces_excluding_comments(
              next_line)
            brace_depth += brace_delta
            bracket_depth += bracket_delta

            # Consume this line
            i += 1

          # Remove trailing blank lines before this removed variable
          while result_lines and not result_lines[-1].strip():
            result_lines.pop()
        else:
          result_lines.append(line)
          i += 1
      else:
        result_lines.append(line)
        i += 1
    else:
      # Indented line - pass through as-is
      result_lines.append(line)
      i += 1

  new_content = '\n'.join(result_lines)

  # Remove trailing whitespace and ensure file ends with newline
  new_content = new_content.rstrip() + '\n'

  # Write back only if changed
  if new_content != original_content.rstrip() + '\n':
    tfvars_file.write_text(new_content, encoding="utf-8")

    # Run terraform fmt to normalize formatting after variable removal
    try:
      subprocess.run(
        ['terraform', 'fmt', str(tfvars_file)],
        capture_output=True,
        timeout=10,
        check=False
      )
    except (FileNotFoundError, subprocess.TimeoutExpired):
      # Gracefully handle if terraform not installed or timeout
      pass

    return True

  return False


def check_module(module: Path) -> List[str]:
  """
  Check consistency of variables in a module's env folders.
  Returns a list of modifications made (file paths that were changed).
  """
  modifications: List[str] = []
  rel = module.relative_to(REPO_ROOT)

  # Check if this module has an env folder
  env_dir = module / "env"
  if not env_dir.is_dir():
    return modifications

  # Get declared variables from 99_variables.tf
  variables_file = module / "99_variables.tf"
  declared_vars = extract_declared_variables(variables_file)

  # Check each environment subfolder
  try:
    env_subdirs = sorted(
      d for d in env_dir.iterdir() if d.is_dir() and not d.name.startswith('.'))
  except OSError:
    return modifications

  for env_subfolder in env_subdirs:
    tfvars_file = env_subfolder / "terraform.tfvars"

    if not tfvars_file.is_file():
      continue

    # Get assigned variables in this env's terraform.tfvars
    assigned_vars = extract_assigned_variables(tfvars_file)

    # Find variables that are assigned but not declared
    undeclared_vars = assigned_vars - declared_vars

    if undeclared_vars:
      # Remove undeclared variables from the file
      if remove_variables_from_tfvars(tfvars_file, undeclared_vars):
        rel_tfvars = tfvars_file.relative_to(REPO_ROOT)
        modifications.append(
          f"[{rel}] Removed undeclared variables from {rel_tfvars}: "
          f"{', '.join(sorted(undeclared_vars))}"
        )

  return modifications


def main() -> None:
  modules = find_module_dirs(REPO_ROOT)

  if not modules:
    print("No Terraform modules found.")
    sys.exit(0)

  all_modifications: List[str] = []
  for module in modules:
    all_modifications.extend(check_module(module))

  if all_modifications:
    print(
      "[INFO] Terraform env variables consistency check - modifications made:\n")
    for mod in all_modifications:
      print(f"  • {mod}")
    print(
      f"\n{len(all_modifications)} file(s) modified to remove undeclared variables."
    )

  print(
    f"Env variables consistency check completed for {len(modules)} module(s).")
  sys.exit(0)


if __name__ == "__main__":
  main()
