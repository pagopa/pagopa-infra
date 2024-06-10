#!/bin/bash

#set -x

action=$1
local_env=$2
shift 2


if [ -z "$action" ]; then
helpmessage=$(cat <<EOF

./sops.sh d env -> decrypt json file in specified environment
    example: ./sops.sh d itn-dev
    example: ./sops.sh decrypt itn-dev

./sops.sh s env -> search in enc file in specified environment
    example: ./sops.sh s itn-dev
    example: ./sops.sh search itn-dev

./sops.sh n env -> create new file enc json template in specified environment
    example: ./sops.sh n itn-dev
    example: ./sops.sh new itn-dev

./sops.sh a env -> add new secret record to enc json in specified environment
    example: ./sops.sh a itn-dev
    example: ./sops.sh add itn-dev

./sops.sh e env -> edit enc json record in specified environment
    example: ./sops.sh e itn-dev
    example: ./sops.sh edit itn-dev

./sops.sh f env  -> enc a json file in a specified environment
    example: ./sops.sh f itn-dev

EOF
)
  echo "$helpmessage"
  exit 0
fi

if [ -z "$local_env" ]; then
  echo "env should be something like: itn-dev, itn-uat or itn-prod."
  exit 0
fi

echo "✅ Mandatory variables are correct"

kv_name=""
file_crypted=""
# shellcheck disable=SC2034
key_vault_sops_key_name=""

# shellcheck disable=SC1090
source "./secret/$local_env/secret.ini"
echo "🔨 All variables loaded"

# Check if kv_name and file_crypted variables are not empty
if [ -z "${kv_name}" ]; then
  echo "Error: kv_name variable is not defined correctly."
  exit 1
fi

if [ -z "$file_crypted" ]; then
  echo "Error: file_crypted variable is not defined correctly."
  exit 1
fi

encrypted_file_path="./secret/$local_env/$file_crypted"
echo "encrypted_file_path: $encrypted_file_path"

# Controlla se la chiave esiste nel Key Vault
# shellcheck disable=SC2154
kv_key_url=$(az keyvault key show --vault-name "$kv_name" --name "$kv_sops_key_name" --query "key.kid" -o tsv)

echo "url: $kv_key_url"
if [[ $kv_key_url ]]; then
  echo "URL della chiave: $kv_key_url"
else
  echo "La chiave non esiste."
  exit 1
fi

echo "🔨 Key url loaded correctly"

if echo "d a s n e f" | grep -w "$action" > /dev/null; then

    case $action in
      "d")

        filesecret="$encrypted_file_path"
        sops --decrypt --azure-kv "${kv_name}" "$encrypted_file_path"
        if [ $? -eq 1 ]
        then
          echo "-------------------------------"
          echo "--->>> File $filesecret NOT encrypted"
          exit 0
        fi

      ;;
      "s")
      read -r -p 'key: ' key
      sops --decrypt --azure-kv "${kv_name}" "$encrypted_file_path" | grep -i "$key"

      ;;
      "a")
        read -r -p 'key: ' key
        read -r -p 'valore: ' value
        sops -i --set  '["'"$key"'"] "'"$value"'"' --azure-kv "${kv_name}" "$encrypted_file_path"
      ;;
      "n")
        if [ -f "$encrypted_file_path" ]
        then
          echo "file $encrypted_file_path already exists"
          exit 0
        else
          echo "{}" > "$encrypted_file_path"
          echo "kv_key_url: $kv_key_url"
          sops --encrypt -i --azure-kv "$kv_key_url" "$encrypted_file_path"
        fi
      ;;
      "e")
        if [ -f "$encrypted_file_path" ]
        then
          sops  --azure-kv "${kv_name}"€ "$encrypted_file_path"

        else
          echo "file $encrypted_file_path not found"

        fi
      ;;
      "f")
          read -r -p 'file: ' file
          sops --encrypt --azure-kv "${kv_name}" "./secret/$local_env/$file" > "$encrypted_file_path"
      ;;
    esac

else
    echo "Action not allowed."
    exit 1
fi




