
<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | <= 1.12.1 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | <= 2.6.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.45.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | <= 2.4.1 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.2.2 |
| <a name="requirement_time"></a> [time](#requirement\_time) | <= 0.10.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_canoneunico_function"></a> [canoneunico\_function](#module\_canoneunico\_function) | git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app | v6.15.2 |
| <a name="module_canoneunico_function_snet"></a> [canoneunico\_function\_snet](#module\_canoneunico\_function\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v6.15.0 |
| <a name="module_canoneunico_sa"></a> [canoneunico\_sa](#module\_canoneunico\_sa) | git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account | v7.18.0 |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../../tag_config | n/a |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.sftp_localuser_on_container](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource_action.generate_sftp_user_password](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource_action) | resource |
| [azurerm_app_service_plan.canoneunico_service_plan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_plan) | resource |
| [azurerm_eventgrid_system_topic.storage_topic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_system_topic) | resource |
| [azurerm_eventgrid_system_topic_event_subscription.storage_subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_system_topic_event_subscription) | resource |
| [azurerm_monitor_autoscale_setting.canoneunico_function](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.canoneunico_gpd_error](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.canoneunico_parsing_csv_error](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-cup-create-debt-position-function-availability](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-cup-csv-genearate-csv-batch-function-availability](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-cup-csv-parsing-function-availability](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_resource_group.canoneunico_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_blob.containers_err_directory](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_blob.containers_in_directory](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_blob.containers_out_directory](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_container.corporate_containers](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.err_csv_blob_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.in_csv_blob_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.out_csv_blob_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_queue.cu_blob_event_queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.cu_debtposition_queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_table.cu_debtposition_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) | resource |
| [azurerm_storage_table.cu_ecconfig_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) | resource |
| [azurerm_storage_table.cu_iuvs_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) | resource |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_container_registry.login_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/container_registry) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_resource_group.container_registry_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.apim_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_canoneunico_advanced_threat_protection"></a> [canoneunico\_advanced\_threat\_protection](#input\_canoneunico\_advanced\_threat\_protection) | Enable contract threat advanced protection | `bool` | `false` | no |
| <a name="input_canoneunico_backup_retention_days"></a> [canoneunico\_backup\_retention\_days](#input\_canoneunico\_backup\_retention\_days) | Number of days to retain backup. | `number` | `0` | no |
| <a name="input_canoneunico_batch_size_debt_pos_queue"></a> [canoneunico\_batch\_size\_debt\_pos\_queue](#input\_canoneunico\_batch\_size\_debt\_pos\_queue) | Batch size Debt Position queue | `number` | `25` | no |
| <a name="input_canoneunico_batch_size_debt_pos_table"></a> [canoneunico\_batch\_size\_debt\_pos\_table](#input\_canoneunico\_batch\_size\_debt\_pos\_table) | Batch size Debt Position table | `number` | `25` | no |
| <a name="input_canoneunico_delete_retention_days"></a> [canoneunico\_delete\_retention\_days](#input\_canoneunico\_delete\_retention\_days) | Number of days to retain deleted. | `number` | `30` | no |
| <a name="input_canoneunico_enable_versioning"></a> [canoneunico\_enable\_versioning](#input\_canoneunico\_enable\_versioning) | Enable sa versioning | `bool` | `false` | no |
| <a name="input_canoneunico_function_always_on"></a> [canoneunico\_function\_always\_on](#input\_canoneunico\_function\_always\_on) | Always on property | `bool` | `false` | no |
| <a name="input_canoneunico_function_autoscale_default"></a> [canoneunico\_function\_autoscale\_default](#input\_canoneunico\_function\_autoscale\_default) | The number of instances that are available for scaling if metrics are not available for evaluation. | `number` | `1` | no |
| <a name="input_canoneunico_function_autoscale_maximum"></a> [canoneunico\_function\_autoscale\_maximum](#input\_canoneunico\_function\_autoscale\_maximum) | The maximum number of instances for this resource. | `number` | `3` | no |
| <a name="input_canoneunico_function_autoscale_minimum"></a> [canoneunico\_function\_autoscale\_minimum](#input\_canoneunico\_function\_autoscale\_minimum) | The minimum number of instances for this resource. | `number` | `1` | no |
| <a name="input_canoneunico_plan_kind"></a> [canoneunico\_plan\_kind](#input\_canoneunico\_plan\_kind) | App service plan kind | `string` | `"Linux"` | no |
| <a name="input_canoneunico_plan_sku_size"></a> [canoneunico\_plan\_sku\_size](#input\_canoneunico\_plan\_sku\_size) | App service plan sku size | `string` | `null` | no |
| <a name="input_canoneunico_plan_sku_tier"></a> [canoneunico\_plan\_sku\_tier](#input\_canoneunico\_plan\_sku\_tier) | App service plan sku tier | `string` | `null` | no |
| <a name="input_canoneunico_queue_message_delay"></a> [canoneunico\_queue\_message\_delay](#input\_canoneunico\_queue\_message\_delay) | Queue message delay | `number` | `120` | no |
| <a name="input_canoneunico_runtime_version"></a> [canoneunico\_runtime\_version](#input\_canoneunico\_runtime\_version) | Version for the Azure function runtime | `string` | `"~4"` | no |
| <a name="input_canoneunico_schedule_batch"></a> [canoneunico\_schedule\_batch](#input\_canoneunico\_schedule\_batch) | Cron scheduling (NCRON) default : every hour | `string` | `"0 0 */1 * * *"` | no |
| <a name="input_cidr_subnet_canoneunico_common"></a> [cidr\_subnet\_canoneunico\_common](#input\_cidr\_subnet\_canoneunico\_common) | Address prefixes subnet canoneunico\_common function | `list(string)` | `null` | no |
| <a name="input_corporate_cup_users"></a> [corporate\_cup\_users](#input\_corporate\_cup\_users) | List of corporate CUP user. | <pre>list(object({<br/>    username = string<br/>  }))</pre> | `[]` | no |
| <a name="input_dns_zone_prefix"></a> [dns\_zone\_prefix](#input\_dns\_zone\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_enable_canoneunico_backup"></a> [enable\_canoneunico\_backup](#input\_enable\_canoneunico\_backup) | (Optional) Enables canoneunico storage account backup | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_function_storage_account_info"></a> [function\_storage\_account\_info](#input\_function\_storage\_account\_info) | n/a | <pre>object({<br/>    account_kind                      = string<br/>    account_tier                      = string<br/>    account_replication_type          = string<br/>    access_tier                       = string<br/>    advanced_threat_protection_enable = bool<br/>  })</pre> | <pre>{<br/>  "access_tier": "Hot",<br/>  "account_kind": "StorageV2",<br/>  "account_replication_type": "LRS",<br/>  "account_tier": "Standard",<br/>  "advanced_threat_protection_enable": true<br/>}</pre> | no |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | The image name to use with a function app | `string` | `"pagopa/canone-unico"` | no |
| <a name="input_image_tag"></a> [image\_tag](#input\_image\_tag) | The image tag to use with a function app | `string` | `"latest"` | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | `"westeurope"` | no |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"pagopa"` | no |
| <a name="input_private_endpoint_network_policies_enabled"></a> [private\_endpoint\_network\_policies\_enabled](#input\_private\_endpoint\_network\_policies\_enabled) | Enable the private endpoint network policies | `bool` | `false` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Enable the public network access | `bool` | `false` | no |
| <a name="input_storage_account_info"></a> [storage\_account\_info](#input\_storage\_account\_info) | n/a | <pre>object({<br/>    account_kind                      = string<br/>    account_tier                      = string<br/>    account_replication_type          = string<br/>    access_tier                       = string<br/>    advanced_threat_protection_enable = bool<br/>  })</pre> | <pre>{<br/>  "access_tier": "Hot",<br/>  "account_kind": "StorageV2",<br/>  "account_replication_type": "LRS",<br/>  "account_tier": "Standard",<br/>  "advanced_threat_protection_enable": true<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sshPassword"></a> [sshPassword](#output\_sshPassword) | n/a |
<!-- END_TF_DOCS -->

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | = 1.3.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.6.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.30.0, <= 3.53.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.2.3 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.9.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_canoneunico_function"></a> [canoneunico\_function](#module\_canoneunico\_function) | git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app | v6.15.2 |
| <a name="module_canoneunico_function_snet"></a> [canoneunico\_function\_snet](#module\_canoneunico\_function\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v6.15.0 |
| <a name="module_canoneunico_sa"></a> [canoneunico\_sa](#module\_canoneunico\_sa) | git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account | v6.15.2 |

## Resources

| Name | Type |
|------|------|
| [azurerm_app_service_plan.canoneunico_service_plan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_plan) | resource |
| [azurerm_monitor_autoscale_setting.canoneunico_function](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.canoneunico_gpd_error](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.canoneunico_parsing_csv_error](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_resource_group.canoneunico_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_container.err_csv_blob_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.in_csv_blob_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.out_csv_blob_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_queue.cu_debtposition_queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_table.cu_debtposition_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) | resource |
| [azurerm_storage_table.cu_ecconfig_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) | resource |
| [azurerm_storage_table.cu_iuvs_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) | resource |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_container_registry.login_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/container_registry) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_resource_group.container_registry_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.apim_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_canoneunico_advanced_threat_protection"></a> [canoneunico\_advanced\_threat\_protection](#input\_canoneunico\_advanced\_threat\_protection) | Enable contract threat advanced protection | `bool` | `false` | no |
| <a name="input_canoneunico_batch_size_debt_pos_queue"></a> [canoneunico\_batch\_size\_debt\_pos\_queue](#input\_canoneunico\_batch\_size\_debt\_pos\_queue) | Batch size Debt Position queue | `number` | `25` | no |
| <a name="input_canoneunico_batch_size_debt_pos_table"></a> [canoneunico\_batch\_size\_debt\_pos\_table](#input\_canoneunico\_batch\_size\_debt\_pos\_table) | Batch size Debt Position table | `number` | `25` | no |
| <a name="input_canoneunico_delete_retention_days"></a> [canoneunico\_delete\_retention\_days](#input\_canoneunico\_delete\_retention\_days) | Number of days to retain deleted. | `number` | `30` | no |
| <a name="input_canoneunico_enable_versioning"></a> [canoneunico\_enable\_versioning](#input\_canoneunico\_enable\_versioning) | Enable sa versioning | `bool` | `false` | no |
| <a name="input_canoneunico_function_always_on"></a> [canoneunico\_function\_always\_on](#input\_canoneunico\_function\_always\_on) | Always on property | `bool` | `false` | no |
| <a name="input_canoneunico_function_autoscale_default"></a> [canoneunico\_function\_autoscale\_default](#input\_canoneunico\_function\_autoscale\_default) | The number of instances that are available for scaling if metrics are not available for evaluation. | `number` | `1` | no |
| <a name="input_canoneunico_function_autoscale_maximum"></a> [canoneunico\_function\_autoscale\_maximum](#input\_canoneunico\_function\_autoscale\_maximum) | The maximum number of instances for this resource. | `number` | `3` | no |
| <a name="input_canoneunico_function_autoscale_minimum"></a> [canoneunico\_function\_autoscale\_minimum](#input\_canoneunico\_function\_autoscale\_minimum) | The minimum number of instances for this resource. | `number` | `1` | no |
| <a name="input_canoneunico_plan_kind"></a> [canoneunico\_plan\_kind](#input\_canoneunico\_plan\_kind) | App service plan kind | `string` | `"Linux"` | no |
| <a name="input_canoneunico_plan_sku_size"></a> [canoneunico\_plan\_sku\_size](#input\_canoneunico\_plan\_sku\_size) | App service plan sku size | `string` | `null` | no |
| <a name="input_canoneunico_plan_sku_tier"></a> [canoneunico\_plan\_sku\_tier](#input\_canoneunico\_plan\_sku\_tier) | App service plan sku tier | `string` | `null` | no |
| <a name="input_canoneunico_queue_message_delay"></a> [canoneunico\_queue\_message\_delay](#input\_canoneunico\_queue\_message\_delay) | Queue message delay | `number` | `120` | no |
| <a name="input_canoneunico_schedule_batch"></a> [canoneunico\_schedule\_batch](#input\_canoneunico\_schedule\_batch) | Cron scheduling (NCRON) default : every hour | `string` | `"0 0 */1 * * *"` | no |
| <a name="input_cidr_subnet_canoneunico_common"></a> [cidr\_subnet\_canoneunico\_common](#input\_cidr\_subnet\_canoneunico\_common) | Address prefixes subnet canoneunico\_common function | `list(string)` | `null` | no |
| <a name="input_dns_zone_prefix"></a> [dns\_zone\_prefix](#input\_dns\_zone\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | The image name to use with a function app | `string` | `null` | no |
| <a name="input_image_tag"></a> [image\_tag](#input\_image\_tag) | The image tag to use with a function app | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | `"westeurope"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"pagopa"` | no |
| <a name="input_private_endpoint_network_policies_enabled"></a> [private\_endpoint\_network\_policies\_enabled](#input\_private\_endpoint\_network\_policies\_enabled) | Enable the private endpoint network policies | `bool` | `false` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Enable the public network access | `bool` | `false` | no |
| <a name="input_storage_account_info"></a> [storage\_account\_info](#input\_storage\_account\_info) | n/a | <pre>object({<br>    account_kind                      = string<br>    account_tier                      = string<br>    account_replication_type          = string<br>    access_tier                       = string<br>    advanced_threat_protection_enable = bool<br>  })</pre> | <pre>{<br>  "access_tier": "Hot",<br>  "account_kind": "StorageV2",<br>  "account_replication_type": "LRS",<br>  "account_tier": "Standard",<br>  "advanced_threat_protection_enable": true<br>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
