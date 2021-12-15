#!/usr/bin/env bash

#
# Apply the configuration relative to a given subscription
# Subscription are defined in ./subscription
# Usage:
#  ./flyway.sh info|validate|migrate ENV-pagoPA mock-psp -schemas=mock_psp_u


BASHDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
WORKDIR="$BASHDIR"

set -e

COMMAND=$1
SUBSCRIPTION=$2
DATABASE=$3
shift 3
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

psql_server_name=$(az postgres server list -o tsv --query "[?contains(name,'postgresql')].{Name:name}" | head -1)
psql_server_private_fqdn=$(az postgres server list -o tsv --query "[?contains(name,'postgresql')].{Name:fullyQualifiedDomainName}" | head -1)
keyvault_name=$(az keyvault list -o tsv --query "[?contains(name,'kv')].{Name:name}")

administrator_login=$(az keyvault secret show --name db-administrator-login --vault-name "${keyvault_name}" -o tsv --query value)
administrator_login_password=$(az keyvault secret show --name db-administrator-login-password --vault-name "${keyvault_name}" -o tsv --query value)
paypal_psp_hmac_key=$(az keyvault secret show --name paypal-psp-hmac-key --vault-name "${keyvault_name}" -o tsv --query value)
mock_psp_auth_key=$(az keyvault secret show --name mock-psp-auth-key --vault-name "${keyvault_name}" -o tsv --query value)

export ADMIN_USER="${administrator_login}"
export FLYWAY_URL="jdbc:postgresql://${psql_server_private_fqdn}:5432/${DATABASE}?sslmode=require"
export FLYWAY_USER="${administrator_login}@${psql_server_name}"
export FLYWAY_PASSWORD="${administrator_login_password}"
export SERVER_NAME="${psql_server_name}"
export FLYWAY_DOCKER_TAG="7.11.1-alpine"
export FLYWAY_SCHEMAS="${SCHEMA}"
export PAYPAL_PSP_HMAC_KEY="${paypal_psp_hmac_key}"
export MOCK_PSP_AUTH_KEY="${mock_psp_auth_key}"

mockpsp_user_password=$(az keyvault secret show --name db-mock-psp-user-login --vault-name "${keyvault_name}" -o tsv --query value)

export mockpsp_user_password="${mockpsp_user_password}"


docker run --rm -it --network=host -v "${WORKDIR}/migrations/${SUBSCRIPTION}/${DATABASE}":/flyway/sql \
  flyway/flyway:"${FLYWAY_DOCKER_TAG}" \
  -url="${FLYWAY_URL}" -user="${FLYWAY_USER}" -password="${FLYWAY_PASSWORD}" \
  -validateMigrationNaming=true \
  -placeholders.paypal_psp_hmac_key="${PAYPAL_PSP_HMAC_KEY}" \
  -placeholders.mock_psp_auth_key="${MOCK_PSP_AUTH_KEY}" \
  -placeholders.admin="${ADMIN_USER}" \
  "${COMMAND}" ${other}
