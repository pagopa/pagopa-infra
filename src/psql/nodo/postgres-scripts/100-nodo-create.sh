#!/bin/sh

init () {
    PG_USER=$1
    PG_DB=$2
    USERNAME=$3
    PASSWORD=$4
    SCHEMA=$5

    #echo ""
    #echo "Creating '$SCHEMA' ..."

    set -e

    PGPASSWORD="$POSTGRES_PASSWORD" psql -v ON_ERROR_STOP=1 --username "$PG_USER" --dbname "$PG_DB" <<-EOSQL

    DO \$do\$
    BEGIN
       IF EXISTS (SELECT FROM pg_catalog.pg_roles WHERE  rolname = '$USERNAME') THEN
          RAISE NOTICE 'Role "$USERNAME" already exists. Skipping.';
       ELSE
          CREATE ROLE $USERNAME LOGIN PASSWORD '$PASSWORD';
          GRANT ALL PRIVILEGES ON DATABASE $PG_DB TO $USERNAME;
       END IF;
    END
    \$do\$;

    CREATE SCHEMA IF NOT EXISTS $SCHEMA AUTHORIZATION $USERNAME;

EOSQL

    echo "Created '$SCHEMA'."
}

init $POSTGRES_USER $POSTGRES_DB \
    $NODO_CFG_USERNAME \
    $NODO_CFG_PASSWORD \
    $NODO_CFG_SCHEMA

init $POSTGRES_USER $POSTGRES_DB \
    $NODO_ONLINE_USERNAME \
    $NODO_ONLINE_PASSWORD \
    $NODO_ONLINE_SCHEMA

echo "Creating function trunc on '$NODO_ONLINE_SCHEMA' ..."
PGPASSWORD="$POSTGRES_PASSWORD" psql -v ON_ERROR_STOP=1 --username "$NODO_ONLINE_USERNAME" --dbname "$PG_DB" <<-EOSQL
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
