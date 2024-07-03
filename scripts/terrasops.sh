#!/bin/bash
# set -x  # Uncomment this line to enable debug mode

#
# ℹ️ This script is used by terraform, to decrypt all secrets on sops and export them to json.
#    This way it can loop through them and use them to insert them inside the KV
# ⚠️ Do not add additional echos to the script in case of golden path,
#    as the script only needs to return a json
#

eval "$(jq -r '@sh "export terrasops_env=\(.env)"')"

# shellcheck disable=SC1090
source "./secret/$terrasops_env/secret.ini"
encrypted_file_path="./secret/$terrasops_env/$file_crypted"

if [ -f "$encrypted_file_path" ]; then
  # Load the values of azure_kv.vault_url and azure_kv.name from the JSON file
  azure_kv_vault_url=$(jq -r '.sops.azure_kv[0].vault_url' "$encrypted_file_path")
  azure_kv_name=$(jq -r '.sops.azure_kv[0].name' "$encrypted_file_path")

  if [ -z "$azure_kv_vault_url" ] || [ -z "$azure_kv_name" ]; then
    echo "❌ Error: Unable to load the values of azure_kv.vault_url and azure_kv.name from the JSON file" >&2
    exit 1
  fi
  sops -d --azure-kv "azure_kv_vault_url" "$encrypted_file_path" | jq -c
else
  echo "{}" | jq -c
fi
