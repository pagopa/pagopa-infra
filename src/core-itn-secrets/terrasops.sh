#!/bin/bash

#set -x
eval "$(jq -r '@sh "export terrasops_env=\(.env)"')"

source "./secret/$terrasops_env/secret.ini"

if [ -f ./secret/$terrasops_env/$file_crypted ]
then
    azurekvurl=`az keyvault key show --name $prefix-$env_short-$domain-sops-key --vault-name $prefix-$env_short-itn-$domain-kv --query key.kid | sed 's/"//g'`
    sops -d  --azure-kv $azurekvurl ./secret/$terrasops_env/$file_crypted | jq -c
else
    echo "{}" | jq -c
fi

