#!/usr/bin/env bash

. dev.env
#. ../dev.env

init () {
    PG_USER=$1
    PG_DB=$2
    USERNAME=$3
    PASSWORD=$4
    SCHEMA=$5

    # mkdir -p /var/lib/postgresql/tablespaces/$TABLESPACE_DATA
    # mkdir -p /var/lib/postgresql/tablespaces/$TABLESPACE_LOB
    # mkdir -p /var/lib/postgresql/tablespaces/$TABLESPACE_IDX

    #echo ""
    #echo "Creating '$SCHEMA' ..."

    set -e

    # echo "POSTGRES_DB_HOST >>> ($POSTGRES_DB_HOST) with USER >>> ($PG_USER)"

    # connection and create user ...
    PGPASSWORD="$POSTGRES_PASSWORD" psql -h "$POSTGRES_DB_HOST" -p "$POSTGRES_DB_PORT" -v ON_ERROR_STOP=1 --username "$PG_USER" --dbname "$PG_DB" <<-EOSQL
    CREATE USER ${USERNAME} WITH PASSWORD '${PASSWORD}';
    GRANT ALL PRIVILEGES ON DATABASE nodo TO ${USERNAME};
    CREATE SCHEMA ${SCHEMA};
    GRANT USAGE, CREATE ON SCHEMA ${SCHEMA} TO ${USERNAME};
    GRANT USAGE, CREATE ON SCHEMA nodo_online_dev TO ${USERNAME};


EOSQL
    echo "Created '$SCHEMA'."
}

init $POSTGRES_USER $POSTGRES_DB \
    $NODO_CFG_USERNAME \
    $NODO_CFG_PASSWORD \
    $NODO_CFG_SCHEMA \

exit

init $POSTGRES_USER $POSTGRES_DB \
    $NODO_ONLINE_USERNAME \
    $NODO_ONLINE_PASSWORD \
    $NODO_ONLINE_SCHEMA

echo "Creating function trunc on '$NODO_ONLINE_SCHEMA' ..."
PGPASSWORD="$POSTGRES_PASSWORD" psql -h "$POSTGRES_DB_HOST" -p "$POSTGRES_DB_PORT" -v ON_ERROR_STOP=1 --username "$NODO_ONLINE_USERNAME" --dbname "$PG_DB" <<-EOSQL
    CREATE or REPLACE FUNCTION trunc(timestamp without time zone) RETURNS date
        AS 'select DATE_TRUNC(''day'',\$1);'
        LANGUAGE SQL
        IMMUTABLE
        RETURNS NULL ON NULL INPUT;
EOSQL
echo "Created function trunc on '$NODO_ONLINE_SCHEMA'"

init $POSTGRES_USER $POSTGRES_DB \
    $NODO_OFFLINE_USERNAME \
    $NODO_OFFLINE_PASSWORD \
    $NODO_OFFLINE_SCHEMA 

init $POSTGRES_USER $POSTGRES_DB \
    $NODO_WFESP_USERNAME \
    $NODO_WFESP_PASSWORD \
    $NODO_WFESP_SCHEMA 

init $POSTGRES_USER $POSTGRES_DB \
    $NODO_RE_USERNAME \
    $NODO_RE_PASSWORD \
    $NODO_RE_SCHEMA
