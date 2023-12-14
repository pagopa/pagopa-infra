# receipts-common

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.21.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.30.0, <= 3.53.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | = 3.1.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_receipts_datastore_cosmosdb_account"></a> [receipts\_datastore\_cosmosdb\_account](#module\_receipts\_datastore\_cosmosdb\_account) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_account | v6.7.0 |
| <a name="module_receipts_datastore_cosmosdb_containers"></a> [receipts\_datastore\_cosmosdb\_containers](#module\_receipts\_datastore\_cosmosdb\_containers) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container | v6.7.0 |
| <a name="module_receipts_datastore_cosmosdb_database"></a> [receipts\_datastore\_cosmosdb\_database](#module\_receipts\_datastore\_cosmosdb\_database) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_database | v6.7.0 |
| <a name="module_receipts_datastore_cosmosdb_snet"></a> [receipts\_datastore\_cosmosdb\_snet](#module\_receipts\_datastore\_cosmosdb\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v6.4.1 |
| <a name="module_receipts_datastore_fn_sa"></a> [receipts\_datastore\_fn\_sa](#module\_receipts\_datastore\_fn\_sa) | git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account | v7.18.0 |
| <a name="module_receipts_st_snet"></a> [receipts\_st\_snet](#module\_receipts\_st\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v6.7.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_metric_alert.cosmos_db_normalized_ru_exceeded](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_private_dns_a_record.ingress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_endpoint.queue_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.storage_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_resource_group.receipts_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.st_receipts_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_container.blob-receipt-st-attach](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_management_policy.st_blob_receipts_management_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy) | resource |
| [azurerm_storage_queue.queue-receipt-io-notifier-error](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.queue-receipt-waiting-4-gen](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.cosmos](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.internal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.aks_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_insights_name"></a> [application\_insights\_name](#input\_application\_insights\_name) | Specifies the name of the Application Insights. | `string` | n/a | yes |
| <a name="input_cidr_subnet_receipts_datastore_cosmosdb"></a> [cidr\_subnet\_receipts\_datastore\_cosmosdb](#input\_cidr\_subnet\_receipts\_datastore\_cosmosdb) | Cosmos DB address space | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_receipts_datastore_storage"></a> [cidr\_subnet\_receipts\_datastore\_storage](#input\_cidr\_subnet\_receipts\_datastore\_storage) | Storage address space | `list(string)` | `null` | no |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_enable_iac_pipeline"></a> [enable\_iac\_pipeline](#input\_enable\_iac\_pipeline) | If true create the key vault policy to allow used by azure devops iac pipelines. | `bool` | `false` | no |
| <a name="input_enable_sa_backup"></a> [enable\_sa\_backup](#input\_enable\_sa\_backup) | (Optional) Enables storage account backup PIT restore | `bool` | `false` | no |
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
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_receipts_datastore_cosmos_db_params"></a> [receipts\_datastore\_cosmos\_db\_params](#input\_receipts\_datastore\_cosmos\_db\_params) | n/a | <pre>object({<br>    kind           = string<br>    capabilities   = list(string)<br>    offer_type     = string<br>    server_version = string<br>    consistency_policy = object({<br>      consistency_level       = string<br>      max_interval_in_seconds = number<br>      max_staleness_prefix    = number<br>    })<br>    main_geo_location_zone_redundant = bool<br>    enable_free_tier                 = bool<br>    additional_geo_locations = list(object({<br>      location          = string<br>      failover_priority = number<br>      zone_redundant    = bool<br>    }))<br>    private_endpoint_enabled          = bool<br>    public_network_access_enabled     = bool<br>    is_virtual_network_filter_enabled = bool<br>    backup_continuous_enabled         = bool<br>    container_default_ttl             = number<br>  })</pre> | n/a | yes |
| <a name="input_receipts_datastore_fn_sa_advanced_threat_protection"></a> [receipts\_datastore\_fn\_sa\_advanced\_threat\_protection](#input\_receipts\_datastore\_fn\_sa\_advanced\_threat\_protection) | Enable contract threat advanced protection | `bool` | `false` | no |
| <a name="input_receipts_datastore_fn_sa_backup_retention_days"></a> [receipts\_datastore\_fn\_sa\_backup\_retention\_days](#input\_receipts\_datastore\_fn\_sa\_backup\_retention\_days) | Number of days to retain backups. | `number` | `0` | no |
| <a name="input_receipts_datastore_fn_sa_delete_after_last_access"></a> [receipts\_datastore\_fn\_sa\_delete\_after\_last\_access](#input\_receipts\_datastore\_fn\_sa\_delete\_after\_last\_access) | Number of days since modification to blob before deleting | `number` | `3650` | no |
| <a name="input_receipts_datastore_fn_sa_delete_retention_days"></a> [receipts\_datastore\_fn\_sa\_delete\_retention\_days](#input\_receipts\_datastore\_fn\_sa\_delete\_retention\_days) | Number of days to retain deleted. | `number` | `0` | no |
| <a name="input_receipts_datastore_fn_sa_enable_versioning"></a> [receipts\_datastore\_fn\_sa\_enable\_versioning](#input\_receipts\_datastore\_fn\_sa\_enable\_versioning) | Enable sa versioning | `bool` | `false` | no |
| <a name="input_receipts_datastore_fn_sa_tier_to_cool_after_last_access"></a> [receipts\_datastore\_fn\_sa\_tier\_to\_cool\_after\_last\_access](#input\_receipts\_datastore\_fn\_sa\_tier\_to\_cool\_after\_last\_access) | Number of days since last access to blob before moving to cool tier | `number` | `183` | no |
| <a name="input_receipts_datastore_queue_fn_sa_advanced_threat_protection"></a> [receipts\_datastore\_queue\_fn\_sa\_advanced\_threat\_protection](#input\_receipts\_datastore\_queue\_fn\_sa\_advanced\_threat\_protection) | Enable contract threat advanced protection | `bool` | `false` | no |
| <a name="input_receipts_datastore_queue_fn_sa_delete_retention_days"></a> [receipts\_datastore\_queue\_fn\_sa\_delete\_retention\_days](#input\_receipts\_datastore\_queue\_fn\_sa\_delete\_retention\_days) | Number of days to retain deleted. | `number` | `30` | no |
| <a name="input_receipts_max_retry_queuing"></a> [receipts\_max\_retry\_queuing](#input\_receipts\_max\_retry\_queuing) | Max retry queuing when the node calling fails. | `number` | `5` | no |
| <a name="input_receipts_queue_delay_sec"></a> [receipts\_queue\_delay\_sec](#input\_receipts\_queue\_delay\_sec) | The length of time during which the message will be invisible, starting when it is added to the queue. | `number` | `3600` | no |
| <a name="input_receipts_queue_retention_sec"></a> [receipts\_queue\_retention\_sec](#input\_receipts\_queue\_retention\_sec) | The maximum time to allow the message to be in the queue. | `number` | `86400` | no |
| <a name="input_receipts_storage_account_replication_type"></a> [receipts\_storage\_account\_replication\_type](#input\_receipts\_storage\_account\_replication\_type) | (Optional) Receipts datastore storage account replication type | `string` | `"LRS"` | no |
| <a name="input_receipts_tier_to_archive_after_days_since_last_access_time_greater_than"></a> [receipts\_tier\_to\_archive\_after\_days\_since\_last\_access\_time\_greater\_than](#input\_receipts\_tier\_to\_archive\_after\_days\_since\_last\_access\_time\_greater\_than) | Number of days since last access to blob before moving to archive tier | `number` | `730` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
