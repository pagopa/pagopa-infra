#!/usr/bin/env bash

#
# Apply the configuration relative to a given subscription
# Subscription are defined in ./subscription
# Usage:
#  ./liquidbase_nodo.sh 3.9


BASHDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
WORKDIR="$BASHDIR"

set -e

NODO_VERSION=$1
WEB_BO_VERSION=$2
DATABASE=nodo
shift 2
other=$@

if [ -z "${NODO_VERSION}" ]; then
    printf "\e[1;31mYou must provide a version as second argument.\n"
    exit 1
fi

printf "Creating env file"

echo 'POSTGRES_DB_HOST="db-nodo"
POSTGRES_DB_PORT=5432
POSTGRES_DB="nodo"
POSTGRES_USER="root"
POSTGRES_PASSWORD="password"
NODO_CFG_USERNAME="cfg"
NODO_CFG_PASSWORD="cfg"
NODO_CFG_SCHEMA="cfg"
NODO_ONLINE_USERNAME="online"
NODO_ONLINE_PASSWORD="online"
NODO_ONLINE_SCHEMA="online"
NODO_OFFLINE_USERNAME="offline"
NODO_OFFLINE_PASSWORD="offline"
NODO_OFFLINE_SCHEMA="offline"
NODO_WFESP_USERNAME="wfesp"
NODO_WFESP_PASSWORD="wfesp"
NODO_WFESP_SCHEMA="wfesp"
NODO_RE_USERNAME="re"
NODO_RE_PASSWORD="re"
NODO_RE_SCHEMA="re"
WEB_BO_USERNAME="web-bo"
WEB_BO_PASSWORD="web-bo"
WEB_BO_SCHEMA="web-bo"
LQB_CONTEXTS="dev"
' > dev.env

cat dev.env

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>> STEP#1 (re)creating nodo db ( CREATE SCHEMAs ... ) "
docker compose -f postgresql.yml down -v --remove-orphans
docker compose -f postgresql.yml up -d
sleep 2
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<< done!"



echo ">>>>>>>>>>>>>>>>>>>>>>>>>>> STEP#2 Executing docker compose ( liquibase Migration to nodo version $NODO_VERSION) "
export NODO_VERSION=$NODO_VERSION
docker compose -f ./liquibase-nodo.yml up
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<< Migration done!"

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>> STEP#2 Executing docker compose ( liquibase Migration to web-bo version $WEB_BO_VERSION) "
export WEB_BO_VERSION=$WEB_BO_VERSION
docker compose -f ./liquibase-web-bo.yml up
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<< Migration done!"

