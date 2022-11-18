#!/usr/bin/env bash

#
# Apply the configuration relative to a given subscription
# Subscription are defined in ./subscription
# Usage:
#  ./liquidbase_nodo.sh DEV-pagoPA


BASHDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
WORKDIR="$BASHDIR"

set -e

SUBSCRIPTION=$1
DATABASE=nodo
shift 1
other=$@

if [ -z "${SUBSCRIPTION}" ]; then
    printf "\e[1;31mYou must provide a subscription as first argument.\n"
    exit 1
fi

if [ ! -d "${WORKDIR}/subscriptions/${SUBSCRIPTION}" ]; then
    printf "\e[1;31mYou must provide a subscription for which a variable file is defined. You provided: '%s'.\n" "${SUBSCRIPTION}" > /dev/stderr
    exit 1
fi

echo "Setting subscription"
# az account set -s "${SUBSCRIPTION}"

# shellcheck disable=SC1090
source "${WORKDIR}/subscriptions/${SUBSCRIPTION}/backend.ini"

# shellcheck disable=SC2154
printf "Subscription: %s\n" "${SUBSCRIPTION}"
printf "Resource Group Name: %s\n" "${resource_group_name}"


# flexible-server
psql_server_name=$(az postgres flexible-server list -o tsv --query "[?contains(name,'nodo-flexible')].{Name:name}" | head -1)
psql_server_private_fqdn=$(az postgres flexible-server list -o tsv --query "[?contains(name,'nodo-flexible')].{Name:fullyQualifiedDomainName}" | head -1)

# kv
keyvault_name=$(az keyvault list -o tsv --query "[?contains(name,'nodo-kv')].{Name:name}")

# flexible-server
administrator_login=$(az keyvault secret show --name db-administrator-login --vault-name "${keyvault_name}" -o tsv --query value)
administrator_login_password=$(az keyvault secret show --name db-administrator-login-password --vault-name "${keyvault_name}" -o tsv --query value)

nodo_cfg_user=$(az keyvault secret show --name db-nodo-cfg-login --vault-name "${keyvault_name}" -o tsv --query value)
nodo_cfg_user_password=$(az keyvault secret show --name db-nodo-cfg-login-password --vault-name "${keyvault_name}" -o tsv --query value)

#export ADMIN_USER="${administrator_login}"
#export FLYWAY_URL="jdbc:postgresql://${psql_server_private_fqdn}:5432/${DATABASE}?sslmode=require"
#export FLYWAY_USER="${administrator_login}"
#export FLYWAY_PASSWORD="${administrator_login_password}"
#export SERVER_NAME="${psql_server_name}"
#export FLYWAY_DOCKER_TAG="7.11.1-alpine"
#export FLYWAY_SCHEMAS="${SCHEMA}"
#export NODO_CFG_DB_USER="${nodo_cfg_user}"
#export NODO_CFG_DB_PASS="${nodo_cfg_user_password}"
#printf "user [%s] pwd [%s] schema [%s]\n" "${NODO_CFG_DB_USER}" "${NODO_CFG_DB_PASS}"

printf "Creating env file"
cd migrations/${SUBSCRIPTION}/nodo

echo 'POSTGRES_DB_HOST="'${psql_server_private_fqdn}'"
POSTGRES_DB_PORT=5432
POSTGRES_DB="nodo"
POSTGRES_USER="'${administrator_login}'"
POSTGRES_PASSWORD="'${administrator_login_password}'"
NODO_CFG_USERNAME="'${nodo_cfg_user}'"
NODO_CFG_PASSWORD="'${nodo_cfg_user_password}'"
NODO_CFG_SCHEMA="nodo4_cfg_dev"
NODO_CFG_TABLESPACE_DATA="nodo4_cfg_data"
NODO_CFG_TABLESPACE_LOB="nodo4_cfg_lob"
NODO_CFG_TABLESPACE_IDX="nodo4_cfg_idx"
NODO_ONLINE_USERNAME="nodo_online_dev"
NODO_ONLINE_PASSWORD="nodo_online_dev"
NODO_ONLINE_SCHEMA="nodo_online_dev"
NODO_ONLINE_TABLESPACE_DATA="nodo_online_data"
NODO_ONLINE_TABLESPACE_LOB="nodo_online_lob"
NODO_ONLINE_TABLESPACE_IDX="nodo_online_idx"
NODO_OFFLINE_USERNAME="nodo_offline_dev"
NODO_OFFLINE_PASSWORD="nodo_offline_dev"
NODO_OFFLINE_SCHEMA="nodo_offline_dev"
NODO_OFFLINE_TABLESPACE_DATA="nodo_offline_data"
NODO_OFFLINE_TABLESPACE_LOB="nodo_offline_lob"
NODO_OFFLINE_TABLESPACE_IDX="nodo_offline_idx"
NODO_WFESP_USERNAME="wfesp_dev"
NODO_WFESP_PASSWORD="wfesp_dev"
NODO_WFESP_SCHEMA="wfesp_dev"
NODO_WFESP_TABLESPACE_DATA="wfesp_dev_data"
NODO_WFESP_TABLESPACE_LOB="wfesp_dev_lob"
NODO_WFESP_TABLESPACE_IDX="wfesp_dev_idx"
NODO_RE_USERNAME="re_dev"
NODO_RE_PASSWORD="re_dev"
NODO_RE_SCHEMA="re_dev"
NODO_RE_TABLESPACE_DATA="re_dev_data"
NODO_RE_TABLESPACE_LOB="re_dev_lob"
NODO_RE_TABLESPACE_IDX="re_dev_idx"
LQB_CONTEXTS="!dev"
' > dev.env

cat dev.env

echo -n "Configure nodo db ..."
sh postgres-scripts/100-nodo-create.sh
echo "DONE!"


echo "Executing docker compose"
#docker compose -f docker-compose-liquibase.yml up

echo "Migration done"

#docker run --rm -it --network=host -v "${WORKDIR}/migrations/${SUBSCRIPTION}/${DATABASE}":/flyway/sql \
#  flyway/flyway:"${FLYWAY_DOCKER_TAG}" \
#  -url="${FLYWAY_URL}" -user="${FLYWAY_USER}" -password="${FLYWAY_PASSWORD}" \
#  -validateMigrationNaming=true \
#  -placeholders.admin="${ADMIN_USER}" \
#  -placeholders.db_user="${NODO_CFG_DB_USER}" \
#  -placeholders.db_user_password="${NODO_CFG_DB_PASS}" \
#  -placeholders.database="${DATABASE}" \
#  -placeholders.db_schema="${FLYWAY_SCHEMAS}" \
#  "${COMMAND}" ${other}
