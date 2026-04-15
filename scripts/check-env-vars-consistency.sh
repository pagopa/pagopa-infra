#!/bin/bash
# Wrapper script for pre-commit hook
# Calls the Python script for checking Terraform env variables consistency

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
python3 "${SCRIPT_DIR}/check_env_vars_consistency.py"
exit $?
