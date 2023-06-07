# apiconfig-common

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 2.30.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 3.38.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | = 3.1.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cosmosdb_account_mongodb"></a> [cosmosdb\_account\_mongodb](#module\_cosmosdb\_account\_mongodb) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_account | v6.3.1 |
| <a name="module_cosmosdb_fdr_collections"></a> [cosmosdb\_fdr\_collections](#module\_cosmosdb\_fdr\_collections) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_mongodb_collection | v6.3.1 |
| <a name="module_cosmosdb_fdr_snet"></a> [cosmosdb\_fdr\_snet](#module\_cosmosdb\_fdr\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v6.3.1 |
| <a name="module_fdr_conversion_sa"></a> [fdr\_conversion\_sa](#module\_fdr\_conversion\_sa) | git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account | v6.4.1 |
| <a name="module_postgres_flexible_server_fdr"></a> [postgres\_flexible\_server\_fdr](#module\_postgres\_flexible\_server\_fdr) | git::https://github.com/pagopa/terraform-azurerm-v3.git//postgres_flexible_server | v6.2.1 |
| <a name="module_postgres_flexible_snet"></a> [postgres\_flexible\_snet](#module\_postgres\_flexible\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v6.2.1 |

## Resources

| Name | Type |
|------|------|
| [azurerm_cosmosdb_mongo_database.fdr](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/cosmosdb_mongo_database) | resource |
| [azurerm_postgresql_flexible_server_configuration.fdr_db_flex_default_pool_size](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_configuration.fdr_db_flex_ignore_startup_parameters](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_configuration.fdr_db_flex_max_connection](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_configuration.fdr_db_flex_min_pool_size](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_database.fdr_db](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/postgresql_flexible_server_database) | resource |
| [azurerm_postgresql_flexible_server_database.fdr_replica_db](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/postgresql_flexible_server_database) | resource |
| [azurerm_private_dns_a_record.ingress](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_resource_group.db_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.fdr_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/resource_group) | resource |
| [azurerm_storage_container.xml_blob_file](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/storage_container) | resource |
| [azurerm_storage_queue.flow_id_send_queue](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/storage_queue) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/2.30.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/2.30.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/2.30.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/2.30.0/docs/data-sources/group) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.pgres_flex_admin_login](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pgres_flex_admin_pwd](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.slackemail](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.cosmos](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.internal](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.postgres](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.aks_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_dns_zone_prefix"></a> [apim\_dns\_zone\_prefix](#input\_apim\_dns\_zone\_prefix) | The dns subdomain for apim. | `string` | `null` | no |
| <a name="input_cidr_subnet_cosmosdb_fdr"></a> [cidr\_subnet\_cosmosdb\_fdr](#input\_cidr\_subnet\_cosmosdb\_fdr) | Cosmos DB address space for fdr. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_flex_dbms"></a> [cidr\_subnet\_flex\_dbms](#input\_cidr\_subnet\_flex\_dbms) | Postgresql network address space. | `list(string)` | n/a | yes |
| <a name="input_cosmos_mongo_db_fdr_params"></a> [cosmos\_mongo\_db\_fdr\_params](#input\_cosmos\_mongo\_db\_fdr\_params) | n/a | <pre>object({<br>    enable_serverless  = bool<br>    enable_autoscaling = bool<br>    throughput         = number<br>    max_throughput     = number<br>  })</pre> | n/a | yes |
| <a name="input_cosmos_mongo_db_params"></a> [cosmos\_mongo\_db\_params](#input\_cosmos\_mongo\_db\_params) | n/a | <pre>object({<br>    enabled        = bool<br>    capabilities   = list(string)<br>    offer_type     = string<br>    server_version = string<br>    kind           = string<br>    consistency_policy = object({<br>      consistency_level       = string<br>      max_interval_in_seconds = number<br>      max_staleness_prefix    = number<br>    })<br>    main_geo_location_zone_redundant = bool<br>    enable_free_tier                 = bool<br>    main_geo_location_zone_redundant = bool<br>    additional_geo_locations = list(object({<br>      location          = string<br>      failover_priority = number<br>      zone_redundant    = bool<br>    }))<br>    private_endpoint_enabled          = bool<br>    public_network_access_enabled     = bool<br>    is_virtual_network_filter_enabled = bool<br>    backup_continuous_enabled         = bool<br>  })</pre> | n/a | yes |
| <a name="input_custom_metric_alerts"></a> [custom\_metric\_alerts](#input\_custom\_metric\_alerts) | Map of name = criteria objects | <pre>map(object({<br>    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]<br>    aggregation = string<br>    metric_name = string<br>    # "Insights.Container/pods" "Insights.Container/nodes"<br>    metric_namespace = string<br>    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]<br>    operator  = string<br>    threshold = number<br>    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H<br>    frequency = string<br>    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.<br>    window_size = string<br>    # severity: The severity of this Metric Alert. Possible values are 0, 1, 2, 3 and 4. Defaults to 3.<br>    severity = number<br>  }))</pre> | <pre>{<br>  "active_connections": {<br>    "aggregation": "Average",<br>    "frequency": "PT5M",<br>    "metric_name": "active_connections",<br>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br>    "operator": "GreaterThan",<br>    "severity": 2,<br>    "threshold": 80,<br>    "window_size": "PT30M"<br>  },<br>  "connections_failed": {<br>    "aggregation": "Total",<br>    "frequency": "PT5M",<br>    "metric_name": "connections_failed",<br>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br>    "operator": "GreaterThan",<br>    "severity": 2,<br>    "threshold": 80,<br>    "window_size": "PT30M"<br>  },<br>  "cpu_percent": {<br>    "aggregation": "Average",<br>    "frequency": "PT5M",<br>    "metric_name": "cpu_percent",<br>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br>    "operator": "GreaterThan",<br>    "severity": 2,<br>    "threshold": 4500,<br>    "window_size": "PT30M"<br>  },<br>  "memory_percent": {<br>    "aggregation": "Average",<br>    "frequency": "PT5M",<br>    "metric_name": "memory_percent",<br>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br>    "operator": "GreaterThan",<br>    "severity": 2,<br>    "threshold": 80,<br>    "window_size": "PT30M"<br>  },<br>  "storage_percent": {<br>    "aggregation": "Average",<br>    "frequency": "PT5M",<br>    "metric_name": "storage_percent",<br>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br>    "operator": "GreaterThan",<br>    "severity": 2,<br>    "threshold": 80,<br>    "window_size": "PT30M"<br>  }<br>}</pre> | no |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_enable_iac_pipeline"></a> [enable\_iac\_pipeline](#input\_enable\_iac\_pipeline) | If true create the key vault policy to allow used by azure devops iac pipelines. | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_fdr_conversion_versioning"></a> [fdr\_conversion\_versioning](#input\_fdr\_conversion\_versioning) | Enable sa versioning | `bool` | `false` | no |
| <a name="input_fdr_convertion_advanced_threat_protection"></a> [fdr\_convertion\_advanced\_threat\_protection](#input\_fdr\_convertion\_advanced\_threat\_protection) | Enable contract threat advanced protection | `bool` | `false` | no |
| <a name="input_fdr_convertion_delete_retention_days"></a> [fdr\_convertion\_delete\_retention\_days](#input\_fdr\_convertion\_delete\_retention\_days) | Number of days to retain deleted. | `number` | `30` | no |
| <a name="input_github"></a> [github](#input\_github) | n/a | <pre>object({<br>    org = string<br>  })</pre> | <pre>{<br>  "org": "pagopa"<br>}</pre> | no |
| <a name="input_ingress_load_balancer_ip"></a> [ingress\_load\_balancer\_ip](#input\_ingress\_load\_balancer\_ip) | n/a | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_k8s_kube_config_path_prefix"></a> [k8s\_kube\_config\_path\_prefix](#input\_k8s\_kube\_config\_path\_prefix) | n/a | `string` | `"~/.kube"` | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_pgres_flex_fdr_db_name"></a> [pgres\_flex\_fdr\_db\_name](#input\_pgres\_flex\_fdr\_db\_name) | FdR DB name | `string` | `"fdr"` | no |
| <a name="input_pgres_flex_params"></a> [pgres\_flex\_params](#input\_pgres\_flex\_params) | Postgres Flexible | <pre>object({<br>    enabled                                = bool<br>    sku_name                               = string<br>    db_version                             = string<br>    storage_mb                             = string<br>    zone                                   = number<br>    backup_retention_days                  = number<br>    geo_redundant_backup_enabled           = bool<br>    create_mode                            = string<br>    pgres_flex_private_endpoint_enabled    = bool<br>    pgres_flex_ha_enabled                  = bool<br>    pgres_flex_pgbouncer_enabled           = bool<br>    pgres_flex_diagnostic_settings_enabled = bool<br>    max_connections                        = number<br>  })</pre> | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
