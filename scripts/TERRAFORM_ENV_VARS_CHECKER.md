# Terraform Environment Variables Consistency Checker

## Overview

This pre-commit hook (`check-env-vars-consistency`) automatically validates and enforces consistency between Terraform variable definitions and their assignments in environment-specific configuration files.

## What It Does

For every Terraform module (folder with `.tf` files) that contains an `env/` subfolder:

1. **Scans** the module's `99_variables.tf` to extract all declared variable names
2. **Checks** each environment subfolder (e.g., `env/dev`, `env/prod`, `env/uat`)
3. **Validates** each `terraform.tfvars` file in those subfolders
4. **Removes** any variable assignments that don't have a corresponding declaration in `99_variables.tf`
5. **Reports** all modifications made

## Why This Matters

- **Data Consistency**: Prevents orphaned variables in environment configs that are no longer declared
- **Clean Configuration**: Removes unused/dead variables from `terraform.tfvars` files
- **Maintainability**: Makes it easier to understand which variables are actually used
- **Prevention**: Stops accidental configuration drift between declared and assigned variables

## How It Works

### Key Principle

**Only top-level variable assignments are checked.** Nested properties within objects/maps/lists are preserved and never considered as separate variables.

### Input Structure

```
src/my-module/
├── 99_variables.tf          # Variable declarations
├── env/
│   ├── dev/
│   │   ├── terraform.tfvars # Variable assignments for dev
│   │   └── backend.tfvars
│   ├── prod/
│   │   ├── terraform.tfvars # Variable assignments for prod
│   │   └── backend.tfvars
│   └── uat/
│       ├── terraform.tfvars # Variable assignments for uat
│       └── backend.tfvars
└── ...other .tf files
```

### Example

**99_variables.tf:**
```hcl
variable "env_short" {
  type = string
}

variable "env" {
  type = string
}

variable "location_short" {
  type = string
}
```

**env/dev/terraform.tfvars (BEFORE):**
```hcl
env_short      = "d"
env            = "dev"
location_short = "itn"
enabled_features = {
  data_explorer = true
}
```

**env/dev/terraform.tfvars (AFTER):**
```hcl
env_short      = "d"
env            = "dev"
location_short = "itn"
```

The `enabled_features` variable is removed because it's not declared in `99_variables.tf`. The properties inside it (`data_explorer = true`) are part of the value and would never be treated as separate variables.

### Important: Nested Properties Are Preserved

Even if a variable is declared, all its nested properties are fully preserved:

**Example with object variables:**
```hcl
# 99_variables.tf
variable "config" {
  type = object({
    enabled = bool
    settings = object({
      timeout = number
    })
  })
}

# env/dev/terraform.tfvars - ALL properties are preserved
config = {
  enabled = true
  settings = {
    timeout = 300
  }
}
```

All nested properties inside `config` (like `enabled`, `settings`, `timeout`) remain unchanged because they are properties within the declared `config` variable, not separate variables.

## Integration

The hook is configured in `.pre-commit-config.yaml`:

```yaml
- repo: local
  hooks:
    - id: check-env-vars-consistency
      name: Check Terraform env variables consistency
      entry: scripts/check-env-vars-consistency.sh
      always_run: true
      language: python
      types: [java]
```

## Implementation Files

- **`scripts/check_env_vars_consistency.py`** - Main Python script with the validation logic
- **`scripts/check-env-vars-consistency.sh`** - Shell wrapper for pre-commit integration

## Running Manually

```bash
# Run from repository root
python3 scripts/check_env_vars_consistency.py

# Or use the shell wrapper
bash scripts/check-env-vars-consistency.sh
```

## Output

The tool reports:
- **Modified files** - Lists each environment file with removed variables
- **Summary** - Total count of modifications across all modules

Example output:
```
[INFO] Terraform env variables consistency check - modifications made:

  • [src/audit-logs] Removed undeclared variables from src/audit-logs/env/dev/terraform.tfvars: enabled_features, data_explorer
  • [src/audit-logs] Removed undeclared variables from src/audit-logs/env/prod/terraform.tfvars: enabled_features, data_explorer
  • [src/audit-logs] Removed undeclared variables from src/audit-logs/env/uat/terraform.tfvars: enabled_features, data_explorer

2 file(s) modified to remove undeclared variables.
```

## Key Features

✅ **Recursive Scanning** - Finds all Terraform modules in the project
✅ **Environment Aware** - Handles multiple environment folders (dev, prod, uat, etc.)
✅ **Complex Value Support** - Properly handles multiline values (maps, lists, etc.)
✅ **Automatic Cleanup** - Removes undeclared variables in-place
✅ **Detailed Reporting** - Clear information about what was changed
✅ **Non-Destructive** - Only modifies files with undeclared variables; valid assignments are preserved

## Exclusions

The tool automatically skips:
- Hidden directories (starting with `.`)
- `.terraform` directory
- `.git` directory
- `tests` directories
- `.venv` and `__pycache__` directories

## Troubleshooting

### Files not being modified

Ensure your `terraform.tfvars` files are in the correct structure:
```
env/
├── dev/
│   └── terraform.tfvars
├── prod/
│   └── terraform.tfvars
```

### Script permissions

Make sure both wrapper scripts are executable:
```bash
chmod +x scripts/check-env-vars-consistency.sh
chmod +x scripts/check_env_vars_consistency.py
```

## Python Dependencies

The script uses only Python standard library modules:
- `os`
- `re`
- `sys`
- `pathlib`
- `typing`

No external dependencies required!
