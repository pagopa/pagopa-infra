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

if echo "d decrypt a add s search n new e edit f file-encrypt di decryptignore" | grep -w "$action" > /dev/null; then
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
  esac
else
  echo "⚠️ Action not allowed."
  exit 1
fi
