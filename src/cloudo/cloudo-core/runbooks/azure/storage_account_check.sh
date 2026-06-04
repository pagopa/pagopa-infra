#!/usr/bin/env bash
# Script to check the health and configuration of an Azure Storage Account
# Required environment variables:
# - AZURE_CLIENT_ID (for managed identity login)
# - RESOURCE_RG (Resource Group)
# - RESOURCE_NAME (Storage Account Name)

set -euo pipefail

RG_NAME=${RESOURCE_RG:-""}
STORAGE_ACCOUNT_NAME=${RESOURCE_NAME:-""}

if [ -z "$RG_NAME" ] || [ -z "$STORAGE_ACCOUNT_NAME" ]; then
  echo "Error: RESOURCE_RG and RESOURCE_NAME environment variables are required."
  exit 1
fi

echo "Logging into Azure..."
if [[ -n "${AZURE_CLIENT_ID:-}" ]]; then
  az login --identity --client-id "$AZURE_CLIENT_ID" > /dev/null
else
  az login --identity > /dev/null
fi

echo "Checking Storage Account: $STORAGE_ACCOUNT_NAME in $RG_NAME"
echo "------------------------------------------------------------------------"

# Check account properties
ACCOUNT_INFO=$(az storage account show --name "$STORAGE_ACCOUNT_NAME" --resource-group "$RG_NAME" --output json)

STATUS=$(echo "$ACCOUNT_INFO" | jq -r '.statusOfPrimary')
PROVISIONING=$(echo "$ACCOUNT_INFO" | jq -r '.provisioningState')
KIND=$(echo "$ACCOUNT_INFO" | jq -r '.kind')
SKU=$(echo "$ACCOUNT_INFO" | jq -r '.sku.name')

echo "Provisioning State: $PROVISIONING"
echo "Primary Status:     $STATUS"
echo "Kind/SKU:           $KIND / $SKU"

EXIT_CODE=0

if [ "$PROVISIONING" != "Succeeded" ]; then
  echo "WARNING: Provisioning state is $PROVISIONING"
  EXIT_CODE=1
fi

if [ "$STATUS" != "available" ]; then
  echo "WARNING: Primary status is $STATUS"
  EXIT_CODE=1
fi

echo "------------------------------------------------------------------------"
echo "Checking Network Rules..."
NET_RULES=$(az storage account show --name "$STORAGE_ACCOUNT_NAME" --resource-group "$RG_NAME" --query "networkRuleSet" -o json)
DEFAULT_ACTION=$(echo "$NET_RULES" | jq -r '.defaultAction')
echo "Default Network Action: $DEFAULT_ACTION"

if [ "$DEFAULT_ACTION" == "Deny" ]; then
  IP_RULES_COUNT=$(echo "$NET_RULES" | jq '.ipRules | length')
  VNET_RULES_COUNT=$(echo "$NET_RULES" | jq '.virtualNetworkRules | length')
  echo "Network access restricted (Deny by default). Rules: $IP_RULES_COUNT IP rules, $VNET_RULES_COUNT VNET rules."
else
  echo "WARNING: Storage account has open network access (Allow by default)."
fi

# Check Blob Service availability (basic check by listing containers)
echo "------------------------------------------------------------------------"
echo "Checking Blob Service..."
if az storage container list --account-name "$STORAGE_ACCOUNT_NAME" --auth-mode login --query "length(@)" -o tsv > /dev/null 2>&1; then
  CONTAINER_COUNT=$(az storage container list --account-name "$STORAGE_ACCOUNT_NAME" --auth-mode login --query "length(@)" -o tsv)
  echo "Blob service is accessible. Found $CONTAINER_COUNT containers."
else
  echo "Warning: Could not list containers using current identity. This might be due to lack of 'Storage Blob Data Reader' role."
fi

exit $EXIT_CODE
