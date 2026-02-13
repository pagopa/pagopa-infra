#!/usr/bin/env bash
# Script to check the status of Azure VPN Gateway connections
# Required environment variables:
# - AZURE_CLIENT_ID (for managed identity login)
# - RESOURCE_RG (Resource Group of the VPN Gateway)
# - RESOURCE_NAME (Name of the VPN Gateway)

set -euo pipefail

RG_NAME=${RESOURCE_RG:-""}
VPN_GW_NAME=${RESOURCE_NAME:-""}

if [ -z "$RG_NAME" ] || [ -z "$VPN_GW_NAME" ]; then
  echo "Error: RESOURCE_RG and RESOURCE_NAME environment variables are required."
  exit 1
fi

echo "Logging into Azure..."
if [[ -n "${AZURE_CLIENT_ID:-}" ]]; then
  az login --identity --client-id "$AZURE_CLIENT_ID" > /dev/null
else
  az login --identity > /dev/null
fi

echo "Checking VPN Gateway connections status for: $VPN_GW_NAME in $RG_NAME"
echo "------------------------------------------------------------------------"

# Get connections associated with the VPN Gateway
CONNECTIONS=$(az network vpn-connection list --resource-group "$RG_NAME" --query "[?virtualNetworkGateway1.id && contains(virtualNetworkGateway1.id, '$VPN_GW_NAME')].{name:name, status:connectionStatus, egress:egressBytesTransferred, ingress:ingressBytesTransferred}" -o json)

if [ "$CONNECTIONS" == "[]" ]; then
  echo "No connections found for VPN Gateway $VPN_GW_NAME."
  exit 0
fi

EXIT_CODE=0
echo "$CONNECTIONS" | jq -c '.[]' | while read -r connection; do
  NAME=$(echo "$connection" | jq -r '.name')
  STATUS=$(echo "$connection" | jq -r '.status')
  EGRESS=$(echo "$connection" | jq -r '.egress')
  INGRESS=$(echo "$connection" | jq -r '.ingress')

  echo "Connection: $NAME"
  echo "  Status:  $STATUS"
  echo "  Traffic: In: $INGRESS bytes, Out: $EGRESS bytes"

  if [ "$STATUS" != "Connected" ]; then
    echo "  WARNING: Connection $NAME is in state $STATUS!"
    EXIT_CODE=1
  fi
  echo "---------------------------------------------------"
done

# If EXIT_CODE was set in the loop, we need a way to propagate it. 
# Since while read runs in a subshell, let's use a temporary file or check the overall status.

DISCONNECTED=$(echo "$CONNECTIONS" | jq -r '.[] | select(.status != "Connected") | .name')

if [ -n "$DISCONNECTED" ]; then
  echo "Critical: The following connections are NOT connected:"
  echo "$DISCONNECTED"
  exit 1
else
  echo "All VPN connections are healthy."
  exit 0
fi
