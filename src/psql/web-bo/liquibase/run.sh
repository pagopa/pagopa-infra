#!/bin/bash

#export POSTGRES_DB_HOST="pagopa-d-weu-nodo-flexible-postgresql.postgres.database.azure.com"
#export POSTGRES_DB_PORT="5432"
#export POSTGRES_DB="nodo"
#export NODO_CFG_SCHEMA="cfg"
#export LQB_CONTEXTS="dev,integ"
#export NODO_CFG_USERNAME="cfg"
#export NODO_CFG_PASSWORD="password"

export JDBC_URL="jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1624)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=NDPSPCA_WEB)))"
export JDBC_URL="jdbc:postgresql://${POSTGRES_DB_HOST}:${POSTGRES_DB_PORT}/${POSTGRES_DB}?sslmode=require&prepareThreshold=0&currentSchema=${NODO_CFG_SCHEMA}"
export POSTGRES_DB_HOST="pagopa-u-weu-nodo-flexible-postgresql.postgres.database.azure.com"
export POSTGRES_DB_PORT="5432"
export POSTGRES_DB="nodo"
export NODO_CFG_SCHEMA="cfg"
export LQB_CONTEXTS="uat"
export NODO_CFG_USERNAME="cfg"
export NODO_CFG_PASSWORD="password"

#export POSTGRES_DB_HOST="localhost"
#export POSTGRES_DB_PORT="5432"
#export POSTGRES_DB="nodo"
#export NODO_CFG_SCHEMA="cfg"
#export LQB_CONTEXTS=$CONTEXTS
#export NODO_CFG_USERNAME="cfg"
#export NODO_CFG_PASSWORD="cfg"

CONTEXTS=$1
DOMAIN=$2



echo "
classpath: ./changelog/cfg/
liquibase.headless: true
url: ${JDBC_URL}
url: jdbc:postgresql://${POSTGRES_DB_HOST}:${POSTGRES_DB_PORT}/${POSTGRES_DB}?sslmode=require&prepareThreshold=0&currentSchema=${NODO_CFG_SCHEMA}
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

liquibase --defaultsFile=cfg.properties generate-changelog --diff-types=data

#liquibase --defaultsFile=cfg.properties update --changelogFile="db.changelog-master-3.10.0.xml"

rm cfg.properties
