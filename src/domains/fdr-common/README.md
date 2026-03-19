# apiconfig-common

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
| <a name="module___v4__"></a> [\_\_v4\_\_](#module\_\_\_v4\_\_) | git::https://github.com/pagopa/terraform-azurerm-v4 | d72285dd7a5f032fdbe8f572f796b75d76865004 |
| <a name="module_cosmosdb_account_mongodb_fdr_re"></a> [cosmosdb\_account\_mongodb\_fdr\_re](#module\_cosmosdb\_account\_mongodb\_fdr\_re) | ./.terraform/modules/__v4__/cosmosdb_account | n/a |
| <a name="module_cosmosdb_fdr_re_collections"></a> [cosmosdb\_fdr\_re\_collections](#module\_cosmosdb\_fdr\_re\_collections) | ./.terraform/modules/__v4__/cosmosdb_mongodb_collection | n/a |
| <a name="module_cosmosdb_fdr_snet"></a> [cosmosdb\_fdr\_snet](#module\_cosmosdb\_fdr\_snet) | ./.terraform/modules/__v4__/subnet | n/a |
| <a name="module_fdr_conversion_sa"></a> [fdr\_conversion\_sa](#module\_fdr\_conversion\_sa) | ./.terraform/modules/__v4__/storage_account | n/a |
| <a name="module_fdr_flows_sa"></a> [fdr\_flows\_sa](#module\_fdr\_flows\_sa) | ./.terraform/modules/__v4__/storage_account | n/a |
| <a name="module_fdr_re_sa"></a> [fdr\_re\_sa](#module\_fdr\_re\_sa) | ./.terraform/modules/__v4__/storage_account | n/a |
| <a name="module_fdr_storage_snet"></a> [fdr\_storage\_snet](#module\_fdr\_storage\_snet) | ./.terraform/modules/__v4__/subnet | n/a |
| <a name="module_identity_cd_01"></a> [identity\_cd\_01](#module\_identity\_cd\_01) | ./.terraform/modules/__v4__/github_federated_identity | n/a |
| <a name="module_identity_ci_01"></a> [identity\_ci\_01](#module\_identity\_ci\_01) | ./.terraform/modules/__v4__/github_federated_identity | n/a |
| <a name="module_identity_oidc_01"></a> [identity\_oidc\_01](#module\_identity\_oidc\_01) | ./.terraform/modules/__v4__/github_federated_identity | n/a |
| <a name="module_postgres_flexible_itn_spoke_snet_replica"></a> [postgres\_flexible\_itn\_spoke\_snet\_replica](#module\_postgres\_flexible\_itn\_spoke\_snet\_replica) | ./.terraform/modules/__v4__/IDH/subnet | n/a |
| <a name="module_postgres_flexible_server_fdr"></a> [postgres\_flexible\_server\_fdr](#module\_postgres\_flexible\_server\_fdr) | ./.terraform/modules/__v4__/postgres_flexible_server | n/a |
| <a name="module_postgres_flexible_snet"></a> [postgres\_flexible\_snet](#module\_postgres\_flexible\_snet) | ./.terraform/modules/__v4__/subnet | n/a |
| <a name="module_postgresql_fdr_spoke_replica_itn_db"></a> [postgresql\_fdr\_spoke\_replica\_itn\_db](#module\_postgresql\_fdr\_spoke\_replica\_itn\_db) | ./.terraform/modules/__v4__/postgres_flexible_server_replica | n/a |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../../tag_config | n/a |
| <a name="module_workload_identity"></a> [workload\_identity](#module\_workload\_identity) | ./.terraform/modules/__v4__/kubernetes_workload_identity_init | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_subscription.opex_internal_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_api_management_subscription.opex_org_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_api_management_subscription.opex_psp_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_api_management_subscription.test_internal_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_api_management_subscription.test_org_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_api_management_subscription.test_psp_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_cosmosdb_mongo_database.fdr_re](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_database) | resource |
| [azurerm_key_vault_secret.evthub_fdr-qi-flows_rx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.evthub_fdr-qi-flows_tx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.evthub_fdr-qi-reported-iuv_rx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.evthub_fdr-qi-reported-iuv_tx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.fdr_re_mongodb_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.fdr_re_storage_account_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.fdr_storage_account_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.opex_internal_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.opex_org_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.opex_psp_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.test_internal_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.test_org_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.test_psp_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.fdr_parsing_0_flows_alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_postgresql_flexible_server_configuration.fdr_db_flex_ignore_startup_parameters](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_configuration.fdr_db_flex_max_connection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_configuration.fdr_db_flex_max_worker_process](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_configuration.fdr_db_flex_min_pool_size](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_configuration.fdr_db_flex_shared_preoload_libraries](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_configuration.fdr_db_flex_wal_level](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_database.fdr3_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_database) | resource |
| [azurerm_postgresql_flexible_server_database.fdr_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_database) | resource |
| [azurerm_postgresql_flexible_server_database.fdr_replica_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_database) | resource |
| [azurerm_postgresql_flexible_server_virtual_endpoint.virtual_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_virtual_endpoint) | resource |
| [azurerm_private_dns_a_record.ingress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_cname_record.cname_record](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_cname_record) | resource |
| [azurerm_private_endpoint.fdr_blob_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.fdr_queue_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.fdr_re_blob_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.fdr_table_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_resource_group.data](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.db_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.fdr_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.data_contributor_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.fdrconversionsa_data_contributor_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_security_center_storage_defender.fdr_re_storage_defender](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_storage_defender) | resource |
| [azurerm_storage_container.fdr1_flows_blob_file](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.fdr3_flows_blob_file](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.fdr_rend_flow](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.fdr_rend_flow_out](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.re_payload_blob_file](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.re_payloads_blob_file](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_management_policy.fdr1_re_payload_blob_file_management_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy) | resource |
| [azurerm_storage_management_policy.storage_account_fdr_management_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy) | resource |
| [azurerm_storage_table.fdr1_conversion_error_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) | resource |
| [null_resource.change_auth_fdr_blob_container](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.github_runner_app_permissions_to_namespace_cd_01](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.github_runner_app_permissions_to_namespace_ci_01](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_api_management_product.fdr_internal_product](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management_product) | data source |
| [azurerm_api_management_product.fdr_org_product](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management_product) | data source |
| [azurerm_api_management_product.fdr_psp_product](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management_product) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_eventhub_authorization_rule.pagopa-weu-core-evh-ns04_fdr-qi-flows-rx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.pagopa-weu-core-evh-ns04_fdr-qi-flows-tx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.pagopa-weu-core-evh-ns04_fdr-qi-reported-iuv-rx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.pagopa-weu-core-evh-ns04_fdr-qi-reported-iuv-tx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.pgres_flex_admin_login](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pgres_flex_admin_pwd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.slackemail](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.cosmos](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.internal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.postgres](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_blob_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_queue_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_table_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.identity_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.reporting_fdr_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.aks_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.spoke_data_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet_italy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_dns_zone_prefix"></a> [apim\_dns\_zone\_prefix](#input\_apim\_dns\_zone\_prefix) | The dns subdomain for apim. | `string` | `null` | no |
| <a name="input_cidr_subnet_cosmosdb_fdr"></a> [cidr\_subnet\_cosmosdb\_fdr](#input\_cidr\_subnet\_cosmosdb\_fdr) | Cosmos DB address space for fdr. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_flex_dbms"></a> [cidr\_subnet\_flex\_dbms](#input\_cidr\_subnet\_flex\_dbms) | Postgresql network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_storage_account"></a> [cidr\_subnet\_storage\_account](#input\_cidr\_subnet\_storage\_account) | Storage account network address space. | `list(string)` | n/a | yes |
| <a name="input_cosmos_mongo_db_fdr_re_params"></a> [cosmos\_mongo\_db\_fdr\_re\_params](#input\_cosmos\_mongo\_db\_fdr\_re\_params) | n/a | <pre>object({<br/>    capabilities   = list(string)<br/>    offer_type     = string<br/>    server_version = string<br/>    kind           = string<br/>    consistency_policy = object({<br/>      consistency_level       = string<br/>      max_interval_in_seconds = number<br/>      max_staleness_prefix    = number<br/>    })<br/>    main_geo_location_zone_redundant = bool<br/>    enable_free_tier                 = bool<br/>    additional_geo_locations = list(object({<br/>      location          = string<br/>      failover_priority = number<br/>      zone_redundant    = bool<br/>    }))<br/>    private_endpoint_enabled          = bool<br/>    public_network_access_enabled     = bool<br/>    is_virtual_network_filter_enabled = bool<br/>    backup_continuous_enabled         = bool<br/>    enable_serverless                 = bool<br/>    enable_autoscaling                = bool<br/>    throughput                        = number<br/>    max_throughput                    = number<br/>    container_default_ttl             = number<br/>    burst_capacity_enabled            = optional(bool, false)<br/>    ip_range                          = optional(list(string), [])<br/>  })</pre> | n/a | yes |
| <a name="input_custom_metric_alerts"></a> [custom\_metric\_alerts](#input\_custom\_metric\_alerts) | Map of name = criteria objects | <pre>map(object({<br/>    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]<br/>    aggregation = string<br/>    metric_name = string<br/>    # "Insights.Container/pods" "Insights.Container/nodes"<br/>    metric_namespace = string<br/>    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]<br/>    operator  = string<br/>    threshold = number<br/>    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H<br/>    frequency = string<br/>    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.<br/>    window_size = string<br/>    # severity: The severity of this Metric Alert. Possible values are 0, 1, 2, 3 and 4. Defaults to 3.<br/>    severity = number<br/>  }))</pre> | <pre>{<br/>  "active_connections": {<br/>    "aggregation": "Average",<br/>    "frequency": "PT5M",<br/>    "metric_name": "active_connections",<br/>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br/>    "operator": "GreaterThan",<br/>    "severity": 2,<br/>    "threshold": 80,<br/>    "window_size": "PT30M"<br/>  },<br/>  "connections_failed": {<br/>    "aggregation": "Total",<br/>    "frequency": "PT5M",<br/>    "metric_name": "connections_failed",<br/>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br/>    "operator": "GreaterThan",<br/>    "severity": 2,<br/>    "threshold": 80,<br/>    "window_size": "PT30M"<br/>  },<br/>  "cpu_percent": {<br/>    "aggregation": "Average",<br/>    "frequency": "PT5M",<br/>    "metric_name": "cpu_percent",<br/>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br/>    "operator": "GreaterThan",<br/>    "severity": 2,<br/>    "threshold": 4500,<br/>    "window_size": "PT30M"<br/>  },<br/>  "memory_percent": {<br/>    "aggregation": "Average",<br/>    "frequency": "PT5M",<br/>    "metric_name": "memory_percent",<br/>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br/>    "operator": "GreaterThan",<br/>    "severity": 2,<br/>    "threshold": 80,<br/>    "window_size": "PT30M"<br/>  },<br/>  "storage_percent": {<br/>    "aggregation": "Average",<br/>    "frequency": "PT5M",<br/>    "metric_name": "storage_percent",<br/>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br/>    "operator": "GreaterThan",<br/>    "severity": 2,<br/>    "threshold": 80,<br/>    "window_size": "PT30M"<br/>  }<br/>}</pre> | no |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_enable_iac_pipeline"></a> [enable\_iac\_pipeline](#input\_enable\_iac\_pipeline) | If true create the key vault policy to allow used by azure devops iac pipelines. | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_fdr1_cached_response_blob_file_retention_days"></a> [fdr1\_cached\_response\_blob\_file\_retention\_days](#input\_fdr1\_cached\_response\_blob\_file\_retention\_days) | The number of day for storage\_management\_policy | `number` | `1` | no |
| <a name="input_fdr_convertion_delete_retention_days"></a> [fdr\_convertion\_delete\_retention\_days](#input\_fdr\_convertion\_delete\_retention\_days) | Number of days to retain deleted. | `number` | `30` | no |
| <a name="input_fdr_re_advanced_threat_protection"></a> [fdr\_re\_advanced\_threat\_protection](#input\_fdr\_re\_advanced\_threat\_protection) | Enable contract threat advanced protection | `bool` | `false` | no |
| <a name="input_fdr_re_delete_retention_days"></a> [fdr\_re\_delete\_retention\_days](#input\_fdr\_re\_delete\_retention\_days) | Number of days to retain deleted. | `number` | `30` | no |
| <a name="input_fdr_re_storage_account"></a> [fdr\_re\_storage\_account](#input\_fdr\_re\_storage\_account) | n/a | <pre>object({<br/>    account_kind                                                 = string<br/>    account_tier                                                 = string<br/>    account_replication_type                                     = string<br/>    blob_versioning_enabled                                      = bool<br/>    public_network_access_enabled                                = bool<br/>    blob_delete_retention_days                                   = number<br/>    enable_low_availability_alert                                = bool<br/>    backup_enabled                                               = optional(bool, false)<br/>    backup_retention                                             = optional(number, 0)<br/>    storage_defender_enabled                                     = bool<br/>    storage_defender_override_subscription_settings_enabled      = bool<br/>    storage_defender_sensitive_data_discovery_enabled            = bool<br/>    storage_defender_malware_scanning_on_upload_enabled          = bool<br/>    storage_defender_malware_scanning_on_upload_cap_gb_per_month = number<br/>    blob_file_retention_days                                     = number<br/>  })</pre> | <pre>{<br/>  "account_kind": "StorageV2",<br/>  "account_replication_type": "LRS",<br/>  "account_tier": "Standard",<br/>  "backup_enabled": false,<br/>  "backup_retention": 0,<br/>  "blob_delete_retention_days": 30,<br/>  "blob_file_retention_days": 180,<br/>  "blob_versioning_enabled": false,<br/>  "enable_low_availability_alert": false,<br/>  "public_network_access_enabled": false,<br/>  "storage_defender_enabled": true,<br/>  "storage_defender_malware_scanning_on_upload_cap_gb_per_month": -1,<br/>  "storage_defender_malware_scanning_on_upload_enabled": false,<br/>  "storage_defender_override_subscription_settings_enabled": false,<br/>  "storage_defender_sensitive_data_discovery_enabled": false<br/>}</pre> | no |
| <a name="input_fdr_re_versioning"></a> [fdr\_re\_versioning](#input\_fdr\_re\_versioning) | Enable sa versioning | `bool` | `false` | no |
| <a name="input_fdr_storage_account"></a> [fdr\_storage\_account](#input\_fdr\_storage\_account) | n/a | <pre>object({<br/>    account_kind                  = string<br/>    account_tier                  = string<br/>    account_replication_type      = string<br/>    advanced_threat_protection    = bool<br/>    blob_versioning_enabled       = bool<br/>    public_network_access_enabled = bool<br/>    blob_delete_retention_days    = number<br/>    enable_low_availability_alert = bool<br/>    backup_enabled                = optional(bool, false)<br/>    backup_retention              = optional(number, 0)<br/>  })</pre> | <pre>{<br/>  "account_kind": "StorageV2",<br/>  "account_replication_type": "LRS",<br/>  "account_tier": "Standard",<br/>  "advanced_threat_protection": true,<br/>  "backup_enabled": false,<br/>  "backup_retention": 0,<br/>  "blob_delete_retention_days": 30,<br/>  "blob_versioning_enabled": false,<br/>  "enable_low_availability_alert": false,<br/>  "public_network_access_enabled": false<br/>}</pre> | no |
| <a name="input_geo_replica_cidr_subnet_postgresql"></a> [geo\_replica\_cidr\_subnet\_postgresql](#input\_geo\_replica\_cidr\_subnet\_postgresql) | Address prefixes replica subnet postgresql | `list(string)` | `null` | no |
| <a name="input_geo_replica_enabled"></a> [geo\_replica\_enabled](#input\_geo\_replica\_enabled) | (Optional) True if geo replica should be active for key data components i.e. PostgreSQL Flexible servers | `bool` | `false` | no |
| <a name="input_github"></a> [github](#input\_github) | n/a | <pre>object({<br/>    org = string<br/>  })</pre> | <pre>{<br/>  "org": "pagopa"<br/>}</pre> | no |
| <a name="input_ingress_load_balancer_ip"></a> [ingress\_load\_balancer\_ip](#input\_ingress\_load\_balancer\_ip) | n/a | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_k8s_kube_config_path_prefix"></a> [k8s\_kube\_config\_path\_prefix](#input\_k8s\_kube\_config\_path\_prefix) | n/a | `string` | `"~/.kube"` | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, italynorth | `string` | n/a | yes |
| <a name="input_location_replica"></a> [location\_replica](#input\_location\_replica) | One of westeurope, italynorth | `string` | `"italynorth"` | no |
| <a name="input_location_replica_short"></a> [location\_replica\_short](#input\_location\_replica\_short) | One of wue, itn | `string` | `"itn"` | no |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_pgres_flex_fdr_db_name"></a> [pgres\_flex\_fdr\_db\_name](#input\_pgres\_flex\_fdr\_db\_name) | FdR DB name | `string` | `"fdr"` | no |
| <a name="input_pgres_flex_params"></a> [pgres\_flex\_params](#input\_pgres\_flex\_params) | Postgres Flexible | <pre>object({<br/>    sku_name                               = string<br/>    db_version                             = string<br/>    storage_mb                             = string<br/>    zone                                   = number<br/>    standby_zone                           = optional(number, 1)<br/>    backup_retention_days                  = number<br/>    geo_redundant_backup_enabled           = bool<br/>    create_mode                            = string<br/>    pgres_flex_private_endpoint_enabled    = bool<br/>    pgres_flex_ha_enabled                  = bool<br/>    pgres_flex_pgbouncer_enabled           = bool<br/>    pgres_flex_diagnostic_settings_enabled = bool<br/>    alerts_enabled                         = bool<br/>    max_connections                        = number<br/>    pgbouncer_min_pool_size                = number<br/>    max_worker_process                     = number<br/>    wal_level                              = string<br/>    shared_preoload_libraries              = string<br/>    public_network_access_enabled          = bool<br/>  })</pre> | n/a | yes |
| <a name="input_postgres_dns_registration_enabled"></a> [postgres\_dns\_registration\_enabled](#input\_postgres\_dns\_registration\_enabled) | (Optional) If true, adds a CNAME record for the database FQDN in the db private dns | `bool` | `false` | no |
| <a name="input_postgres_dns_registration_virtual_endpoint_enabled"></a> [postgres\_dns\_registration\_virtual\_endpoint\_enabled](#input\_postgres\_dns\_registration\_virtual\_endpoint\_enabled) | (Optional) If true, adds a CNAME record for the database VE in the db private dns | `bool` | `false` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_reporting_fdr_blobs_retention_days"></a> [reporting\_fdr\_blobs\_retention\_days](#input\_reporting\_fdr\_blobs\_retention\_days) | The number of day for storage\_management\_policy | `number` | `30` | no |
| <a name="input_reporting_fdr_storage_account"></a> [reporting\_fdr\_storage\_account](#input\_reporting\_fdr\_storage\_account) | n/a | <pre>object({<br/>    advanced_threat_protection         = bool<br/>    advanced_threat_protection_enabled = bool<br/>    blob_versioning_enabled            = bool<br/>    blob_delete_retention_days         = number<br/>    account_replication_type           = string<br/>  })</pre> | <pre>{<br/>  "account_replication_type": "LRS",<br/>  "advanced_threat_protection": false,<br/>  "advanced_threat_protection_enabled": false,<br/>  "blob_delete_retention_days": 30,<br/>  "blob_versioning_enabled": false<br/>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
