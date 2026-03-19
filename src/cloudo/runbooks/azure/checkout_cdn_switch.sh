#!/usr/bin/env bash
# Script to check the status of Azure VPN Gateway connections
# Required environment variables:
# - AZURE_CLIENT_ID (for managed identity login)
# - RESOURCE_RG (Resource Group of the VPN Gateway)
# - RESOURCE_NAME (Name of the VPN Gateway)

set -euo pipefail

echo "Logging into Azure..."
if [[ -n "${AZURE_CLIENT_ID:-}" ]]; then
  az login --identity --client-id "$AZURE_CLIENT_ID" > /dev/null
else
  az login --identity > /dev/null
fi


echo "------------------------------------------------------------------------"

# Get connections associated with the VPN Gateway
GW_IP=$(az network public-ip show --name "pagopa-d-appgateway-pip" --resource-group  "pagopa-d-vnet-rg" --query "ipAddress" -o tsv)

echo "retrieved gateway ip: '$GW_IP'"


if [ "$GW_IP" == "" ]; then
  echo "Gateway ip not found, exiting with error"
  exit 1
fi

az network dns record-set a delete -g "pagopa-d-vnet-rg" --zone-name "dev.checkout.pagopa.it" -n "@" -y
az network dns record-set a create -g "pagopa-d-vnet-rg" --zone-name "dev.checkout.pagopa.it" -n "@"
az network dns record-set a add-record -g "pagopa-d-vnet-rg" --zone-name "dev.checkout.pagopa.it" -a "$GW_IP" --record-set-name "@"


