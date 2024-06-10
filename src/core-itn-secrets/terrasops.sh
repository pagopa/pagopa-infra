#!/bin/bash

if [ -z "${1:-}" ]; then
  echo "Errore: Devi fornire il valore di terrasops_env come primo argomento" >&2
  exit 1
fi

terrasops_env="$1"
file_crypted="noedit_secret_enc.json"
encrypted_file_path="./secret/$terrasops_env/$file_crypted"

# shellcheck disable=SC1090
source "./secret/$terrasops_env/secret.ini"

echo "🔨 Loading variables"

if [ -f "$encrypted_file_path" ]; then
  # Carica i valori di azure_kv.vault_url e azure_kv.name dal file JSON
  azure_kv_vault_url=$(jq -r '.sops.azure_kv[0].vault_url' "$encrypted_file_path")
  azure_kv_name=$(jq -r '.sops.azure_kv[0].name' "$encrypted_file_path")

  if [ -n "$azure_kv_vault_url" ] && [ -n "$azure_kv_name" ]; then
    echo "🔨 start decript file"
    sops -d --azure-kv "azure_kv_vault_url" "$encrypted_file_path" | jq -c
  else
    echo "Errore: Impossibile caricare i valori di azure_kv.vault_url e azure_kv.name dal file JSON" >&2
    exit 1
  fi
else
  echo "{}" | jq -c
fi
