#!/usr/bin/env python3
"""
Pre-commit hook: Terraform variables.tf convention checker.

Enforces two rules for every Terraform module directory:
  1. variables.tf must NOT contain a `locals` block.
  2. ALL variable definitions must live in variables.tf only
     (no `variable` blocks allowed in any other .tf file).

A "module directory" is any directory (at any depth) that contains at least
one .tf file at its root level, excluding `tests` directories and hidden
directories (those starting with a dot).
"""

import os
import re
import sys
from pathlib import Path
from typing import List, Tuple

# Root of the repository — two levels up from this script's location (.scripts/)
REPO_ROOT = Path(__file__).resolve().parent.parent

# Directory names to skip entirely during traversal
EXCLUDED_DIRS = {".git", ".terraform", ".venv", "__pycache__"}

# Matches a `locals {` block opener at top scope (not inside a comment)
LOCALS_BLOCK_RE = re.compile(r"^\s*locals\s*\{", re.MULTILINE)

# Matches a `variable "name" {` block opener
VARIABLE_BLOCK_RE = re.compile(r'^\s*variable\s+"[^"]+"\s*\{', re.MULTILINE)


def is_module_dir(path: Path) -> bool:
    """Return True if *path* contains at least one .tf file at its root."""
    return any(p.suffix == ".tf" for p in path.iterdir() if p.is_file())


def find_module_dirs(root: Path) -> List[Path]:
    """
    Walk *root* recursively and return all module directories found.
    Skips hidden directories, directories named `tests`, and entries in
    EXCLUDED_DIRS.
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
    try:
        return path.read_text(encoding="utf-8")
    except OSError as exc:
        print(f"  WARNING: cannot read {path}: {exc}", file=sys.stderr)
        return ""


def check_module(module: Path) -> List[str]:
    """
    Run both checks on *module* and return a (possibly empty) list of errors.
    """
    errors: List[str] = []
    rel = module.relative_to(REPO_ROOT)

    tf_files = sorted(p for p in module.iterdir() if p.is_file() and p.suffix == ".tf")
    variables_tf = module / "99_variables.tf"

    # ── Check 1: variables.tf must not contain a `locals` block ──────────────
    if variables_tf.is_file():
        content = read_file(variables_tf)
        if LOCALS_BLOCK_RE.search(content):
            errors.append(
                f"[{rel}] 99_variables.tf must not define a 'locals' block."
            )

    # ── Check 2: variable blocks must only appear in variables.tf ────────────
    for tf_file in tf_files:
        if tf_file.name == "99_variables.tf":
            continue
        content = read_file(tf_file)
        if VARIABLE_BLOCK_RE.search(content):
            errors.append(
                f"[{rel}] '{tf_file.name}' must not define 'variable' blocks — "
                f"all variables must be declared only in 99_variables.tf."
            )

    return errors


def main() -> None:
    modules = find_module_dirs(REPO_ROOT)

    if not modules:
        print("No Terraform modules found.")
        sys.exit(0)

    all_errors: List[str] = []
    for module in modules:
        all_errors.extend(check_module(module))

    if all_errors:
        print("[ERROR] Terraform variables.tf convention violations:\n")
        for err in all_errors:
            print(f"  • {err}")
        print(
            f"\n{len(all_errors)} violation(s) found across "
            f"{len(modules)} module(s). Fix them before committing."
        )
        sys.exit(1)

    print(f"All {len(modules)} modules passed variables.tf convention checks.")
    sys.exit(0)


if __name__ == "__main__":
    main()
