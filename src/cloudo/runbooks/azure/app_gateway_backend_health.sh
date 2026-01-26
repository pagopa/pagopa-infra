#!/usr/bin/env bash
# Script to check the backend health of an Azure Application Gateway
# Required environment variables:
# - AZURE_CLIENT_ID (for managed identity login)
# - RESOURCE_RG (Resource Group of the App Gateway)
# - RESOURCE_NAME (Name of the App Gateway)

set -euo pipefail

RG_NAME=${RESOURCE_RG:-""}
APPGW_NAME=${RESOURCE_NAME:-""}

if [ -z "$RG_NAME" ] || [ -z "$APPGW_NAME" ]; then
  echo "Error: RESOURCE_RG and RESOURCE_NAME environment variables are required."
  exit 1
fi

echo "Logging into Azure..."
if [[ -n "${AZURE_CLIENT_ID:-}" ]]; then
  az login --identity --client-id "$AZURE_CLIENT_ID" > /dev/null
else
  az login --identity > /dev/null
fi

echo "Checking Backend Health for Application Gateway: $APPGW_NAME in $RG_NAME"
echo "------------------------------------------------------------------------"

HEALTH_JSON=$(az network application-gateway show-backend-health --resource-group "$RG_NAME" --name "$APPGW_NAME" --output json)

EXIT_CODE=0

# Iterate over backend address pools
echo "$HEALTH_JSON" | jq -c '.backendAddressPools[]' | while read -r pool; do
  POOL_NAME=$(echo "$pool" | jq -r '.backendAddressPool.id' | awk -F'/' '{print $11}')
  echo "Backend Pool: $POOL_NAME"
  
  # Iterate over HTTP settings within the pool
  echo "$pool" | jq -c '.backendHttpSettingsCollection[]' | while read -r setting; do
    SETTING_NAME=$(echo "$setting" | jq -r '.backendHttpSettings.id' | awk -F'/' '{print $13}')
    echo "  HTTP Setting: $SETTING_NAME"
    
    # Iterate over servers
    echo "$setting" | jq -c '.servers[]' | while read -r server; do
      ADDRESS=$(echo "$server" | jq -r '.address')
      HEALTH=$(echo "$server" | jq -r '.health')
      echo "    Server: $ADDRESS - Health: $HEALTH"
      
      if [ "$HEALTH" != "Healthy" ]; then
        echo "    WARNING: Backend $ADDRESS is $HEALTH!"
        # To propagate error from nested loops, we'll check the final JSON at the end
      fi
    done
  done
  echo "---------------------------------------------------"
done

# Check if there are any Unhealthy backends in the whole JSON
UNHEALTHY_COUNT=$(echo "$HEALTH_JSON" | jq '[.backendAddressPools[].backendHttpSettingsCollection[].servers[] | select(.health != "Healthy")] | length')

if [ "$UNHEALTHY_COUNT" -gt 0 ]; then
  echo "Critical: Found $UNHEALTHY_COUNT unhealthy backend(s)!"
  exit 1
else
  echo "All backends are healthy."
  exit 0
fi
