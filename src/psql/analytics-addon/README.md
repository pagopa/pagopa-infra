# Analytics Add-on Database Migrations

This folder manages database schema migrations and changelog versioning for the analytics add-on databases using **Liquibase**. It integrates with the Azure Pipelines CI/CD workflow defined in `.devops/db-addon-migration-pipelines.yml`.

## Overview

The `analytics-addon` folder contains database changelogs for multiple PostgreSQL databases and schemas:

- **GPD**  - `apd` schema
- **Nodo**  - `cfg`, `offline`, `online`, `re` schemas
- **Cruscotto**  - `cruscotto` schema
- **FDR**  - `fdr`, `fdr3` schemas

Each database/schema combination has:
1. **Versioned changelog master files** (`db.changelog-master-<VERSION>.xml`)
2. **Version-specific changelog** (`<VERSION>/db.changelog-<name>.xml`)
3. **SQL migration files** (`<VERSION>/sql/*.sql`)

## Folder Structure

```
analytics-addon/
├── changelog_v1.0.0.properties       # Maps schema versions for pipeline v1.0.0
├── changelog_v1.1.0.properties       # Maps schema versions for pipeline v1.1.0
├── README.md                         # This file
├── gpd/
│   └── apd/
│       ├── db.changelog-master-1.0.0.xml
│       ├── db.changelog-master-1.1.0.xml
│       ├── 1.0.0/
│       │   ├── db.changelog-index.xml
│       │   └── sql/
│       │       └── *.sql
│       └── 1.1.0/
│           ├── db.changelog-index.xml
│           └── sql/
│               └── *.sql
├── nodo/
│   ├── cfg/
│   ├── offline/
│   ├── online/
│   └── re/
├── cruscotto/
│   └── cruscotto/
└── fdr/
    ├── fdr/
    └── fdr3/
```

## How to Use

### 1. Understanding the Version Structure

Each migration version follows semantic versioning (e.g., `1.0.0`, `1.0.1`, `1.1.0`). Schemas within the same database version may be at different changelog versions.

### 2. Running Database Migrations

Migrations are executed automatically by the Azure Pipeline: **`db-addon-migration-pipelines.yml`**

**Trigger the pipeline:**
- Push changes to this folder
- Pipeline runs with default `dbVersion` parameter
- Liquibase applies migrations to all configured schemas



## How to Configure a New Changelog for an Existing Database/Schema

To add migrations for a schema that already exists (e.g., adding a new index to `gpd_apd`):

### Step 1: Create a New Version Directory

In the schema folder (e.g., `gpd/apd/`), create a new version directory:

```bash
mkdir -p gpd/apd/1.2.0/sql
```

### Step 2: Add SQL Migration Files

Create your SQL files in the `sql/` subdirectory:

```bash
# Example: gpd/apd/1.2.0/sql/add_new_index.sql
CREATE INDEX IF NOT EXISTS idx_mb_cateogry
    ON apd.transfer USING btree
    (category COLLATE pg_catalog."default" ASC NULLS LAST)
    WITH (fillfactor=100, deduplicate_items=True)
    TABLESPACE pg_default;
```

### Step 3: Create the Changelog  XML

Create `gpd/apd/1.2.0/db.changelog-<name>.xml`:

```xml
<?xml version="1.1" encoding="UTF-8" standalone="no"?>
<databaseChangeLog xmlns="http://www.liquibase.org/xml/ns/dbchangelog"
                   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                   xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-4.1.xsd">

  <changeSet author="<your-name>" id="add_new_index-1">
    <sqlFile
      encoding="UTF-8"
      path="sql/add_new_index.sql"
      relativeToChangelogFile="true"
      splitStatements="true"
      stripComments="true"/>
  </changeSet>

  <!-- Add additional changeSet entries for each SQL file -->

</databaseChangeLog>
```

**Guidelines for changelog-index.xml:**
- One `<changeSet>` per logical change
- Use descriptive `id` attributes (e.g., `index_for_some_reason`)
- Set `author` to your name or team name
- Ensure all SQL files are included with proper `<sqlFile>` entries

### Step 4: Create the Changelog Master XML

Create `gpd/apd/db.changelog-master-1.2.0.xml`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<databaseChangeLog xmlns="http://www.liquibase.org/xml/ns/dbchangelog"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog
  http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-4.1.xsd">

    <property name="version" value="1.2.0" global="false"/>

    <include file="./${version}/db.changelog-<name>.xml" labels="${version}"/>

</databaseChangeLog>
```

### Step 5: Update the Version Properties File

Create or update `changelog_v1.2.0.properties` with the version mapping:

```properties
gpd_apd=1.2.0
nodo_cfg=1.0.0
nodo_offline=0.0.0
nodo_online=0.0.0
nodo_re=0.0.0
crusc8_cruscotto=0.0.0
fdr_fdr=0.0.0
fdr_fdr3=0.0.0
```

- Schemas that have new migrations get their new version
- Schemas without changes keep their current version
- Only schemas listed here will be deployed in the pipeline


## How to Configure a New Database

To add support for a completely new database (e.g., `MYDB` with schema `MYSCHEMA`):

### Step 1: Create Database Directory Structure

```bash
mkdir -p mydb/myschema
```

### Step 2: Create Initial Changelog Master XML

Create `mydb/myschema/db.changelog-master-0.0.0.xml`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<databaseChangeLog xmlns="http://www.liquibase.org/xml/ns/dbchangelog"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog
  http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-4.1.xsd">

</databaseChangeLog>
```

