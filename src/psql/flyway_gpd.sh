#!/usr/bin/env bash

#
# Apply the configuration relative to a given subscription
# Subscription are defined in ./subscription
# Usage:
#  ./flyway_gpd.sh info|validate|migrate DEV-pagoPA apd APD_USER -schemas=apd
#  ./flyway_gpd.sh info DEV-pagoPA apd apd -schemas=apd
#  ./flyway_gpd.sh info UAT-pagoPA apd apd -schemas=apd
#  ./flyway_gpd.sh info PROD-pagoPA apd apd -schemas=apd


BASHDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
WORKDIR="$BASHDIR"

set -e

COMMAND=$1
SUBSCRIPTION=$2
DATABASE=$3
SCHEMA=$4
shift 4
other=$@

if [ -z "${SUBSCRIPTION}" ]; then
    printf "\e[1;31mYou must provide a subscription as first argument.\n"
    exit 1
fi

if [ ! -d "${WORKDIR}/subscriptions/${SUBSCRIPTION}" ]; then
    printf "\e[1;31mYou must provide a subscription for which a variable file is defined. You provided: '%s'.\n" "${SUBSCRIPTION}" > /dev/stderr
    exit 1
fi

az account set -s "${SUBSCRIPTION}"

# shellcheck disable=SC1090
source "${WORKDIR}/subscriptions/${SUBSCRIPTION}/backend.ini"

# shellcheck disable=SC2154
printf "Subscription: %s\n" "${SUBSCRIPTION}"
printf "Resource Group Name: %s\n" "${resource_group_name}"


# if [ $SUBSCRIPTION == "DEV-pagoPA" ]; then # ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️ DEPRECATED ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
#     # single-server
#     psql_server_name=$(az postgres server list -o tsv --query "[?contains(name,'gpd-postgresql')].{Name:name}" | head -1)
#     psql_server_private_fqdn=$(az postgres server list -o tsv --query "[?contains(name,'gpd-postgresql')].{Name:fullyQualifiedDomainName}" | head -1)
# fi

printf ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>       1\n"

# flexible-server
psql_server_name=$(az postgres flexible-server list -o tsv --query "[?contains(name,'pgflex')].{Name:name}" | grep "weu-gpd" | head -1)
psql_server_private_fqdn=$(az postgres flexible-server list -o tsv --query "[?contains(name,'pgflex')].{Name:fullyQualifiedDomainName}" | grep "weu-gpd" | head -1)

# kv
keyvault_name=$(az keyvault list -o tsv --query "[?contains(name,'gps')].{Name:name}")

printf ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>       2\n"

# if [ $SUBSCRIPTION == "DEV-pagoPA" ]; then # ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️ DEPRECATED ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
#     # single-server
#     administrator_login="$(az keyvault secret show --name pgres-admin-login --vault-name "${keyvault_name}" -o tsv --query value)@pagopa-d-gpd-postgresql"
#     administrator_login_password=$(az keyvault secret show --name pgres-admin-pwd --vault-name "${keyvault_name}" -o tsv --query value)
# fi

# flexible-server
administrator_login=$(az keyvault secret show --name pgres-admin-login --vault-name "${keyvault_name}" -o tsv --query value)
administrator_login_password=$(az keyvault secret show --name pgres-admin-pwd --vault-name "${keyvault_name}" -o tsv --query value)

printf ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>       3\n"

echo ${administrator_login}

apd_user_password=$(az keyvault secret show --name db-apd-user-password --vault-name "${keyvault_name}" -o tsv --query value)
apd_user=$(az keyvault secret show --name db-apd-user-name --vault-name "${keyvault_name}" -o tsv --query value)

printf ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>       4\n"

cdc_user_password=$(az keyvault secret show --name cdc-logical-replication-apd-pwd --vault-name "${keyvault_name}" -o tsv --query value)
cdc_user=$(az keyvault secret show --name cdc-logical-replication-apd-user --vault-name "${keyvault_name}" -o tsv --query value)

printf ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>       5\n"

export ADMIN_USER="${administrator_login}"
export FLYWAY_URL="jdbc:postgresql://${psql_server_private_fqdn}:5432/${DATABASE}?sslmode=require"
#export FLYWAY_USER="${administrator_login}@${psql_server_name}"
export FLYWAY_USER="${administrator_login}"
export FLYWAY_PASSWORD="${administrator_login_password}"
export SERVER_NAME="${psql_server_name}"
export FLYWAY_DOCKER_TAG="10-alpine"
export FLYWAY_SCHEMAS="${SCHEMA}"
# ADP USR
export APD_DB_USER="${apd_user}"
export APD_DB_PASS="${apd_user_password}"
# CDC USR
export CDC_LOGICAL_REPLICATION_DB_USER="${cdc_user}"
export CDC_LOGICAL_REPLICATION_DB_PASS="${cdc_user_password}"

printf "${psql_server_private_fqdn}"
printf "user [%s] pwd [%s] schema [%s]\n" "${APD_DB_USER}" "${APD_DB_PASS}" "${FLYWAY_SCHEMAS}" "${CDC_LOGICAL_REPLICATION_DB_USER}" "${CDC_LOGICAL_REPLICATION_DB_PASS}"

# ADP USER ( GPD default ust)
# https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-logical#prerequisites-for-logical-replication-and-logical-decoding
# CDC usr >>> ALTER ROLE <adminname> WITH REPLICATION ( ✋ creation )
docker run --rm -it --network=host -v "${WORKDIR}/migrations/${SUBSCRIPTION}/${DATABASE}":/flyway/sql \
  flyway/flyway:"${FLYWAY_DOCKER_TAG}" \
  -url="${FLYWAY_URL}" -user="${FLYWAY_USER}" -password="${FLYWAY_PASSWORD}" \
  -validateMigrationNaming=true \
  -placeholders.admin="${ADMIN_USER}" \
  -placeholders.db_user="${APD_DB_USER}" \
  -placeholders.db_user_password="${APD_DB_PASS}" \
  -placeholders.db_user_cdc="${CDC_LOGICAL_REPLICATION_DB_USER}" \
  -placeholders.db_user_cdc_password="${CDC_LOGICAL_REPLICATION_DB_PASS}" \
  -placeholders.database="${DATABASE}" \
  -placeholders.db_schema="${FLYWAY_SCHEMAS}" \
  "${COMMAND}" ${other}

