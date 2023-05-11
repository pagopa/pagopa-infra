#!/usr/bin/env bash
set -e

#
# Apply the configuration relative to a given subscription
# Subscription are defined in ./subscription
# Usage:
#  ./create-terraform-storage.sh SUBSCRIPTION_NAME

SUBSCRIPTION=$1
STORAGE_TYPE=$2
ENABLE_ADVANCED_THREAT_PROTECTION=$3

if [ -z "${SUBSCRIPTION}" ]; then
    printf "\e[1;31mYou must provide a subscription as first argument.\n"
    exit 1
fi

LOCATION="westeurope"
LOCATION_SHORT="weu"
RESOURCE_GROUP_NAME="terraform-state-rg"
STORAGE_ACCOUNT_NAME=${SUBSCRIPTION//-/}
STORAGE_ACCOUNT_NAME=$(echo "$STORAGE_ACCOUNT_NAME" | tr '[:upper:]' '[:lower:]')
STORAGE_ACCOUNT_NAME="tf${STORAGE_TYPE}${STORAGE_ACCOUNT_NAME}"
STORAGE_ACCOUNT_CONTAINERS=("terraform-state")

echo "[INFO] SUBSCRIPTION: ${SUBSCRIPTION}"
echo "[INFO] LOCATION: ${LOCATION}"
echo "[INFO] LOCATION_SHORT: ${LOCATION_SHORT}"
echo "[INFO] RESOURCE_GROUP_NAME: ${RESOURCE_GROUP_NAME}"
echo "[INFO] STORAGE_ACCOUNT_NAME: ${STORAGE_ACCOUNT_NAME}"
echo "[INFO] STORAGE_ACCOUNT_CONTAINERS: ${STORAGE_ACCOUNT_CONTAINERS}"

az account set -s "${SUBSCRIPTION}"
az provider register -n 'Microsoft.Storage'

# Create RESOURCE_GROUP if not exixts
if [ "$(az group exists --name ${RESOURCE_GROUP_NAME})" = false ]; then
    az group create --name "${RESOURCE_GROUP_NAME}" --location "${LOCATION}"
    echo "[INFO] RESOURCE_GROUP ${RESOURCE_GROUP_NAME} created"
else
    echo "[INFO] RESOURCE_GROUP ${RESOURCE_GROUP_NAME} already exists"
fi

# Create STORAGE_ACCOUNT if not exixts
# shellcheck disable=SC2046
if [ $(az storage account check-name -n "${STORAGE_ACCOUNT_NAME}" --query nameAvailable -o tsv) == "true" ]; then
    az storage account create -g "${RESOURCE_GROUP_NAME}" -n "${STORAGE_ACCOUNT_NAME}" -l "${LOCATION}" --sku Standard_GZRS --min-tls-version TLS1_2
    echo "[INFO] storage account: ${STORAGE_ACCOUNT_NAME} created"
else
    echo "[INFO] storage account: ${STORAGE_ACCOUNT_NAME} already exists"
fi

# 🗄 STORAGE ACCOUNT/CONTAINERS
for CONTAINER_NAME in "${STORAGE_ACCOUNT_CONTAINERS[@]}";
do
    # shellcheck disable=SC2046
    if [ $(az storage container exists --account-name "${STORAGE_ACCOUNT_NAME}" -n "${CONTAINER_NAME}" --auth-mode login -o tsv --only-show-errors) == "False" ]; then
        az storage container create -n "${CONTAINER_NAME}" --account-name "${STORAGE_ACCOUNT_NAME}" --auth-mode login --only-show-errors
        echo "[INFO] container: ${CONTAINER_NAME} created"
        sleep 30
    else
        echo "[INFO] container: ${CONTAINER_NAME} already exists"
    fi
done

az storage account blob-service-properties update \
  --account-name "${STORAGE_ACCOUNT_NAME}" \
  --resource-group "${RESOURCE_GROUP_NAME}" \
  --enable-delete-retention true \
  --enable-container-delete-retention true \
  --container-delete-retention-days 30 \
  --enable-restore-policy true \
  --restore-days 29 \
  --delete-retention-days 30 \
  --enable-change-feed true \
  --change-feed-retention-days 30 \
  --enable-versioning true

echo "[INFO] blob-service-properties updated"

az storage account update \
  --name "${STORAGE_ACCOUNT_NAME}" \
  --resource-group "${RESOURCE_GROUP_NAME}" \
  --min-tls-version TLS1_2 \
  --sku Standard_GZRS \
  --allow-blob-public-access false \
  --allow-shared-key-access true

az security atp storage update --is-enabled "${ENABLE_ADVANCED_THREAT_PROTECTION}" \
  --storage-account "${STORAGE_ACCOUNT_NAME}" \
  --resource-group "${RESOURCE_GROUP_NAME}" \
  --subscription "${SUBSCRIPTION}"

echo "[INFO] security advanced threat protection storage updated"
