# Nodo Database Migration

## Manual execution of liquibase migration on subscription

Connects to azure subscription database and runs liquibase update.

```sh
./liquidbase_nodo.sh DEV-pagoPA 3.9
```

## Manual execution of liquibase migration on local machine

Creates a new PostgreSQL container with default users/schemas and runs liquibase.

```sh
./liquidbase_local.sh 3.9
```
