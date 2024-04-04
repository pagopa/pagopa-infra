# wallet-common

<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | <= 2.47.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.93.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.2.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cosmosdb_account_mongodb"></a> [cosmosdb\_account\_mongodb](#module\_cosmosdb\_account\_mongodb) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_account | v6.3.1 |
| <a name="module_cosmosdb_notices_collections"></a> [cosmosdb\_notices\_collections](#module\_cosmosdb\_notices\_collections) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_mongodb_collection | v6.3.1 |
| <a name="module_cosmosdb_printit_snet"></a> [cosmosdb\_printit\_snet](#module\_cosmosdb\_printit\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v6.3.1 |
| <a name="module_institutions_sa"></a> [institutions\_sa](#module\_institutions\_sa) | git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account | v7.18.0 |
| <a name="module_notices_sa"></a> [notices\_sa](#module\_notices\_sa) | git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account | v7.18.0 |
| <a name="module_printit_storage_snet"></a> [printit\_storage\_snet](#module\_printit\_storage\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v6.7.0 |
| <a name="module_templates_sa"></a> [templates\_sa](#module\_templates\_sa) | git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account | v7.18.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_cosmosdb_mongo_database.notices_mongo_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_database) | resource |
| [azurerm_private_dns_a_record.ingress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_endpoint.institutions_blob_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.notices_blob_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.notices_table_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.templates_blob_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_resource_group.db_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.printit_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_container.institutions_blob_file](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.notices_blob_file](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.template_blob_file](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_management_policy.st_blob_receipts_management_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy) | resource |
| [azurerm_storage_table.template_data_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) | resource |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_eventhub.printit_event_hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub) | data source |
| [azurerm_eventhub_authorization_rule.pagopa_evh_printit-evt_notice-complete-evt-rx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.pagopa_evh_printit-evt_notice-error-evt-rx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.pagopa_evh_printit-evt_notice-evt-rx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_namespace.printit_event_hub_namespace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_namespace) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.cosmos](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.internal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_blob_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_queue_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_table_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.msg_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.aks_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_subnet_cosmosdb_printit"></a> [cidr\_subnet\_cosmosdb\_printit](#input\_cidr\_subnet\_cosmosdb\_printit) | Cosmos DB address space for printit. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_storage_account"></a> [cidr\_subnet\_storage\_account](#input\_cidr\_subnet\_storage\_account) | Storage account network address space. | `list(string)` | n/a | yes |
| <a name="input_cosmos_mongo_db_notices_params"></a> [cosmos\_mongo\_db\_notices\_params](#input\_cosmos\_mongo\_db\_notices\_params) | n/a | <pre>object({<br>    enabled        = bool<br>    capabilities   = list(string)<br>    offer_type     = string<br>    server_version = string<br>    kind           = string<br>    consistency_policy = object({<br>      consistency_level       = string<br>      max_interval_in_seconds = number<br>      max_staleness_prefix    = number<br>    })<br>    main_geo_location_zone_redundant = bool<br>    enable_free_tier                 = bool<br>    additional_geo_locations = list(object({<br>      location          = string<br>      failover_priority = number<br>      zone_redundant    = bool<br>    }))<br>    private_endpoint_enabled          = bool<br>    public_network_access_enabled     = bool<br>    is_virtual_network_filter_enabled = bool<br>    backup_continuous_enabled         = bool<br>    enable_serverless                 = bool<br>    enable_autoscaling                = bool<br>    throughput                        = number<br>    max_throughput                    = number<br>    container_default_ttl             = number<br>  })</pre> | n/a | yes |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_platform"></a> [dns\_zone\_platform](#input\_dns\_zone\_platform) | The platform dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_prefix"></a> [dns\_zone\_prefix](#input\_dns\_zone\_prefix) | The wallet dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_ingress_load_balancer_ip"></a> [ingress\_load\_balancer\_ip](#input\_ingress\_load\_balancer\_ip) | n/a | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_institutions_storage_account"></a> [institutions\_storage\_account](#input\_institutions\_storage\_account) | n/a | <pre>object({<br>    account_kind                  = string<br>    account_tier                  = string<br>    account_replication_type      = string<br>    advanced_threat_protection    = bool<br>    blob_versioning_enabled       = bool<br>    public_network_access_enabled = bool<br>    blob_delete_retention_days    = number<br>    enable_low_availability_alert = bool<br>    backup_enabled                = optional(bool, false)<br>    backup_retention              = optional(number, 0)<br>  })</pre> | <pre>{<br>  "account_kind": "StorageV2",<br>  "account_replication_type": "LRS",<br>  "account_tier": "Standard",<br>  "advanced_threat_protection": true,<br>  "backup_enabled": false,<br>  "backup_retention": 0,<br>  "blob_delete_retention_days": 30,<br>  "blob_versioning_enabled": false,<br>  "enable_low_availability_alert": false,<br>  "public_network_access_enabled": false<br>}</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_notices_storage_account"></a> [notices\_storage\_account](#input\_notices\_storage\_account) | n/a | <pre>object({<br>    account_kind                                                        = string<br>    account_tier                                                        = string<br>    account_replication_type                                            = string<br>    advanced_threat_protection                                          = bool<br>    blob_versioning_enabled                                             = bool<br>    public_network_access_enabled                                       = bool<br>    blob_delete_retention_days                                          = number<br>    enable_low_availability_alert                                       = bool<br>    backup_enabled                                                      = optional(bool, false)<br>    backup_retention                                                    = optional(number, 0)<br>    blob_tier_to_cool_after_last_access                                 = number<br>    blob_tier_to_archive_after_days_since_last_access_time_greater_than = number<br>    blob_delete_after_last_access                                       = number<br>  })</pre> | <pre>{<br>  "account_kind": "StorageV2",<br>  "account_replication_type": "LRS",<br>  "account_tier": "Standard",<br>  "advanced_threat_protection": true,<br>  "backup_enabled": false,<br>  "backup_retention": 0,<br>  "blob_delete_after_last_access": 3650,<br>  "blob_delete_retention_days": 30,<br>  "blob_tier_to_archive_after_days_since_last_access_time_greater_than": 3650,<br>  "blob_tier_to_cool_after_last_access": 0,<br>  "blob_versioning_enabled": false,<br>  "enable_low_availability_alert": false,<br>  "public_network_access_enabled": false<br>}</pre> | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |
| <a name="input_templates_storage_account"></a> [templates\_storage\_account](#input\_templates\_storage\_account) | n/a | <pre>object({<br>    account_kind                  = string<br>    account_tier                  = string<br>    account_replication_type      = string<br>    advanced_threat_protection    = bool<br>    blob_versioning_enabled       = bool<br>    public_network_access_enabled = bool<br>    blob_delete_retention_days    = number<br>    enable_low_availability_alert = bool<br>    backup_enabled                = optional(bool, false)<br>    backup_retention              = optional(number, 0)<br>  })</pre> | <pre>{<br>  "account_kind": "StorageV2",<br>  "account_replication_type": "LRS",<br>  "account_tier": "Standard",<br>  "advanced_threat_protection": true,<br>  "backup_enabled": false,<br>  "backup_retention": 0,<br>  "blob_delete_retention_days": 30,<br>  "blob_versioning_enabled": false,<br>  "enable_low_availability_alert": false,<br>  "public_network_access_enabled": false<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
