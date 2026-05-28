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


DNS_ZONE_NAME="${CLOUDO_ENVIRONMENT}.checkout.pagopa.it"
if [ "${CLOUDO_ENVIRONMENT}" == "prod" ]; then
  DNS_ZONE_NAME="checkout.pagopa.it"
fi

echo "------------------------------------------------------------------------"

# Get connections associated with the VPN Gateway
GW_IP=$(az network public-ip show --name "pagopa-${CLOUDO_ENVIRONMENT_SHORT}-appgateway-pip" --resource-group  "pagopa-${CLOUDO_ENVIRONMENT_SHORT}-vnet-rg" --query "ipAddress" -o tsv)
echo "[INFO] retrieved gateway ip: '$GW_IP'"


if [ "$GW_IP" == "" ]; then
  echo "Gateway ip not found, exiting with error"
  exit 1
fi

az network dns record-set a delete -g "pagopa-${CLOUDO_ENVIRONMENT_SHORT}-vnet-rg" --zone-name "${DNS_ZONE_NAME}" -n "@" -y
echo "[INFO] deleted old DNS record"
az network dns record-set a create -g "pagopa-${CLOUDO_ENVIRONMENT_SHORT}-vnet-rg" --zone-name "${DNS_ZONE_NAME}" -n "@" --ttl 10
echo "[INFO] created new DNS record"
az network dns record-set a add-record -g "pagopa-${CLOUDO_ENVIRONMENT_SHORT}-vnet-rg" --zone-name "${DNS_ZONE_NAME}" -a "$GW_IP" --record-set-name "@"  --ttl 10
echo "[INFO] added record set to DNS"
echo "[INFO] runbook completed"

