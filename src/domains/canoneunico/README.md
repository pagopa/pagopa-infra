# canoneunico

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | = 1.3.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.6.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 2.99.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.2.3 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.9.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_canoneunico_function"></a> [canoneunico\_function](#module\_canoneunico\_function) | git::https://github.com/pagopa/azurerm.git//function_app | v2.2.0 |
| <a name="module_canoneunico_function_snet"></a> [canoneunico\_function\_snet](#module\_canoneunico\_function\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.90 |
| <a name="module_cu_sa"></a> [cu\_sa](#module\_cu\_sa) | git::https://github.com/pagopa/azurerm.git//storage_account | v2.0.28 |

## Resources

| Name | Type |
|------|------|
| [azurerm_app_service_plan.canoneunico_service_plan](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/app_service_plan) | resource |
| [azurerm_monitor_autoscale_setting.canoneunico_function](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.canoneunico_gpd_error](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.canoneunico_parsing_csv_error](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_resource_group.canoneunico_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_storage_container.err_csv_blob_container](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/storage_container) | resource |
| [azurerm_storage_container.in_csv_blob_container](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/storage_container) | resource |
| [azurerm_storage_container.out_csv_blob_container](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/storage_container) | resource |
| [azurerm_storage_queue.cu_debtposition_queue](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/storage_queue) | resource |
| [azurerm_storage_table.cu_debtposition_table](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/storage_table) | resource |
| [azurerm_storage_table.cu_ecconfig_table](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/storage_table) | resource |
| [azurerm_storage_table.cu_iuvs_table](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/storage_table) | resource |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/client_config) | data source |
| [azurerm_container_registry.login_server](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/container_registry) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/monitor_action_group) | data source |
| [azurerm_resource_group.container_registry_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.apim_snet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr_enabled"></a> [acr\_enabled](#input\_acr\_enabled) | Container registry enabled | `bool` | `false` | no |
| <a name="input_advanced_fees_management_size"></a> [advanced\_fees\_management\_size](#input\_advanced\_fees\_management\_size) | advanced fees management plan size | `string` | `"S1"` | no |
| <a name="input_advanced_fees_management_tier"></a> [advanced\_fees\_management\_tier](#input\_advanced\_fees\_management\_tier) | advanced fees management plan tier | `string` | `"Standard"` | no |
| <a name="input_afm_marketplace_cname_record_name"></a> [afm\_marketplace\_cname\_record\_name](#input\_afm\_marketplace\_cname\_record\_name) | DNS canonical name | `string` | `"marketplace"` | no |
| <a name="input_allow_blob_public_access"></a> [allow\_blob\_public\_access](#input\_allow\_blob\_public\_access) | Allow or disallow public access to all blobs or containers in the storage account. | `bool` | `false` | no |
| <a name="input_apim_alerts_enabled"></a> [apim\_alerts\_enabled](#input\_apim\_alerts\_enabled) | Enable alerts | `bool` | `true` | no |
| <a name="input_apim_autoscale"></a> [apim\_autoscale](#input\_apim\_autoscale) | Configure Apim autoscale on capacity metric | <pre>object(<br>    {<br>      enabled                       = bool<br>      default_instances             = number<br>      minimum_instances             = number<br>      maximum_instances             = number<br>      scale_out_capacity_percentage = number<br>      scale_out_time_window         = string<br>      scale_out_value               = string<br>      scale_out_cooldown            = string<br>      scale_in_capacity_percentage  = number<br>      scale_in_time_window          = string<br>      scale_in_value                = string<br>      scale_in_cooldown             = string<br>    }<br>  )</pre> | <pre>{<br>  "default_instances": 1,<br>  "enabled": false,<br>  "maximum_instances": 5,<br>  "minimum_instances": 1,<br>  "scale_in_capacity_percentage": 30,<br>  "scale_in_cooldown": "PT30M",<br>  "scale_in_time_window": "PT30M",<br>  "scale_in_value": "1",<br>  "scale_out_capacity_percentage": 60,<br>  "scale_out_cooldown": "PT45M",<br>  "scale_out_time_window": "PT10M",<br>  "scale_out_value": "2"<br>}</pre> | no |
| <a name="input_apim_fdr_nodo_pagopa_enable"></a> [apim\_fdr\_nodo\_pagopa\_enable](#input\_apim\_fdr\_nodo\_pagopa\_enable) | Enable Fdr Service Nodo pagoPA side | `bool` | `false` | no |
| <a name="input_apim_nodo_auth_decoupler_enable"></a> [apim\_nodo\_auth\_decoupler\_enable](#input\_apim\_nodo\_auth\_decoupler\_enable) | Apply decoupler to nodo-auth product apim policy | `bool` | `false` | no |
| <a name="input_apim_nodo_decoupler_enable"></a> [apim\_nodo\_decoupler\_enable](#input\_apim\_nodo\_decoupler\_enable) | Apply decoupler to nodo product apim policy | `bool` | `false` | no |
| <a name="input_apim_publisher_name"></a> [apim\_publisher\_name](#input\_apim\_publisher\_name) | apim | `string` | n/a | yes |
| <a name="input_apim_sku"></a> [apim\_sku](#input\_apim\_sku) | n/a | `string` | n/a | yes |
| <a name="input_app_gateway_alerts_enabled"></a> [app\_gateway\_alerts\_enabled](#input\_app\_gateway\_alerts\_enabled) | Enable alerts | `bool` | `true` | no |
| <a name="input_app_gateway_allowed_paths_pagopa_onprem_only"></a> [app\_gateway\_allowed\_paths\_pagopa\_onprem\_only](#input\_app\_gateway\_allowed\_paths\_pagopa\_onprem\_only) | Allowed paths from pagopa onprem only | <pre>object({<br>    paths = list(string)<br>    ips   = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_app_gateway_api_certificate_name"></a> [app\_gateway\_api\_certificate\_name](#input\_app\_gateway\_api\_certificate\_name) | Application gateway api certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_deny_paths"></a> [app\_gateway\_deny\_paths](#input\_app\_gateway\_deny\_paths) | Deny paths on app gateway | `list(string)` | `[]` | no |
| <a name="input_app_gateway_deny_paths_2"></a> [app\_gateway\_deny\_paths\_2](#input\_app\_gateway\_deny\_paths\_2) | Deny paths on app gateway | `list(string)` | `[]` | no |
| <a name="input_app_gateway_kibana_certificate_name"></a> [app\_gateway\_kibana\_certificate\_name](#input\_app\_gateway\_kibana\_certificate\_name) | Application gateway api certificate name on Key Vault | `string` | `""` | no |
| <a name="input_app_gateway_management_certificate_name"></a> [app\_gateway\_management\_certificate\_name](#input\_app\_gateway\_management\_certificate\_name) | Application gateway api management certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_max_capacity"></a> [app\_gateway\_max\_capacity](#input\_app\_gateway\_max\_capacity) | n/a | `number` | `2` | no |
| <a name="input_app_gateway_min_capacity"></a> [app\_gateway\_min\_capacity](#input\_app\_gateway\_min\_capacity) | n/a | `number` | `0` | no |
| <a name="input_app_gateway_portal_certificate_name"></a> [app\_gateway\_portal\_certificate\_name](#input\_app\_gateway\_portal\_certificate\_name) | Application gateway developer portal certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_prf_certificate_name"></a> [app\_gateway\_prf\_certificate\_name](#input\_app\_gateway\_prf\_certificate\_name) | Application gateway api certificate name on Key Vault | `string` | `""` | no |
| <a name="input_app_gateway_sku_name"></a> [app\_gateway\_sku\_name](#input\_app\_gateway\_sku\_name) | The Name of the SKU to use for this Application Gateway. Possible values are Standard\_Small, Standard\_Medium, Standard\_Large, Standard\_v2, WAF\_Medium, WAF\_Large, and WAF\_v2 | `string` | n/a | yes |
| <a name="input_app_gateway_sku_tier"></a> [app\_gateway\_sku\_tier](#input\_app\_gateway\_sku\_tier) | The Tier of the SKU to use for this Application Gateway. Possible values are Standard, Standard\_v2, WAF and WAF\_v2 | `string` | n/a | yes |
| <a name="input_app_gateway_waf_enabled"></a> [app\_gateway\_waf\_enabled](#input\_app\_gateway\_waf\_enabled) | Enable waf | `bool` | `true` | no |
| <a name="input_app_gateway_wfespgovit_certificate_name"></a> [app\_gateway\_wfespgovit\_certificate\_name](#input\_app\_gateway\_wfespgovit\_certificate\_name) | Application gateway wfespgovit certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_wisp2_certificate_name"></a> [app\_gateway\_wisp2\_certificate\_name](#input\_app\_gateway\_wisp2\_certificate\_name) | Application gateway wisp2 certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_wisp2govit_certificate_name"></a> [app\_gateway\_wisp2govit\_certificate\_name](#input\_app\_gateway\_wisp2govit\_certificate\_name) | Application gateway wisp2govit certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_azdo_sp_tls_cert_enabled"></a> [azdo\_sp\_tls\_cert\_enabled](#input\_azdo\_sp\_tls\_cert\_enabled) | Enable Azure DevOps connection for TLS cert management | `string` | `false` | no |
| <a name="input_azuread_service_principal_azure_cdn_frontdoor_id"></a> [azuread\_service\_principal\_azure\_cdn\_frontdoor\_id](#input\_azuread\_service\_principal\_azure\_cdn\_frontdoor\_id) | Azure CDN Front Door Principal ID | `string` | `"f3b3f72f-4770-47a5-8c1e-aa298003be12"` | no |
| <a name="input_base_path_nodo_fatturazione"></a> [base\_path\_nodo\_fatturazione](#input\_base\_path\_nodo\_fatturazione) | base nodo on cloud | `string` | n/a | yes |
| <a name="input_base_path_nodo_fatturazione_dev"></a> [base\_path\_nodo\_fatturazione\_dev](#input\_base\_path\_nodo\_fatturazione\_dev) | base nodo on cloud | `string` | `"/fatturazione-dev"` | no |
| <a name="input_base_path_nodo_oncloud"></a> [base\_path\_nodo\_oncloud](#input\_base\_path\_nodo\_oncloud) | base nodo on cloud | `string` | n/a | yes |
| <a name="input_base_path_nodo_ppt_lmi"></a> [base\_path\_nodo\_ppt\_lmi](#input\_base\_path\_nodo\_ppt\_lmi) | base nodo on cloud | `string` | n/a | yes |
| <a name="input_base_path_nodo_ppt_lmi_dev"></a> [base\_path\_nodo\_ppt\_lmi\_dev](#input\_base\_path\_nodo\_ppt\_lmi\_dev) | base nodo on cloud | `string` | `"/ppt-lmi-dev"` | no |
| <a name="input_base_path_nodo_sync"></a> [base\_path\_nodo\_sync](#input\_base\_path\_nodo\_sync) | base nodo on cloud | `string` | n/a | yes |
| <a name="input_base_path_nodo_sync_dev"></a> [base\_path\_nodo\_sync\_dev](#input\_base\_path\_nodo\_sync\_dev) | base nodo on cloud | `string` | `"/sync-cron-dev/syncWisp"` | no |
| <a name="input_base_path_nodo_web_bo"></a> [base\_path\_nodo\_web\_bo](#input\_base\_path\_nodo\_web\_bo) | base nodo on cloud | `string` | n/a | yes |
| <a name="input_base_path_nodo_web_bo_dev"></a> [base\_path\_nodo\_web\_bo\_dev](#input\_base\_path\_nodo\_web\_bo\_dev) | base nodo on cloud | `string` | `"/web-bo-dev"` | no |
| <a name="input_base_path_nodo_web_bo_history"></a> [base\_path\_nodo\_web\_bo\_history](#input\_base\_path\_nodo\_web\_bo\_history) | base nodo on cloud | `string` | n/a | yes |
| <a name="input_base_path_nodo_web_bo_history_dev"></a> [base\_path\_nodo\_web\_bo\_history\_dev](#input\_base\_path\_nodo\_web\_bo\_history\_dev) | base nodo on cloud | `string` | `"/web-bo-history-dev"` | no |
| <a name="input_base_path_nodo_wfesp"></a> [base\_path\_nodo\_wfesp](#input\_base\_path\_nodo\_wfesp) | base nodo on cloud | `string` | n/a | yes |
| <a name="input_base_path_nodo_wfesp_dev"></a> [base\_path\_nodo\_wfesp\_dev](#input\_base\_path\_nodo\_wfesp\_dev) | base nodo on cloud | `string` | `"/wfesp-dev"` | no |
| <a name="input_bpd_hostname"></a> [bpd\_hostname](#input\_bpd\_hostname) | BPD hostname | `string` | `""` | no |
| <a name="input_buyerbanks_advanced_threat_protection"></a> [buyerbanks\_advanced\_threat\_protection](#input\_buyerbanks\_advanced\_threat\_protection) | Enable contract threat advanced protection | `bool` | `false` | no |
| <a name="input_buyerbanks_delete_retention_days"></a> [buyerbanks\_delete\_retention\_days](#input\_buyerbanks\_delete\_retention\_days) | Number of days to retain deleted buyerbanks. | `number` | `30` | no |
| <a name="input_buyerbanks_enable_versioning"></a> [buyerbanks\_enable\_versioning](#input\_buyerbanks\_enable\_versioning) | Enable buyerbanks sa versioning | `bool` | `false` | no |
| <a name="input_buyerbanks_function_always_on"></a> [buyerbanks\_function\_always\_on](#input\_buyerbanks\_function\_always\_on) | Always on property | `bool` | `false` | no |
| <a name="input_buyerbanks_function_autoscale_default"></a> [buyerbanks\_function\_autoscale\_default](#input\_buyerbanks\_function\_autoscale\_default) | The number of instances that are available for scaling if metrics are not available for evaluation. | `number` | `1` | no |
| <a name="input_buyerbanks_function_autoscale_maximum"></a> [buyerbanks\_function\_autoscale\_maximum](#input\_buyerbanks\_function\_autoscale\_maximum) | The maximum number of instances for this resource. | `number` | `3` | no |
| <a name="input_buyerbanks_function_autoscale_minimum"></a> [buyerbanks\_function\_autoscale\_minimum](#input\_buyerbanks\_function\_autoscale\_minimum) | The minimum number of instances for this resource. | `number` | `1` | no |
| <a name="input_buyerbanks_function_kind"></a> [buyerbanks\_function\_kind](#input\_buyerbanks\_function\_kind) | App service plan kind | `string` | `null` | no |
| <a name="input_buyerbanks_function_sku_size"></a> [buyerbanks\_function\_sku\_size](#input\_buyerbanks\_function\_sku\_size) | App service plan sku size | `string` | `null` | no |
| <a name="input_buyerbanks_function_sku_tier"></a> [buyerbanks\_function\_sku\_tier](#input\_buyerbanks\_function\_sku\_tier) | App service plan sku tier | `string` | `null` | no |
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
| <a name="input_checkout_enabled"></a> [checkout\_enabled](#input\_checkout\_enabled) | checkout | `bool` | `false` | no |
| <a name="input_checkout_function_always_on"></a> [checkout\_function\_always\_on](#input\_checkout\_function\_always\_on) | Always on property | `bool` | `false` | no |
| <a name="input_checkout_function_autoscale_default"></a> [checkout\_function\_autoscale\_default](#input\_checkout\_function\_autoscale\_default) | The number of instances that are available for scaling if metrics are not available for evaluation. | `number` | `1` | no |
| <a name="input_checkout_function_autoscale_maximum"></a> [checkout\_function\_autoscale\_maximum](#input\_checkout\_function\_autoscale\_maximum) | The maximum number of instances for this resource. | `number` | `3` | no |
| <a name="input_checkout_function_autoscale_minimum"></a> [checkout\_function\_autoscale\_minimum](#input\_checkout\_function\_autoscale\_minimum) | The minimum number of instances for this resource. | `number` | `1` | no |
| <a name="input_checkout_function_kind"></a> [checkout\_function\_kind](#input\_checkout\_function\_kind) | App service plan kind | `string` | `null` | no |
| <a name="input_checkout_function_sku_size"></a> [checkout\_function\_sku\_size](#input\_checkout\_function\_sku\_size) | App service plan sku size | `string` | `null` | no |
| <a name="input_checkout_function_sku_tier"></a> [checkout\_function\_sku\_tier](#input\_checkout\_function\_sku\_tier) | App service plan sku tier | `string` | `null` | no |
| <a name="input_checkout_pagopaproxy_host"></a> [checkout\_pagopaproxy\_host](#input\_checkout\_pagopaproxy\_host) | pagopaproxy host | `string` | `null` | no |
| <a name="input_cidr_common_private_endpoint_snet"></a> [cidr\_common\_private\_endpoint\_snet](#input\_cidr\_common\_private\_endpoint\_snet) | Common Private Endpoint network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_advanced_fees_management"></a> [cidr\_subnet\_advanced\_fees\_management](#input\_cidr\_subnet\_advanced\_fees\_management) | Cosmos DB address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_apim"></a> [cidr\_subnet\_apim](#input\_cidr\_subnet\_apim) | Address prefixes subnet api management. | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_appgateway"></a> [cidr\_subnet\_appgateway](#input\_cidr\_subnet\_appgateway) | Application gateway address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_azdoa"></a> [cidr\_subnet\_azdoa](#input\_cidr\_subnet\_azdoa) | Azure DevOps agent network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_buyerbanks"></a> [cidr\_subnet\_buyerbanks](#input\_cidr\_subnet\_buyerbanks) | Address prefixes subnet buyerbanks | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_canoneunico_common"></a> [cidr\_subnet\_canoneunico\_common](#input\_cidr\_subnet\_canoneunico\_common) | Address prefixes subnet canoneunico\_common function | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_checkout_be"></a> [cidr\_subnet\_checkout\_be](#input\_cidr\_subnet\_checkout\_be) | Address prefixes subnet checkout function | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_cosmosdb_paymentsdb"></a> [cidr\_subnet\_cosmosdb\_paymentsdb](#input\_cidr\_subnet\_cosmosdb\_paymentsdb) | Cosmos DB address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_dns_forwarder"></a> [cidr\_subnet\_dns\_forwarder](#input\_cidr\_subnet\_dns\_forwarder) | DNS Forwarder network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_eventhub"></a> [cidr\_subnet\_eventhub](#input\_cidr\_subnet\_eventhub) | Address prefixes subnet eventhub | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_gpd"></a> [cidr\_subnet\_gpd](#input\_cidr\_subnet\_gpd) | Address prefixes subnet gpd service | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_logicapp_biz_evt"></a> [cidr\_subnet\_logicapp\_biz\_evt](#input\_cidr\_subnet\_logicapp\_biz\_evt) | Address prefixes subnet logic app | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_mock_ec"></a> [cidr\_subnet\_mock\_ec](#input\_cidr\_subnet\_mock\_ec) | Address prefixes subnet mock ec | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_mock_payment_gateway"></a> [cidr\_subnet\_mock\_payment\_gateway](#input\_cidr\_subnet\_mock\_payment\_gateway) | Address prefixes subnet mock payment\_gateway | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_node_forwarder"></a> [cidr\_subnet\_node\_forwarder](#input\_cidr\_subnet\_node\_forwarder) | Address prefixes subnet node forwarder | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_pagopa_proxy"></a> [cidr\_subnet\_pagopa\_proxy](#input\_cidr\_subnet\_pagopa\_proxy) | Address prefixes subnet proxy | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_pagopa_proxy_redis"></a> [cidr\_subnet\_pagopa\_proxy\_redis](#input\_cidr\_subnet\_pagopa\_proxy\_redis) | Address prefixes subnet redis for pagopa proxy | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_pg_flex_dbms"></a> [cidr\_subnet\_pg\_flex\_dbms](#input\_cidr\_subnet\_pg\_flex\_dbms) | Postgres Flexible Server network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_postgresql"></a> [cidr\_subnet\_postgresql](#input\_cidr\_subnet\_postgresql) | Address prefixes subnet postgresql | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_redis"></a> [cidr\_subnet\_redis](#input\_cidr\_subnet\_redis) | Redis network address space. | `list(string)` | <pre>[<br>  "10.1.162.0/24"<br>]</pre> | no |
| <a name="input_cidr_subnet_reporting_fdr"></a> [cidr\_subnet\_reporting\_fdr](#input\_cidr\_subnet\_reporting\_fdr) | Address prefixes subnet reporting\_fdr function | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_vpn"></a> [cidr\_subnet\_vpn](#input\_cidr\_subnet\_vpn) | VPN network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_vnet"></a> [cidr\_vnet](#input\_cidr\_vnet) | Virtual network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_vnet_integration"></a> [cidr\_vnet\_integration](#input\_cidr\_vnet\_integration) | Virtual network to peer with sia subscription. It should host apim | `list(string)` | n/a | yes |
| <a name="input_cobadge_hostname"></a> [cobadge\_hostname](#input\_cobadge\_hostname) | Cobadge hostname | `string` | `""` | no |
| <a name="input_cosmos_document_db_params"></a> [cosmos\_document\_db\_params](#input\_cosmos\_document\_db\_params) | n/a | <pre>object({<br>    kind           = string<br>    capabilities   = list(string)<br>    offer_type     = string<br>    server_version = string<br>    consistency_policy = object({<br>      consistency_level       = string<br>      max_interval_in_seconds = number<br>      max_staleness_prefix    = number<br>    })<br>    main_geo_location_zone_redundant = bool<br>    enable_free_tier                 = bool<br>    main_geo_location_zone_redundant = bool<br>    additional_geo_locations = list(object({<br>      location          = string<br>      failover_priority = number<br>      zone_redundant    = bool<br>    }))<br>    private_endpoint_enabled          = bool<br>    public_network_access_enabled     = bool<br>    is_virtual_network_filter_enabled = bool<br>    backup_continuous_enabled         = bool<br>  })</pre> | n/a | yes |
| <a name="input_cstar_outbound_ip_1"></a> [cstar\_outbound\_ip\_1](#input\_cstar\_outbound\_ip\_1) | CSTAR ip 1 | `string` | n/a | yes |
| <a name="input_cstar_outbound_ip_2"></a> [cstar\_outbound\_ip\_2](#input\_cstar\_outbound\_ip\_2) | CSTAR ip 2 | `string` | n/a | yes |
| <a name="input_ddos_protection_plan"></a> [ddos\_protection\_plan](#input\_ddos\_protection\_plan) | Network | <pre>object({<br>    id     = string<br>    enable = bool<br>  })</pre> | `null` | no |
| <a name="input_dns_a_reconds_dbnodo_ips"></a> [dns\_a\_reconds\_dbnodo\_ips](#input\_dns\_a\_reconds\_dbnodo\_ips) | IPs address of DB Nodo | `list(string)` | `[]` | no |
| <a name="input_dns_a_reconds_dbnodo_prf_ips"></a> [dns\_a\_reconds\_dbnodo\_prf\_ips](#input\_dns\_a\_reconds\_dbnodo\_prf\_ips) | IPs address of DB Nodo | `list(string)` | `[]` | no |
| <a name="input_dns_default_ttl_sec"></a> [dns\_default\_ttl\_sec](#input\_dns\_default\_ttl\_sec) | value | `number` | `3600` | no |
| <a name="input_dns_zone_checkout"></a> [dns\_zone\_checkout](#input\_dns\_zone\_checkout) | The checkout dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_prefix"></a> [dns\_zone\_prefix](#input\_dns\_zone\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_prefix_prf"></a> [dns\_zone\_prefix\_prf](#input\_dns\_zone\_prefix\_prf) | The dns subdomain. | `string` | `""` | no |
| <a name="input_dns_zone_wfesp"></a> [dns\_zone\_wfesp](#input\_dns\_zone\_wfesp) | The wfesp dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_wisp2"></a> [dns\_zone\_wisp2](#input\_dns\_zone\_wisp2) | The wisp2 dns subdomain. | `string` | `null` | no |
| <a name="input_ecommerce_ingress_hostname"></a> [ecommerce\_ingress\_hostname](#input\_ecommerce\_ingress\_hostname) | ecommerce ingress hostname | `string` | `null` | no |
| <a name="input_ecommerce_vpos_psps_list"></a> [ecommerce\_vpos\_psps\_list](#input\_ecommerce\_vpos\_psps\_list) | psps list using vpos as comma separated value | `string` | `""` | no |
| <a name="input_ecommerce_xpay_psps_list"></a> [ecommerce\_xpay\_psps\_list](#input\_ecommerce\_xpay\_psps\_list) | psps list using xpay as comma separated value | `string` | `""` | no |
| <a name="input_ehns_alerts_enabled"></a> [ehns\_alerts\_enabled](#input\_ehns\_alerts\_enabled) | Event hub alerts enabled? | `bool` | `true` | no |
| <a name="input_ehns_auto_inflate_enabled"></a> [ehns\_auto\_inflate\_enabled](#input\_ehns\_auto\_inflate\_enabled) | Is Auto Inflate enabled for the EventHub Namespace? | `bool` | `false` | no |
| <a name="input_ehns_capacity"></a> [ehns\_capacity](#input\_ehns\_capacity) | Specifies the Capacity / Throughput Units for a Standard SKU namespace. | `number` | `null` | no |
| <a name="input_ehns_maximum_throughput_units"></a> [ehns\_maximum\_throughput\_units](#input\_ehns\_maximum\_throughput\_units) | Specifies the maximum number of throughput units when Auto Inflate is Enabled | `number` | `null` | no |
| <a name="input_ehns_metric_alerts"></a> [ehns\_metric\_alerts](#input\_ehns\_metric\_alerts) | Map of name = criteria objects | <pre>map(object({<br>    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]<br>    aggregation = string<br>    metric_name = string<br>    description = string<br>    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]<br>    operator  = string<br>    threshold = number<br>    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H<br>    frequency = string<br>    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.<br>    window_size = string<br><br>    dimension = list(object(<br>      {<br>        name     = string<br>        operator = string<br>        values   = list(string)<br>      }<br>    ))<br>  }))</pre> | `{}` | no |
| <a name="input_ehns_sku_name"></a> [ehns\_sku\_name](#input\_ehns\_sku\_name) | Defines which tier to use. | `string` | `"Basic"` | no |
| <a name="input_ehns_zone_redundant"></a> [ehns\_zone\_redundant](#input\_ehns\_zone\_redundant) | Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones). | `bool` | `false` | no |
| <a name="input_enable_azdoa"></a> [enable\_azdoa](#input\_enable\_azdoa) | Enable Azure DevOps agent. | `bool` | n/a | yes |
| <a name="input_enable_iac_pipeline"></a> [enable\_iac\_pipeline](#input\_enable\_iac\_pipeline) | If true create the key vault policy to allow used by azure devops iac pipelines. | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | Contains env description in extend format (dev,uat,prod) | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_eventhub_enabled"></a> [eventhub\_enabled](#input\_eventhub\_enabled) | eventhub enable? | `bool` | `false` | no |
| <a name="input_eventhubs"></a> [eventhubs](#input\_eventhubs) | A list of event hubs to add to namespace. | <pre>list(object({<br>    name              = string<br>    partitions        = number<br>    message_retention = number<br>    consumers         = list(string)<br>    keys = list(object({<br>      name   = string<br>      listen = bool<br>      send   = bool<br>      manage = bool<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_eventhubs_02"></a> [eventhubs\_02](#input\_eventhubs\_02) | A list of event hubs to add to namespace. | <pre>list(object({<br>    name              = string<br>    partitions        = number<br>    message_retention = number<br>    consumers         = list(string)<br>    keys = list(object({<br>      name   = string<br>      listen = bool<br>      send   = bool<br>      manage = bool<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_fdr_advanced_threat_protection"></a> [fdr\_advanced\_threat\_protection](#input\_fdr\_advanced\_threat\_protection) | Enable contract threat advanced protection | `bool` | `false` | no |
| <a name="input_fdr_delete_retention_days"></a> [fdr\_delete\_retention\_days](#input\_fdr\_delete\_retention\_days) | Number of days to retain deleted. | `number` | `30` | no |
| <a name="input_fdr_enable_versioning"></a> [fdr\_enable\_versioning](#input\_fdr\_enable\_versioning) | Enable sa versioning | `bool` | `false` | no |
| <a name="input_fesp_hostname"></a> [fesp\_hostname](#input\_fesp\_hostname) | Fesp hostname | `string` | `""` | no |
| <a name="input_github_runner"></a> [github\_runner](#input\_github\_runner) | GitHub runner variables | <pre>object({<br>    subnet_address_prefixes = list(string)<br>  })</pre> | <pre>{<br>  "subnet_address_prefixes": [<br>    "10.1.200.0/23"<br>  ]<br>}</pre> | no |
| <a name="input_gpd_always_on"></a> [gpd\_always\_on](#input\_gpd\_always\_on) | Always on property | `bool` | `true` | no |
| <a name="input_gpd_autoscale_default"></a> [gpd\_autoscale\_default](#input\_gpd\_autoscale\_default) | The number of instances that are available for scaling if metrics are not available for evaluation. | `number` | `1` | no |
| <a name="input_gpd_autoscale_maximum"></a> [gpd\_autoscale\_maximum](#input\_gpd\_autoscale\_maximum) | The maximum number of instances for this resource. | `number` | `3` | no |
| <a name="input_gpd_autoscale_minimum"></a> [gpd\_autoscale\_minimum](#input\_gpd\_autoscale\_minimum) | The minimum number of instances for this resource. | `number` | `1` | no |
| <a name="input_gpd_cron_job_enable"></a> [gpd\_cron\_job\_enable](#input\_gpd\_cron\_job\_enable) | GPD cron job enable | `bool` | `false` | no |
| <a name="input_gpd_cron_schedule_expired_to"></a> [gpd\_cron\_schedule\_expired\_to](#input\_gpd\_cron\_schedule\_expired\_to) | GDP cron scheduling (NCRON example '*/55 * * * * *') | `string` | `null` | no |
| <a name="input_gpd_cron_schedule_valid_to"></a> [gpd\_cron\_schedule\_valid\_to](#input\_gpd\_cron\_schedule\_valid\_to) | GPD cron scheduling (NCRON example '*/35 * * * * *') | `string` | `null` | no |
| <a name="input_gpd_db_name"></a> [gpd\_db\_name](#input\_gpd\_db\_name) | Name of the DB to connect to | `string` | `"apd"` | no |
| <a name="input_gpd_dbms_port"></a> [gpd\_dbms\_port](#input\_gpd\_dbms\_port) | Port number of the DBMS | `number` | `5432` | no |
| <a name="input_gpd_max_retry_queuing"></a> [gpd\_max\_retry\_queuing](#input\_gpd\_max\_retry\_queuing) | Max retry queuing when the node calling fails. | `number` | `5` | no |
| <a name="input_gpd_paa_id_intermediario"></a> [gpd\_paa\_id\_intermediario](#input\_gpd\_paa\_id\_intermediario) | PagoPA Broker ID | `string` | `false` | no |
| <a name="input_gpd_paa_stazione_int"></a> [gpd\_paa\_stazione\_int](#input\_gpd\_paa\_stazione\_int) | PagoPA Station ID | `string` | `false` | no |
| <a name="input_gpd_payments_advanced_threat_protection"></a> [gpd\_payments\_advanced\_threat\_protection](#input\_gpd\_payments\_advanced\_threat\_protection) | Enable contract threat advanced protection | `bool` | `false` | no |
| <a name="input_gpd_payments_autoscale_default"></a> [gpd\_payments\_autoscale\_default](#input\_gpd\_payments\_autoscale\_default) | The number of instances that are available for scaling if metrics are not available for evaluation. | `number` | `5` | no |
| <a name="input_gpd_payments_autoscale_maximum"></a> [gpd\_payments\_autoscale\_maximum](#input\_gpd\_payments\_autoscale\_maximum) | The maximum number of instances for this resource. | `number` | `10` | no |
| <a name="input_gpd_payments_autoscale_minimum"></a> [gpd\_payments\_autoscale\_minimum](#input\_gpd\_payments\_autoscale\_minimum) | The minimum number of instances for this resource. | `number` | `3` | no |
| <a name="input_gpd_payments_delete_retention_days"></a> [gpd\_payments\_delete\_retention\_days](#input\_gpd\_payments\_delete\_retention\_days) | Number of days to retain deleted. | `number` | `30` | no |
| <a name="input_gpd_payments_versioning"></a> [gpd\_payments\_versioning](#input\_gpd\_payments\_versioning) | Enable sa versioning | `bool` | `false` | no |
| <a name="input_gpd_plan_kind"></a> [gpd\_plan\_kind](#input\_gpd\_plan\_kind) | App service plan kind | `string` | `null` | no |
| <a name="input_gpd_plan_sku_size"></a> [gpd\_plan\_sku\_size](#input\_gpd\_plan\_sku\_size) | App service plan sku size | `string` | `null` | no |
| <a name="input_gpd_plan_sku_tier"></a> [gpd\_plan\_sku\_tier](#input\_gpd\_plan\_sku\_tier) | App service plan sku tier | `string` | `null` | no |
| <a name="input_gpd_queue_delay_sec"></a> [gpd\_queue\_delay\_sec](#input\_gpd\_queue\_delay\_sec) | The length of time during which the message will be invisible, starting when it is added to the queue. | `number` | `3600` | no |
| <a name="input_gpd_queue_retention_sec"></a> [gpd\_queue\_retention\_sec](#input\_gpd\_queue\_retention\_sec) | The maximum time to allow the message to be in the queue. | `number` | `86400` | no |
| <a name="input_gpd_schema_name"></a> [gpd\_schema\_name](#input\_gpd\_schema\_name) | Name of the schema of the DB | `string` | `"apd"` | no |
| <a name="input_ingress_elk_load_balancer_ip"></a> [ingress\_elk\_load\_balancer\_ip](#input\_ingress\_elk\_load\_balancer\_ip) | n/a | `string` | `""` | no |
| <a name="input_io_bpd_hostname"></a> [io\_bpd\_hostname](#input\_io\_bpd\_hostname) | IO BPD hostname | `string` | `""` | no |
| <a name="input_ip_nodo"></a> [ip\_nodo](#input\_ip\_nodo) | Nodo pagamenti ip | `string` | n/a | yes |
| <a name="input_law_daily_quota_gb"></a> [law\_daily\_quota\_gb](#input\_law\_daily\_quota\_gb) | The workspace daily quota for ingestion in GB. | `number` | `-1` | no |
| <a name="input_law_retention_in_days"></a> [law\_retention\_in\_days](#input\_law\_retention\_in\_days) | The workspace data retention in days | `number` | `30` | no |
| <a name="input_law_sku"></a> [law\_sku](#input\_law\_sku) | Sku of the Log Analytics Workspace | `string` | `"PerGB2018"` | no |
| <a name="input_lb_aks"></a> [lb\_aks](#input\_lb\_aks) | IP load balancer AKS Nexi/SIA | `string` | `"0.0.0.0"` | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | `"westeurope"` | no |
| <a name="input_lock_enable"></a> [lock\_enable](#input\_lock\_enable) | Apply locks to block accidentally deletions. | `bool` | `false` | no |
| <a name="input_logic_app_biz_evt_plan_kind"></a> [logic\_app\_biz\_evt\_plan\_kind](#input\_logic\_app\_biz\_evt\_plan\_kind) | App service plan kind | `string` | `"Linux"` | no |
| <a name="input_logic_app_biz_evt_plan_sku_size"></a> [logic\_app\_biz\_evt\_plan\_sku\_size](#input\_logic\_app\_biz\_evt\_plan\_sku\_size) | App service plan sku size | `string` | `"WS1"` | no |
| <a name="input_logic_app_biz_evt_plan_sku_tier"></a> [logic\_app\_biz\_evt\_plan\_sku\_tier](#input\_logic\_app\_biz\_evt\_plan\_sku\_tier) | App service plan sku tier | `string` | `"WorkflowStandard"` | no |
| <a name="input_mock_ec_always_on"></a> [mock\_ec\_always\_on](#input\_mock\_ec\_always\_on) | Mock EC always on property | `bool` | `false` | no |
| <a name="input_mock_ec_enabled"></a> [mock\_ec\_enabled](#input\_mock\_ec\_enabled) | Mock EC enabled | `bool` | `false` | no |
| <a name="input_mock_ec_secondary_enabled"></a> [mock\_ec\_secondary\_enabled](#input\_mock\_ec\_secondary\_enabled) | Mock Secondary EC enabled | `bool` | `false` | no |
| <a name="input_mock_ec_size"></a> [mock\_ec\_size](#input\_mock\_ec\_size) | Mock EC Plan size | `string` | `"S1"` | no |
| <a name="input_mock_ec_tier"></a> [mock\_ec\_tier](#input\_mock\_ec\_tier) | Mock EC Plan tier | `string` | `"Standard"` | no |
| <a name="input_mock_payment_gateway_always_on"></a> [mock\_payment\_gateway\_always\_on](#input\_mock\_payment\_gateway\_always\_on) | Mock payment gateway always on property | `bool` | `false` | no |
| <a name="input_mock_payment_gateway_enabled"></a> [mock\_payment\_gateway\_enabled](#input\_mock\_payment\_gateway\_enabled) | Mock payment gateway enabled | `bool` | `false` | no |
| <a name="input_mock_payment_gateway_size"></a> [mock\_payment\_gateway\_size](#input\_mock\_payment\_gateway\_size) | Mock payment gateway Plan size | `string` | `"S1"` | no |
| <a name="input_mock_payment_gateway_tier"></a> [mock\_payment\_gateway\_tier](#input\_mock\_payment\_gateway\_tier) | Mock payment gateway Plan tier | `string` | `"Standard"` | no |
| <a name="input_mock_psp_secondary_service_enabled"></a> [mock\_psp\_secondary\_service\_enabled](#input\_mock\_psp\_secondary\_service\_enabled) | Mock Secondary PSP service Nexi | `bool` | `false` | no |
| <a name="input_mock_psp_service_enabled"></a> [mock\_psp\_service\_enabled](#input\_mock\_psp\_service\_enabled) | Mock PSP service Nexi | `bool` | `false` | no |
| <a name="input_nat_gateway_enabled"></a> [nat\_gateway\_enabled](#input\_nat\_gateway\_enabled) | Nat Gateway enabled | `bool` | `false` | no |
| <a name="input_nat_gateway_public_ips"></a> [nat\_gateway\_public\_ips](#input\_nat\_gateway\_public\_ips) | Number of public outbound ips | `number` | `1` | no |
| <a name="input_node_decoupler_primitives"></a> [node\_decoupler\_primitives](#input\_node\_decoupler\_primitives) | Node decoupler primitives | `string` | `"nodoChiediNumeroAvviso,nodoChiediCatalogoServizi,nodoAttivaRPT,nodoVerificaRPT,nodoChiediInformativaPA,nodoChiediInformativaPSP,nodoChiediTemplateInformativaPSP,nodoPAChiediInformativaPA,nodoChiediSceltaWISP,demandPaymentNotice"` | no |
| <a name="input_node_forwarder_always_on"></a> [node\_forwarder\_always\_on](#input\_node\_forwarder\_always\_on) | Node Forwarder always on property | `bool` | `true` | no |
| <a name="input_node_forwarder_autoscale_enabled"></a> [node\_forwarder\_autoscale\_enabled](#input\_node\_forwarder\_autoscale\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_node_forwarder_logging_level"></a> [node\_forwarder\_logging\_level](#input\_node\_forwarder\_logging\_level) | Logging level of Node Forwarder | `string` | `"INFO"` | no |
| <a name="input_node_forwarder_size"></a> [node\_forwarder\_size](#input\_node\_forwarder\_size) | Node Forwarder plan size | `string` | `"B1"` | no |
| <a name="input_node_forwarder_tier"></a> [node\_forwarder\_tier](#input\_node\_forwarder\_tier) | Node Forwarder plan tier | `string` | `"Basic"` | no |
| <a name="input_nodo_auth_subscription_limit"></a> [nodo\_auth\_subscription\_limit](#input\_nodo\_auth\_subscription\_limit) | subscriptions limit | `number` | `1000` | no |
| <a name="input_nodo_ip_filter"></a> [nodo\_ip\_filter](#input\_nodo\_ip\_filter) | IP Node | `string` | `""` | no |
| <a name="input_nodo_pagamenti_auth_password"></a> [nodo\_pagamenti\_auth\_password](#input\_nodo\_pagamenti\_auth\_password) | Default password used for nodo-auth | `string` | `"PLACEHOLDER"` | no |
| <a name="input_nodo_pagamenti_ec"></a> [nodo\_pagamenti\_ec](#input\_nodo\_pagamenti\_ec) | EC' black list nodo pagamenti (separate comma list). | `string` | `","` | no |
| <a name="input_nodo_pagamenti_enabled"></a> [nodo\_pagamenti\_enabled](#input\_nodo\_pagamenti\_enabled) | nodo pagamenti enabled | `bool` | `false` | no |
| <a name="input_nodo_pagamenti_psp"></a> [nodo\_pagamenti\_psp](#input\_nodo\_pagamenti\_psp) | PSP' white list nodo pagamenti (separate comma list) . | `string` | `","` | no |
| <a name="input_nodo_pagamenti_subkey_required"></a> [nodo\_pagamenti\_subkey\_required](#input\_nodo\_pagamenti\_subkey\_required) | Enabled subkeys for nodo dei pagamenti api | `bool` | `false` | no |
| <a name="input_nodo_pagamenti_test_enabled"></a> [nodo\_pagamenti\_test\_enabled](#input\_nodo\_pagamenti\_test\_enabled) | test del nodo dei pagamenti enabled | `bool` | `false` | no |
| <a name="input_nodo_pagamenti_url"></a> [nodo\_pagamenti\_url](#input\_nodo\_pagamenti\_url) | Nodo pagamenti url | `string` | `"https://"` | no |
| <a name="input_nodo_pagamenti_x_forwarded_for"></a> [nodo\_pagamenti\_x\_forwarded\_for](#input\_nodo\_pagamenti\_x\_forwarded\_for) | X-Forwarded-For IP address used for nodo-auth | `string` | n/a | yes |
| <a name="input_pagopa_proxy_autoscale_default"></a> [pagopa\_proxy\_autoscale\_default](#input\_pagopa\_proxy\_autoscale\_default) | The number of instances that are available for scaling if metrics are not available for evaluation. | `number` | `5` | no |
| <a name="input_pagopa_proxy_autoscale_maximum"></a> [pagopa\_proxy\_autoscale\_maximum](#input\_pagopa\_proxy\_autoscale\_maximum) | The maximum number of instances for this resource. | `number` | `10` | no |
| <a name="input_pagopa_proxy_autoscale_minimum"></a> [pagopa\_proxy\_autoscale\_minimum](#input\_pagopa\_proxy\_autoscale\_minimum) | The minimum number of instances for this resource. | `number` | `1` | no |
| <a name="input_pagopa_proxy_redis_capacity"></a> [pagopa\_proxy\_redis\_capacity](#input\_pagopa\_proxy\_redis\_capacity) | n/a | `number` | `1` | no |
| <a name="input_pagopa_proxy_redis_family"></a> [pagopa\_proxy\_redis\_family](#input\_pagopa\_proxy\_redis\_family) | n/a | `string` | `"C"` | no |
| <a name="input_pagopa_proxy_redis_sku_name"></a> [pagopa\_proxy\_redis\_sku\_name](#input\_pagopa\_proxy\_redis\_sku\_name) | n/a | `string` | `null` | no |
| <a name="input_pagopa_proxy_size"></a> [pagopa\_proxy\_size](#input\_pagopa\_proxy\_size) | pagopa-proxy Plan size | `string` | `null` | no |
| <a name="input_pagopa_proxy_tier"></a> [pagopa\_proxy\_tier](#input\_pagopa\_proxy\_tier) | pagopa-proxy Plan tier | `string` | `null` | no |
| <a name="input_payments_always_on"></a> [payments\_always\_on](#input\_payments\_always\_on) | Always on property | `bool` | `true` | no |
| <a name="input_payments_logging_level"></a> [payments\_logging\_level](#input\_payments\_logging\_level) | Log level of Payments | `string` | `"INFO"` | no |
| <a name="input_paytipper_hostname"></a> [paytipper\_hostname](#input\_paytipper\_hostname) | Paytipper hostname | `string` | `""` | no |
| <a name="input_pgres_flex_params"></a> [pgres\_flex\_params](#input\_pgres\_flex\_params) | Postgres Flexible | <pre>object({<br>    private_endpoint_enabled     = bool<br>    sku_name                     = string<br>    db_version                   = string<br>    storage_mb                   = string<br>    zone                         = number<br>    backup_retention_days        = number<br>    geo_redundant_backup_enabled = bool<br>    high_availability_enabled    = bool<br>    standby_availability_zone    = number<br>    pgbouncer_enabled            = bool<br>  })</pre> | `null` | no |
| <a name="input_platform_private_dns_zone_records"></a> [platform\_private\_dns\_zone\_records](#input\_platform\_private\_dns\_zone\_records) | List of records to add into the platform.pagopa.it dns private | `list(string)` | `null` | no |
| <a name="input_postgres_private_endpoint_enabled"></a> [postgres\_private\_endpoint\_enabled](#input\_postgres\_private\_endpoint\_enabled) | Private endpoint database enable? | `bool` | `false` | no |
| <a name="input_postgresql_alerts_enabled"></a> [postgresql\_alerts\_enabled](#input\_postgresql\_alerts\_enabled) | Database alerts enabled? | `bool` | `false` | no |
| <a name="input_postgresql_configuration"></a> [postgresql\_configuration](#input\_postgresql\_configuration) | PostgreSQL Server configuration | `map(string)` | `{}` | no |
| <a name="input_postgresql_connection_limit"></a> [postgresql\_connection\_limit](#input\_postgresql\_connection\_limit) | n/a | `number` | `-1` | no |
| <a name="input_postgresql_enable_replica"></a> [postgresql\_enable\_replica](#input\_postgresql\_enable\_replica) | Create a PostgreSQL Server Replica. | `bool` | `false` | no |
| <a name="input_postgresql_geo_redundant_backup_enabled"></a> [postgresql\_geo\_redundant\_backup\_enabled](#input\_postgresql\_geo\_redundant\_backup\_enabled) | Turn Geo-redundant server backups on/off. | `bool` | `false` | no |
| <a name="input_postgresql_name"></a> [postgresql\_name](#input\_postgresql\_name) | n/a | `string` | `null` | no |
| <a name="input_postgresql_network_rules"></a> [postgresql\_network\_rules](#input\_postgresql\_network\_rules) | Network rules restricting access to the postgresql server. | <pre>object({<br>    ip_rules                       = list(string)<br>    allow_access_to_azure_services = bool<br>  })</pre> | <pre>{<br>  "allow_access_to_azure_services": false,<br>  "ip_rules": []<br>}</pre> | no |
| <a name="input_postgresql_public_network_access_enabled"></a> [postgresql\_public\_network\_access\_enabled](#input\_postgresql\_public\_network\_access\_enabled) | database public | `bool` | `false` | no |
| <a name="input_postgresql_sku_name"></a> [postgresql\_sku\_name](#input\_postgresql\_sku\_name) | Specifies the SKU Name for this PostgreSQL Server. | `string` | n/a | yes |
| <a name="input_postgresql_storage_mb"></a> [postgresql\_storage\_mb](#input\_postgresql\_storage\_mb) | Max storage allowed for a server | `number` | `5120` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"pagopa"` | no |
| <a name="input_private_dns_zone_db_nodo_pagamenti"></a> [private\_dns\_zone\_db\_nodo\_pagamenti](#input\_private\_dns\_zone\_db\_nodo\_pagamenti) | n/a | `string` | `"dev.db-nodo-pagamenti.com"` | no |
| <a name="input_prostgresql_db_mockpsp"></a> [prostgresql\_db\_mockpsp](#input\_prostgresql\_db\_mockpsp) | n/a | `string` | `null` | no |
| <a name="input_psql_password"></a> [psql\_password](#input\_psql\_password) | n/a | `string` | `null` | no |
| <a name="input_psql_username"></a> [psql\_username](#input\_psql\_username) | n/a | `string` | `null` | no |
| <a name="input_redis_cache_enabled"></a> [redis\_cache\_enabled](#input\_redis\_cache\_enabled) | redis cache enabled | `bool` | `false` | no |
| <a name="input_redis_cache_params"></a> [redis\_cache\_params](#input\_redis\_cache\_params) | # Redis cache | <pre>object({<br>    public_access = bool<br>    capacity      = number<br>    sku_name      = string<br>    family        = string<br>  })</pre> | <pre>{<br>  "capacity": 1,<br>  "family": "C",<br>  "public_access": false,<br>  "sku_name": "Basic"<br>}</pre> | no |
| <a name="input_redis_private_endpoint_enabled"></a> [redis\_private\_endpoint\_enabled](#input\_redis\_private\_endpoint\_enabled) | Enable private endpoints for redis instances? | `bool` | `true` | no |
| <a name="input_reporting_fdr_blobs_retention_days"></a> [reporting\_fdr\_blobs\_retention\_days](#input\_reporting\_fdr\_blobs\_retention\_days) | The number of day for storage\_management\_policy | `number` | `30` | no |
| <a name="input_reporting_fdr_function_always_on"></a> [reporting\_fdr\_function\_always\_on](#input\_reporting\_fdr\_function\_always\_on) | Always on property | `bool` | `false` | no |
| <a name="input_reporting_fdr_function_autoscale_default"></a> [reporting\_fdr\_function\_autoscale\_default](#input\_reporting\_fdr\_function\_autoscale\_default) | The number of instances that are available for scaling if metrics are not available for evaluation. | `number` | `1` | no |
| <a name="input_reporting_fdr_function_autoscale_maximum"></a> [reporting\_fdr\_function\_autoscale\_maximum](#input\_reporting\_fdr\_function\_autoscale\_maximum) | The maximum number of instances for this resource. | `number` | `3` | no |
| <a name="input_reporting_fdr_function_autoscale_minimum"></a> [reporting\_fdr\_function\_autoscale\_minimum](#input\_reporting\_fdr\_function\_autoscale\_minimum) | The minimum number of instances for this resource. | `number` | `1` | no |
| <a name="input_reporting_fdr_function_kind"></a> [reporting\_fdr\_function\_kind](#input\_reporting\_fdr\_function\_kind) | App service plan kind | `string` | `null` | no |
| <a name="input_reporting_fdr_function_sku_size"></a> [reporting\_fdr\_function\_sku\_size](#input\_reporting\_fdr\_function\_sku\_size) | App service plan sku size | `string` | `null` | no |
| <a name="input_reporting_fdr_function_sku_tier"></a> [reporting\_fdr\_function\_sku\_tier](#input\_reporting\_fdr\_function\_sku\_tier) | App service plan sku tier | `string` | `null` | no |
| <a name="input_satispay_hostname"></a> [satispay\_hostname](#input\_satispay\_hostname) | Satispay hostname | `string` | `""` | no |
| <a name="input_storage_account_info"></a> [storage\_account\_info](#input\_storage\_account\_info) | n/a | <pre>object({<br>    account_tier                      = string<br>    account_replication_type          = string<br>    access_tier                       = string<br>    advanced_threat_protection_enable = bool<br>  })</pre> | <pre>{<br>  "access_tier": "Hot",<br>  "account_replication_type": "LRS",<br>  "account_tier": "Standard",<br>  "advanced_threat_protection_enable": true<br>}</pre> | no |
| <a name="input_storage_queue_private_endpoint_enabled"></a> [storage\_queue\_private\_endpoint\_enabled](#input\_storage\_queue\_private\_endpoint\_enabled) | Whether private endpoint for Azure Storage Queues is enabled | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |
| <a name="input_users"></a> [users](#input\_users) | List of psql users with grants. | <pre>list(object({<br>    name = string<br>    grants = list(object({<br>      object_type = string<br>      database    = string<br>      schema      = string<br>      privileges  = list(string)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_vpn_pip_sku"></a> [vpn\_pip\_sku](#input\_vpn\_pip\_sku) | VPN GW PIP SKU | `string` | `"Basic"` | no |
| <a name="input_vpn_sku"></a> [vpn\_sku](#input\_vpn\_sku) | VPN Gateway SKU | `string` | `"VpnGw1"` | no |
| <a name="input_xpay_hostname"></a> [xpay\_hostname](#input\_xpay\_hostname) | Nexi xpay hostname | `string` | `""` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
