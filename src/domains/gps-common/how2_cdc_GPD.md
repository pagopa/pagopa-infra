### Step 

1. create topic via `src/domains/observability`

    ```sh
    sh terraform.sh apply <ENV> \
    -target=module.eventhub_namespace_observability_gpd \
    -target=module.eventhub_observability_gpd_configuration \
    -target=azurerm_eventhub_namespace_authorization_rule.cdc_connection_string \
    -target=azurerm_resource_group.gpd_ingestion_rg \
    -target=module.gpd_ingestion_sa
    ```

    + `src/domains/observability/gpd_evh_create__az.sh` for eventhub with `cleanup-policy`

2. apply secrets `src/domains/gps-secret`
    apply DB `src/domains/gps-common`

    ⚠️⚠️ _ReCreate DB GPD with new name convention_ ⚠️⚠️ 
    
    `pagopa-<ENV_SHORT>-<REGION_SHORT>-gpd-pgflex`
    NOTE : GDP network ( `+ Add 0.0.0.0 - 255.255.255.255` ) ( _only dev_ )

3. _[OPT iif not exists]_ user APD `./flyway_gpd.sh migrate <ENV>-pagoPA apd apd -schemas=apd`

4. _[OPT iif not exists]_ run [DB migration](https://github.com/pagopa/pagopa-debt-position/actions/workflows/db_migration_with_github_runner.yml)
 
5. apply `tokenizer-api-key` secret into gpd-secrets

6. create CDC user ✋

    ```sql 
    -- as admin
    CREATE ROLE cdcapd;
    ALTER ROLE cdcapd WITH INHERIT NOCREATEROLE NOCREATEDB LOGIN REPLICATION;
    ALTER USER cdcapd WITH PASSWORD 'xxx';
    GRANT USAGE, CREATE ON SCHEMA apd TO cdcapd;
    -- as apd
    GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA apd TO cdcapd;
    GRANT SELECT, UPDATE, USAGE ON ALL SEQUENCES IN SCHEMA apd TO cdcapd;
    ```

7. Grant `pg_publication` CDC

    ```sql
    -- as admin
    CREATE PUBLICATION dbz_publication FOR TABLE "apd"."payment_option", "apd"."payment_position", "apd"."transfer";
    -- as admin (???)
    ALTER USER cdcapd CREATEDB;
    -- as adp
    GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA apd TO cdcapd;
    -- to check
    SELECT * FROM pg_publication;
    SELECT * FROM pg_replication_slots;
    ```
1. Grant usage on `pglogical` public (useful for RTP)

    ```sql
    -- as admin
    GRANT USAGE ON SCHEMA pglogical TO public
    ```

8. create `src/domains/gps-app/set_registry_secrets.sh` ( ACR pull )
    ```
        kubectl config get-contexts
        kubectl config current-context
        kubectl config use-context <NEW_CONTEXT_NAME> 
    ```

    ```
        sh set_registry_secrets.sh \
        pagopa<env>commonacr.azurecr.io \
        pagopa<env>commonacr \
        <pwd>
    ```

9. deploy debezium `src/domains/gps-app`

    ```sh
    ./terraform.sh apply weu-<ENV>  \
    -target="helm_release.strimzi-kafka-operator" \
    -target="kubectl_manifest.debezium_role" \
    -target="kubectl_manifest.debezium_secrets" \
    -target="kubectl_manifest.debezoum_rbac" \
    -target="kubectl_manifest.kafka_connect" \
    -target="null_resource.wait_kafka_connect" \
    -target="kubectl_manifest.postgres_connector" \
    -target="null_resource.wait_postgres_connector" \
    -target="module.apim_gpd_debezium_product" \
    -target="azurerm_api_management_api_version_set.api_gpd_debezium_api" \
    -target="module.apim_api_gpd_debezium_api" \
    -target="kubectl_manifest.healthchecker-config-map" \
    -target="kubectl_manifest.healthchecker-cron" \
    -target="kubectl_manifest.debezium-ingress" \
    -target="kubectl_manifest.debezium-network-policy"
    ```    
10. debezium connector alert `src/synthetic-monitoring`

     ```sh
     ./terraform.sh apply weu-<ENV> -target="module.monitoring_function"
     ```    

11. secret for gpd-mng-ingestion `src/domains/gps-common`

     ```sh
     sh terraform.sh apply weu-<ENV> \
     -target=azurerm_key_vault_secret.gpd_ingestion_apd_payment_option_tx_kv \
     -target=azurerm_key_vault_secret.gpd_ingestion_apd_payment_position_tx_kv \
     -target=azurerm_key_vault_secret.gpd_ingestion_apd_payment_option_transfer_tx_kv \
     -target=azurerm_key_vault_secret.cdc-raw-auto_apd_payment_option-rx_kv \
     -target=azurerm_key_vault_secret.cdc-raw-auto_apd_payment_position-rx_kv \
     -target=azurerm_key_vault_secret.cdc-raw-auto_apd_transfer-rx_kv \
     -target=azurerm_key_vault_secret.azure_web_jobs_storage_kv
     ```
