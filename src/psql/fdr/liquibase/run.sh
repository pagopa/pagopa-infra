#!/bin/bash

TIPO=$1
LOCAL_CONTEXTS=$2

if [[ "${TIPO}" == 'dev' ]]; then
  #DEV
  echo "run on DEV"
  export POSTGRES_DB_HOST="pagopa-d-weu-nodo-flexible-postgresql.postgres.database.azure.com"
  export POSTGRES_DB_PORT="5432"
  export POSTGRES_DB="nodo"
  export SCHEMA="fdr"
  export LQB_CONTEXTS="dev"
  export USERNAME="fdr"
  export PASSWORD="password"
  export REPLICA=""
  export DOMAIN=dev
elif [[ "${TIPO}" == 'uat' ]]; then
  #UAT
  echo "run on UAT"
  export POSTGRES_DB_HOST="pagopa-u-weu-nodo-flexible-postgresql.postgres.database.azure.com"
  export POSTGRES_DB_PORT="6432"
  export POSTGRES_DB="nodo"
  export SCHEMA="fdr"
  export LQB_CONTEXTS="uat"
  export USERNAME="fdr"
  export PASSWORD="password"
  export REPLICA=""
  export DOMAIN=uat
else
  #LOCAL
    echo "run on LOCAL"
  export POSTGRES_DB_HOST="localhost"
  export POSTGRES_DB_PORT="5432"
  export POSTGRES_DB="postgres"
  export SCHEMA="fdr"
  export LQB_CONTEXTS=$LOCAL_CONTEXTS
  export USERNAME="fdr"
  export PASSWORD="password"
  export REPLICA=""
  export DOMAIN=dev
fi

echo "
classpath: ./changelog/fdr/
liquibase.headless: true
url: jdbc:postgresql://${POSTGRES_DB_HOST}:${POSTGRES_DB_PORT}/${POSTGRES_DB}?prepareThreshold=0&currentSchema=${SCHEMA}
contexts: ${LQB_CONTEXTS}
username: ${USERNAME}
password: ${PASSWORD}
defaultSchemaName: ${SCHEMA}
liquibaseSchemaName: ${SCHEMA}
liquibase.hub.mode: OFF
log-level: INFO
" > fdr.properties

#liquibase --defaultsFile=fdr.properties drop-all
liquibase --defaultsFile=fdr.properties update --changelogFile="db.changelog-master-1.0.0.xml"

rm fdr.properties
