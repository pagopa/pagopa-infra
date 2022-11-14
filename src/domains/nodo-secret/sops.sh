#!/bin/bash

#set -x

action=$1
localenv=$2
shift 2
other=$@

if [ -z "$action" ]; then
  echo "Missed action: e, d"
  exit 0
fi

if [ -z "$localenv" ]; then
  echo "env should be: dev, uat or prod."
  exit 0
fi

source "./secret/$localenv/secret.ini"


if echo "e d" | grep -w $action > /dev/null; then

  azurekvurl=`az keyvault key show --name $prefix-$env_short-$domain-sops-key --vault-name $prefix-$env_short-$domain-kv --query key.kid | sed 's/"//g'`

  
    
    case $action in
      "d")
      sops --decrypt --azure-kv $azurekvurl ./secret/$localenv/$file_crypted > ./secret/$localenv/$file_decrypted
      if [ $? -eq 1 ]
      then
        echo "-------------------------------"
        echo "--->>> File $filesecret NON criptato"
        exit 0
      fi
      ;;
      "e")
      sops --encrypt --azure-kv $azurekvurl ./secret/$localenv/$file_decrypted > ./secret/$localenv/$file_crypted
      if [ $? -eq 203 ]
      then
        echo "-------------------------------"
        echo "--->>> File $filesecret già criptato"
        exit 0
      fi
      ;;
    esac
  
else
    echo "Action not allowed."
    exit 1
fi




