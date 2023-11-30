#!/bin/bash


# example to run :
# sh run.sh dev cfg 3.22.0

TIPO=$1
SCHEMA=$2
VERSION=$3
LOCAL_CONTEXTS=$4

if [[ "${TIPO}" == 'dev' ]]; then
  #DEV
  echo "run on DEV"
  export POSTGRES_DB_HOST="pagopa-d-weu-nodo-flexible-postgresql.postgres.database.azure.com"
  export POSTGRES_DB_PORT="6432"
  export POSTGRES_DB="nodo"
  export NODO_CFG_SCHEMA=$SCHEMA
  export LQB_CONTEXTS="dev"
  export NODO_CFG_USERNAME=$SCHEMA
  export NODO_CFG_PASSWORD="password"
  export REPLICA=""
  export DOMAIN=dev
elif [[ "${TIPO}" == 'it' ]]; then
  #IT
  echo "run on IT"
  export POSTGRES_DB_HOST="pagopa-d-weu-nodo-flexible-postgresql.postgres.database.azure.com"
  export POSTGRES_DB_PORT="6432"
  export POSTGRES_DB="nodo-replica"
  export NODO_CFG_SCHEMA=$SCHEMA
  export LQB_CONTEXTS="it"
  export NODO_CFG_USERNAME=$SCHEMA
  export NODO_CFG_PASSWORD="password"
  export REPLICA="-replica"
  export DOMAIN=dev
elif [[ "${TIPO}" == 'partner' ]]; then
  #IT
  echo "run on IT PARTNER"
  export POSTGRES_DB_HOST="pagopa-d-weu-nodo-flexible-postgresql.postgres.database.azure.com"
  export POSTGRES_DB_PORT="6432"
  export POSTGRES_DB="nodo-replica"
  export NODO_CFG_SCHEMA="partner"
  export LQB_CONTEXTS="it"
  export NODO_CFG_USERNAME=$SCHEMA
  export NODO_CFG_PASSWORD="password"
  export REPLICA="-replica"
  export DOMAIN=dev
elif [[ "${TIPO}" == 'uat' ]]; then
  #UAT
  echo "run on UAT"
  export POSTGRES_DB_HOST="pagopa-u-weu-nodo-flexible-postgresql.postgres.database.azure.com"
  export POSTGRES_DB_PORT="6432"
  export POSTGRES_DB="nodo"
  export NODO_CFG_SCHEMA=$SCHEMA
  export LQB_CONTEXTS="uat"
  export NODO_CFG_USERNAME=$SCHEMA
  export NODO_CFG_PASSWORD="password"
  export REPLICA=""
  export DOMAIN=uat
elif [[ "${TIPO}" == 'prf' ]]; then
  #PRF
  echo "run on PRF"
  export POSTGRES_DB_HOST="pagopa-u-weu-nodo-flexible-postgresql.postgres.database.azure.com"
  export POSTGRES_DB_PORT="6432"
  export POSTGRES_DB="nodo-replica"
  export NODO_CFG_SCHEMA=$SCHEMA
  export LQB_CONTEXTS="prf"
  export NODO_CFG_USERNAME=$SCHEMA
  export NODO_CFG_PASSWORD="password"
  export REPLICA="-replica"
  export DOMAIN=uat
else
  #LOCAL
    echo "run on LOCAL"
  export POSTGRES_DB_HOST="localhost"
  export POSTGRES_DB_PORT="6432"
  export POSTGRES_DB="nodo"
  export NODO_CFG_SCHEMA=$SCHEMA
  export LQB_CONTEXTS=$LOCAL_CONTEXTS
  export NODO_CFG_USERNAME=$SCHEMA
  export NODO_CFG_PASSWORD="password"
  export REPLICA=""
  export DOMAIN=dev
fi
if [[ "${SCHEMA}" == 'offline' ]]; then
  export NODO_ONLINE_SCHEMA="online"
fi

properties=${NODO_CFG_SCHEMA}.properties

echo "
classpath: ./changelog/$NODO_CFG_SCHEMA/
liquibase.headless: true
#url: jdbc:postgresql://${POSTGRES_DB_HOST}:${POSTGRES_DB_PORT}/${POSTGRES_DB}?sslmode=require&prepareThreshold=0&currentSchema=${NODO_CFG_SCHEMA}
url: jdbc:postgresql://${POSTGRES_DB_HOST}:${POSTGRES_DB_PORT}/${POSTGRES_DB}?prepareThreshold=0&currentSchema=${NODO_CFG_SCHEMA}
contexts: ${LQB_CONTEXTS}
username: ${NODO_CFG_USERNAME}
password: ${NODO_CFG_PASSWORD}
defaultSchemaName: ${NODO_CFG_SCHEMA}
liquibaseSchemaName: ${NODO_CFG_SCHEMA}
parameter.schema: ${NODO_CFG_SCHEMA}
parameter.schemaOnline: ${NODO_ONLINE_SCHEMA}
parameter.usernameOffline: offline
liquibase.hub.mode: OFF
log-level: INFO
" > ${properties}

#liquibase --defaultsFile=cfg.properties drop-all
# liquibase --defaultsFile=cfg.properties update-sql --changelogFile="db.changelog-master-3.20.0.xml"
# liquibase --defaultsFile=cfg.properties update-sql --changelogFile="db.changelog-master-$VERSION.xml"

liquibase \
--defaultsFile=${properties} update \
--contexts="${LQB_CONTEXTS}" \
--changelogFile="db.changelog-master-$VERSION.xml"

#rm ${properties}
