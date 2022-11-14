#!/bin/bash

#set -x

action=$1
localenv=$2
shift 2
other=$@

if [ -z "$action" ]; then
helpmessage=$(cat <<EOF
Usage:

./sops.sh d env -> decrypt json file per ambiente 
    example: ./sops.sh d weu-dev

./sops.sh e env -> encrypt json file per ambiente
    example: ./sops.sh e weu-dev

./sops.sh n env -> crea nuovo file json template per ambiente
    example: ./sops.sh n weu-dev


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


if echo "e d n" | grep -w $action > /dev/null; then

  azurekvurl=`az keyvault key show --name $prefix-$env_short-$domain-sops-key --vault-name $prefix-$env_short-$domain-kv --query key.kid | sed 's/"//g'`

  
    
    case $action in
      "d")
      if [ -f ./secret/$localenv/$file_crypted ]
      then
        filesecret="./secret/$localenv/$file_crypted"
        sops --decrypt --azure-kv $azurekvurl ./secret/$localenv/$file_crypted > ./secret/$localenv/$file_decrypted
        if [ $? -eq 1 ]
        then
          echo "-------------------------------"
          echo "--->>> File $filesecret NON criptato"
          exit 0
        fi
      else
        echo "-------------------------------"
        echo "--->>> File $filesecret NON trovato"
        exit 1
      fi
      ;;
      "e")
      if [ -f ./secret/$localenv/$file_decrypted ]
      then
        filesecret="./secret/$localenv/$file_decrypted"
        sops --encrypt --azure-kv $azurekvurl ./secret/$localenv/$file_decrypted > ./secret/$localenv/$file_crypted
        if [ $? -eq 203 ]
        then
          echo "-------------------------------"
          echo "--->>> File $filesecret già criptato"
          exit 0
        fi
      else
        echo "-------------------------------"
        echo "--->>> File $filesecret NON trovato"
        exit 1
      fi
 
      ;;
      "n")
      json_data=$(cat <<EOF
      {
          "secrets": [
              {
                      "key": "keepherekey",
                      "value":  "keepherevalue"
              }
          ]
      }
EOF
)

      if [ -f ./secret/$localenv/$file_decrypted ]
      then
          echo "File: ./secret/$localenv/$file_decrypted esiste già - esco"
          exit 1
      else
          echo "$json_data" > ./secret/$localenv/$file_decrypted
          if [ $? -eq 0 ]
              then
                echo "-------------------------------"
                echo "File: ./secret/$localenv/$file_decrypted creato"
                exit 0
          fi
          

      fi
      ;;
    esac
  
else
    echo "Action not allowed."
    exit 1
fi




