#!/usr/bin/env bash

#
# Apply the configuration relative to a given subscription
# Subscription are defined in ./subscription
# Usage:
#  ./liquidbase_nodo.sh DEV-pagoPA 3.9


BASHDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
WORKDIR="$BASHDIR"

set -e

SUBSCRIPTION=$1
NODO_VERSION=$2
DATABASE=nodo
shift 2
other=$@

if [ -z "${SUBSCRIPTION}" ]; then
    printf "\e[1;31mYou must provide a subscription as first argument.\n"
    exit 1
fi

if [ -z "${NODO_VERSION}" ]; then
    printf "\e[1;31mYou must provide a version as second argument.\n"
    exit 1
fi

if [ ! -d "${WORKDIR}/subscriptions/${SUBSCRIPTION}" ]; then
    printf "\e[1;31mYou must provide a subscription for which a variable file is defined. You provided: '%s'.\n" "${SUBSCRIPTION}" > /dev/stderr
    exit 1
fi

echo "Setting subscription"
az account set -s "${SUBSCRIPTION}"

# shellcheck disable=SC1090
source "${WORKDIR}/subscriptions/${SUBSCRIPTION}/backend.ini"

# shellcheck disable=SC2154
printf "Subscription: %s\n" "${SUBSCRIPTION}"
printf "Resource Group Name: %s\n" "${resource_group_name}"


# flexible-server
psql_server_name=$(az postgres flexible-server list -o tsv --query "[?contains(name,'nodo-flexible-postgresql')].{Name:name}" | head -1)
psql_server_private_fqdn=$(az postgres flexible-server list -o tsv --query "[?contains(name,'nodo-flexible-postgresql')].{Name:fullyQualifiedDomainName}" | head -1)

# kv
keyvault_name=$(az keyvault list -o tsv --query "[?contains(name,'nodo-kv')].{Name:name}")

# flexible-server
administrator_login=$(az keyvault secret show --name db-administrator-login --vault-name "${keyvault_name}" -o tsv --query value)
administrator_login_password=$(az keyvault secret show --name db-administrator-login-password --vault-name "${keyvault_name}" -o tsv --query value)

nodo_cfg_user_password=$(az keyvault secret show --name db-cfg-password --vault-name "${keyvault_name}" -o tsv --query value)
nodo_online_user_password=$(az keyvault secret show --name db-online-password --vault-name "${keyvault_name}" -o tsv --query value)
nodo_offline_user_password=$(az keyvault secret show --name db-offline-password --vault-name "${keyvault_name}" -o tsv --query value)
nodo_re_user_password=$(az keyvault secret show --name db-re-password --vault-name "${keyvault_name}" -o tsv --query value)
nodo_wfespe_user_password=$(az keyvault secret show --name db-wfesp-password --vault-name "${keyvault_name}" -o tsv --query value)

echo "Creating env file"
cd nodo

echo '
POSTGRES_DB_HOST="'${psql_server_private_fqdn}'"
POSTGRES_DB_PORT=5432
POSTGRES_DB="nodo"
POSTGRES_USER="'${administrator_login}'"
POSTGRES_PASSWORD="'${administrator_login_password}'"
NODO_CFG_USERNAME="cfg"
NODO_CFG_PASSWORD="'${nodo_cfg_user_password}'"
NODO_CFG_SCHEMA="cfg"
NODO_ONLINE_USERNAME="online"
NODO_ONLINE_PASSWORD="'${nodo_online_user_password}'"
NODO_ONLINE_SCHEMA="online"
NODO_OFFLINE_USERNAME="offline"
NODO_OFFLINE_PASSWORD="'${nodo_offline_user_password}'"
NODO_OFFLINE_SCHEMA="offline"
NODO_WFESP_USERNAME="wfesp"
NODO_WFESP_PASSWORD="'${nodo_wfespe_user_password}'"
NODO_WFESP_SCHEMA="wfesp"
NODO_RE_USERNAME="re"
NODO_RE_PASSWORD="'${nodo_re_user_password}'"
NODO_RE_SCHEMA="re"
LQB_CONTEXTS="dev"' > dev.env

cat dev.env



echo ">>>>>>>>>>>>>>>>>>>>>>>>>>> STEP#1 Configuring nodo db ( CREATE SCHEMAs if not exists... ) "
docker compose -f docker-compose-pg-init.yml up
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<< done!"

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>> STEP#2 Executing docker compose ( liquibase Migration to version $NODO_VERSION) "
export NODO_VERSION=$NODO_VERSION
docker compose -f docker-compose-liquibase.yml up
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<< Migration done!"