Start with an empty changelog. Changelogs are added when actual migrations are needed.

### Step 3: Add Version Properties Entry

Update the relevant `changelog_v*.properties` files to include your new database/schema:

```properties
gpd_apd=1.1.0
mydb_myschema=0.0.0
nodo_cfg=0.0.0
```

### Step 4: Configure in CI/CD Pipeline

Update `.devops/db-addon-migration-pipelines.yml`:

**a) Add connection variables** (in the `variables` section):

```yaml
variables:
  # ... existing variables ...
  MYDB_JDBC_URL: jdbc:postgresql://pagopa-${{ variables.ENV }}-weu-mydb-flexible-postgresql.postgres.database.azure.com:5432/mydb?sslmode=require&prepareThreshold=0
  MYDB_KV_NAME: pagopa-${{ variables.ENV }}-mydb-kv
  MYDB_MYSCHEMA_KV_KEY: db-myschema-password
  MYDB_MYSCHEMA_USERNAME: myschema_user
  MYDB_MYSCHEMA_SCHEMA: myschema
```

**b) Update version loading script** (in job `liquibase_status_job`, task `load_db_specific_version`):

```bash
# ... existing exports ...
echo "##vso[task.setvariable variable=mydb_myschema;isOutput=true]${mydb_myschema}"
```

**c) Map output variables** (in job `liquibase_apply_job`, `variables` section):

```yaml
variables:
  gpd_apd: $[ dependencies.liquibase_status_job.outputs['load_db_specific_version.gpd_apd'] ]
  mydb_myschema: $[ dependencies.liquibase_status_job.outputs['load_db_specific_version.mydb_myschema'] ]
```

**d) Add Liquibase status template** (in job `liquibase_status_job`):

```yaml
- template: ./templates/generic-liquibase-status-with-kv.yml
  parameters:
    DATABASE_FOLDER_NAME: mydb
    SCHEMA: ${{variables.MYDB_MYSCHEMA_SCHEMA}}
    LIQUIBASE_FOLDER: ${{variables.LIQUIBASE_FOLDER}}
    LIQUIBASE_DB_VERSION: "$(mydb_myschema)"
    JDBC_URL: ${{variables.MYDB_JDBC_URL}}
    USERNAME: ${{variables.MYDB_MYSCHEMA_USERNAME}}
    KV_NAME: ${{variables.MYDB_KV_NAME}}
    PASSWORD_KV_KEY: ${{variables.MYDB_MYSCHEMA_KV_KEY}}
    AZURE_SERVICE_CONNECTION: $(AZURE_SERVICE_CONNECTION)
    lbContexts: ${{ parameters.lbContexts }}
    lbLogLevel: ${{ parameters.lbLogLevel }}
```

**e) Add Liquibase apply template** (in job `liquibase_apply_job`):

```yaml
- template: ./templates/generic-liquibase-apply-with-kv.yml
  parameters:
    DATABASE_FOLDER_NAME: mydb
    SCHEMA: ${{variables.MYDB_MYSCHEMA_SCHEMA}}
    LIQUIBASE_FOLDER: ${{variables.LIQUIBASE_FOLDER}}
    LIQUIBASE_DB_VERSION: "$(mydb_myschema)"
    JDBC_URL: ${{variables.MYDB_JDBC_URL}}
    USERNAME: ${{variables.MYDB_MYSCHEMA_USERNAME}}
    KV_NAME: ${{variables.MYDB_KV_NAME}}
    PASSWORD_KV_KEY: ${{variables.MYDB_MYSCHEMA_KV_KEY}}
    AZURE_SERVICE_CONNECTION: $(AZURE_SERVICE_CONNECTION)
    lbContexts: ${{ parameters.lbContexts }}
    lbLogLevel: ${{ parameters.lbLogLevel }}
```

### Step 5: Add Migrations

Once the database is configured, follow the steps in **"How to Configure a New Changelog for an Existing Database/Schema"** to add your first migrations.

## Schema Naming Convention

Each database/schema is named using the format: `{database}_{schema}`

- `gpd_apd` → Database: `GPD`, Schema: `apd`
- `nodo_cfg` → Database: `Nodo`, Schema: `cfg`
- `nodo_online` → Database: `Nodo`, Schema: `online`
- `mydb_myschema` → Database: `mydb`, Schema: `myschema`

This naming convention is used consistently throughout properties files and pipeline variable mappings.

## Troubleshooting

### Pipeline Fails with "Property Not Found"

**Cause**: Schema version property is missing from `.properties` file.

**Solution**: Ensure the changelog_v*.properties file includes all schemas in the format: `{db}_{schema}={version}`

### Migration Not Applying

**Cause**: Changelog master XML not created or version mismatch.

**Solution**: Verify:
- Changelog master XML exists at correct path: `{db}/{schema}/db.changelog-master-{version}.xml`
- Version in master XML matches the property file entry
- Changelog index XML exists at `{db}/{schema}/{version}/db.changelog-index.xml`
