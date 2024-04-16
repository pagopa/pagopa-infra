#!/bin/bash

#set -x

action=$1
localenv=$2
shift 2
other=$@

if [ -z "$action" ]; then
helpmessage=$(cat <<EOF

./sops.sh d env -> decrypt json file in specified environment
    example: ./sops.sh d itn-dev

./sops.sh s env -> search in enc file in specified environment
    example: ./sops.sh s itn-dev

./sops.sh n env -> create new file enc json template in specified environment
    example: ./sops.sh n itn-dev

./sops.sh a env -> add new secret record to enc json in specified environment
    example: ./sops.sh a itn-dev

./sops.sh e env -> edit enc json record in specified environment
    example: ./sops.sh e itn-dev

./sops.sh f env  -> enc a json file in a specified environment
    example: ./sops.sh k itn-dev

EOF
)
  echo "$helpmessage"
  exit 0
fi

if [ -z "$localenv" ]; then
  echo "env should be: dev, uat or prod."
  exit 0
fi

source "./secret/$localenv/secret.ini"

echo "az keyvault key show --name $prefix-$env_short-$domain-sops-key --vault-name $prefix-$env_short-$domain-kv --query key.kid"

if echo "d a s n e f" | grep -w $action > /dev/null; then



  azurekvurl=`az keyvault key show --name $prefix-$env_short-$domain-sops-key --vault-name $prefix-$env_short-$domain-kv --query key.kid | sed 's/"//g'`
  echo $azurekvurl


    case $action in
      "d")

        filesecret="./secret/$localenv/$file_crypted"
        sops --decrypt --azure-kv $azurekvurl ./secret/$localenv/$file_crypted
        if [ $? -eq 1 ]
        then
          echo "-------------------------------"
          echo "--->>> File $filesecret NOT encrypted"
          exit 0
        fi

      ;;
      "s")
      read -p 'key: ' key
      sops --decrypt --azure-kv $azurekvurl ./secret/$localenv/$file_crypted | grep -i $key

      ;;

      "a")
        read -p 'key: ' key
        read -p 'valore: ' value
        sops -i --set  '["'$key'"] "'$value'"' --azure-kv $azurekvurl ./secret/$localenv/$file_crypted
      ;;
      "n")
        if [ -f ./secret/$localenv/$file_crypted ]
        then
          echo "file ./secret/$localenv/$file_crypted already exists"
          exit 0
        else
          echo "{}" > ./secret/$localenv/$file_crypted
          sops --encrypt -i --azure-kv $azurekvurl ./secret/$localenv/$file_crypted
        fi
      ;;
      "e")
        if [ -f ./secret/$localenv/$file_crypted ]
        then
          sops  --azure-kv $azurekvurl ./secret/$localenv/$file_crypted

        else
          echo "file ./secret/$localenv/$file_crypted not found"

        fi
      ;;
      "f")
        if [ -f ./secret/$localenv/$file_crypted ]
        then
          read -p 'file: ' file
          sops --encrypt --azure-kv $azurekvurl ./secret/$localenv/$file > ./secret/$localenv/$file_crypted
        else
          echo "file ./secret/$localenv/$file_crypted not found"

        fi
      ;;
    esac

else
    echo "Action not allowed."
    exit 1
fi




