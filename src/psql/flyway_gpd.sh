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


if [ $SUBSCRIPTION == "DEV-pagoPA" ]; then
    # single-server
    psql_server_name=$(az postgres server list -o tsv --query "[?contains(name,'postgresql')].{Name:name}" | head -1)
    psql_server_private_fqdn=$(az postgres server list -o tsv --query "[?contains(name,'postgresql')].{Name:fullyQualifiedDomainName}" | head -1)
else
    # flexible-server
    psql_server_name=$(az postgres flexible-server list -o tsv --query "[?contains(name,'pgflex')].{Name:name}" | head -1)
    psql_server_private_fqdn=$(az postgres flexible-server list -o tsv --query "[?contains(name,'pgflex')].{Name:fullyQualifiedDomainName}" | head -1)
fi

# kv
keyvault_name=$(az keyvault list -o tsv --query "[?contains(name,'kv')].{Name:name}" | sed -n 2p)


if [ $SUBSCRIPTION == "DEV-pagoPA" ]; then
    # single-server
    administrator_login=$(az keyvault secret show --name db-administrator-login --vault-name "${keyvault_name}" -o tsv --query value)
    administrator_login_password=$(az keyvault secret show --name db-administrator-login-password --vault-name "${keyvault_name}" -o tsv --query value)
else
    # flexible-server
    administrator_login=$(az keyvault secret show --name pgres-flex-admin-login --vault-name "${keyvault_name}" -o tsv --query value)
    administrator_login_password=$(az keyvault secret show --name pgres-flex-admin-pwd --vault-name "${keyvault_name}" -o tsv --query value)
fi

apd_user_password=$(az keyvault secret show --name db-apd-user-password --vault-name "${keyvault_name}" -o tsv --query value)
apd_user=$(az keyvault secret show --name db-apd-user-name --vault-name "${keyvault_name}" -o tsv --query value)

export ADMIN_USER="${administrator_login}"
export FLYWAY_URL="jdbc:postgresql://${psql_server_private_fqdn}:5432/${DATABASE}?sslmode=require"
#export FLYWAY_USER="${administrator_login}@${psql_server_name}"
export FLYWAY_USER="${administrator_login}"
export FLYWAY_PASSWORD="${administrator_login_password}"
export SERVER_NAME="${psql_server_name}"
export FLYWAY_DOCKER_TAG="7.11.1-alpine"
export FLYWAY_SCHEMAS="${SCHEMA}"
export APD_DB_USER="${apd_user}"
export APD_DB_PASS="${apd_user_password}"

printf "user [%s] pwd [%s] schema [%s]\n" "${APD_DB_USER}" "${APD_DB_PASS}" "${FLYWAY_SCHEMAS}"

docker run --rm -it --network=host -v "${WORKDIR}/migrations/${SUBSCRIPTION}/${DATABASE}":/flyway/sql \
  flyway/flyway:"${FLYWAY_DOCKER_TAG}" \
  -url="${FLYWAY_URL}" -user="${FLYWAY_USER}" -password="${FLYWAY_PASSWORD}" \
  -validateMigrationNaming=true \
  -placeholders.admin="${ADMIN_USER}" \
  -placeholders.db_user="${APD_DB_USER}" \
  -placeholders.db_user_password="${APD_DB_PASS}" \
  -placeholders.database="${DATABASE}" \
  -placeholders.db_schema="${FLYWAY_SCHEMAS}" \
  "${COMMAND}" ${other}
