
<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | n/a |<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | = 1.3.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.6.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 2.99.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.2.3 |
| <a name="requirement_random"></a> [random](#requirement\_random) | <= 3.4.3 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.9.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apim"></a> [apim](#module\_apim) | git::https://github.com/pagopa/azurerm.git//api_management | v2.5.0 |
| <a name="module_apim_api_donations_api"></a> [apim\_api\_donations\_api](#module\_apim\_api\_donations\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.1.13 |
| <a name="module_apim_buyerbanks_api_v1"></a> [apim\_buyerbanks\_api\_v1](#module\_apim\_buyerbanks\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_donations_product"></a> [apim\_donations\_product](#module\_apim\_donations\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_donazioni_ucraina_product"></a> [apim\_donazioni\_ucraina\_product](#module\_apim\_donazioni\_ucraina\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_node_forwarder_api"></a> [apim\_node\_forwarder\_api](#module\_apim\_node\_forwarder\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_node_forwarder_product"></a> [apim\_node\_forwarder\_product](#module\_apim\_node\_forwarder\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_nodo_dei_pagamenti_monitoring_product"></a> [apim\_nodo\_dei\_pagamenti\_monitoring\_product](#module\_apim\_nodo\_dei\_pagamenti\_monitoring\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_nodo_dei_pagamenti_product"></a> [apim\_nodo\_dei\_pagamenti\_product](#module\_apim\_nodo\_dei\_pagamenti\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_nodo_dei_pagamenti_product_auth"></a> [apim\_nodo\_dei\_pagamenti\_product\_auth](#module\_apim\_nodo\_dei\_pagamenti\_product\_auth) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_nodo_dei_pagamenti_product_dev"></a> [apim\_nodo\_dei\_pagamenti\_product\_dev](#module\_apim\_nodo\_dei\_pagamenti\_product\_dev) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_nodo_fatturazione_api"></a> [apim\_nodo\_fatturazione\_api](#module\_apim\_nodo\_fatturazione\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_nodo_fatturazione_dev_api"></a> [apim\_nodo\_fatturazione\_dev\_api](#module\_apim\_nodo\_fatturazione\_dev\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_nodo_fatturazione_dev_product"></a> [apim\_nodo\_fatturazione\_dev\_product](#module\_apim\_nodo\_fatturazione\_dev\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_nodo_fatturazione_product"></a> [apim\_nodo\_fatturazione\_product](#module\_apim\_nodo\_fatturazione\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_nodo_monitoring_api"></a> [apim\_nodo\_monitoring\_api](#module\_apim\_nodo\_monitoring\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_nodo_monitoring_api_dev"></a> [apim\_nodo\_monitoring\_api\_dev](#module\_apim\_nodo\_monitoring\_api\_dev) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_nodo_per_pm_api_v1"></a> [apim\_nodo\_per\_pm\_api\_v1](#module\_apim\_nodo\_per\_pm\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.1.13 |
| <a name="module_apim_nodo_per_pm_api_v1_dev"></a> [apim\_nodo\_per\_pm\_api\_v1\_dev](#module\_apim\_nodo\_per\_pm\_api\_v1\_dev) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.1.13 |
| <a name="module_apim_nodo_per_pm_api_v2"></a> [apim\_nodo\_per\_pm\_api\_v2](#module\_apim\_nodo\_per\_pm\_api\_v2) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.1.13 |
| <a name="module_apim_nodo_per_pm_api_v2_dev"></a> [apim\_nodo\_per\_pm\_api\_v2\_dev](#module\_apim\_nodo\_per\_pm\_api\_v2\_dev) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.1.13 |
| <a name="module_apim_nodo_sync_api"></a> [apim\_nodo\_sync\_api](#module\_apim\_nodo\_sync\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_nodo_sync_dev_api"></a> [apim\_nodo\_sync\_dev\_api](#module\_apim\_nodo\_sync\_dev\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_nodo_sync_dev_product"></a> [apim\_nodo\_sync\_dev\_product](#module\_apim\_nodo\_sync\_dev\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_nodo_sync_product"></a> [apim\_nodo\_sync\_product](#module\_apim\_nodo\_sync\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_nodo_web_bo_api"></a> [apim\_nodo\_web\_bo\_api](#module\_apim\_nodo\_web\_bo\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_nodo_web_bo_api_history"></a> [apim\_nodo\_web\_bo\_api\_history](#module\_apim\_nodo\_web\_bo\_api\_history) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_nodo_web_bo_api_onprem"></a> [apim\_nodo\_web\_bo\_api\_onprem](#module\_apim\_nodo\_web\_bo\_api\_onprem) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_nodo_web_bo_api_onprem_history"></a> [apim\_nodo\_web\_bo\_api\_onprem\_history](#module\_apim\_nodo\_web\_bo\_api\_onprem\_history) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_nodo_web_bo_dev_api"></a> [apim\_nodo\_web\_bo\_dev\_api](#module\_apim\_nodo\_web\_bo\_dev\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_nodo_web_bo_dev_api_history"></a> [apim\_nodo\_web\_bo\_dev\_api\_history](#module\_apim\_nodo\_web\_bo\_dev\_api\_history) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_nodo_web_bo_dev_product"></a> [apim\_nodo\_web\_bo\_dev\_product](#module\_apim\_nodo\_web\_bo\_dev\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_nodo_web_bo_dev_product_history"></a> [apim\_nodo\_web\_bo\_dev\_product\_history](#module\_apim\_nodo\_web\_bo\_dev\_product\_history) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_nodo_web_bo_product"></a> [apim\_nodo\_web\_bo\_product](#module\_apim\_nodo\_web\_bo\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_nodo_web_bo_product_history"></a> [apim\_nodo\_web\_bo\_product\_history](#module\_apim\_nodo\_web\_bo\_product\_history) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_nodo_wfesp_api"></a> [apim\_nodo\_wfesp\_api](#module\_apim\_nodo\_wfesp\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_nodo_wfesp_dev_api"></a> [apim\_nodo\_wfesp\_dev\_api](#module\_apim\_nodo\_wfesp\_dev\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_nodo_wfesp_dev_product"></a> [apim\_nodo\_wfesp\_dev\_product](#module\_apim\_nodo\_wfesp\_dev\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_nodo_wfesp_product"></a> [apim\_nodo\_wfesp\_product](#module\_apim\_nodo\_wfesp\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_payment_manager_product"></a> [apim\_payment\_manager\_product](#module\_apim\_payment\_manager\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_payment_transactions_gateway_external_api_v1"></a> [apim\_payment\_transactions\_gateway\_external\_api\_v1](#module\_apim\_payment\_transactions\_gateway\_external\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_payment_transactions_gateway_internal_api_v1"></a> [apim\_payment\_transactions\_gateway\_internal\_api\_v1](#module\_apim\_payment\_transactions\_gateway\_internal\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_payment_transactions_gateway_pgsfe_api_v1"></a> [apim\_payment\_transactions\_gateway\_pgsfe\_api\_v1](#module\_apim\_payment\_transactions\_gateway\_pgsfe\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_payment_transactions_gateway_product"></a> [apim\_payment\_transactions\_gateway\_product](#module\_apim\_payment\_transactions\_gateway\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_payment_transactions_gateway_update_api_v1"></a> [apim\_payment\_transactions\_gateway\_update\_api\_v1](#module\_apim\_payment\_transactions\_gateway\_update\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_adminpanel_api_v1"></a> [apim\_pm\_adminpanel\_api\_v1](#module\_apim\_pm\_adminpanel\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_auth_rtd_api_v1"></a> [apim\_pm\_auth\_rtd\_api\_v1](#module\_apim\_pm\_auth\_rtd\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.18.3 |
| <a name="module_apim_pm_auth_rtd_api_v2"></a> [apim\_pm\_auth\_rtd\_api\_v2](#module\_apim\_pm\_auth\_rtd\_api\_v2) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.18.3 |
| <a name="module_apim_pm_bpd_api_v1"></a> [apim\_pm\_bpd\_api\_v1](#module\_apim\_pm\_bpd\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_cobadge_api_v4"></a> [apim\_pm\_cobadge\_api\_v4](#module\_apim\_pm\_cobadge\_api\_v4) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_events_v1"></a> [apim\_pm\_events\_v1](#module\_apim\_pm\_events\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_fesp_api_v1"></a> [apim\_pm\_fesp\_api\_v1](#module\_apim\_pm\_fesp\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_logging_api_v1"></a> [apim\_pm\_logging\_api\_v1](#module\_apim\_pm\_logging\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_mock_services_api_v1"></a> [apim\_pm\_mock\_services\_api\_v1](#module\_apim\_pm\_mock\_services\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_mock_services_fe"></a> [apim\_pm\_mock\_services\_fe](#module\_apim\_pm\_mock\_services\_fe) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_paypalpsp_api_v1"></a> [apim\_pm\_paypalpsp\_api\_v1](#module\_apim\_pm\_paypalpsp\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_per_nodo_v1"></a> [apim\_pm\_per\_nodo\_v1](#module\_apim\_pm\_per\_nodo\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_per_nodo_v2"></a> [apim\_pm\_per\_nodo\_v2](#module\_apim\_pm\_per\_nodo\_v2) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_ptg_api_v1"></a> [apim\_pm\_ptg\_api\_v1](#module\_apim\_pm\_ptg\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.18.3 |
| <a name="module_apim_pm_restapi_api_old_v4"></a> [apim\_pm\_restapi\_api\_old\_v4](#module\_apim\_pm\_restapi\_api\_old\_v4) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.18.3 |
| <a name="module_apim_pm_restapi_api_v4"></a> [apim\_pm\_restapi\_api\_v4](#module\_apim\_pm\_restapi\_api\_v4) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.18.3 |
| <a name="module_apim_pm_restapi_cd_assets"></a> [apim\_pm\_restapi\_cd\_assets](#module\_apim\_pm\_restapi\_cd\_assets) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_restapi_server_api_v4"></a> [apim\_pm\_restapi\_server\_api\_v4](#module\_apim\_pm\_restapi\_server\_api\_v4) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_restapicd_api_v1"></a> [apim\_pm\_restapicd\_api\_v1](#module\_apim\_pm\_restapicd\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.18.3 |
| <a name="module_apim_pm_restapicd_api_v2"></a> [apim\_pm\_restapicd\_api\_v2](#module\_apim\_pm\_restapicd\_api\_v2) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.18.3 |
| <a name="module_apim_pm_restapicd_api_v3"></a> [apim\_pm\_restapicd\_api\_v3](#module\_apim\_pm\_restapicd\_api\_v3) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.18.3 |
| <a name="module_apim_pm_restapicd_internal_api_v1"></a> [apim\_pm\_restapicd\_internal\_api\_v1](#module\_apim\_pm\_restapicd\_internal\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.18.3 |
| <a name="module_apim_pm_restapicd_internal_api_v2"></a> [apim\_pm\_restapicd\_internal\_api\_v2](#module\_apim\_pm\_restapicd\_internal\_api\_v2) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.18.3 |
| <a name="module_apim_pm_restapirtd_api_v1"></a> [apim\_pm\_restapirtd\_api\_v1](#module\_apim\_pm\_restapirtd\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.18.3 |
| <a name="module_apim_pm_restapirtd_api_v2"></a> [apim\_pm\_restapirtd\_api\_v2](#module\_apim\_pm\_restapirtd\_api\_v2) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.18.3 |
| <a name="module_apim_pm_satispay_api_v1"></a> [apim\_pm\_satispay\_api\_v1](#module\_apim\_pm\_satispay\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_test_utility_api_v1"></a> [apim\_pm\_test\_utility\_api\_v1](#module\_apim\_pm\_test\_utility\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_wisp_api_v1"></a> [apim\_pm\_wisp\_api\_v1](#module\_apim\_pm\_wisp\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_xpay_api_v1"></a> [apim\_pm\_xpay\_api\_v1](#module\_apim\_pm\_xpay\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pmclient_iobpd_api_v1"></a> [apim\_pmclient\_iobpd\_api\_v1](#module\_apim\_pmclient\_iobpd\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_snet"></a> [apim\_snet](#module\_apim\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.90 |
| <a name="module_apim_tkm_acquirer_manager_api_v1"></a> [apim\_tkm\_acquirer\_manager\_api\_v1](#module\_apim\_tkm\_acquirer\_manager\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_tkm_card_manager_api_v1"></a> [apim\_tkm\_card\_manager\_api\_v1](#module\_apim\_tkm\_card\_manager\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_tkm_consent_manager_api_v1"></a> [apim\_tkm\_consent\_manager\_api\_v1](#module\_apim\_tkm\_consent\_manager\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_tkm_consent_manager_internal_api_v1"></a> [apim\_tkm\_consent\_manager\_internal\_api\_v1](#module\_apim\_tkm\_consent\_manager\_internal\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_tkm_mock_circuit_api_v1"></a> [apim\_tkm\_mock\_circuit\_api\_v1](#module\_apim\_tkm\_mock\_circuit\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_tkm_product"></a> [apim\_tkm\_product](#module\_apim\_tkm\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_tkm_test_utility_api_v1"></a> [apim\_tkm\_test\_utility\_api\_v1](#module\_apim\_tkm\_test\_utility\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_app_gw"></a> [app\_gw](#module\_app\_gw) | git::https://github.com/pagopa/azurerm.git//app_gateway | v2.20.0 |
| <a name="module_appgateway_snet"></a> [appgateway\_snet](#module\_appgateway\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.90 |
| <a name="module_assets_cdn_platform"></a> [assets\_cdn\_platform](#module\_assets\_cdn\_platform) | git::https://github.com/pagopa/azurerm.git//cdn | v3.2.0 |
| <a name="module_azdoa_li_app"></a> [azdoa\_li\_app](#module\_azdoa\_li\_app) | git::https://github.com/pagopa/azurerm.git//azure_devops_agent | v4.20.0 |
| <a name="module_azdoa_li_infra"></a> [azdoa\_li\_infra](#module\_azdoa\_li\_infra) | git::https://github.com/pagopa/azurerm.git//azure_devops_agent | v4.20.0 |
| <a name="module_azdoa_loadtest_li"></a> [azdoa\_loadtest\_li](#module\_azdoa\_loadtest\_li) | git::https://github.com/pagopa/azurerm.git//azure_devops_agent | v4.20.0 |
| <a name="module_azdoa_snet"></a> [azdoa\_snet](#module\_azdoa\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v3.5.0 |
| <a name="module_backupstorage"></a> [backupstorage](#module\_backupstorage) | git::https://github.com/pagopa/azurerm.git//storage_account | v2.1.26 |
| <a name="module_buyerbanks_function"></a> [buyerbanks\_function](#module\_buyerbanks\_function) | git::https://github.com/pagopa/azurerm.git//function_app | v3.2.5 |
| <a name="module_buyerbanks_function_snet"></a> [buyerbanks\_function\_snet](#module\_buyerbanks\_function\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.90 |
| <a name="module_buyerbanks_storage"></a> [buyerbanks\_storage](#module\_buyerbanks\_storage) | git::https://github.com/pagopa/azurerm.git//storage_account | v2.0.28 |
| <a name="module_common_private_endpoint_snet"></a> [common\_private\_endpoint\_snet](#module\_common\_private\_endpoint\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v4.18.1 |
| <a name="module_container_registry"></a> [container\_registry](#module\_container\_registry) | git::https://github.com/pagopa/azurerm.git//container_registry | v2.14.1 |
| <a name="module_cosmos_payments_account"></a> [cosmos\_payments\_account](#module\_cosmos\_payments\_account) | git::https://github.com/pagopa/azurerm.git//cosmosdb_account | v2.1.18 |
| <a name="module_cosmosdb_paymentsdb_snet"></a> [cosmosdb\_paymentsdb\_snet](#module\_cosmosdb\_paymentsdb\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v2.15.1 |
| <a name="module_dns_forwarder"></a> [dns\_forwarder](#module\_dns\_forwarder) | git::https://github.com/pagopa/azurerm.git//dns_forwarder | v4.18.1 |
| <a name="module_dns_forwarder_snet"></a> [dns\_forwarder\_snet](#module\_dns\_forwarder\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v4.18.1 |
| <a name="module_event_hub01"></a> [event\_hub01](#module\_event\_hub01) | git::https://github.com/pagopa/azurerm.git//eventhub | v1.0.90 |
| <a name="module_event_hub02"></a> [event\_hub02](#module\_event\_hub02) | git::https://github.com/pagopa/azurerm.git//eventhub | v1.0.90 |
| <a name="module_eventhub_snet"></a> [eventhub\_snet](#module\_eventhub\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.90 |
| <a name="module_fdr_flows_sa"></a> [fdr\_flows\_sa](#module\_fdr\_flows\_sa) | git::https://github.com/pagopa/azurerm.git//storage_account | v2.0.28 |
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | git::https://github.com/pagopa/azurerm.git//key_vault | v1.0.90 |
| <a name="module_loadtest_agent_snet"></a> [loadtest\_agent\_snet](#module\_loadtest\_agent\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v3.5.0 |
| <a name="module_logic_app_biz_evt_sa"></a> [logic\_app\_biz\_evt\_sa](#module\_logic\_app\_biz\_evt\_sa) | git::https://github.com/pagopa/azurerm.git//storage_account | v2.0.28 |
| <a name="module_logic_app_biz_evt_snet"></a> [logic\_app\_biz\_evt\_snet](#module\_logic\_app\_biz\_evt\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.90 |
| <a name="module_monitor"></a> [monitor](#module\_monitor) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_nat_gw"></a> [nat\_gw](#module\_nat\_gw) | git::https://github.com/pagopa/azurerm.git//nat_gateway | v1.0.90 |
| <a name="module_node_forwarder_app_service"></a> [node\_forwarder\_app\_service](#module\_node\_forwarder\_app\_service) | git::https://github.com/pagopa/azurerm.git//app_service | v3.4.0 |
| <a name="module_node_forwarder_slot_staging"></a> [node\_forwarder\_slot\_staging](#module\_node\_forwarder\_slot\_staging) | git::https://github.com/pagopa/azurerm.git//app_service_slot | v3.4.0 |
| <a name="module_node_forwarder_snet"></a> [node\_forwarder\_snet](#module\_node\_forwarder\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.90 |
| <a name="module_nodo_test_storage"></a> [nodo\_test\_storage](#module\_nodo\_test\_storage) | git::https://github.com/pagopa/azurerm.git//storage_account | v2.1.13 |
| <a name="module_payments_cosmos_db"></a> [payments\_cosmos\_db](#module\_payments\_cosmos\_db) | git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_database | v2.1.15 |
| <a name="module_payments_cosmosdb_containers"></a> [payments\_cosmosdb\_containers](#module\_payments\_cosmosdb\_containers) | git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_container | v3.2.4 |
| <a name="module_postgresql"></a> [postgresql](#module\_postgresql) | git::https://github.com/pagopa/azurerm.git//postgresql_server | v2.0.28 |
| <a name="module_postgresql_snet"></a> [postgresql\_snet](#module\_postgresql\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.90 |
| <a name="module_redis"></a> [redis](#module\_redis) | git::https://github.com/pagopa/azurerm.git//redis_cache | v2.18.3 |
| <a name="module_redis_snet"></a> [redis\_snet](#module\_redis\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v2.18.3 |
| <a name="module_reporting_fdr_function"></a> [reporting\_fdr\_function](#module\_reporting\_fdr\_function) | git::https://github.com/pagopa/azurerm.git//function_app | v2.2.0 |
| <a name="module_reporting_fdr_function_snet"></a> [reporting\_fdr\_function\_snet](#module\_reporting\_fdr\_function\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.90 |
| <a name="module_route_table_peering_sia"></a> [route\_table\_peering\_sia](#module\_route\_table\_peering\_sia) | git::https://github.com/pagopa/azurerm.git//route_table | v4.18.1 |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | git::https://github.com/pagopa/azurerm.git//virtual_network | v4.18.1 |
| <a name="module_vnet_integration"></a> [vnet\_integration](#module\_vnet\_integration) | git::https://github.com/pagopa/azurerm.git//virtual_network | v4.18.1 |
| <a name="module_vnet_peering"></a> [vnet\_peering](#module\_vnet\_peering) | git::https://github.com/pagopa/azurerm.git//virtual_network_peering | v4.19.0 |
| <a name="module_vpn"></a> [vpn](#module\_vpn) | git::https://github.com/pagopa/azurerm.git//vpn_gateway | v4.18.1 |
| <a name="module_vpn_snet"></a> [vpn\_snet](#module\_vpn\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v4.18.1 |
| <a name="module_web_test_api"></a> [web\_test\_api](#module\_web\_test\_api) | git::https://github.com/pagopa/azurerm.git//application_insights_web_test_preview | v2.19.1 |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.decoupler_activate_outbound](https://registry.terraform.io/providers/Azure/azapi/1.3.0/docs/resources/resource) | resource |
| [azapi_resource.decoupler_algorithm](https://registry.terraform.io/providers/Azure/azapi/1.3.0/docs/resources/resource) | resource |
| [azapi_resource.decoupler_configuration](https://registry.terraform.io/providers/Azure/azapi/1.3.0/docs/resources/resource) | resource |
| [azapi_resource.on_erro_soap_handler](https://registry.terraform.io/providers/Azure/azapi/1.3.0/docs/resources/resource) | resource |
| [azurerm_api_management_api.apim_api_donazioni_ucraina_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_node_for_io_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_node_for_io_api_v1_auth](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_node_for_io_api_v1_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_node_for_pa_api_v1_auth](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_node_for_psp_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_node_for_psp_api_v1_auth](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_node_for_psp_api_v1_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_nodo_per_pa_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_nodo_per_pa_api_v1_auth](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_nodo_per_pa_api_v1_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_nodo_per_psp_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_nodo_per_psp_api_v1_auth](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_nodo_per_psp_api_v1_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_nodo_per_psp_richiesta_avvisi_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_nodo_per_psp_richiesta_avvisi_api_v1_auth](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_nodo_per_psp_richiesta_avvisi_api_v1_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api_diagnostic.apim_info_logs](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_diagnostic) | resource |
| [azurerm_api_management_api_diagnostic.apim_logs](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_diagnostic) | resource |
| [azurerm_api_management_api_operation_policy.activateIO_reservation_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.close_payment_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.close_payment_api_v1_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.donazioni_activate_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.donazioni_sendrt_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.donazioni_verify_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.get_donations](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.nm3_activate_v2_verify_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.nm3_activate_v2_verify_policy_auth](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.nm3_activate_verify_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.nm3_activate_verify_policy_auth](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.parked_list_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.parked_list_api_v1_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_policy.apim_node_for_donazioni_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_node_for_io_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_node_for_io_policy_auth](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_node_for_io_policy_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_node_for_pa_policy_auth](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_node_for_psp_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_node_for_psp_policy_auth](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_node_for_psp_policy_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_nodo_per_pa_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_nodo_per_pa_policy_auth](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_nodo_per_pa_policy_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_nodo_per_psp_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_nodo_per_psp_policy_auth](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_nodo_per_psp_policy_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_nodo_per_psp_richiesta_avvisi_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_nodo_per_psp_richiesta_avvisi_policy_auth](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_nodo_per_psp_richiesta_avvisi_policy_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_version_set.api_donations_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_donazioni_ucraina_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_pm_bpd_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_pm_cobadge_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_pm_fesp_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_pm_mock_services_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_pm_paypalpsp_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_pm_satispay_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_pm_test_utility_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_pm_xpay_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.buyerbanks_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.node_for_io_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.node_for_io_api_auth](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.node_for_io_api_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.node_for_pa_api_auth](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.node_for_psp_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.node_for_psp_api_auth](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.node_for_psp_api_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.node_forwarder_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_fatturazione_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_fatturazione_dev_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_monitoring_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_monitoring_api_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_per_pa_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_per_pa_api_auth](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_per_pa_api_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_per_pm_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_per_pm_api_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_per_psp_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_per_psp_api_auth](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_per_psp_api_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_per_psp_richiesta_avvisi_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_per_psp_richiesta_avvisi_api_auth](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_per_psp_richiesta_avvisi_api_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_sync_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_sync_dev_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_wfesp_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_wfesp_dev_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.payment_transactions_gateway_external_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.payment_transactions_gateway_internal_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.payment_transactions_gateway_pgsfe_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.payment_transactions_gateway_update_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pm_adminpanel_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pm_auth_rtd_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pm_events_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pm_per_nodo_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pm_ptg_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pm_restapi_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pm_restapi_old_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pm_restapi_server_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pm_restapicd_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pm_restapicd_internal_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pm_restapirtd_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pmclient_iobpd_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.tkm_acquirer_manager_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.tkm_card_manager_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.tkm_consent_manager_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.tkm_consent_manager_internal_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.tkm_mock_circuit_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.tkm_test_utility_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_custom_domain.api_custom_domain](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_custom_domain) | resource |
| [azurerm_api_management_group.afm_calculator](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.centro_stella](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.checkout_rate_limit_300](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.checkout_rate_no_limit](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.client_io](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.ecommerce](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.gps_grp](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.payment_manager](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.pda](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.piattaforma_notifiche](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.readonly](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_group) | resource |
| [azurerm_api_management_named_value.aks_lb_nexi](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_fatturazione](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_fatturazione_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_oncloud](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_ppt_lmi](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_ppt_lmi_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_sync](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_sync_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_web_bo](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_web_bo_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_web_bo_history](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_web_bo_history_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_wfesp](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_wfesp_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.brokerlist_value](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.checkout_google_recaptcha_secret](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.checkout_v2_test_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.default_nodo_backend](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.default_nodo_backend_dev_nexi](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.default_nodo_backend_prf](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.default_nodo_id](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.donazioni_config_name](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.donazioni_config_name_2](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.ecblacklist_value](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.enable_nm3_decoupler_switch](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.enable_routing_decoupler_switch](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.fdrcontainername](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.fdrsaname](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.ip_nodo_value](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.node_decoupler_primitives](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.nodo_auth_password_value](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pagopa_fn_buyerbanks_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pagopa_fn_buyerbanks_url_value](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pagopa_fn_checkout_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pagopa_fn_checkout_url_value](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pagopa_mock_services_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.password_pm_test](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.payment_gateway_service_jwt_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pm_gtw_hostname](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pm_host](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pm_host_prf](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pm_onprem_hostname](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.schema_ip_nexi](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.schema_ip_nodo_pagopa](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.urlnodo_value](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.user_pm_test](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.verificatore_api_key_apiconfig](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.wisp2_gov_it](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.wisp2_it](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.x_forwarded_for_value](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_product_api.apim_nodo_dei_pagamenti_product_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_product_api) | resource |
| [azurerm_api_management_product_api.apim_nodo_dei_pagamenti_product_api_auth](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_product_api) | resource |
| [azurerm_api_management_product_api.apim_nodo_dei_pagamenti_product_api_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_product_api) | resource |
| [azurerm_api_management_redis_cache.apim_external_cache_redis](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_redis_cache) | resource |
| [azurerm_app_service_plan.logic_app_biz_evt_service_plan](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/app_service_plan) | resource |
| [azurerm_app_service_virtual_network_swift_connection.logic_app_virtual_network_swift_connection](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/app_service_virtual_network_swift_connection) | resource |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/application_insights) | resource |
| [azurerm_application_insights_web_test.assets_cdn_platform_web_test](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/application_insights_web_test) | resource |
| [azurerm_dns_a_record.dns_a_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.dns_a_api_prf](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.dns_a_apix](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.dns_a_forwarder](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.dns_a_kibana](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.dns_a_management](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.dns_a_management_prf](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.dns_a_portal](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.dns_a_portal_prf](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.dns_a_wisp2_at](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_a_record) | resource |
| [azurerm_dns_caa_record.api_platform_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_caa_record) | resource |
| [azurerm_dns_caa_record.api_platform_pagopa_it_prf](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_caa_record) | resource |
| [azurerm_dns_caa_record.wisp2_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_caa_record) | resource |
| [azurerm_dns_cname_record.dkim-aws-ses-backoffice-platform-pagopa-it](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_cname_record) | resource |
| [azurerm_dns_cname_record.dkim-aws-ses-ndp-platform-pagopa-it](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_cname_record) | resource |
| [azurerm_dns_cname_record.dkim-aws-ses-platform-pagopa-it](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_cname_record) | resource |
| [azurerm_dns_mx_record.dns-mx-backoffice-platform-pagopa-it](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_mx_record) | resource |
| [azurerm_dns_mx_record.dns-mx-email-platform-pagopa-it](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_mx_record) | resource |
| [azurerm_dns_mx_record.dns-mx-ndp-platform-pagopa-it](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_mx_record) | resource |
| [azurerm_dns_ns_record.dev_pagopa_it_ns](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ns_record.dev_wisp2](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ns_record.prf_pagopa_it_ns](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ns_record.uat_pagopa_it_ns](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ns_record.uat_wisp2](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_txt_record.dns-txt-backoffice-platform-pagopa-it-aws-ses](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_txt_record) | resource |
| [azurerm_dns_txt_record.dns-txt-backoffice-platform-pagopa-it-aws-ses-txt](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_txt_record) | resource |
| [azurerm_dns_txt_record.dns-txt-email-platform-pagopa-it-aws-ses](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_txt_record) | resource |
| [azurerm_dns_txt_record.dns-txt-ndp-platform-pagopa-it-aws-ses](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_txt_record) | resource |
| [azurerm_dns_txt_record.dns-txt-ndp-platform-pagopa-it-aws-ses-txt](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_txt_record) | resource |
| [azurerm_dns_txt_record.dns-txt-platform-pagopa-it-aws-ses](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_txt_record) | resource |
| [azurerm_dns_zone.public](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_zone) | resource |
| [azurerm_dns_zone.public_prf](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_zone) | resource |
| [azurerm_dns_zone.wisp2_public](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_zone) | resource |
| [azurerm_key_vault_access_policy.ad_group_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_developers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_externals_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_security_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.api_management_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.app_gateway_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_legacy_policies](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_managed_identities](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azure_cdn_frontdoor_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_certificate.buyerbanks_cert](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_certificate) | resource |
| [azurerm_key_vault_secret.certificate_crt_node_forwarder_s](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.certificate_key_node_forwarder_s](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.github_token_read_packages_bot](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.newconn_opsgenie_webhook_token](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.node_forwarder_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.pgs_jwt_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.team_core_opsgenie_webhook_token](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_log_analytics_workspace.log_analytics_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/log_analytics_workspace) | resource |
| [azurerm_logic_app_standard.logic_app_biz_evt](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/logic_app_standard) | resource |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_action_group.error_action_group](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_action_group.mo_email](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_action_group.new_conn_srv_opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_action_group.pm_opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_autoscale_setting.buyerbanks_function](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.node_forwarder_app_service_autoscale](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.reporting_fdr_function](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_diagnostic_setting.activity_log](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_metric_alert.app_service_over_cpu_usage](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.app_service_over_mem_usage](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.snat_connection_over_10K](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.buyerbanks_update_alert](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.fdr_parsing_0_flows_alert](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-node-forwarder-availability-upd](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-node-forwarder-responsetime-upd](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.pm_payment_gateway_availability](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.pm_restapi_availability](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.pm_restapi_cd_availability](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.pm_wallet_availability](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_postgresql_database.this](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/postgresql_database) | resource |
| [azurerm_private_dns_a_record.platform_dns_a_private_apim](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.platform_dns_a_private_prf](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.private_dns_a_record_db_nodo](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.private_dns_a_record_db_nodo_nexi_postgres](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.private_dns_a_record_db_nodo_nexi_postgres_prf](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.private_dns_a_record_db_nodo_prf](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_zone.db_nodo_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.internal_platform_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.platform_private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.platform_private_dns_zone_prf](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.postgres](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_azurecr_pagopa](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_documents_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_mongo_cosmos_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_postgres_database_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_queue_core_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_redis_cache_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_table_cosmos_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.table_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.db_nodo_dns_zone_virtual_link](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.internal_platform_pagopa_it_private_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.internal_platform_vnetlink_vnet_core](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.platform_vnetlink_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.platform_vnetlink_vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.platform_vnetlink_vnet_integration_prf](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.platform_vnetlink_vnet_prf](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.postgres_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_blob_azure_com_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_blob_azure_com_vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_documents_azure_com_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_documents_azure_com_vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_postgres_database_azure_com_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_redis_cache_windows_net_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_table_azure_com_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_table_cosmos_azure_com_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_table_cosmos_azure_com_vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.vnet_integration_network_link](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.vnet_link_privatelink_queue_core_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.vnet_privatelink_mongo_cosmos_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_public_ip.appgateway_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/public_ip) | resource |
| [azurerm_resource_group.assets_cdn_platform_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.azdo_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.buyerbanks_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.container_registry_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.cosmosdb_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.data](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.default_roleassignment_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.managed_identities_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.msg_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.node_forwarder_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.nodo_pagamenti_test_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.pagopa_logic_app](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.payment_manager_monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.reporting_fdr_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.data_contributor_role](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/role_assignment) | resource |
| [azurerm_role_definition.iac_reader](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/role_definition) | resource |
| [azurerm_storage_container.apim_backup](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/storage_container) | resource |
| [azurerm_storage_container.banks](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/storage_container) | resource |
| [azurerm_storage_container.fdr_rend_flow](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/storage_container) | resource |
| [azurerm_storage_container.fdr_rend_flow_out](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/storage_container) | resource |
| [azurerm_storage_management_policy.backups](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/storage_management_policy) | resource |
| [azurerm_storage_management_policy.buyerbanks_storage_lifeclycle_policies](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/storage_management_policy) | resource |
| [azurerm_storage_management_policy.storage_account_fdr_management_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/storage_management_policy) | resource |
| [azurerm_user_assigned_identity.appgateway](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/user_assigned_identity) | resource |
| [null_resource.change_auth_fdr_blob_container](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.decoupler_configuration_from_json_2_xml](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_id.dns_forwarder_hash](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [azuread_application.vpn_app](https://registry.terraform.io/providers/hashicorp/azuread/2.6.0/docs/data-sources/application) | data source |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/2.6.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/2.6.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/2.6.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/2.6.0/docs/data-sources/group) | data source |
| [azuread_service_principal.iac_deploy_legacy](https://registry.terraform.io/providers/hashicorp/azuread/2.6.0/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.iac_plan_legacy](https://registry.terraform.io/providers/hashicorp/azuread/2.6.0/docs/data-sources/service_principal) | data source |
| [azurerm_api_management_api.apim_aca_api_v1_](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/api_management_api) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/client_config) | data source |
| [azurerm_key_vault_certificate.app_gw_platform](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.app_gw_platform_prf](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.app_gw_platformx](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.kibana](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.management_platform](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.portal_platform](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.wfespgovit](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.wisp2](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.wisp2govit](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_secret.alert_error_notification_email](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.alert_error_notification_slack](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.apiconfig-client-secret](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.apim_publisher_email](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.certificate_crt_node_forwarder](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.certificate_key_node_forwarder](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.checkout_v2_test_key_secret](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.db_administrator_login](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.db_administrator_login_password](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.db_nodo_pwd](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.db_nodo_usr](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.fn_buyerbanks_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.fn_checkout_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.google_recaptcha_secret](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.gpd_payments_apiconfig_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.mock_services_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_mo_notification_email](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_new_conn_srv_webhook_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_notification_email](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_notification_slack_email](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_pm_opsgenie_webhook_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pagopa_buyerbank_cert_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pagopa_buyerbank_cert_peer](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pagopa_buyerbank_signature](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pagopa_buyerbank_thumbprint](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pagopa_buyerbank_thumbprint_peer](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.password_pm_test_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pgs_jwt_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pm_gtw_hostname](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pm_host](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pm_host_prf](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pm_logging_ip](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pm_onprem_hostname](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pm_restapi_ip](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pm_wisp_metadata](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.sec_storage_id](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.sec_workspace_id](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.user_pm_test_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.verificatore_key_secret_apiconfig](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_private_dns_zone.privatelink_redis_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/private_dns_zone) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/subscription) | data source |
| [azurerm_user_assigned_identity.iac_federated_azdo](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/user_assigned_identity) | data source |

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
| <a name="input_apim_enable_nm3_decoupler_switch"></a> [apim\_enable\_nm3\_decoupler\_switch](#input\_apim\_enable\_nm3\_decoupler\_switch) | Enable switch backend address in NM3 algorithm logic | `bool` | `false` | no |
| <a name="input_apim_enable_routing_decoupler_switch"></a> [apim\_enable\_routing\_decoupler\_switch](#input\_apim\_enable\_routing\_decoupler\_switch) | Enable switch backend address in Routing algorithm logic | `bool` | `false` | no |
| <a name="input_apim_fdr_nodo_pagopa_enable"></a> [apim\_fdr\_nodo\_pagopa\_enable](#input\_apim\_fdr\_nodo\_pagopa\_enable) | Enable Fdr Service Nodo pagoPA side | `bool` | `false` | no |
| <a name="input_apim_nodo_auth_decoupler_enable"></a> [apim\_nodo\_auth\_decoupler\_enable](#input\_apim\_nodo\_auth\_decoupler\_enable) | Apply decoupler to nodo-auth product apim policy | `bool` | `false` | no |
| <a name="input_apim_nodo_decoupler_enable"></a> [apim\_nodo\_decoupler\_enable](#input\_apim\_nodo\_decoupler\_enable) | Apply decoupler to nodo product apim policy | `bool` | `false` | no |
| <a name="input_apim_publisher_name"></a> [apim\_publisher\_name](#input\_apim\_publisher\_name) | apim | `string` | n/a | yes |
| <a name="input_apim_sku"></a> [apim\_sku](#input\_apim\_sku) | n/a | `string` | n/a | yes |
| <a name="input_app_gateway_alerts_enabled"></a> [app\_gateway\_alerts\_enabled](#input\_app\_gateway\_alerts\_enabled) | Enable alerts | `bool` | `true` | no |
| <a name="input_app_gateway_allowed_paths_pagopa_onprem_only"></a> [app\_gateway\_allowed\_paths\_pagopa\_onprem\_only](#input\_app\_gateway\_allowed\_paths\_pagopa\_onprem\_only) | Allowed paths from pagopa onprem only | <pre>object({<br>    paths = list(string)<br>    ips   = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_app_gateway_api_certificate_name"></a> [app\_gateway\_api\_certificate\_name](#input\_app\_gateway\_api\_certificate\_name) | Application gateway api certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_apix_certificate_name"></a> [app\_gateway\_apix\_certificate\_name](#input\_app\_gateway\_apix\_certificate\_name) | Application gateway api certificate name on Key Vault ( where 'x' stay for heavy payload ) | `string` | n/a | yes |
| <a name="input_app_gateway_deny_paths"></a> [app\_gateway\_deny\_paths](#input\_app\_gateway\_deny\_paths) | Deny paths on app gateway | `list(string)` | `[]` | no |
| <a name="input_app_gateway_deny_paths_2"></a> [app\_gateway\_deny\_paths\_2](#input\_app\_gateway\_deny\_paths\_2) | Deny paths on app gateway | `list(string)` | `[]` | no |
| <a name="input_app_gateway_kibana_certificate_name"></a> [app\_gateway\_kibana\_certificate\_name](#input\_app\_gateway\_kibana\_certificate\_name) | Application gateway api certificate name on Key Vault | `string` | `""` | no |
| <a name="input_app_gateway_kibana_deny_paths"></a> [app\_gateway\_kibana\_deny\_paths](#input\_app\_gateway\_kibana\_deny\_paths) | Deny paths on app gateway kibana | `list(string)` | `[]` | no |
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
| <a name="input_backup_storage_replication_type"></a> [backup\_storage\_replication\_type](#input\_backup\_storage\_replication\_type) | (Optional) Backup storage account replication type | `string` | `"GRS"` | no |
| <a name="input_base_path_nodo_fatturazione"></a> [base\_path\_nodo\_fatturazione](#input\_base\_path\_nodo\_fatturazione) | base nodo on cloud | `string` | n/a | yes |
| <a name="input_base_path_nodo_fatturazione_dev"></a> [base\_path\_nodo\_fatturazione\_dev](#input\_base\_path\_nodo\_fatturazione\_dev) | base nodo on cloud | `string` | `"/fatturazione-dev"` | no |
| <a name="input_base_path_nodo_oncloud"></a> [base\_path\_nodo\_oncloud](#input\_base\_path\_nodo\_oncloud) | base nodo on cloud | `string` | n/a | yes |
| <a name="input_base_path_nodo_postgresql_nexi_onprem"></a> [base\_path\_nodo\_postgresql\_nexi\_onprem](#input\_base\_path\_nodo\_postgresql\_nexi\_onprem) | base nodo postgresql Nexi on prem | `string` | n/a | yes |
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
| <a name="input_buyer_banks_storage_account_replication_type"></a> [buyer\_banks\_storage\_account\_replication\_type](#input\_buyer\_banks\_storage\_account\_replication\_type) | (Optional) Buyer banks storage account replication type | `string` | `"LRS"` | no |
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
| <a name="input_cdn_storage_account_replication_type"></a> [cdn\_storage\_account\_replication\_type](#input\_cdn\_storage\_account\_replication\_type) | (Optional) Cdn storage account replication type | `string` | `"GRS"` | no |
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
| <a name="input_cidr_subnet_loadtest_agent"></a> [cidr\_subnet\_loadtest\_agent](#input\_cidr\_subnet\_loadtest\_agent) | LoadTest Agent Pool address space | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_logicapp_biz_evt"></a> [cidr\_subnet\_logicapp\_biz\_evt](#input\_cidr\_subnet\_logicapp\_biz\_evt) | Address prefixes subnet logic app | `list(string)` | `null` | no |
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
| <a name="input_cosmos_document_db_params"></a> [cosmos\_document\_db\_params](#input\_cosmos\_document\_db\_params) | n/a | <pre>object({<br>    kind           = string<br>    capabilities   = list(string)<br>    offer_type     = string<br>    server_version = string<br>    consistency_policy = object({<br>      consistency_level       = string<br>      max_interval_in_seconds = number<br>      max_staleness_prefix    = number<br>    })<br>    main_geo_location_zone_redundant = bool<br>    enable_free_tier                 = bool<br>    additional_geo_locations = list(object({<br>      location          = string<br>      failover_priority = number<br>      zone_redundant    = bool<br>    }))<br>    private_endpoint_enabled          = bool<br>    public_network_access_enabled     = bool<br>    is_virtual_network_filter_enabled = bool<br>    backup_continuous_enabled         = bool<br>  })</pre> | n/a | yes |
| <a name="input_cstar_outbound_ip_1"></a> [cstar\_outbound\_ip\_1](#input\_cstar\_outbound\_ip\_1) | CSTAR ip 1 | `string` | n/a | yes |
| <a name="input_cstar_outbound_ip_2"></a> [cstar\_outbound\_ip\_2](#input\_cstar\_outbound\_ip\_2) | CSTAR ip 2 | `string` | n/a | yes |
| <a name="input_ddos_protection_plan"></a> [ddos\_protection\_plan](#input\_ddos\_protection\_plan) | Network | <pre>object({<br>    id     = string<br>    enable = bool<br>  })</pre> | `null` | no |
| <a name="input_default_node_id"></a> [default\_node\_id](#input\_default\_node\_id) | Default NodeId according to default base url | `string` | n/a | yes |
| <a name="input_devops_agent_balance_zones"></a> [devops\_agent\_balance\_zones](#input\_devops\_agent\_balance\_zones) | (Optional) True if the devops agent instances must be evenly balanced between the configured zones | `bool` | `false` | no |
| <a name="input_devops_agent_zones"></a> [devops\_agent\_zones](#input\_devops\_agent\_zones) | (Optional) List of zones in which the scale set for azdo agent will be deployed | `list(number)` | `null` | no |
| <a name="input_dns_a_reconds_dbnodo_ips"></a> [dns\_a\_reconds\_dbnodo\_ips](#input\_dns\_a\_reconds\_dbnodo\_ips) | IPs address of DB Nodo | `list(string)` | `[]` | no |
| <a name="input_dns_a_reconds_dbnodo_prf_ips"></a> [dns\_a\_reconds\_dbnodo\_prf\_ips](#input\_dns\_a\_reconds\_dbnodo\_prf\_ips) | IPs address of DB Nodo | `list(string)` | `[]` | no |
| <a name="input_dns_a_reconds_dbnodonexipostgres_ips"></a> [dns\_a\_reconds\_dbnodonexipostgres\_ips](#input\_dns\_a\_reconds\_dbnodonexipostgres\_ips) | IPs address of DB Nodo PostgreSQL Nexi | `list(string)` | `[]` | no |
| <a name="input_dns_a_reconds_dbnodonexipostgres_prf_ips"></a> [dns\_a\_reconds\_dbnodonexipostgres\_prf\_ips](#input\_dns\_a\_reconds\_dbnodonexipostgres\_prf\_ips) | IPs address of DB Nodo PostgreSQL Nexi | `list(string)` | `[]` | no |
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
| <a name="input_fdr_flow_sa_replication_type"></a> [fdr\_flow\_sa\_replication\_type](#input\_fdr\_flow\_sa\_replication\_type) | (Optional) Fdr flow storage account replication type | `string` | `"LRS"` | no |
| <a name="input_fesp_hostname"></a> [fesp\_hostname](#input\_fesp\_hostname) | Fesp hostname | `string` | `""` | no |
| <a name="input_function_app_storage_account_info"></a> [function\_app\_storage\_account\_info](#input\_function\_app\_storage\_account\_info) | n/a | <pre>object({<br>    account_kind                      = optional(string, "StorageV2")<br>    account_tier                      = optional(string, "Standard")<br>    account_replication_type          = optional(string, "LRS")<br>    access_tier                       = optional(string, "Hot")<br>    advanced_threat_protection_enable = optional(bool, true)<br>  })</pre> | <pre>{<br>  "access_tier": "Hot",<br>  "account_kind": "StorageV2",<br>  "account_replication_type": "LRS",<br>  "account_tier": "Standard",<br>  "advanced_threat_protection_enable": true<br>}</pre> | no |
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
| <a name="input_logic_app_storage_account_replication_type"></a> [logic\_app\_storage\_account\_replication\_type](#input\_logic\_app\_storage\_account\_replication\_type) | (Optional) Storage account replication type used for function apps | `string` | `"LRS"` | no |
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
| <a name="input_reporting_fdr_storage_account_info"></a> [reporting\_fdr\_storage\_account\_info](#input\_reporting\_fdr\_storage\_account\_info) | n/a | <pre>object({<br>    account_tier                      = string<br>    account_replication_type          = string<br>    access_tier                       = string<br>    advanced_threat_protection_enable = bool<br>  })</pre> | <pre>{<br>  "access_tier": "Hot",<br>  "account_replication_type": "ZRS",<br>  "account_tier": "Standard",<br>  "advanced_threat_protection_enable": true<br>}</pre> | no |
| <a name="input_satispay_hostname"></a> [satispay\_hostname](#input\_satispay\_hostname) | Satispay hostname | `string` | `""` | no |
| <a name="input_schema_ip_nexi"></a> [schema\_ip\_nexi](#input\_schema\_ip\_nexi) | Nodo Pagamenti Nexi schema://ip | `string` | n/a | yes |
| <a name="input_storage_queue_private_endpoint_enabled"></a> [storage\_queue\_private\_endpoint\_enabled](#input\_storage\_queue\_private\_endpoint\_enabled) | Whether private endpoint for Azure Storage Queues is enabled | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |
| <a name="input_users"></a> [users](#input\_users) | List of psql users with grants. | <pre>list(object({<br>    name = string<br>    grants = list(object({<br>      object_type = string<br>      database    = string<br>      schema      = string<br>      privileges  = list(string)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_vpn_pip_sku"></a> [vpn\_pip\_sku](#input\_vpn\_pip\_sku) | VPN GW PIP SKU | `string` | `"Basic"` | no |
| <a name="input_vpn_sku"></a> [vpn\_sku](#input\_vpn\_sku) | VPN Gateway SKU | `string` | `"VpnGw1"` | no |
| <a name="input_xpay_hostname"></a> [xpay\_hostname](#input\_xpay\_hostname) | Nexi xpay hostname | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_insights_instrumentation_key"></a> [application\_insights\_instrumentation\_key](#output\_application\_insights\_instrumentation\_key) | n/a |
| <a name="output_container_registry_admin_password"></a> [container\_registry\_admin\_password](#output\_container\_registry\_admin\_password) | n/a |
| <a name="output_container_registry_admin_username"></a> [container\_registry\_admin\_username](#output\_container\_registry\_admin\_username) | n/a |
| <a name="output_container_registry_login_server"></a> [container\_registry\_login\_server](#output\_container\_registry\_login\_server) | # Container registry ## |
| <a name="output_ehub_biz_event_rx_conn_str"></a> [ehub\_biz\_event\_rx\_conn\_str](#output\_ehub\_biz\_event\_rx\_conn\_str) | n/a |
| <a name="output_ehub_biz_event_tx_primary_key"></a> [ehub\_biz\_event\_tx\_primary\_key](#output\_ehub\_biz\_event\_tx\_primary\_key) | n/a |
| <a name="output_nat_gw_outbound_ip_addresses"></a> [nat\_gw\_outbound\_ip\_addresses](#output\_nat\_gw\_outbound\_ip\_addresses) | n/a |
| <a name="output_nodo_test_sa_blob_connection_string"></a> [nodo\_test\_sa\_blob\_connection\_string](#output\_nodo\_test\_sa\_blob\_connection\_string) | n/a |
| <a name="output_nodo_test_sa_blob_host"></a> [nodo\_test\_sa\_blob\_host](#output\_nodo\_test\_sa\_blob\_host) | Blob storage |
| <a name="output_nodo_test_sa_connection_string"></a> [nodo\_test\_sa\_connection\_string](#output\_nodo\_test\_sa\_connection\_string) | n/a |
| <a name="output_nodo_test_sa_web_host"></a> [nodo\_test\_sa\_web\_host](#output\_nodo\_test\_sa\_web\_host) | n/a |
| <a name="output_vnet_address_space"></a> [vnet\_address\_space](#output\_vnet\_address\_space) | n/a |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | n/a |
| <a name="output_vnet_integration_address_space"></a> [vnet\_integration\_address\_space](#output\_vnet\_integration\_address\_space) | n/a |
| <a name="output_vnet_integration_name"></a> [vnet\_integration\_name](#output\_vnet\_integration\_name) | n/a |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
