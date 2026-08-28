#!/bin/bash

# =================================================================
# Terraform SOPS Secrets Decryption Script
# =================================================================
#
# DESCRIPTION
# -----------
# This script is used by Terraform to decrypt SOPS secrets and export them to JSON.
# It's designed to work with Azure Key Vault and handles the decryption of secrets
# stored in environment-specific files.
#
# PREREQUISITES
# ------------
# - jq installed
# - SOPS installed
# - Azure CLI configured
# - Proper access to Azure Key Vault
# - Encrypted files in ./secret/<env>/ directory
#
# DIRECTORY STRUCTURE
# -----------------
# ./
# ├── secret/
# │   ├── weu-dev/
# │   │   ├── secret.ini
# │   │   └── noedit_secret_enc.json
# │   ├── weu-prod/
# │   │   ├── secret.ini
# │   │   └── noedit_secret_enc.json
# │   └── ...
#
# TERRAFORM USAGE
# -------------
# data "external" "terrasops_sh" {
#   program = ["bash", "terrasops.sh"]
#   query = {
#     env = "${var.location_short}-${var.env}"
#   }
# }
#
# LOCAL USAGE EXAMPLES
# ------------------
# 1. Basic usage:
#    echo '{"env": "weu-dev"}' | ./terrasops.sh
#
# 2. With debug mode (shows detailed execution steps):
#    echo '{"env": "weu-dev"}' | ./terrasops.sh debug
#
# 3. Pretty print output (useful for debugging):
#    echo '{"env": "weu-dev"}' | ./terrasops.sh | jq '.'
#
# 4. Save output to file:
#    echo '{"env": "weu-dev"}' | ./terrasops.sh > output.json
#
# 5. Debug mode with output redirection (shows process but saves clean JSON):
#    echo '{"env": "weu-dev"}' | ./terrasops.sh debug 2>debug.log >output.json
#
# 6. Different environments examples:
#    echo '{"env": "weu-prod"}' | ./terrasops.sh
#    echo '{"env": "neu-dev"}' | ./terrasops.sh
#    echo '{"env": "neu-prod"}' | ./terrasops.sh
#
# ERROR HANDLING
# -------------
# The script will exit with status code 1 and error message if:
# - Environment is not specified in input JSON
# - Configuration files are missing
# - Azure Key Vault parameters are missing/invalid
# - SOPS decryption fails
#
#
# NOTE
# ----
# ⚠️  Do not add additional echoes to the script in case of golden path,
#     as the script only needs to return a json for Terraform
#
# =================================================================

# Function for debug messages
debug_log() {
    if [[ "${DEBUG:-false}" == "true" ]]; then
        echo "🔍 DEBUG: $1" >&2
    fi
}

# Function for error messages
error_log() {
    echo "❌ ERROR: $1" >&2
}

set -o pipefail

# Enable debug mode if passed as parameter
if [[ "$1" == "debug" ]]; then
    export DEBUG=true
    debug_log "🐛 Debug mode enabled"
fi

debug_log "📝 Parsing JSON input from Terraform"
eval "$(jq -r '@sh "export terrasops_env=\(.env)"')"

if [[ -z "$terrasops_env" ]]; then
    error_log "🚫 Environment not specified in Terraform JSON input"
    exit 1
fi
debug_log "🌍 Environment set to: $terrasops_env"

# Load configuration
debug_log "📂 Loading configuration file"
# shellcheck disable=SC1090
source "./secret/$terrasops_env/secret.ini"
encrypted_file_path="./secret/$terrasops_env/$file_crypted"

debug_log "🔒 Checking file existence: $encrypted_file_path"
if [ -f "$encrypted_file_path" ]; then
    debug_log "🔑 Extracting Azure Key Vault parameters"
    # Load the values of azure_kv.vault_url and azure_kv.name from the JSON file
    azure_kv_vault_url=$(jq -r '.sops.azure_kv[0].vault_url' "$encrypted_file_path")
    azure_kv_name=$(jq -r '.sops.azure_kv[0].name' "$encrypted_file_path")

    debug_log "kv url: $azure_kv_vault_url"
    debug_log "path: $encrypted_file_path"

    if [ -z "$azure_kv_vault_url" ] || [ -z "$azure_kv_name" ]; then
        error_log "🔐 Unable to load azure_kv.vault_url and azure_kv.name values from JSON file"
        exit 1
    fi

    debug_log "🔓 Decrypting file with SOPS"
    if ! sops -d --azure-kv "$azure_kv_vault_url" "$encrypted_file_path" | jq -c; then
        error_log "🔐 SOPS decryption failed"
        exit 1
    fi
    debug_log "🎉 Decryption completed"
else
    debug_log "⚠️ Encrypted file not found, returning empty JSON"
    echo "{}" | jq -c
fi
