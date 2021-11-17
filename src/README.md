<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 2.76.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.3.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.76.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acr"></a> [acr](#module\_acr) | git::https://github.com/pagopa/azurerm.git//container_registry | v1.0.7 |
| <a name="module_api_config_app_service"></a> [api\_config\_app\_service](#module\_api\_config\_app\_service) | git::https://github.com/pagopa/azurerm.git//app_service | v1.0.14 |
| <a name="module_api_config_fe_cdn"></a> [api\_config\_fe\_cdn](#module\_api\_config\_fe\_cdn) | git::https://github.com/pagopa/azurerm.git//cdn | v1.0.85 |
| <a name="module_api_config_snet"></a> [api\_config\_snet](#module\_api\_config\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.51 |
| <a name="module_apim"></a> [apim](#module\_apim) | git::https://github.com/pagopa/azurerm.git//api_management | v1.0.50 |
| <a name="module_apim_api_config_api"></a> [apim\_api\_config\_api](#module\_apim\_api\_config\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_api_config_product"></a> [apim\_api\_config\_product](#module\_apim\_api\_config\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.84 |
| <a name="module_apim_checkout_payments_api_v1"></a> [apim\_checkout\_payments\_api\_v1](#module\_apim\_checkout\_payments\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_checkout_product"></a> [apim\_checkout\_product](#module\_apim\_checkout\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_checkout_transactions_api_v1"></a> [apim\_checkout\_transactions\_api\_v1](#module\_apim\_checkout\_transactions\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_mock_ec_api"></a> [apim\_mock\_ec\_api](#module\_apim\_mock\_ec\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_mock_ec_product"></a> [apim\_mock\_ec\_product](#module\_apim\_mock\_ec\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_mock_psp_api"></a> [apim\_mock\_psp\_api](#module\_apim\_mock\_psp\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_mock_psp_mng_api"></a> [apim\_mock\_psp\_mng\_api](#module\_apim\_mock\_psp\_mng\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_mock_psp_product"></a> [apim\_mock\_psp\_product](#module\_apim\_mock\_psp\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_nodo_pagamenti_product"></a> [apim\_nodo\_pagamenti\_product](#module\_apim\_nodo\_pagamenti\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_snet"></a> [apim\_snet](#module\_apim\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.51 |
| <a name="module_app_gw"></a> [app\_gw](#module\_app\_gw) | git::https://github.com/pagopa/azurerm.git//app_gateway | v1.0.80 |
| <a name="module_appgateway_snet"></a> [appgateway\_snet](#module\_appgateway\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.51 |
| <a name="module_azdoa_li"></a> [azdoa\_li](#module\_azdoa\_li) | git::https://github.com/pagopa/azurerm.git//azure_devops_agent | v1.0.57 |
| <a name="module_azdoa_snet"></a> [azdoa\_snet](#module\_azdoa\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.3 |
| <a name="module_checkout_cdn"></a> [checkout\_cdn](#module\_checkout\_cdn) | git::https://github.com/pagopa/azurerm.git//cdn | v1.0.73 |
| <a name="module_checkout_function"></a> [checkout\_function](#module\_checkout\_function) | git::https://github.com/pagopa/azurerm.git//function_app | v1.0.84 |
| <a name="module_checkout_function_snet"></a> [checkout\_function\_snet](#module\_checkout\_function\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.51 |
| <a name="module_event_hub01"></a> [event\_hub01](#module\_event\_hub01) | git::https://github.com/pagopa/azurerm.git//eventhub | v1.0.51 |
| <a name="module_eventhub_snet"></a> [eventhub\_snet](#module\_eventhub\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.7 |
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | git::https://github.com/pagopa/azurerm.git//key_vault | v1.0.69 |
| <a name="module_mock_ec"></a> [mock\_ec](#module\_mock\_ec) | git::https://github.com/pagopa/azurerm.git//app_service | v1.0.14 |
| <a name="module_mock_ec_snet"></a> [mock\_ec\_snet](#module\_mock\_ec\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.51 |
| <a name="module_mock_psp"></a> [mock\_psp](#module\_mock\_psp) | git::https://github.com/pagopa/azurerm.git//app_service | v1.0.14 |
| <a name="module_mock_psp_snet"></a> [mock\_psp\_snet](#module\_mock\_psp\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.51 |
| <a name="module_monitor"></a> [monitor](#module\_monitor) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_nat_gw"></a> [nat\_gw](#module\_nat\_gw) | git::https://github.com/pagopa/azurerm.git//nat_gateway | v1.0.77 |
| <a name="module_postgresql"></a> [postgresql](#module\_postgresql) | git::https://github.com/pagopa/azurerm.git//postgresql_server | v1.0.51 |
| <a name="module_postgresql_snet"></a> [postgresql\_snet](#module\_postgresql\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.7 |
| <a name="module_redis"></a> [redis](#module\_redis) | git::https://github.com/pagopa/azurerm.git//redis_cache | v1.0.37 |
| <a name="module_redis_snet"></a> [redis\_snet](#module\_redis\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.51 |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | git::https://github.com/pagopa/azurerm.git//virtual_network | v1.0.51 |
| <a name="module_vnet_integration"></a> [vnet\_integration](#module\_vnet\_integration) | git::https://github.com/pagopa/azurerm.git//virtual_network | v1.0.51 |
| <a name="module_vnet_peering"></a> [vnet\_peering](#module\_vnet\_peering) | git::https://github.com/pagopa/azurerm.git//virtual_network_peering | v1.0.30 |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_api.apim_nodo_pagamenti_api_ec_svr](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_nodo_pagamenti_api_psp_cli](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_nodo_pagamenti_api_psp_svr](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api_operation_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_policy.apim_nodo_pagamenti_api_psp_cli_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_version_set.api_config_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.checkout_payments_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.checkout_transactions_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_custom_domain.api_custom_domain](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_custom_domain) | resource |
| [azurerm_api_management_group.readonly](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_group) | resource |
| [azurerm_api_management_named_value.brokerlist_value](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.ecblacklist_value](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pagopa_fn_checkout_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pagopa_fn_checkout_url_value](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.urlnodo_value](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_product_api.apim_nodo_pagamenti_products_ec_s](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_product_api) | resource |
| [azurerm_api_management_product_api.apim_nodo_pagamenti_products_psp_c](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_product_api) | resource |
| [azurerm_api_management_product_api.apim_nodo_pagamenti_products_psp_s](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_product_api) | resource |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/application_insights) | resource |
| [azurerm_dns_a_record.dns_a_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.dns_a_management](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.dns_a_portal](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/dns_a_record) | resource |
| [azurerm_dns_ns_record.dev_checkout](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ns_record.dev_pagopa_it_ns](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ns_record.uat_checkout](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ns_record.uat_pagopa_it_ns](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_zone.checkout_public](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/dns_zone) | resource |
| [azurerm_dns_zone.public](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/dns_zone) | resource |
| [azurerm_key_vault_access_policy.ad_group_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_developers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_externals_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_security_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.api_management_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.app_gateway_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azure_cdn_frontdoor_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_log_analytics_workspace.log_analytics_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/log_analytics_workspace) | resource |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_autoscale_setting.checkout_function](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_private_dns_a_record.private_dns_a_record_db_nodo](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_zone.db_nodo_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.db_nodo_dns_zone_virtual_link](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_public_ip.appgateway_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/public_ip) | resource |
| [azurerm_resource_group.api_config_fe_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.api_config_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.azdo_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.checkout_be_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.checkout_fe_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.data](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.default_roleassignment_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.mock_ec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.mock_psp_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.msg_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_aks](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/resource_group) | resource |
| [azurerm_user_assigned_identity.appgateway](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/user_assigned_identity) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/2.3.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/2.3.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/2.3.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/2.3.0/docs/data-sources/group) | data source |
| [azuread_service_principal.iac_principal](https://registry.terraform.io/providers/hashicorp/azuread/2.3.0/docs/data-sources/service_principal) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/client_config) | data source |
| [azurerm_key_vault_certificate.app_gw_platform](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.management_platform](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.portal_platform](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_secret.apim_publisher_email](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.db_administrator_login](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.db_administrator_login_password](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.db_mock_psp_user_login](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.db_mock_psp_user_login_password](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.db_nodo_pwd](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.db_nodo_usr](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.fn_checkout_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.google_recaptcha_secret](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_notification_email](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_notification_slack_email](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.sec_storage_id](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.sec_workspace_id](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr_enabled"></a> [acr\_enabled](#input\_acr\_enabled) | Container registry enabled | `bool` | `false` | no |
| <a name="input_allow_blob_public_access"></a> [allow\_blob\_public\_access](#input\_allow\_blob\_public\_access) | Allow or disallow public access to all blobs or containers in the storage account. | `bool` | `false` | no |
| <a name="input_api_config_always_on"></a> [api\_config\_always\_on](#input\_api\_config\_always\_on) | Api Config always on property | `bool` | `false` | no |
| <a name="input_api_config_enabled"></a> [api\_config\_enabled](#input\_api\_config\_enabled) | Api Config enabled | `bool` | `false` | no |
| <a name="input_api_config_fe_enabled"></a> [api\_config\_fe\_enabled](#input\_api\_config\_fe\_enabled) | Api Config FE enabled | `bool` | `false` | no |
| <a name="input_api_config_size"></a> [api\_config\_size](#input\_api\_config\_size) | Api Config Plan size | `string` | `"S1"` | no |
| <a name="input_api_config_tier"></a> [api\_config\_tier](#input\_api\_config\_tier) | Api config Plan tier | `string` | `"Standard"` | no |
| <a name="input_apim_publisher_name"></a> [apim\_publisher\_name](#input\_apim\_publisher\_name) | apim | `string` | n/a | yes |
| <a name="input_apim_sku"></a> [apim\_sku](#input\_apim\_sku) | n/a | `string` | n/a | yes |
| <a name="input_app_gateway_api_certificate_name"></a> [app\_gateway\_api\_certificate\_name](#input\_app\_gateway\_api\_certificate\_name) | Application gateway api certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_management_certificate_name"></a> [app\_gateway\_management\_certificate\_name](#input\_app\_gateway\_management\_certificate\_name) | Application gateway api management certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_max_capacity"></a> [app\_gateway\_max\_capacity](#input\_app\_gateway\_max\_capacity) | n/a | `number` | `2` | no |
| <a name="input_app_gateway_min_capacity"></a> [app\_gateway\_min\_capacity](#input\_app\_gateway\_min\_capacity) | n/a | `number` | `0` | no |
| <a name="input_app_gateway_portal_certificate_name"></a> [app\_gateway\_portal\_certificate\_name](#input\_app\_gateway\_portal\_certificate\_name) | Application gateway developer portal certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_azdo_sp_tls_cert_enabled"></a> [azdo\_sp\_tls\_cert\_enabled](#input\_azdo\_sp\_tls\_cert\_enabled) | Enable Azure DevOps connection for TLS cert management | `string` | `false` | no |
| <a name="input_azuread_service_principal_azure_cdn_frontdoor_id"></a> [azuread\_service\_principal\_azure\_cdn\_frontdoor\_id](#input\_azuread\_service\_principal\_azure\_cdn\_frontdoor\_id) | Azure CDN Front Door Principal ID | `string` | `"f3b3f72f-4770-47a5-8c1e-aa298003be12"` | no |
| <a name="input_checkout_enabled"></a> [checkout\_enabled](#input\_checkout\_enabled) | checkout | `bool` | `false` | no |
| <a name="input_checkout_function_always_on"></a> [checkout\_function\_always\_on](#input\_checkout\_function\_always\_on) | Always on property | `bool` | `false` | no |
| <a name="input_checkout_function_autoscale_default"></a> [checkout\_function\_autoscale\_default](#input\_checkout\_function\_autoscale\_default) | The number of instances that are available for scaling if metrics are not available for evaluation. | `number` | `1` | no |
| <a name="input_checkout_function_autoscale_maximum"></a> [checkout\_function\_autoscale\_maximum](#input\_checkout\_function\_autoscale\_maximum) | The maximum number of instances for this resource. | `number` | `3` | no |
| <a name="input_checkout_function_autoscale_minimum"></a> [checkout\_function\_autoscale\_minimum](#input\_checkout\_function\_autoscale\_minimum) | The minimum number of instances for this resource. | `number` | `1` | no |
| <a name="input_checkout_function_kind"></a> [checkout\_function\_kind](#input\_checkout\_function\_kind) | App service plan kind | `string` | `null` | no |
| <a name="input_checkout_function_sku_size"></a> [checkout\_function\_sku\_size](#input\_checkout\_function\_sku\_size) | App service plan sku size | `string` | `null` | no |
| <a name="input_checkout_function_sku_tier"></a> [checkout\_function\_sku\_tier](#input\_checkout\_function\_sku\_tier) | App service plan sku tier | `string` | `null` | no |
| <a name="input_checkout_pagopaproxy_host"></a> [checkout\_pagopaproxy\_host](#input\_checkout\_pagopaproxy\_host) | pagopaproxy host | `string` | `null` | no |
| <a name="input_cidr_subnet_api_config"></a> [cidr\_subnet\_api\_config](#input\_cidr\_subnet\_api\_config) | Address prefixes subnet api config | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_apim"></a> [cidr\_subnet\_apim](#input\_cidr\_subnet\_apim) | Address prefixes subnet api management. | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_appgateway"></a> [cidr\_subnet\_appgateway](#input\_cidr\_subnet\_appgateway) | Application gateway address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_azdoa"></a> [cidr\_subnet\_azdoa](#input\_cidr\_subnet\_azdoa) | Azure DevOps agent network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_checkout_be"></a> [cidr\_subnet\_checkout\_be](#input\_cidr\_subnet\_checkout\_be) | Address prefixes subnet checkout function | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_eventhub"></a> [cidr\_subnet\_eventhub](#input\_cidr\_subnet\_eventhub) | Address prefixes subnet eventhub | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_mock_ec"></a> [cidr\_subnet\_mock\_ec](#input\_cidr\_subnet\_mock\_ec) | Address prefixes subnet mock ec | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_mock_psp"></a> [cidr\_subnet\_mock\_psp](#input\_cidr\_subnet\_mock\_psp) | Address prefixes subnet mock psp | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_postgresql"></a> [cidr\_subnet\_postgresql](#input\_cidr\_subnet\_postgresql) | Address prefixes subnet postgresql | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_redis"></a> [cidr\_subnet\_redis](#input\_cidr\_subnet\_redis) | Redis network address space. | `list(string)` | `[]` | no |
| <a name="input_cidr_vnet"></a> [cidr\_vnet](#input\_cidr\_vnet) | Virtual network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_vnet_integration"></a> [cidr\_vnet\_integration](#input\_cidr\_vnet\_integration) | Virtual network to peer with sia subscription. It should host apim | `list(string)` | n/a | yes |
| <a name="input_cname_record_name"></a> [cname\_record\_name](#input\_cname\_record\_name) | n/a | `string` | n/a | yes |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | Port number of the DB | `number` | `1521` | no |
| <a name="input_db_service_name"></a> [db\_service\_name](#input\_db\_service\_name) | Service Name of DB | `string` | `null` | no |
| <a name="input_dns_a_reconds_dbnodo_ips"></a> [dns\_a\_reconds\_dbnodo\_ips](#input\_dns\_a\_reconds\_dbnodo\_ips) | IPs address of DB Nodo | `list(string)` | `[]` | no |
| <a name="input_dns_default_ttl_sec"></a> [dns\_default\_ttl\_sec](#input\_dns\_default\_ttl\_sec) | value | `number` | `3600` | no |
| <a name="input_dns_zone_checkout"></a> [dns\_zone\_checkout](#input\_dns\_zone\_checkout) | The checkout dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_prefix"></a> [dns\_zone\_prefix](#input\_dns\_zone\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_ehns_alerts_enabled"></a> [ehns\_alerts\_enabled](#input\_ehns\_alerts\_enabled) | Event hub alerts enabled? | `bool` | `true` | no |
| <a name="input_ehns_auto_inflate_enabled"></a> [ehns\_auto\_inflate\_enabled](#input\_ehns\_auto\_inflate\_enabled) | Is Auto Inflate enabled for the EventHub Namespace? | `bool` | `false` | no |
| <a name="input_ehns_capacity"></a> [ehns\_capacity](#input\_ehns\_capacity) | Specifies the Capacity / Throughput Units for a Standard SKU namespace. | `number` | `null` | no |
| <a name="input_ehns_maximum_throughput_units"></a> [ehns\_maximum\_throughput\_units](#input\_ehns\_maximum\_throughput\_units) | Specifies the maximum number of throughput units when Auto Inflate is Enabled | `number` | `null` | no |
| <a name="input_ehns_metric_alerts"></a> [ehns\_metric\_alerts](#input\_ehns\_metric\_alerts) | Map of name = criteria objects | <pre>map(object({<br>    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]<br>    aggregation = string<br>    metric_name = string<br>    description = string<br>    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]<br>    operator  = string<br>    threshold = number<br>    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H<br>    frequency = string<br>    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.<br>    window_size = string<br><br>    dimension = list(object(<br>      {<br>        name     = string<br>        operator = string<br>        values   = list(string)<br>      }<br>    ))<br>  }))</pre> | `{}` | no |
| <a name="input_ehns_sku_name"></a> [ehns\_sku\_name](#input\_ehns\_sku\_name) | Defines which tier to use. | `string` | `"Basic"` | no |
| <a name="input_ehns_zone_redundant"></a> [ehns\_zone\_redundant](#input\_ehns\_zone\_redundant) | Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones). | `bool` | `false` | no |
| <a name="input_enable_azdoa"></a> [enable\_azdoa](#input\_enable\_azdoa) | Enable Azure DevOps agent. | `bool` | n/a | yes |
| <a name="input_enable_iac_pipeline"></a> [enable\_iac\_pipeline](#input\_enable\_iac\_pipeline) | If true create the key vault policy to allow used by azure devops iac pipelines. | `bool` | `false` | no |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_eventhub_enabled"></a> [eventhub\_enabled](#input\_eventhub\_enabled) | eventhub enable? | `bool` | `false` | no |
| <a name="input_eventhubs"></a> [eventhubs](#input\_eventhubs) | A list of event hubs to add to namespace. | <pre>list(object({<br>    name              = string<br>    partitions        = number<br>    message_retention = number<br>    consumers         = list(string)<br>    keys = list(object({<br>      name   = string<br>      listen = bool<br>      send   = bool<br>      manage = bool<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_law_daily_quota_gb"></a> [law\_daily\_quota\_gb](#input\_law\_daily\_quota\_gb) | The workspace daily quota for ingestion in GB. | `number` | `-1` | no |
| <a name="input_law_retention_in_days"></a> [law\_retention\_in\_days](#input\_law\_retention\_in\_days) | The workspace data retention in days | `number` | `30` | no |
| <a name="input_law_sku"></a> [law\_sku](#input\_law\_sku) | Sku of the Log Analytics Workspace | `string` | `"PerGB2018"` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"westeurope"` | no |
| <a name="input_lock_enable"></a> [lock\_enable](#input\_lock\_enable) | Apply locks to block accidentally deletions. | `bool` | `false` | no |
| <a name="input_mock_ec_always_on"></a> [mock\_ec\_always\_on](#input\_mock\_ec\_always\_on) | Mock EC always on property | `bool` | `false` | no |
| <a name="input_mock_ec_enabled"></a> [mock\_ec\_enabled](#input\_mock\_ec\_enabled) | Mock EC enabled | `bool` | `false` | no |
| <a name="input_mock_ec_size"></a> [mock\_ec\_size](#input\_mock\_ec\_size) | Mock EC Plan size | `string` | `"S1"` | no |
| <a name="input_mock_ec_tier"></a> [mock\_ec\_tier](#input\_mock\_ec\_tier) | Mock EC Plan tier | `string` | `"Standard"` | no |
| <a name="input_mock_psp_always_on"></a> [mock\_psp\_always\_on](#input\_mock\_psp\_always\_on) | Mock PSP always on property | `bool` | `false` | no |
| <a name="input_mock_psp_enabled"></a> [mock\_psp\_enabled](#input\_mock\_psp\_enabled) | Mock PSP enabled | `bool` | `false` | no |
| <a name="input_mock_psp_size"></a> [mock\_psp\_size](#input\_mock\_psp\_size) | Mock PSP Plan size | `string` | `"S1"` | no |
| <a name="input_mock_psp_tier"></a> [mock\_psp\_tier](#input\_mock\_psp\_tier) | Mock PSP Plan tier | `string` | `"Standard"` | no |
| <a name="input_nat_gateway_enabled"></a> [nat\_gateway\_enabled](#input\_nat\_gateway\_enabled) | Nat Gateway enabled | `bool` | `false` | no |
| <a name="input_nat_gateway_public_ips"></a> [nat\_gateway\_public\_ips](#input\_nat\_gateway\_public\_ips) | Number of public outbound ips | `number` | `1` | no |
| <a name="input_nodo_pagamenti_ec"></a> [nodo\_pagamenti\_ec](#input\_nodo\_pagamenti\_ec) | EC' black list nodo pagamenti (separate comma list). | `string` | `","` | no |
| <a name="input_nodo_pagamenti_enabled"></a> [nodo\_pagamenti\_enabled](#input\_nodo\_pagamenti\_enabled) | nodo pagamenti enabled | `bool` | `false` | no |
| <a name="input_nodo_pagamenti_psp"></a> [nodo\_pagamenti\_psp](#input\_nodo\_pagamenti\_psp) | PSP' white list nodo pagamenti (separate comma list) . | `string` | `","` | no |
| <a name="input_nodo_pagamenti_url"></a> [nodo\_pagamenti\_url](#input\_nodo\_pagamenti\_url) | Nodo pagamenti url | `string` | `"https://"` | no |
| <a name="input_postgresql_alerts_enabled"></a> [postgresql\_alerts\_enabled](#input\_postgresql\_alerts\_enabled) | Database alerts enabled? | `bool` | `false` | no |
| <a name="input_postgresql_configuration"></a> [postgresql\_configuration](#input\_postgresql\_configuration) | PostgreSQL Server configuration | `map(string)` | `{}` | no |
| <a name="input_postgresql_connection_limit"></a> [postgresql\_connection\_limit](#input\_postgresql\_connection\_limit) | n/a | `number` | `-1` | no |
| <a name="input_postgresql_enable_replica"></a> [postgresql\_enable\_replica](#input\_postgresql\_enable\_replica) | Create a PostgreSQL Server Replica. | `bool` | `false` | no |
| <a name="input_postgresql_geo_redundant_backup_enabled"></a> [postgresql\_geo\_redundant\_backup\_enabled](#input\_postgresql\_geo\_redundant\_backup\_enabled) | Turn Geo-redundant server backups on/off. | `bool` | `false` | no |
| <a name="input_postgresql_name"></a> [postgresql\_name](#input\_postgresql\_name) | n/a | `string` | `null` | no |
| <a name="input_postgresql_network_rules"></a> [postgresql\_network\_rules](#input\_postgresql\_network\_rules) | Network rules restricting access to the postgresql server. | <pre>object({<br>    ip_rules                       = list(string)<br>    allow_access_to_azure_services = bool<br>  })</pre> | <pre>{<br>  "allow_access_to_azure_services": false,<br>  "ip_rules": []<br>}</pre> | no |
| <a name="input_postgresql_public_network_access_enabled"></a> [postgresql\_public\_network\_access\_enabled](#input\_postgresql\_public\_network\_access\_enabled) | database public | `bool` | `false` | no |
| <a name="input_postgresql_schema"></a> [postgresql\_schema](#input\_postgresql\_schema) | n/a | `string` | `null` | no |
| <a name="input_postgresql_sku_name"></a> [postgresql\_sku\_name](#input\_postgresql\_sku\_name) | Specifies the SKU Name for this PostgreSQL Server. | `string` | n/a | yes |
| <a name="input_postgresql_storage_mb"></a> [postgresql\_storage\_mb](#input\_postgresql\_storage\_mb) | Max storage allowed for a server | `number` | `5120` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"pagopa"` | no |
| <a name="input_private_dns_zone_db_nodo_pagamenti"></a> [private\_dns\_zone\_db\_nodo\_pagamenti](#input\_private\_dns\_zone\_db\_nodo\_pagamenti) | n/a | `string` | `"metti.qui.il.dns.com"` | no |
| <a name="input_prostgresql_db_mockpsp"></a> [prostgresql\_db\_mockpsp](#input\_prostgresql\_db\_mockpsp) | n/a | `string` | `null` | no |
| <a name="input_prostgresql_enabled"></a> [prostgresql\_enabled](#input\_prostgresql\_enabled) | Mock postegres database enable? | `bool` | `false` | no |
| <a name="input_redis_cache_enabled"></a> [redis\_cache\_enabled](#input\_redis\_cache\_enabled) | redis cache enabled | `bool` | `false` | no |
| <a name="input_redis_capacity"></a> [redis\_capacity](#input\_redis\_capacity) | n/a | `number` | `1` | no |
| <a name="input_redis_family"></a> [redis\_family](#input\_redis\_family) | n/a | `string` | `"C"` | no |
| <a name="input_redis_sku_name"></a> [redis\_sku\_name](#input\_redis\_sku\_name) | n/a | `string` | `"Standard"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_registry_admin_password"></a> [container\_registry\_admin\_password](#output\_container\_registry\_admin\_password) | n/a |
| <a name="output_container_registry_admin_username"></a> [container\_registry\_admin\_username](#output\_container\_registry\_admin\_username) | n/a |
| <a name="output_container_registry_login_server"></a> [container\_registry\_login\_server](#output\_container\_registry\_login\_server) | # Container registry ## |
| <a name="output_nat_gw_outbound_ip_addresses"></a> [nat\_gw\_outbound\_ip\_addresses](#output\_nat\_gw\_outbound\_ip\_addresses) | n/a |
| <a name="output_vnet_address_space"></a> [vnet\_address\_space](#output\_vnet\_address\_space) | n/a |
| <a name="output_vnet_integration_address_space"></a> [vnet\_integration\_address\_space](#output\_vnet\_integration\_address\_space) | n/a |
| <a name="output_vnet_integration_name"></a> [vnet\_integration\_name](#output\_vnet\_integration\_name) | n/a |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
