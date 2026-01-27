<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | <= 1.13.1 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | <= 2.21.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.110.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.2.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module___v3__"></a> [\_\_v3\_\_](#module\_\_\_v3\_\_) | git::https://github.com/pagopa/terraform-azurerm-v3 | ce3200bf6673671bd6e641722e6c9d7500043fda |
| <a name="module_bizevents_datastore_cosmosdb_account"></a> [bizevents\_datastore\_cosmosdb\_account](#module\_bizevents\_datastore\_cosmosdb\_account) | ./.terraform/modules/__v3__/cosmosdb_account | n/a |
| <a name="module_bizevents_datastore_cosmosdb_account_dev"></a> [bizevents\_datastore\_cosmosdb\_account\_dev](#module\_bizevents\_datastore\_cosmosdb\_account\_dev) | ./.terraform/modules/__v3__/cosmosdb_account | n/a |
| <a name="module_bizevents_datastore_cosmosdb_containers"></a> [bizevents\_datastore\_cosmosdb\_containers](#module\_bizevents\_datastore\_cosmosdb\_containers) | ./.terraform/modules/__v3__/cosmosdb_sql_container | n/a |
| <a name="module_bizevents_datastore_cosmosdb_containers_dev"></a> [bizevents\_datastore\_cosmosdb\_containers\_dev](#module\_bizevents\_datastore\_cosmosdb\_containers\_dev) | ./.terraform/modules/__v3__/cosmosdb_sql_container | n/a |
| <a name="module_bizevents_datastore_cosmosdb_database"></a> [bizevents\_datastore\_cosmosdb\_database](#module\_bizevents\_datastore\_cosmosdb\_database) | ./.terraform/modules/__v3__/cosmosdb_sql_database | n/a |
| <a name="module_bizevents_datastore_cosmosdb_database_dev"></a> [bizevents\_datastore\_cosmosdb\_database\_dev](#module\_bizevents\_datastore\_cosmosdb\_database\_dev) | ./.terraform/modules/__v3__/cosmosdb_sql_database | n/a |
| <a name="module_bizevents_datastore_cosmosdb_snet"></a> [bizevents\_datastore\_cosmosdb\_snet](#module\_bizevents\_datastore\_cosmosdb\_snet) | ./.terraform/modules/__v3__/subnet | n/a |
| <a name="module_bizevents_datastore_fn_sa"></a> [bizevents\_datastore\_fn\_sa](#module\_bizevents\_datastore\_fn\_sa) | ./.terraform/modules/__v3__/storage_account | n/a |
| <a name="module_bizevents_datastore_fn_sa_bizview"></a> [bizevents\_datastore\_fn\_sa\_bizview](#module\_bizevents\_datastore\_fn\_sa\_bizview) | ./.terraform/modules/__v3__/storage_account | n/a |
| <a name="module_identity_cd_01"></a> [identity\_cd\_01](#module\_identity\_cd\_01) | github.com/pagopa/terraform-azurerm-v3//github_federated_identity | n/a |
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | ./.terraform/modules/__v3__/key_vault | n/a |
| <a name="module_negative_bizevents_datastore_cosmosdb_account"></a> [negative\_bizevents\_datastore\_cosmosdb\_account](#module\_negative\_bizevents\_datastore\_cosmosdb\_account) | ./.terraform/modules/__v3__/cosmosdb_account | n/a |
| <a name="module_negative_bizevents_datastore_cosmosdb_containers"></a> [negative\_bizevents\_datastore\_cosmosdb\_containers](#module\_negative\_bizevents\_datastore\_cosmosdb\_containers) | ./.terraform/modules/__v3__/cosmosdb_sql_container | n/a |
| <a name="module_negative_bizevents_datastore_cosmosdb_database"></a> [negative\_bizevents\_datastore\_cosmosdb\_database](#module\_negative\_bizevents\_datastore\_cosmosdb\_database) | ./.terraform/modules/__v3__/cosmosdb_sql_database | n/a |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../../tag_config | n/a |
| <a name="module_workload_identity"></a> [workload\_identity](#module\_workload\_identity) | ./.terraform/modules/__v3__/kubernetes_workload_identity_init | n/a |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.tokenizer_rest_service](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azurerm_api_management_subscription.api_config_cache_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_api_management_subscription.biz_trx_api_key_4_perftest](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_api_management_subscription.ecommerce_helpdesk_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_api_management_subscription.list_lap_4_io_api_key_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_api_management_subscription.list_lap_arc_4_io_api_key_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_api_management_subscription.pdf_engine_node_4_list_trx_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_api_management_subscription.pdf_receipt_service_4_list_trx_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_data_factory_data_flow.write_biz_events_to_biz_view](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_data_flow) | resource |
| [azurerm_data_factory_dataset_cosmosdb_sqlapi.biz_events_cart_view_dataset](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_dataset_cosmosdb_sqlapi) | resource |
| [azurerm_data_factory_dataset_cosmosdb_sqlapi.biz_events_dataset](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_dataset_cosmosdb_sqlapi) | resource |
| [azurerm_data_factory_dataset_cosmosdb_sqlapi.biz_events_general_view_dataset](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_dataset_cosmosdb_sqlapi) | resource |
| [azurerm_data_factory_dataset_cosmosdb_sqlapi.biz_events_user_view_dataset](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_dataset_cosmosdb_sqlapi) | resource |
| [azurerm_data_factory_linked_service_cosmosdb.cosmos_biz_new](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_cosmosdb) | resource |
| [azurerm_data_factory_linked_service_cosmosdb.cosmos_biz_new_dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_cosmosdb) | resource |
| [azurerm_data_factory_pipeline.pipeline_biz_to_view](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_key_vault_access_policy.ad_group_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_developers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_externals_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_legacy_policies](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_managed_identities](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.gha_iac_managed_identities](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.ai_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.api_config_cache_subscription_key_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.biz_azurewebjobsstorage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.biz_events_datastore_cosmos_pkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.biz_trx_api_key_4_perftest_store_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.biz_view_azurewebjobsstorage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.bizevent_pdf_engine_4_list_trx_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.bizevent_receiptpdfhelpdesk_4_list_trx_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.bizevent_receiptpdfservice_4_list_trx_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.cosmos_biz_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.cosmos_biz_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.cosmos_negative_biz_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.cosmos_negative_biz_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.db_nexi_biz_pagopa_sv_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ehub_awakable_negative_biz_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ehub_biz_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ehub_biz_enrich_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ehub_biz_tx_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ehub_final_negative_biz_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ehub_negative_biz_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ehub_rx_negative_awakable_biz_conn_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ehub_rx_negative_final_biz_conn_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ehub_tx_biz_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ehub_tx_negative_biz_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ehub_views_biz_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.elastic_otl_secret_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.list_lap_4_io_api_keysubkey_store_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.list_lap_arc_4_io_api_keysubkey_store_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.payment_manager_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.redis_hostname](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.redis_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.tokenizer_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.webhook-slack-token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_monitor_metric_alert.cosmos_biz_db_normalized_ru_exceeded](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.cosmos_biz_db_provisioned_throughput_exceeded](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_private_dns_a_record.ingress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_resource_group.bizevents_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [null_resource.github_runner_app_permissions_to_namespace_cd_01](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_service_principal.iac_deploy_legacy](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.iac_plan_legacy](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.iac_principal](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azurerm_api_management_api.apim_ecommerce_helpdesk_api_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management_api) | data source |
| [azurerm_api_management_product.apim_api_config_cache_product](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management_product) | data source |
| [azurerm_api_management_product.apim_biz_events_service_product](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management_product) | data source |
| [azurerm_api_management_product.apim_biz_lst_lap_product](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management_product) | data source |
| [azurerm_api_management_product.apim_pdf_engine_product](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management_product) | data source |
| [azurerm_api_management_product.apim_pdf_receipt_service_product](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management_product) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_cosmosdb_account.bizevent_cosmos_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/cosmosdb_account) | data source |
| [azurerm_cosmosdb_account.bizevent_cosmos_account_dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/cosmosdb_account) | data source |
| [azurerm_data_factory.data_factory](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/data_factory) | data source |
| [azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-biz-evt-enrich_pagopa-biz-evt-tx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-biz-evt_pagopa-biz-evt-rx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-biz-evt_pagopa-biz-evt-rx-views](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-biz-evt_pagopa-biz-evt-tx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-negative-biz-evt_pagopa-negative-biz-evt-rx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-negative-biz-evt_pagopa-negative-biz-evt-tx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.pagopa-evh-ns04_nodo-dei-pagamenti-negative-awakable-biz-evt_pagopa-biz-evt-rx-pdnd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.pagopa-evh-ns04_nodo-dei-pagamenti-negative-awakable-biz-evt_pagopa-biz-evt-tx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.pagopa-evh-ns04_nodo-dei-pagamenti-negative-final-biz-evt_pagopa-biz-evt-rx-pdnd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.pagopa-evh-ns04_nodo-dei-pagamenti-negative-final-biz-evt_pagopa-biz-evt-tx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.nodo_key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.db_nexi_biz_pagopa_sv_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.tokenizer_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.cosmos](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.internal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_redis_cache.redis_cache](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/redis_cache) | data source |
| [azurerm_resource_group.identity_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.aks_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_user_assigned_identity.iac_federated_azdo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_insights_name"></a> [application\_insights\_name](#input\_application\_insights\_name) | Specifies the name of the Application Insights. | `string` | n/a | yes |
| <a name="input_bizevents_datastore_cosmos_db_params"></a> [bizevents\_datastore\_cosmos\_db\_params](#input\_bizevents\_datastore\_cosmos\_db\_params) | n/a | <pre>object({<br/>    kind           = string<br/>    capabilities   = list(string)<br/>    offer_type     = string<br/>    server_version = string<br/>    consistency_policy = object({<br/>      consistency_level       = string<br/>      max_interval_in_seconds = number<br/>      max_staleness_prefix    = number<br/>    })<br/>    main_geo_location_zone_redundant = bool<br/>    enable_free_tier                 = bool<br/>    additional_geo_locations = list(object({<br/>      location          = string<br/>      failover_priority = number<br/>      zone_redundant    = bool<br/>    }))<br/>    private_endpoint_enabled          = bool<br/>    public_network_access_enabled     = bool<br/>    is_virtual_network_filter_enabled = bool<br/>    backup_continuous_enabled         = bool<br/>    container_default_ttl             = number<br/>    ip_range_filter                   = string<br/>    max_throughput                    = number<br/>    max_throughput_view               = number<br/>    max_throughput_view_alt           = number<br/>  })</pre> | n/a | yes |
| <a name="input_bizevents_datastore_fn_sa_advanced_threat_protection"></a> [bizevents\_datastore\_fn\_sa\_advanced\_threat\_protection](#input\_bizevents\_datastore\_fn\_sa\_advanced\_threat\_protection) | Enable contract threat advanced protection | `bool` | `false` | no |
| <a name="input_bizevents_datastore_fn_sa_delete_retention_days"></a> [bizevents\_datastore\_fn\_sa\_delete\_retention\_days](#input\_bizevents\_datastore\_fn\_sa\_delete\_retention\_days) | Number of days to retain deleted. | `number` | `30` | no |
| <a name="input_bizevents_datastore_fn_sa_enable_versioning"></a> [bizevents\_datastore\_fn\_sa\_enable\_versioning](#input\_bizevents\_datastore\_fn\_sa\_enable\_versioning) | Enable sa versioning | `bool` | `false` | no |
| <a name="input_cidr_subnet_bizevents_datastore_cosmosdb"></a> [cidr\_subnet\_bizevents\_datastore\_cosmosdb](#input\_cidr\_subnet\_bizevents\_datastore\_cosmosdb) | Cosmos DB address space | `list(string)` | `null` | no |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_enable_iac_pipeline"></a> [enable\_iac\_pipeline](#input\_enable\_iac\_pipeline) | If true create the key vault policy to allow used by azure devops iac pipelines. | `bool` | `false` | no |
| <a name="input_enabled_features"></a> [enabled\_features](#input\_enabled\_features) | Features enabled in this domain | <pre>object({<br/>  })</pre> | `{}` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_ingress_load_balancer_ip"></a> [ingress\_load\_balancer\_ip](#input\_ingress\_load\_balancer\_ip) | n/a | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_negative_bizevents_datastore_cosmos_db_params"></a> [negative\_bizevents\_datastore\_cosmos\_db\_params](#input\_negative\_bizevents\_datastore\_cosmos\_db\_params) | n/a | <pre>object({<br/>    kind           = string<br/>    capabilities   = list(string)<br/>    offer_type     = string<br/>    server_version = string<br/>    consistency_policy = object({<br/>      consistency_level       = string<br/>      max_interval_in_seconds = number<br/>      max_staleness_prefix    = number<br/>    })<br/>    main_geo_location_zone_redundant = bool<br/>    enable_free_tier                 = bool<br/>    additional_geo_locations = list(object({<br/>      location          = string<br/>      failover_priority = number<br/>      zone_redundant    = bool<br/>    }))<br/>    private_endpoint_enabled          = bool<br/>    public_network_access_enabled     = bool<br/>    is_virtual_network_filter_enabled = bool<br/>    backup_continuous_enabled         = bool<br/>    container_default_ttl             = number<br/>    max_throughput                    = number<br/>  })</pre> | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_redis_ha_enabled"></a> [redis\_ha\_enabled](#input\_redis\_ha\_enabled) | (Required) enables usage of HA deployed redis instance | `bool` | n/a | yes |
| <a name="input_storage_account_replication_type"></a> [storage\_account\_replication\_type](#input\_storage\_account\_replication\_type) | (Optional) biz event fn storage account replication type | `string` | `"LRS"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
