#!/bin/bash

#export POSTGRES_DB_HOST="pagopa-d-weu-nodo-flexible-postgresql.postgres.database.azure.com"
#export POSTGRES_DB_PORT="5432"
#export POSTGRES_DB="nodo"
#export NODO_CFG_SCHEMA="cfg"
#export LQB_CONTEXTS="dev,integ"
#export NODO_CFG_USERNAME="cfg"
#export NODO_CFG_PASSWORD="password"

CONTEXTS=$1
DOMAIN=$2

export POSTGRES_DB_HOST="localhost"
export POSTGRES_DB_PORT="5432"
export POSTGRES_DB="nodo"
export NODO_CFG_SCHEMA="cfg"
export LQB_CONTEXTS=$CONTEXTS
export NODO_CFG_USERNAME="cfg"
export NODO_CFG_PASSWORD="cfg"

echo "
classpath: ./changelog/cfg/
liquibase.headless: true
url: jdbc:postgresql://${POSTGRES_DB_HOST}:${POSTGRES_DB_PORT}/${POSTGRES_DB}?currentSchema=${NODO_CFG_SCHEMA}
contexts: ${LQB_CONTEXTS}
username: ${NODO_CFG_USERNAME}
password: ${NODO_CFG_PASSWORD}
defaultSchemaName: ${NODO_CFG_SCHEMA}
liquibaseSchemaName: ${NODO_CFG_SCHEMA}
parameter.schema: ${NODO_CFG_SCHEMA}
parameter.domain: ${DOMAIN}
liquibase.hub.mode: OFF
log-level: INFO
" > cfg.properties

#liquibase --defaultsFile=cfg.properties drop-all

liquibase --defaultsFile=cfg.properties update --changelogFile="db.changelog-master-3.10.0.xml"

rm cfg.properties
