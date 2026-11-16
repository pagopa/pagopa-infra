#!/bin/bash

# set -x  # Uncomment this line to enable debug mode

#
# how to use `sh sops.sh`
# ℹ️ This script allows you to create a sops file with the relative azure key,
# it also allows you to edit the secrets and add them with the script.
# ℹ️ This script also uses an inventory file under the "./secret/<env>/secret.ini"
# directory to load environment variables.
#

action=$1
env=$2
shift 2
# shellcheck disable=SC2034
other=( "$@" )

if [ -z "$action" ]; then
  helpmessage=$(cat <<EOF
  ℹ️ Please follow this example on how to use the script

./sops.sh d <env> -> decrypt json file using a specified environment
    example: ./sops.sh d itn-dev
    example: ./sops.sh decrypt itn-dev

./sops.sh s <env> -> search in enc file using a specified environment
    example: ./sops.sh s itn-dev
    example: ./sops.sh search itn-dev

./sops.sh n <env> -> create new file enc json template using a specified environment
    example: ./sops.sh n itn-dev
    example: ./sops.sh new itn-dev

./sops.sh a <env> -> add new secret record to enc json using a specified environment
    example: ./sops.sh a itn-dev
    example: ./sops.sh add itn-dev

./sops.sh e <env> -> edit enc json record using a specified environment
    example: ./sops.sh e itn-dev
    example: ./sops.sh edit itn-dev

./sops.sh f <env>  -> encrypt a external json file (path is requested runtime) into the default sops file using a specified environment
    example: ./sops.sh f itn-dev
    example: ./sops.sh file-encrypt itn-dev

./sops.sh rk <env> -> rotate encryption key in Azure Key Vault and re-encrypt the file with the new key
    example: ./sops.sh rk itn-dev
    example: ./sops.sh rotate-key itn-dev

EOF
)
  echo "$helpmessage"
  exit 0
fi

if [ -z "$env" ]; then
  echo "env should be something like: itn-dev, itn-uat or itn-prod."
  exit 0
fi

echo "🔨 Mandatory variables are correct"
file_crypted=""
kv_name=""
kv_sops_key_name=""

# shellcheck disable=SC1090
source "./secret/$env/secret.ini"

echo "🔨 All variables loaded"

# Check if kv_name and file_crypted variables are not empty
if [ -z "${kv_name}" ]; then
  echo "❌ Error: kv_name variable is not defined correctly."
  exit 1
fi

if [ -z "$file_crypted" ]; then
  echo "❌ Error: file_crypted variable is not defined correctly."
  exit 1
fi

encrypted_file_path="./secret/$env/$file_crypted"

# Check if the key exists in the Key Vault
# shellcheck disable=SC2154
kv_key_url=$(az keyvault key show --vault-name "$kv_name" --name "$kv_sops_key_name" --query "key.kid" -o tsv)
if [ -z "$kv_key_url" ]; then
  echo "❌ The key does not exist."
  exit 1
fi
echo "[INFO] Key URL: $kv_key_url"

echo "🔨 Key URL loaded correctly"

