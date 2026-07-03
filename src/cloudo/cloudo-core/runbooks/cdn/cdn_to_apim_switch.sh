#!/usr/bin/env bash
# Script to check the status of Azure VPN Gateway connections
# Required environment variables:
# - AZURE_CLIENT_ID (for managed identity login)
# - RESOURCE_RG (Resource Group of the VPN Gateway)
# - RESOURCE_NAME (Name of the VPN Gateway)
# - CLOUDO_PAYLOAD containing payload.zoneName. eg:
#   {
#     "source": "cloudo",
#     "severity": "Sev1",
#     "monitorCondition": "Fired",
#     "rule": <schema id for this runbook>,
#     "payload": {
#       "zoneName": <zone name where to change the '@' record to the  app gateway ip>
#     }
#   }

set -euo pipefail

echo "Logging into Azure..."
if [[ -n "${AZURE_CLIENT_ID:-}" ]]; then
  az login --identity --client-id "$AZURE_CLIENT_ID" > /dev/null
else
  az login --identity > /dev/null
fi

DNS_ZONE_NAME=$(echo "$CLOUDO_PAYLOAD" |  jq -r '.payload' | jq -r '.zoneName')

if [ -z "$DNS_ZONE_NAME" ] || [ "$DNS_ZONE_NAME" == "null" ]; then
  echo "DNS zone name not found, exiting with error"
  exit 1
fi

echo "DNS zone name: ${DNS_ZONE_NAME}"
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

