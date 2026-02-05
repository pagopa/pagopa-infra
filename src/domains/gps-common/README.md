<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | <= 1.13.1 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 3.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.16 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.2.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module___v4__"></a> [\_\_v4\_\_](#module\_\_\_v4\_\_) | git::https://github.com/pagopa/terraform-azurerm-v4 | b7f9217e580b2b14913aecd052a1c3687e860a5d |
| <a name="module_eventhub_rtp_namespace_integration"></a> [eventhub\_rtp\_namespace\_integration](#module\_eventhub\_rtp\_namespace\_integration) | ./.terraform/modules/__v4__/eventhub | n/a |
| <a name="module_gpd_cosmosdb_containers"></a> [gpd\_cosmosdb\_containers](#module\_gpd\_cosmosdb\_containers) | ./.terraform/modules/__v4__/cosmosdb_sql_container | n/a |
| <a name="module_gpd_cosmosdb_database"></a> [gpd\_cosmosdb\_database](#module\_gpd\_cosmosdb\_database) | ./.terraform/modules/__v4__/cosmosdb_sql_database | n/a |
| <a name="module_gpd_payments_cosmosdb_account"></a> [gpd\_payments\_cosmosdb\_account](#module\_gpd\_payments\_cosmosdb\_account) | ./.terraform/modules/__v4__/cosmosdb_account | n/a |
| <a name="module_gpd_rtp_sa"></a> [gpd\_rtp\_sa](#module\_gpd\_rtp\_sa) | ./.terraform/modules/__v4__/storage_account | n/a |
| <a name="module_gpd_sa_sftp"></a> [gpd\_sa\_sftp](#module\_gpd\_sa\_sftp) | ./.terraform/modules/__v4__/storage_account | n/a |
| <a name="module_gps_cosmosdb_account"></a> [gps\_cosmosdb\_account](#module\_gps\_cosmosdb\_account) | ./.terraform/modules/__v4__/cosmosdb_account | n/a |
| <a name="module_gps_cosmosdb_containers"></a> [gps\_cosmosdb\_containers](#module\_gps\_cosmosdb\_containers) | ./.terraform/modules/__v4__/cosmosdb_sql_container | n/a |
| <a name="module_gps_cosmosdb_database"></a> [gps\_cosmosdb\_database](#module\_gps\_cosmosdb\_database) | ./.terraform/modules/__v4__/cosmosdb_sql_database | n/a |
| <a name="module_gps_cosmosdb_snet"></a> [gps\_cosmosdb\_snet](#module\_gps\_cosmosdb\_snet) | ./.terraform/modules/__v4__/subnet | n/a |
| <a name="module_identity_cd_01"></a> [identity\_cd\_01](#module\_identity\_cd\_01) | ./.terraform/modules/__v4__/github_federated_identity | n/a |
| <a name="module_identity_oidc_01"></a> [identity\_oidc\_01](#module\_identity\_oidc\_01) | ./.terraform/modules/__v4__/github_federated_identity | n/a |
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | ./.terraform/modules/__v4__/key_vault | n/a |
| <a name="module_postgres_flexible_itn_snet_replica"></a> [postgres\_flexible\_itn\_snet\_replica](#module\_postgres\_flexible\_itn\_snet\_replica) | ./.terraform/modules/__v4__/subnet | n/a |
| <a name="module_postgres_flexible_itn_spoke_snet_replica"></a> [postgres\_flexible\_itn\_spoke\_snet\_replica](#module\_postgres\_flexible\_itn\_spoke\_snet\_replica) | ./.terraform/modules/__v4__/IDH/subnet | n/a |
| <a name="module_postgres_flexible_server_private_db"></a> [postgres\_flexible\_server\_private\_db](#module\_postgres\_flexible\_server\_private\_db) | ./.terraform/modules/__v4__/postgres_flexible_server | n/a |
| <a name="module_postgres_flexible_snet"></a> [postgres\_flexible\_snet](#module\_postgres\_flexible\_snet) | ./.terraform/modules/__v4__/subnet | n/a |
| <a name="module_postgresql_gpd_itn_replica_db"></a> [postgresql\_gpd\_itn\_replica\_db](#module\_postgresql\_gpd\_itn\_replica\_db) | ./.terraform/modules/__v4__/postgres_flexible_server_replica | n/a |
| <a name="module_postgresql_gpd_itn_replica_spoke_db"></a> [postgresql\_gpd\_itn\_replica\_spoke\_db](#module\_postgresql\_gpd\_itn\_replica\_spoke\_db) | ./.terraform/modules/__v4__/postgres_flexible_server_replica | n/a |
| <a name="module_storage_account_snet"></a> [storage\_account\_snet](#module\_storage\_account\_snet) | ./.terraform/modules/__v4__/subnet | n/a |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../../tag_config | n/a |
| <a name="module_workload_identity"></a> [workload\_identity](#module\_workload\_identity) | ./.terraform/modules/__v4__/kubernetes_workload_identity_init | n/a |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.gpd_postgres_linked_service](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azurerm_api_management_subscription.apiconfig_cache_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_api_management_subscription.shared_anonymizer_api_key_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_cosmosdb_table.payments_pp_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_table) | resource |
| [azurerm_cosmosdb_table.payments_receipts_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_table) | resource |
| [azurerm_data_factory_linked_service_key_vault.gps_kv_linked_service](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_key_vault) | resource |
| [azurerm_data_factory_pipeline.pipeline_odp_backfill](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_eventgrid_system_topic.storage_topic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_system_topic) | resource |
| [azurerm_eventgrid_system_topic_event_subscription.storage_subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_system_topic_event_subscription) | resource |
| [azurerm_key_vault_access_policy.ad_group_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_developers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_externals_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_legacy_policies](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_managed_identities](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azure_data_factory_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.gha_iac_managed_identities](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.ai_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.apiconfig_cache_subkey_store_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_web_jobs_storage_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.cdc-raw-auto_apd_payment_option-rx_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.cdc-raw-auto_apd_payment_position-rx_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.cdc-raw-auto_apd_transfer-rx_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.config-cache-eh-connection-for-aca-payments](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.cosmos_gps_pkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.db_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ehub_rtp_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ehub_rtp_integration_test_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.elastic_otel_token_header](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.flyway_db_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.gpd-paa-password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.gpd_apiconfig_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.gpd_archive_sa_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.gpd_core_key_for_upload](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.gpd_db_pwd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.gpd_db_usr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.gpd_donations_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.gpd_gpd_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.gpd_gps_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.gpd_ingestion_apd_payment_option_transfer_tx_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.gpd_ingestion_apd_payment_option_tx_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.gpd_ingestion_apd_payment_position_tx_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.gpd_iuv_generator_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.gpd_node_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.gpd_payments_rest_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.gpd_payments_retry_sa_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.gpd_payments_soap_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.gpd_reporting_enrollment_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.gpd_reporting_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.gpd_upload_db_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.gpd_upload_sa_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.monitor_notification_email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.monitor_notification_slack_email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.payments_cosmos_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.pgres_admin_login](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.pgres_admin_pwd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.redis_hostname](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.redis_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.rtp_storage_account_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.shared_anonymizer_api_keysubkey_store_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.payments_gpd_inconsistency_error](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_portal_dashboard.debt_position_postgresql_dashboard](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/portal_dashboard) | resource |
| [azurerm_postgresql_flexible_server_configuration.pd_pgbouncer_ignore_startup_parameters](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_configuration.pg_max_connections](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_configuration.pg_max_worker_processes](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_configuration.pg_pgbouncer_min_pool_size](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_configuration.pg_shared_preload_libraries](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_configuration.pg_wal_level](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_database.pg_charset](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_database) | resource |
| [azurerm_postgresql_flexible_server_virtual_endpoint.virtual_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_virtual_endpoint) | resource |
| [azurerm_private_dns_a_record.ingress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_cname_record.cname_record](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_cname_record) | resource |
| [azurerm_private_endpoint.gpd_blob](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.gpd_queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.gpd_rtp_blob_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_resource_group.flex_data](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.gpd_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.gps_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rtp_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_container.rtp_dead_letter_blob_file](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_management_policy.gpd_sa_lifecycle_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy) | resource |
| [azurerm_storage_management_policy.time_to_live](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy) | resource |
| [azurerm_storage_queue.gpd_blob_events_queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.gpd_receipt_poison](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.gpd_valid_positions_queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [null_resource.github_runner_app_permissions_to_namespace_cd_01](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_service_principal.iac_deploy_legacy](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.iac_plan_legacy](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.iac_principal](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azurerm_api_management_product.anonymizer_product](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management_product) | data source |
| [azurerm_api_management_product.apiconfig_cache_product](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management_product) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_data_factory.data_factory](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/data_factory) | data source |
| [azurerm_eventhub_authorization_rule.cdc-raw-auto_apd_payment_option-rx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.cdc-raw-auto_apd_payment_position-rx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.cdc-raw-auto_apd_transfer-rx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.gpd_ingestion_apd_payment_option_transfer_tx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.gpd_ingestion_apd_payment_option_tx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.gpd_ingestion_apd_payment_position_tx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.nodo_dei_pagamenti_cache_aca_rx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.pagopa-evh-rtp-integration-test](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.pagopa-evh-rtp-integration-tx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_key_vault.gps_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.gpd_db_pwd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.gpd_db_usr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pgres_admin_login](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pgres_admin_pwd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.infra_opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.cosmos](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.cosmos_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.internal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.postgres](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_servicebus_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.storage_queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_redis_cache.redis_cache](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/redis_cache) | data source |
| [azurerm_resource_group.data](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.identity_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_event_private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_storage_account.gpd_ingestion_sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subnet.aks_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.aks_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.azdo_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.common_itn_cstar_integration_private_endpoint_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.common_itn_private_endpoint_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_user_assigned_identity.iac_federated_azdo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet_italy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet_italy_cstar_integration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_insights_name"></a> [application\_insights\_name](#input\_application\_insights\_name) | Specifies the name of the Application Insights. | `string` | n/a | yes |
| <a name="input_cidr_subnet_gpd_payments_cosmosdb"></a> [cidr\_subnet\_gpd\_payments\_cosmosdb](#input\_cidr\_subnet\_gpd\_payments\_cosmosdb) | Cosmos DB gpd payments address space | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_gps_cosmosdb"></a> [cidr\_subnet\_gps\_cosmosdb](#input\_cidr\_subnet\_gps\_cosmosdb) | Cosmos DB address space | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_pg_flex_dbms"></a> [cidr\_subnet\_pg\_flex\_dbms](#input\_cidr\_subnet\_pg\_flex\_dbms) | Postgres Flexible Server network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_pg_singleser"></a> [cidr\_subnet\_pg\_singleser](#input\_cidr\_subnet\_pg\_singleser) | Postgres Single Server network address space. | `list(string)` | `[]` | no |
| <a name="input_cosmos_gpd_payments_db_params"></a> [cosmos\_gpd\_payments\_db\_params](#input\_cosmos\_gpd\_payments\_db\_params) | n/a | <pre>object({<br/>    kind           = string<br/>    capabilities   = list(string)<br/>    offer_type     = string<br/>    server_version = string<br/>    consistency_policy = object({<br/>      consistency_level       = string<br/>      max_interval_in_seconds = number<br/>      max_staleness_prefix    = number<br/>    })<br/>    main_geo_location_zone_redundant = bool<br/>    enable_free_tier                 = bool<br/>    additional_geo_locations = list(object({<br/>      location          = string<br/>      failover_priority = number<br/>      zone_redundant    = bool<br/>    }))<br/>    private_endpoint_enabled          = bool<br/>    public_network_access_enabled     = bool<br/>    is_virtual_network_filter_enabled = bool<br/>    backup_continuous_enabled         = bool<br/>    payments_receipts_table = object({<br/>      autoscale  = bool<br/>      throughput = number<br/>    })<br/>    payments_pp_table = object({<br/>      autoscale  = bool<br/>      throughput = number<br/>    })<br/>  })</pre> | n/a | yes |
| <a name="input_cosmos_gps_db_params"></a> [cosmos\_gps\_db\_params](#input\_cosmos\_gps\_db\_params) | n/a | <pre>object({<br/>    kind           = string<br/>    capabilities   = list(string)<br/>    offer_type     = string<br/>    server_version = string<br/>    consistency_policy = object({<br/>      consistency_level       = string<br/>      max_interval_in_seconds = number<br/>      max_staleness_prefix    = number<br/>    })<br/>    main_geo_location_zone_redundant = bool<br/>    enable_free_tier                 = bool<br/>    additional_geo_locations = list(object({<br/>      location          = string<br/>      failover_priority = number<br/>      zone_redundant    = bool<br/>    }))<br/>    private_endpoint_enabled          = bool<br/>    public_network_access_enabled     = bool<br/>    is_virtual_network_filter_enabled = bool<br/>    backup_continuous_enabled         = bool<br/>  })</pre> | n/a | yes |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_enable_gpd_archive_backup"></a> [enable\_gpd\_archive\_backup](#input\_enable\_gpd\_archive\_backup) | (Optional) Enables nodo sftp storage account backup | `bool` | `false` | no |
| <a name="input_enable_iac_pipeline"></a> [enable\_iac\_pipeline](#input\_enable\_iac\_pipeline) | If true create the key vault policy to allow used by azure devops iac pipelines. | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_eventhub_namespace_rtp"></a> [eventhub\_namespace\_rtp](#input\_eventhub\_namespace\_rtp) | Namespace configuration | <pre>object({<br/>    auto_inflate_enabled     = bool<br/>    sku_name                 = string<br/>    capacity                 = string<br/>    maximum_throughput_units = number<br/>    public_network_access    = bool<br/>    private_endpoint_created = bool<br/>    metric_alerts_create     = bool<br/>    metric_alerts            = object({})<br/>  })</pre> | n/a | yes |
| <a name="input_eventhubs_rtp"></a> [eventhubs\_rtp](#input\_eventhubs\_rtp) | A list of event hubs to add to namespace. | <pre>list(object({<br/>    name              = string<br/>    partitions        = number<br/>    message_retention = number<br/>    consumers         = list(string)<br/>    keys = list(object({<br/>      name   = string<br/>      listen = bool<br/>      send   = bool<br/>      manage = bool<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_flow_storage_account_replication_type"></a> [flow\_storage\_account\_replication\_type](#input\_flow\_storage\_account\_replication\_type) | (Optional) Reporting storage acocunt replication type | `string` | `"LRS"` | no |
| <a name="input_geo_replica_cidr_subnet_postgresql"></a> [geo\_replica\_cidr\_subnet\_postgresql](#input\_geo\_replica\_cidr\_subnet\_postgresql) | Address prefixes replica subnet postgresql | `list(string)` | `null` | no |
| <a name="input_geo_replica_enabled"></a> [geo\_replica\_enabled](#input\_geo\_replica\_enabled) | (Optional) True if geo replica should be active for key data components i.e. PostgreSQL Flexible servers | `bool` | `false` | no |
| <a name="input_gpd_archive_advanced_threat_protection"></a> [gpd\_archive\_advanced\_threat\_protection](#input\_gpd\_archive\_advanced\_threat\_protection) | Enable contract threat advanced protection | `bool` | `false` | no |
| <a name="input_gpd_archive_replication_type"></a> [gpd\_archive\_replication\_type](#input\_gpd\_archive\_replication\_type) | Archive storage account replication type | `string` | n/a | yes |
| <a name="input_gpd_cdc_enabled"></a> [gpd\_cdc\_enabled](#input\_gpd\_cdc\_enabled) | Enable CDC for GDP | `bool` | `false` | no |
| <a name="input_gpd_db_name"></a> [gpd\_db\_name](#input\_gpd\_db\_name) | Name of the DB to connect to | `string` | `"apd"` | no |
| <a name="input_gpd_sftp_cidr_subnet_gpd_storage_account"></a> [gpd\_sftp\_cidr\_subnet\_gpd\_storage\_account](#input\_gpd\_sftp\_cidr\_subnet\_gpd\_storage\_account) | Storage account network address space. | `list(string)` | n/a | yes |
| <a name="input_gpd_sftp_disable_network_rules"></a> [gpd\_sftp\_disable\_network\_rules](#input\_gpd\_sftp\_disable\_network\_rules) | If false, allow any connection from outside the vnet | `bool` | `false` | no |
| <a name="input_gpd_sftp_enable_private_endpoint"></a> [gpd\_sftp\_enable\_private\_endpoint](#input\_gpd\_sftp\_enable\_private\_endpoint) | If true, create a private endpoint for the GPD storage account | `bool` | `false` | no |
| <a name="input_gpd_sftp_ip_rules"></a> [gpd\_sftp\_ip\_rules](#input\_gpd\_sftp\_ip\_rules) | List of public IP or IP ranges in CIDR Format allowed to access the storage account. Only IPV4 addresses are allowed | `list(string)` | `[]` | no |
| <a name="input_gpd_sftp_sa_access_tier"></a> [gpd\_sftp\_sa\_access\_tier](#input\_gpd\_sftp\_sa\_access\_tier) | (Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot | `string` | `"Hot"` | no |
| <a name="input_gpd_sftp_sa_delete"></a> [gpd\_sftp\_sa\_delete](#input\_gpd\_sftp\_sa\_delete) | Number of days after which the blob is deleted | `number` | n/a | yes |
| <a name="input_gpd_sftp_sa_public_network_access_enabled"></a> [gpd\_sftp\_sa\_public\_network\_access\_enabled](#input\_gpd\_sftp\_sa\_public\_network\_access\_enabled) | True if public network access is enabled. It should always set to false unless there are special needs | `bool` | `false` | no |
| <a name="input_gpd_sftp_sa_replication_type"></a> [gpd\_sftp\_sa\_replication\_type](#input\_gpd\_sftp\_sa\_replication\_type) | Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa | `string` | n/a | yes |
| <a name="input_gpd_sftp_sa_snet_private_link_service_network_policies_enabled"></a> [gpd\_sftp\_sa\_snet\_private\_link\_service\_network\_policies\_enabled](#input\_gpd\_sftp\_sa\_snet\_private\_link\_service\_network\_policies\_enabled) | If true, create a private link service | `bool` | `true` | no |
| <a name="input_gpd_sftp_sa_tier_to_archive"></a> [gpd\_sftp\_sa\_tier\_to\_archive](#input\_gpd\_sftp\_sa\_tier\_to\_archive) | Number of days after which the blob is moved to archive | `number` | `-1` | no |
| <a name="input_gpd_sftp_sa_tier_to_cool"></a> [gpd\_sftp\_sa\_tier\_to\_cool](#input\_gpd\_sftp\_sa\_tier\_to\_cool) | Number of days after which the blob is moved to cool | `number` | n/a | yes |
| <a name="input_gpd_upload_status_throughput"></a> [gpd\_upload\_status\_throughput](#input\_gpd\_upload\_status\_throughput) | Max container throughput (Cosmos-RU) | `number` | `1000` | no |
| <a name="input_gpd_upload_status_ttl"></a> [gpd\_upload\_status\_ttl](#input\_gpd\_upload\_status\_ttl) | The default time in seconds to live of SQL container. If present and the value is set to -1, it is equal to infinity, and items don’t expire by default. | `number` | `-1` | no |
| <a name="input_ingress_load_balancer_ip"></a> [ingress\_load\_balancer\_ip](#input\_ingress\_load\_balancer\_ip) | n/a | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_ita"></a> [location\_ita](#input\_location\_ita) | Main location | `string` | `"italynorth"` | no |
| <a name="input_location_replica"></a> [location\_replica](#input\_location\_replica) | One of westeurope, italynorth | `string` | `"italynorth"` | no |
| <a name="input_location_replica_short"></a> [location\_replica\_short](#input\_location\_replica\_short) | One of wue, itn | `string` | `"itn"` | no |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_location_short_ita"></a> [location\_short\_ita](#input\_location\_short\_ita) | Main location | `string` | `"itn"` | no |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_pgflex_public_metric_alerts"></a> [pgflex\_public\_metric\_alerts](#input\_pgflex\_public\_metric\_alerts) | Map of name = criteria objects | <pre>map(object({<br/>    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]<br/>    aggregation = string<br/>    # "Insights.Container/pods" "Insights.Container/nodes"<br/>    metric_namespace = string<br/>    metric_name      = string<br/>    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]<br/>    operator  = string<br/>    threshold = number<br/>    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H<br/>    frequency = string<br/>    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.<br/>    window_size = string<br/>    # severity: The severity of this Metric Alert. Possible values are 0, 1, 2, 3 and 4. Defaults to 3. Lower is worst<br/>    severity = number<br/>  }))</pre> | <pre>{<br/>  "active_connections": {<br/>    "aggregation": "Average",<br/>    "frequency": "PT5M",<br/>    "metric_name": "active_connections",<br/>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br/>    "operator": "GreaterThan",<br/>    "severity": 2,<br/>    "threshold": 4000,<br/>    "window_size": "PT30M"<br/>  },<br/>  "connections_failed": {<br/>    "aggregation": "Total",<br/>    "frequency": "PT5M",<br/>    "metric_name": "connections_failed",<br/>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br/>    "operator": "GreaterThan",<br/>    "severity": 2,<br/>    "threshold": 10,<br/>    "window_size": "PT30M"<br/>  },<br/>  "cpu_percent": {<br/>    "aggregation": "Average",<br/>    "frequency": "PT5M",<br/>    "metric_name": "cpu_percent",<br/>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br/>    "operator": "GreaterThan",<br/>    "severity": 2,<br/>    "threshold": 80,<br/>    "window_size": "PT30M"<br/>  },<br/>  "memory_percent": {<br/>    "aggregation": "Average",<br/>    "frequency": "PT5M",<br/>    "metric_name": "memory_percent",<br/>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br/>    "operator": "GreaterThan",<br/>    "severity": 2,<br/>    "threshold": 80,<br/>    "window_size": "PT30M"<br/>  },<br/>  "storage_percent": {<br/>    "aggregation": "Average",<br/>    "frequency": "PT5M",<br/>    "metric_name": "storage_percent",<br/>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br/>    "operator": "GreaterThan",<br/>    "severity": 2,<br/>    "threshold": 80,<br/>    "window_size": "PT30M"<br/>  }<br/>}</pre> | no |
| <a name="input_pgres_flex_params"></a> [pgres\_flex\_params](#input\_pgres\_flex\_params) | Postgres Flexible | <pre>object({<br/>    private_endpoint_enabled                         = bool<br/>    sku_name                                         = string<br/>    db_version                                       = string<br/>    storage_mb                                       = string<br/>    zone                                             = number<br/>    backup_retention_days                            = number<br/>    geo_redundant_backup_enabled                     = bool<br/>    high_availability_enabled                        = bool<br/>    standby_availability_zone                        = number<br/>    pgbouncer_enabled                                = bool<br/>    alerts_enabled                                   = bool<br/>    max_connections                                  = number<br/>    enable_private_dns_registration                  = optional(bool, false)<br/>    enable_private_dns_registration_virtual_endpoint = optional(bool, false)<br/>    max_worker_process                               = number<br/>    wal_level                                        = string<br/>    shared_preoload_libraries                        = string<br/>    public_network_access_enabled                    = bool<br/>  })</pre> | `null` | no |
| <a name="input_postgresql_network_rules"></a> [postgresql\_network\_rules](#input\_postgresql\_network\_rules) | Network rules restricting access to the postgresql server. | <pre>object({<br/>    ip_rules                       = list(string)<br/>    allow_access_to_azure_services = bool<br/>  })</pre> | <pre>{<br/>  "allow_access_to_azure_services": false,<br/>  "ip_rules": []<br/>}</pre> | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_redis_ha_enabled"></a> [redis\_ha\_enabled](#input\_redis\_ha\_enabled) | (Required) If true, enables the usage of HA redis instance | `bool` | n/a | yes |
| <a name="input_reporting_storage_account"></a> [reporting\_storage\_account](#input\_reporting\_storage\_account) | n/a | <pre>object({<br/>    advanced_threat_protection = bool<br/>    blob_delete_retention_days = number<br/>    blob_versioning_enabled    = bool<br/>    backup_enabled             = bool<br/>    backup_retention           = optional(number, 0)<br/>  })</pre> | <pre>{<br/>  "advanced_threat_protection": false,<br/>  "backup_enabled": false,<br/>  "backup_retention": 0,<br/>  "blob_delete_retention_days": 30,<br/>  "blob_versioning_enabled": false<br/>}</pre> | no |
| <a name="input_rtp_storage_account"></a> [rtp\_storage\_account](#input\_rtp\_storage\_account) | n/a | <pre>object({<br/>    account_kind                  = string<br/>    account_tier                  = string<br/>    account_replication_type      = string<br/>    advanced_threat_protection    = bool<br/>    blob_versioning_enabled       = bool<br/>    public_network_access_enabled = bool<br/>    blob_delete_retention_days    = number<br/>    enable_low_availability_alert = bool<br/>    backup_enabled                = optional(bool, false)<br/>    backup_retention              = optional(number, 0)<br/>  })</pre> | <pre>{<br/>  "account_kind": "StorageV2",<br/>  "account_replication_type": "LRS",<br/>  "account_tier": "Standard",<br/>  "advanced_threat_protection": true,<br/>  "backup_enabled": false,<br/>  "backup_retention": 0,<br/>  "blob_delete_retention_days": 30,<br/>  "blob_versioning_enabled": false,<br/>  "enable_low_availability_alert": false,<br/>  "public_network_access_enabled": false<br/>}</pre> | no |
| <a name="input_spoke_replica"></a> [spoke\_replica](#input\_spoke\_replica) | n/a | `bool` | `false` | no |
| <a name="input_storage_account_replication_type"></a> [storage\_account\_replication\_type](#input\_storage\_account\_replication\_type) | (Optional) Fn app storage acocunt replication type | `string` | `"LRS"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