if echo "d decrypt a add s search n new e edit f file-encrypt di decryptignore rk rotate-key" | grep -w "$action" > /dev/null; then
  case $action in
    "d"|"decrypt")
      sops --decrypt --azure-kv "$kv_key_url" "$encrypted_file_path"
      if [ $? -eq 1 ]; then
        echo "❌ File $encrypted_file_path NOT encrypted"
        exit 0
      fi
      ;;
    "di"|"decryptignore")
      sops --decrypt --ignore-mac --azure-kv "$kv_key_url" "$encrypted_file_path"
      if [ $? -eq 1 ]; then
        echo "❌ File $encrypted_file_path NOT encrypted"
        exit 0
      fi
      ;;
    "s"|"search")
      read -r -p 'key: ' key
      sops --decrypt --azure-kv "$kv_key_url" "$encrypted_file_path" | grep -i "$key"
      ;;
    "a"|"add")
      read -r -p 'key: ' key
      read -r -p 'value: ' value
      sops -i --set '["'"$key"'"] "'"$value"'"' --azure-kv "$kv_key_url" "$encrypted_file_path"
      echo "✅ Added key"
      ;;
    "n"|"new")
      if [ -f "$encrypted_file_path" ]; then
        echo "⚠️ file $encrypted_file_path already exists"
        exit 0
      fi
      echo "{}" > "$encrypted_file_path"
      sops --encrypt -i --azure-kv "$kv_key_url" "$encrypted_file_path"
      echo "✅ created new file for sops"
      ;;
    "e"|"edit")
      if [ ! -f "$encrypted_file_path" ]; then
        echo "⚠️ file $encrypted_file_path not found"
        exit 1
      fi

      sops --azure-kv "$kv_key_url" "$encrypted_file_path"
      echo "✅ edit file completed"

      ;;
    "f"|"file-encrypt")
      read -r -p 'file: ' file
      sops --encrypt --azure-kv "$kv_key_url" "./secret/$env/$file" > "$encrypted_file_path"
      ;;
    "rk"|"rotate-key")
      if [ ! -f "$encrypted_file_path" ]; then
        echo "⚠️ file $encrypted_file_path not found"
        exit 1
      fi

      old_kv_key_urls=$(jq -r '.sops.azure_kv[]? | "\(.vault_url)/keys/\(.name)/\(.version)"' "$encrypted_file_path")
      if [ -z "$old_kv_key_urls" ]; then
        echo "❌ Unable to extract existing Azure Key Vault keys from $encrypted_file_path"
        exit 1
      fi

      new_kv_key_url="$kv_key_url"

      if echo "$old_kv_key_urls" | grep -Fxq "$kv_key_url"; then
        echo "ℹ️ The file is currently using the latest key version ($kv_key_url)."
        read -r -p "Do you want to rotate the key in Azure Key Vault to generate a new version? (y/n): " confirm_rotate
        if [[ "$confirm_rotate" =~ ^[Yy]$ ]]; then
          echo "🔄 Rotating key in Azure Key Vault..."
          new_kv_key_url=$(az keyvault key rotate --vault-name "$kv_name" --name "$kv_sops_key_name" --query "key.kid" -o tsv)
          if [ -z "$new_kv_key_url" ]; then
            echo "❌ Failed to rotate key in Azure Key Vault."
            exit 1
          fi
          echo "[INFO] New Key URL: $new_kv_key_url"
        else
          echo "Rotation cancelled."
          exit 0
        fi
      else
        echo "ℹ️ Azure Key Vault has a newer key version ($kv_key_url) than the one(s) in $encrypted_file_path:"
        echo "$old_kv_key_urls"
        read -r -p "Rotate in Azure Key Vault first [r] or sync with existing latest version [s] (r/s)?: " choice
        case "$choice" in
          [Rr]*)
            echo "🔄 Rotating key in Azure Key Vault..."
            new_kv_key_url=$(az keyvault key rotate --vault-name "$kv_name" --name "$kv_sops_key_name" --query "key.kid" -o tsv)
            if [ -z "$new_kv_key_url" ]; then
              echo "❌ Failed to rotate key in Azure Key Vault."
              exit 1
            fi
            echo "[INFO] New Key URL: $new_kv_key_url"
            ;;
          [Ss]*)
            echo "ℹ️ Syncing file with existing latest Key Vault version ($new_kv_key_url)..."
            ;;
          *)
            echo "Operation cancelled."
            exit 0
            ;;
        esac
      fi

      rm_args=()
      while IFS= read -r old_url; do
        if [ -n "$old_url" ] && [ "$old_url" != "$new_kv_key_url" ]; then
          rm_args+=(--rm-azure-kv "$old_url")
        fi
      done <<< "$old_kv_key_urls"

      echo "🔄 Re-encrypting $encrypted_file_path with new key..."
      if [ ${#rm_args[@]} -gt 0 ]; then
        sops rotate -i "${rm_args[@]}" --add-azure-kv "$new_kv_key_url" "$encrypted_file_path"
      else
        sops rotate -i --add-azure-kv "$new_kv_key_url" "$encrypted_file_path"
      fi

      if [ $? -eq 0 ]; then
        echo "✅ Key rotation and re-encryption completed successfully"
      else
        echo "❌ Key rotation failed"
        exit 1
      fi
      ;;
  esac
else
  echo "⚠️ Action not allowed."
  exit 1
fi
