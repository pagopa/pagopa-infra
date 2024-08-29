#!/usr/bin/env bash


# https://pagopa.atlassian.net/wiki/spaces/PPAOP/pages/1049985209/Parametri+Mutua+Autenticazione

if [ $# -eq 0 ]
  then
    echo "> sh set_kv_secrets.sh <dev|uat>"
    exit
fi

environment=$1

pem_certificate="./certs/"
crt_certificate="./certs/$environment-certificate.crt"
pkcs1_private_key=""
pkcs8_private_key="./certs/"
kv_name="pagopa-${environment:0:1}-shared-kv"


if [[ "$environment" == "dev" ]]; then # UAT-NEXI
  pem_certificate+="pagopajira.stgb2b-issuing.nexi.it.pem"
elif [[ "$environment" == "uat" ]]; then # PROD-NEXI
  pem_certificate+="pagopajira.b2b-issuing.nexi.it.pem"
else
  echo "PEM Certificate not found"
  exit
fi

pkcs1_private_key="$environment-private.key"

if [[ ! -f "$pem_certificate" ]]; then
    echo "$pem_certificate not exist."
fi

if [[ ! -f "$pkcs1_private_key" ]]; then
    echo "$pkcs1_private_key not exist."
fi

pkcs8_private_key+="$pkcs1_private_key"

# convert private key PKCS1 to PKCS8
openssl pkcs8 -topk8 -nocrypt -in "$pkcs1_private_key" -out "$pkcs8_private_key"

# extract crt from pem
openssl x509 -outform pem -in "$pem_certificate" -out "$crt_certificate"

echo "uploading info into azure kv"
az keyvault secret set --vault-name "$kv_name" --name "certificate-crt-app-forwarder" --file "$crt_certificate"
# https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/asset/Microsoft_Azure_KeyVault/Secret/https://pagopa-d-shared-kv.vault.azure.net/secrets/certificate-crt-app-forwarder
az keyvault secret set --vault-name "$kv_name" --name "certificate-key-app-forwarder" --file "$pkcs8_private_key"
# https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/asset/Microsoft_Azure_KeyVault/Secret/https://pagopa-d-shared-kv.vault.azure.net/secrets/certificate-key-app-forwarder
