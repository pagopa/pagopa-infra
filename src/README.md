## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.6.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 2.92.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.6.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.92.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acr"></a> [acr](#module\_acr) | git::https://github.com/pagopa/azurerm.git//container_registry | v1.0.7 |
| <a name="module_api_config_app_service"></a> [api\_config\_app\_service](#module\_api\_config\_app\_service) | git::https://github.com/pagopa/azurerm.git//app_service | v1.0.93 |
| <a name="module_api_config_fe_cdn"></a> [api\_config\_fe\_cdn](#module\_api\_config\_fe\_cdn) | git::https://github.com/pagopa/azurerm.git//cdn | v2.0.18 |
| <a name="module_api_config_snet"></a> [api\_config\_snet](#module\_api\_config\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.51 |
| <a name="module_apim"></a> [apim](#module\_apim) | git::https://github.com/pagopa/azurerm.git//api_management | v2.5.0 |
| <a name="module_apim_api_config_api"></a> [apim\_api\_config\_api](#module\_apim\_api\_config\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.0.12 |
| <a name="module_apim_api_config_checkout_api"></a> [apim\_api\_config\_checkout\_api](#module\_apim\_api\_config\_checkout\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.0.12 |
| <a name="module_apim_api_config_checkout_product"></a> [apim\_api\_config\_checkout\_product](#module\_apim\_api\_config\_checkout\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.84 |
| <a name="module_apim_api_config_product"></a> [apim\_api\_config\_product](#module\_apim\_api\_config\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.84 |
| <a name="module_apim_api_donations_api"></a> [apim\_api\_donations\_api](#module\_apim\_api\_donations\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.1.13 |
| <a name="module_apim_api_gpd_api"></a> [apim\_api\_gpd\_api](#module\_apim\_api\_gpd\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.1.13 |
| <a name="module_apim_api_gpd_payments_rest_api"></a> [apim\_api\_gpd\_payments\_rest\_api](#module\_apim\_api\_gpd\_payments\_rest\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.1.13 |
| <a name="module_apim_api_gpd_reporting_analysis_api"></a> [apim\_api\_gpd\_reporting\_analysis\_api](#module\_apim\_api\_gpd\_reporting\_analysis\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.1.13 |
| <a name="module_apim_buyerbanks_api_v1"></a> [apim\_buyerbanks\_api\_v1](#module\_apim\_buyerbanks\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_checkout_payment_activations_api_auth_v1"></a> [apim\_checkout\_payment\_activations\_api\_auth\_v1](#module\_apim\_checkout\_payment\_activations\_api\_auth\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.1.13 |
| <a name="module_apim_checkout_payment_activations_api_auth_v2"></a> [apim\_checkout\_payment\_activations\_api\_auth\_v2](#module\_apim\_checkout\_payment\_activations\_api\_auth\_v2) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.1.13 |
| <a name="module_apim_checkout_payment_activations_api_v1"></a> [apim\_checkout\_payment\_activations\_api\_v1](#module\_apim\_checkout\_payment\_activations\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.1.13 |
| <a name="module_apim_checkout_product"></a> [apim\_checkout\_product](#module\_apim\_checkout\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_checkout_transactions_api_v1"></a> [apim\_checkout\_transactions\_api\_v1](#module\_apim\_checkout\_transactions\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_donations_product"></a> [apim\_donations\_product](#module\_apim\_donations\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.84 |
| <a name="module_apim_donazioni_ucraina_product"></a> [apim\_donazioni\_ucraina\_product](#module\_apim\_donazioni\_ucraina\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.84 |
| <a name="module_apim_gpd_payments_product"></a> [apim\_gpd\_payments\_product](#module\_apim\_gpd\_payments\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.84 |
| <a name="module_apim_gpd_payments_rest_product"></a> [apim\_gpd\_payments\_rest\_product](#module\_apim\_gpd\_payments\_rest\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.84 |
| <a name="module_apim_gpd_product"></a> [apim\_gpd\_product](#module\_apim\_gpd\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.84 |
| <a name="module_apim_gpd_reporting_analysis_product"></a> [apim\_gpd\_reporting\_analysis\_product](#module\_apim\_gpd\_reporting\_analysis\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.84 |
| <a name="module_apim_mock_ec_api"></a> [apim\_mock\_ec\_api](#module\_apim\_mock\_ec\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_mock_ec_product"></a> [apim\_mock\_ec\_product](#module\_apim\_mock\_ec\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_mock_psp_api"></a> [apim\_mock\_psp\_api](#module\_apim\_mock\_psp\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_mock_psp_mng_api"></a> [apim\_mock\_psp\_mng\_api](#module\_apim\_mock\_psp\_mng\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_mock_psp_product"></a> [apim\_mock\_psp\_product](#module\_apim\_mock\_psp\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_nodo_dei_pagamenti_product"></a> [apim\_nodo\_dei\_pagamenti\_product](#module\_apim\_nodo\_dei\_pagamenti\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.84 |
| <a name="module_apim_nodo_fatturazione_api"></a> [apim\_nodo\_fatturazione\_api](#module\_apim\_nodo\_fatturazione\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_nodo_fatturazione_product"></a> [apim\_nodo\_fatturazione\_product](#module\_apim\_nodo\_fatturazione\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_nodo_oncloud_api"></a> [apim\_nodo\_oncloud\_api](#module\_apim\_nodo\_oncloud\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_nodo_oncloud_product"></a> [apim\_nodo\_oncloud\_product](#module\_apim\_nodo\_oncloud\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_nodo_per_pm_api_v1"></a> [apim\_nodo\_per\_pm\_api\_v1](#module\_apim\_nodo\_per\_pm\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.1.13 |
| <a name="module_apim_nodo_ppt_lmi_api"></a> [apim\_nodo\_ppt\_lmi\_api](#module\_apim\_nodo\_ppt\_lmi\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_nodo_ppt_lmi_product"></a> [apim\_nodo\_ppt\_lmi\_product](#module\_apim\_nodo\_ppt\_lmi\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_nodo_sync_api"></a> [apim\_nodo\_sync\_api](#module\_apim\_nodo\_sync\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_nodo_sync_product"></a> [apim\_nodo\_sync\_product](#module\_apim\_nodo\_sync\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_nodo_web_bo_api"></a> [apim\_nodo\_web\_bo\_api](#module\_apim\_nodo\_web\_bo\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_nodo_web_bo_product"></a> [apim\_nodo\_web\_bo\_product](#module\_apim\_nodo\_web\_bo\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_nodo_wfesp_api"></a> [apim\_nodo\_wfesp\_api](#module\_apim\_nodo\_wfesp\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_nodo_wfesp_product"></a> [apim\_nodo\_wfesp\_product](#module\_apim\_nodo\_wfesp\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_payment_manager_product"></a> [apim\_payment\_manager\_product](#module\_apim\_payment\_manager\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_pm_adminpanel_api_v1"></a> [apim\_pm\_adminpanel\_api\_v1](#module\_apim\_pm\_adminpanel\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_pm_bpd_api_v1"></a> [apim\_pm\_bpd\_api\_v1](#module\_apim\_pm\_bpd\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_pm_cobadge_api_v4"></a> [apim\_pm\_cobadge\_api\_v4](#module\_apim\_pm\_cobadge\_api\_v4) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_pm_fesp_api_v1"></a> [apim\_pm\_fesp\_api\_v1](#module\_apim\_pm\_fesp\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_pm_logging_api_v1"></a> [apim\_pm\_logging\_api\_v1](#module\_apim\_pm\_logging\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_pm_paypalpsp_api_v1"></a> [apim\_pm\_paypalpsp\_api\_v1](#module\_apim\_pm\_paypalpsp\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_pm_ptg_api_v1"></a> [apim\_pm\_ptg\_api\_v1](#module\_apim\_pm\_ptg\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_pm_restapi_api_v4"></a> [apim\_pm\_restapi\_api\_v4](#module\_apim\_pm\_restapi\_api\_v4) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_pm_restapi_cd_assets"></a> [apim\_pm\_restapi\_cd\_assets](#module\_apim\_pm\_restapi\_cd\_assets) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_pm_restapi_server_api_v4"></a> [apim\_pm\_restapi\_server\_api\_v4](#module\_apim\_pm\_restapi\_server\_api\_v4) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_pm_restapicd_api_v1"></a> [apim\_pm\_restapicd\_api\_v1](#module\_apim\_pm\_restapicd\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_pm_restapicd_api_v2"></a> [apim\_pm\_restapicd\_api\_v2](#module\_apim\_pm\_restapicd\_api\_v2) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_pm_restapicd_api_v3"></a> [apim\_pm\_restapicd\_api\_v3](#module\_apim\_pm\_restapicd\_api\_v3) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_pm_restapirtd_api_v1"></a> [apim\_pm\_restapirtd\_api\_v1](#module\_apim\_pm\_restapirtd\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_pm_restapirtd_api_v2"></a> [apim\_pm\_restapirtd\_api\_v2](#module\_apim\_pm\_restapirtd\_api\_v2) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_pm_satispay_api_v1"></a> [apim\_pm\_satispay\_api\_v1](#module\_apim\_pm\_satispay\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_pm_wisp_api_v1"></a> [apim\_pm\_wisp\_api\_v1](#module\_apim\_pm\_wisp\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_pm_xpay_api_v1"></a> [apim\_pm\_xpay\_api\_v1](#module\_apim\_pm\_xpay\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_pmclient_iobpd_api_v1"></a> [apim\_pmclient\_iobpd\_api\_v1](#module\_apim\_pmclient\_iobpd\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_snet"></a> [apim\_snet](#module\_apim\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.51 |
| <a name="module_apim_tkm_acquirer_manager_api_v1"></a> [apim\_tkm\_acquirer\_manager\_api\_v1](#module\_apim\_tkm\_acquirer\_manager\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_tkm_card_manager_api_v1"></a> [apim\_tkm\_card\_manager\_api\_v1](#module\_apim\_tkm\_card\_manager\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_tkm_consent_manager_api_v1"></a> [apim\_tkm\_consent\_manager\_api\_v1](#module\_apim\_tkm\_consent\_manager\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_tkm_product"></a> [apim\_tkm\_product](#module\_apim\_tkm\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.84 |
| <a name="module_app_gw"></a> [app\_gw](#module\_app\_gw) | git::https://github.com/pagopa/azurerm.git//app_gateway | v2.1.20 |
| <a name="module_appgateway_snet"></a> [appgateway\_snet](#module\_appgateway\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.51 |
| <a name="module_azdoa_li"></a> [azdoa\_li](#module\_azdoa\_li) | git::https://github.com/pagopa/azurerm.git//azure_devops_agent | v1.0.57 |
| <a name="module_azdoa_snet"></a> [azdoa\_snet](#module\_azdoa\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.3 |
| <a name="module_buyerbanks_function"></a> [buyerbanks\_function](#module\_buyerbanks\_function) | git::https://github.com/pagopa/azurerm.git//function_app | v2.2.0 |
| <a name="module_buyerbanks_function_snet"></a> [buyerbanks\_function\_snet](#module\_buyerbanks\_function\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.51 |
| <a name="module_buyerbanks_storage"></a> [buyerbanks\_storage](#module\_buyerbanks\_storage) | git::https://github.com/pagopa/azurerm.git//storage_account | v2.0.13 |
| <a name="module_canoneunico_function"></a> [canoneunico\_function](#module\_canoneunico\_function) | git::https://github.com/pagopa/azurerm.git//function_app | v2.2.0 |
| <a name="module_canoneunico_function_snet"></a> [canoneunico\_function\_snet](#module\_canoneunico\_function\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.51 |
| <a name="module_checkout_cdn"></a> [checkout\_cdn](#module\_checkout\_cdn) | git::https://github.com/pagopa/azurerm.git//cdn | v2.0.18 |
| <a name="module_checkout_function"></a> [checkout\_function](#module\_checkout\_function) | git::https://github.com/pagopa/azurerm.git//function_app | v2.2.0 |
| <a name="module_checkout_function_snet"></a> [checkout\_function\_snet](#module\_checkout\_function\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.51 |
| <a name="module_common_private_endpoint_snet"></a> [common\_private\_endpoint\_snet](#module\_common\_private\_endpoint\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v2.0.19 |
| <a name="module_container_registry"></a> [container\_registry](#module\_container\_registry) | git::https://github.com/pagopa/azurerm.git//container_registry | v2.14.1 |
| <a name="module_cu_sa"></a> [cu\_sa](#module\_cu\_sa) | git::https://github.com/pagopa/azurerm.git//storage_account | v2.0.13 |
| <a name="module_dns_forwarder"></a> [dns\_forwarder](#module\_dns\_forwarder) | git::https://github.com/pagopa/azurerm.git//dns_forwarder | v2.0.8 |
| <a name="module_dns_forwarder_snet"></a> [dns\_forwarder\_snet](#module\_dns\_forwarder\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v2.0.3 |
| <a name="module_event_hub01"></a> [event\_hub01](#module\_event\_hub01) | git::https://github.com/pagopa/azurerm.git//eventhub | v1.0.66 |
| <a name="module_eventhub_snet"></a> [eventhub\_snet](#module\_eventhub\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.7 |
| <a name="module_fdr_flows_sa"></a> [fdr\_flows\_sa](#module\_fdr\_flows\_sa) | git::https://github.com/pagopa/azurerm.git//storage_account | v2.0.13 |
| <a name="module_flows"></a> [flows](#module\_flows) | git::https://github.com/pagopa/azurerm.git//storage_account | v2.0.13 |
| <a name="module_gpd_app_service"></a> [gpd\_app\_service](#module\_gpd\_app\_service) | git::https://github.com/pagopa/azurerm.git//app_service | v2.8.0 |
| <a name="module_gpd_app_service_slot_staging"></a> [gpd\_app\_service\_slot\_staging](#module\_gpd\_app\_service\_slot\_staging) | git::https://github.com/pagopa/azurerm.git//app_service_slot | v2.2.0 |
| <a name="module_gpd_snet"></a> [gpd\_snet](#module\_gpd\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.51 |
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | git::https://github.com/pagopa/azurerm.git//key_vault | v1.0.90 |
| <a name="module_mock_ec"></a> [mock\_ec](#module\_mock\_ec) | git::https://github.com/pagopa/azurerm.git//app_service | v1.0.14 |
| <a name="module_mock_ec_snet"></a> [mock\_ec\_snet](#module\_mock\_ec\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.51 |
| <a name="module_mock_psp"></a> [mock\_psp](#module\_mock\_psp) | git::https://github.com/pagopa/azurerm.git//app_service | v1.0.14 |
| <a name="module_mock_psp_snet"></a> [mock\_psp\_snet](#module\_mock\_psp\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.51 |
| <a name="module_monitor"></a> [monitor](#module\_monitor) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_nat_gw"></a> [nat\_gw](#module\_nat\_gw) | git::https://github.com/pagopa/azurerm.git//nat_gateway | v1.0.77 |
| <a name="module_nodo_test_storage"></a> [nodo\_test\_storage](#module\_nodo\_test\_storage) | git::https://github.com/pagopa/azurerm.git//storage_account | v2.1.13 |
| <a name="module_pagopa_proxy_app_service"></a> [pagopa\_proxy\_app\_service](#module\_pagopa\_proxy\_app\_service) | git::https://github.com/pagopa/azurerm.git//app_service | v2.0.28 |
| <a name="module_pagopa_proxy_app_service_slot_staging"></a> [pagopa\_proxy\_app\_service\_slot\_staging](#module\_pagopa\_proxy\_app\_service\_slot\_staging) | git::https://github.com/pagopa/azurerm.git//app_service_slot | v2.0.28 |
| <a name="module_pagopa_proxy_redis"></a> [pagopa\_proxy\_redis](#module\_pagopa\_proxy\_redis) | git::https://github.com/pagopa/azurerm.git//redis_cache | v2.0.19 |
| <a name="module_pagopa_proxy_redis_snet"></a> [pagopa\_proxy\_redis\_snet](#module\_pagopa\_proxy\_redis\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v2.0.19 |
| <a name="module_pagopa_proxy_snet"></a> [pagopa\_proxy\_snet](#module\_pagopa\_proxy\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v2.0.19 |
| <a name="module_payments_app_service"></a> [payments\_app\_service](#module\_payments\_app\_service) | git::https://github.com/pagopa/azurerm.git//app_service | v2.8.0 |
| <a name="module_payments_app_service_slot_staging"></a> [payments\_app\_service\_slot\_staging](#module\_payments\_app\_service\_slot\_staging) | git::https://github.com/pagopa/azurerm.git//app_service_slot | v2.2.0 |
| <a name="module_payments_receipt"></a> [payments\_receipt](#module\_payments\_receipt) | git::https://github.com/pagopa/azurerm.git//storage_account | v2.8.0 |
| <a name="module_postgres_flexible_server_private"></a> [postgres\_flexible\_server\_private](#module\_postgres\_flexible\_server\_private) | git::https://github.com/pagopa/azurerm.git//postgres_flexible_server | v2.8.1 |
| <a name="module_postgres_flexible_snet"></a> [postgres\_flexible\_snet](#module\_postgres\_flexible\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v2.1.13 |
| <a name="module_postgresql"></a> [postgresql](#module\_postgresql) | git::https://github.com/pagopa/azurerm.git//postgresql_server | v2.0.5 |
| <a name="module_postgresql_snet"></a> [postgresql\_snet](#module\_postgresql\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.7 |
| <a name="module_redis"></a> [redis](#module\_redis) | git::https://github.com/pagopa/azurerm.git//redis_cache | v1.0.37 |
| <a name="module_redis_snet"></a> [redis\_snet](#module\_redis\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.51 |
| <a name="module_reporting_analysis_function"></a> [reporting\_analysis\_function](#module\_reporting\_analysis\_function) | git::https://github.com/pagopa/azurerm.git//function_app | v2.2.0 |
| <a name="module_reporting_analysis_function_slot_staging"></a> [reporting\_analysis\_function\_slot\_staging](#module\_reporting\_analysis\_function\_slot\_staging) | git::https://github.com/pagopa/azurerm.git//function_app_slot | v2.2.0 |
| <a name="module_reporting_batch_function"></a> [reporting\_batch\_function](#module\_reporting\_batch\_function) | git::https://github.com/pagopa/azurerm.git//function_app | v2.2.0 |
| <a name="module_reporting_batch_function_slot_staging"></a> [reporting\_batch\_function\_slot\_staging](#module\_reporting\_batch\_function\_slot\_staging) | git::https://github.com/pagopa/azurerm.git//function_app_slot | v2.2.0 |
| <a name="module_reporting_fdr_function"></a> [reporting\_fdr\_function](#module\_reporting\_fdr\_function) | git::https://github.com/pagopa/azurerm.git//function_app | v2.2.0 |
| <a name="module_reporting_fdr_function_snet"></a> [reporting\_fdr\_function\_snet](#module\_reporting\_fdr\_function\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.51 |
| <a name="module_reporting_function_snet"></a> [reporting\_function\_snet](#module\_reporting\_function\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.51 |
| <a name="module_reporting_service_function"></a> [reporting\_service\_function](#module\_reporting\_service\_function) | git::https://github.com/pagopa/azurerm.git//function_app | v2.2.0 |
| <a name="module_reporting_service_function_slot_staging"></a> [reporting\_service\_function\_slot\_staging](#module\_reporting\_service\_function\_slot\_staging) | git::https://github.com/pagopa/azurerm.git//function_app_slot | v2.2.0 |
| <a name="module_route_table_peering_sia"></a> [route\_table\_peering\_sia](#module\_route\_table\_peering\_sia) | git::https://github.com/pagopa/azurerm.git//route_table | v1.0.25 |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | git::https://github.com/pagopa/azurerm.git//virtual_network | v1.0.51 |
| <a name="module_vnet_integration"></a> [vnet\_integration](#module\_vnet\_integration) | git::https://github.com/pagopa/azurerm.git//virtual_network | v1.0.51 |
| <a name="module_vnet_peering"></a> [vnet\_peering](#module\_vnet\_peering) | git::https://github.com/pagopa/azurerm.git//virtual_network_peering | v1.0.30 |
| <a name="module_vpn"></a> [vpn](#module\_vpn) | git::https://github.com/pagopa/azurerm.git//vpn_gateway | v2.0.11 |
| <a name="module_vpn_snet"></a> [vpn\_snet](#module\_vpn\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.58 |
| <a name="module_web_test_api"></a> [web\_test\_api](#module\_web\_test\_api) | git::https://github.com/pagopa/azurerm.git//application_insights_web_test_preview | v2.12.2 |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_api.apim_api_donazioni_ucraina_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_api_gpd_payments_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_cd_info_wisp_v1](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_node_for_io_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_node_for_psp_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_nodo_per_pa_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_nodo_per_psp_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_nodo_per_psp_richiesta_avvisi_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_psp_for_node_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api_diagnostic.apim_logs](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_diagnostic) | resource |
| [azurerm_api_management_api_operation_policy.activate_payment_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.donazioni_activate_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.donazioni_sendrt_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.donazioni_verify_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.fdr_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.get_donations](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.get_payment_info_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.get_spid_metadata_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.nm3_activate_verify_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.send_payment_result_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.updata_status_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_policy.apim_cd_info_wisp_policy_v1](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_node_for_donazioni_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_node_for_io_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_node_for_psp_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_nodo_per_pa_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_nodo_per_psp_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_nodo_per_psp_richiesta_avvisi_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_psp_for_node_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_version_set.api_config_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_config_checkout_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_donations_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_donazioni_ucraina_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_gpd_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_gpd_payments_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_gpd_payments_rest_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_gpd_reporting_analysis_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_pm_bpd_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_pm_cobadge_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_pm_fesp_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_pm_paypalpsp_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_pm_satispay_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_pm_xpay_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.buyerbanks_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.cd_info_wisp](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.checkout_payment_activations_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.checkout_payment_activations_auth_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.checkout_transactions_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.mock_ec_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.node_for_io_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.node_for_psp_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_fatturazione_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_oncloud_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_per_pa_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_per_pm_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_per_psp_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_per_psp_richiesta_avvisi_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_ppt_lmi_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_sync_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_wfesp_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pm_adminpanel_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pm_ptg_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pm_restapi_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pm_restapi_server_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pm_restapicd_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pm_restapirtd_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pmclient_iobpd_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.psp_for_node_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.tkm_acquirer_manager_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.tkm_card_manager_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.tkm_consent_manager_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_authorization_server.apiconfig-oauth2](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_authorization_server) | resource |
| [azurerm_api_management_custom_domain.api_custom_domain](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_custom_domain) | resource |
| [azurerm_api_management_group.centro_stella](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.checkout_rate_limit_300](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.checkout_rate_no_limit](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.client_io](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.pda](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.piattaforma_notifiche](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.readonly](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_group) | resource |
| [azurerm_api_management_named_value.aks_lb_nexi](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_fatturazione](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_oncloud](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_ppt_lmi](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_sync](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_web_bo](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.base_path_nodo_wfesp](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.brokerlist_value](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.checkout_google_recaptcha_secret](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.donazioni_config_name](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.ecblacklist_value](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.fdrcontainername](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.fdrsaname](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.io_backend_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.ip_nodo_value](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pagopa_appservice_proxy_url_value](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pagopa_fn_buyerbanks_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pagopa_fn_buyerbanks_url_value](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pagopa_fn_checkout_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pagopa_fn_checkout_url_value](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pagopa_mock_services_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pm_gtw_hostname](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.urlnodo_value](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_product_api.apim_cd_info_wisp_product_v1](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_product_api) | resource |
| [azurerm_api_management_product_api.apim_nodo_dei_pagamenti_product_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/api_management_product_api) | resource |
| [azurerm_app_service_plan.canoneunico_service_plan](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/app_service_plan) | resource |
| [azurerm_app_service_plan.gpd_reporting_service_plan](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/app_service_plan) | resource |
| [azurerm_app_service_plan.gpd_service_plan](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/app_service_plan) | resource |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/application_insights) | resource |
| [azurerm_application_insights_web_test.checkout_fe_web_test](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/application_insights_web_test) | resource |
| [azurerm_dns_a_record.dns_a_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.dns_a_management](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.dns_a_portal](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/dns_a_record) | resource |
| [azurerm_dns_caa_record.api_platform_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/dns_caa_record) | resource |
| [azurerm_dns_caa_record.checkout_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/dns_caa_record) | resource |
| [azurerm_dns_ns_record.dev_checkout](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ns_record.dev_pagopa_it_ns](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ns_record.uat_checkout](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ns_record.uat_pagopa_it_ns](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_zone.checkout_public](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/dns_zone) | resource |
| [azurerm_dns_zone.public](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/dns_zone) | resource |
| [azurerm_key_vault_access_policy.ad_group_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_developers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_externals_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_security_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.api_management_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.app_gateway_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azure_cdn_frontdoor_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_certificate.buyerbanks_cert](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/key_vault_certificate) | resource |
| [azurerm_log_analytics_workspace.log_analytics_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/log_analytics_workspace) | resource |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_autoscale_setting.apiconfig_app_service_autoscale](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.buyerbanks_function](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.canoneunico_function](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.checkout_function](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.gpd_app_service_autoscale](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.pagopa_proxy_app_service_autoscale](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.reporting_fdr_function](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.reporting_function](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_diagnostic_setting.activity_log](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_metric_alert.checkout_fn_5xx](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.apiconfig_db_healthcheck](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.buyerbanks_update_alert](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.canoneunico_gpd_error](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.canoneunico_parsing_csv_error](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.checkout_availability](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.payments_gpd_inconsistency_error](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.reporting_nodo_chiedi_elenco_flussi_rendicontazione_error](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.reporting_nodo_chiedi_flusso_rendicontazione_error](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.reporting_update_option_error](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_postgresql_database.apd_db](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/postgresql_database) | resource |
| [azurerm_postgresql_database.this](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/postgresql_database) | resource |
| [azurerm_postgresql_flexible_server_configuration.apd_db_flex_ignore_startup_parameters](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_configuration.apd_db_flex_min_pool_size](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_database.apd_db_flex](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/postgresql_flexible_server_database) | resource |
| [azurerm_private_dns_a_record.platform_dns_a_private](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.private_dns_a_record_db_nodo](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_zone.db_nodo_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.platform_private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.postgres](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_azurecr_pagopa](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_postgres_database_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_redis_cache_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.db_nodo_dns_zone_virtual_link](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.platform_vnetlink_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.platform_vnetlink_vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.postgres_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_postgres_database_azure_com_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_redis_cache_windows_net_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_public_ip.appgateway_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/public_ip) | resource |
| [azurerm_resource_group.api_config_fe_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.api_config_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.azdo_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.buyerbanks_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.canoneunico_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.checkout_be_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.checkout_fe_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.container_registry_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.data](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.default_roleassignment_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.flex_data](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.gpd_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.mock_ec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.mock_psp_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.msg_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.nodo_pagamenti_test_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.pagopa_proxy_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.reporting_fdr_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_aks](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.data_contributor_role](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/role_assignment) | resource |
| [azurerm_storage_container.banks](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/storage_container) | resource |
| [azurerm_storage_container.err_csv_blob_container](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/storage_container) | resource |
| [azurerm_storage_container.fdr_rend_flow](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/storage_container) | resource |
| [azurerm_storage_container.fdr_rend_flow_out](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/storage_container) | resource |
| [azurerm_storage_container.in_csv_blob_container](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/storage_container) | resource |
| [azurerm_storage_container.out_csv_blob_container](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/storage_container) | resource |
| [azurerm_storage_container.reporting_flows_container](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/storage_container) | resource |
| [azurerm_storage_management_policy.buyerbanks_storage_lifeclycle_policies](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/storage_management_policy) | resource |
| [azurerm_storage_queue.cu_debtposition_queue](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.reporting_flows_queue](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.reporting_options_queue](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.reporting_organizations_queue](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/storage_queue) | resource |
| [azurerm_storage_table.cu_debtposition_table](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/storage_table) | resource |
| [azurerm_storage_table.cu_ecconfig_table](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/storage_table) | resource |
| [azurerm_storage_table.cu_iuvs_table](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/storage_table) | resource |
| [azurerm_storage_table.payments_receipts_table](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/storage_table) | resource |
| [azurerm_storage_table.reporting_flows_table](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/storage_table) | resource |
| [azurerm_storage_table.reporting_organizations_table](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/storage_table) | resource |
| [azurerm_user_assigned_identity.appgateway](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/resources/user_assigned_identity) | resource |
| [null_resource.change_auth_fdr_blob_container](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [azuread_application.apiconfig-be](https://registry.terraform.io/providers/hashicorp/azuread/2.6.0/docs/data-sources/application) | data source |
| [azuread_application.apiconfig-fe](https://registry.terraform.io/providers/hashicorp/azuread/2.6.0/docs/data-sources/application) | data source |
| [azuread_application.vpn_app](https://registry.terraform.io/providers/hashicorp/azuread/2.6.0/docs/data-sources/application) | data source |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/2.6.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/2.6.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/2.6.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/2.6.0/docs/data-sources/group) | data source |
| [azuread_service_principal.iac_principal](https://registry.terraform.io/providers/hashicorp/azuread/2.6.0/docs/data-sources/service_principal) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/client_config) | data source |
| [azurerm_key_vault_certificate.app_gw_platform](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.management_platform](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.portal_platform](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_secret.apiconfig-client-secret](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.apim_publisher_email](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.db_administrator_login](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.db_administrator_login_password](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.db_mock_psp_user_login](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.db_mock_psp_user_login_password](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.db_nodo_pwd](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.db_nodo_usr](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.fn_buyerbanks_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.fn_checkout_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.google_recaptcha_secret](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.gpd_db_pwd](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.gpd_db_usr](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.gpd_paa_pwd](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.io_backend_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.mock_services_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_notification_email](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_notification_slack_email](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pagopa_buyerbank_cert_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pagopa_buyerbank_cert_peer](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pagopa_buyerbank_signature](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pagopa_buyerbank_thumbprint](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pagopa_buyerbank_thumbprint_peer](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pagopaproxy_node_clients_config](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pgres_flex_admin_login](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pgres_flex_admin_pwd](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pm_gtw_hostname](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pm_logging_ip](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pm_restapi_ip](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pm_restapirtd_ip](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pm_wisp_metadata](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.sec_storage_id](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.sec_workspace_id](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.92.0/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_publisher_name"></a> [apim\_publisher\_name](#input\_apim\_publisher\_name) | apim | `string` | n/a | yes |
| <a name="input_apim_sku"></a> [apim\_sku](#input\_apim\_sku) | n/a | `string` | n/a | yes |
| <a name="input_app_gateway_api_certificate_name"></a> [app\_gateway\_api\_certificate\_name](#input\_app\_gateway\_api\_certificate\_name) | Application gateway api certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_management_certificate_name"></a> [app\_gateway\_management\_certificate\_name](#input\_app\_gateway\_management\_certificate\_name) | Application gateway api management certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_portal_certificate_name"></a> [app\_gateway\_portal\_certificate\_name](#input\_app\_gateway\_portal\_certificate\_name) | Application gateway developer portal certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_sku_name"></a> [app\_gateway\_sku\_name](#input\_app\_gateway\_sku\_name) | The Name of the SKU to use for this Application Gateway. Possible values are Standard\_Small, Standard\_Medium, Standard\_Large, Standard\_v2, WAF\_Medium, WAF\_Large, and WAF\_v2 | `string` | n/a | yes |
| <a name="input_app_gateway_sku_tier"></a> [app\_gateway\_sku\_tier](#input\_app\_gateway\_sku\_tier) | The Tier of the SKU to use for this Application Gateway. Possible values are Standard, Standard\_v2, WAF and WAF\_v2 | `string` | n/a | yes |
| <a name="input_cidr_common_private_endpoint_snet"></a> [cidr\_common\_private\_endpoint\_snet](#input\_cidr\_common\_private\_endpoint\_snet) | Common Private Endpoint network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_appgateway"></a> [cidr\_subnet\_appgateway](#input\_cidr\_subnet\_appgateway) | Application gateway address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_azdoa"></a> [cidr\_subnet\_azdoa](#input\_cidr\_subnet\_azdoa) | Azure DevOps agent network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_dns_forwarder"></a> [cidr\_subnet\_dns\_forwarder](#input\_cidr\_subnet\_dns\_forwarder) | DNS Forwarder network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_pg_flex_dbms"></a> [cidr\_subnet\_pg\_flex\_dbms](#input\_cidr\_subnet\_pg\_flex\_dbms) | Postgres Flexible Server network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_vpn"></a> [cidr\_subnet\_vpn](#input\_cidr\_subnet\_vpn) | VPN network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_vnet"></a> [cidr\_vnet](#input\_cidr\_vnet) | Virtual network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_vnet_integration"></a> [cidr\_vnet\_integration](#input\_cidr\_vnet\_integration) | Virtual network to peer with sia subscription. It should host apim | `list(string)` | n/a | yes |
| <a name="input_cname_record_name"></a> [cname\_record\_name](#input\_cname\_record\_name) | n/a | `string` | n/a | yes |
| <a name="input_cstar_outbound_ip_1"></a> [cstar\_outbound\_ip\_1](#input\_cstar\_outbound\_ip\_1) | CSTAR ip 1 | `string` | n/a | yes |
| <a name="input_cstar_outbound_ip_2"></a> [cstar\_outbound\_ip\_2](#input\_cstar\_outbound\_ip\_2) | CSTAR ip 2 | `string` | n/a | yes |
| <a name="input_enable_azdoa"></a> [enable\_azdoa](#input\_enable\_azdoa) | Enable Azure DevOps agent. | `bool` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_ip_nodo"></a> [ip\_nodo](#input\_ip\_nodo) | Nodo pagamenti ip | `string` | n/a | yes |
| <a name="input_postgresql_sku_name"></a> [postgresql\_sku\_name](#input\_postgresql\_sku\_name) | Specifies the SKU Name for this PostgreSQL Server. | `string` | n/a | yes |
| <a name="input_xsd_ica"></a> [xsd\_ica](#input\_xsd\_ica) | XML Schema of Informatica Conto Accredito | `string` | n/a | yes |
| <a name="input_acr_enabled"></a> [acr\_enabled](#input\_acr\_enabled) | Container registry enabled | `bool` | `false` | no |
| <a name="input_allow_blob_public_access"></a> [allow\_blob\_public\_access](#input\_allow\_blob\_public\_access) | Allow or disallow public access to all blobs or containers in the storage account. | `bool` | `false` | no |
| <a name="input_api_config_always_on"></a> [api\_config\_always\_on](#input\_api\_config\_always\_on) | Api Config always on property | `bool` | `true` | no |
| <a name="input_api_config_fe_enabled"></a> [api\_config\_fe\_enabled](#input\_api\_config\_fe\_enabled) | Api Config FE enabled | `bool` | `false` | no |
| <a name="input_api_config_size"></a> [api\_config\_size](#input\_api\_config\_size) | Api Config Plan size | `string` | `"S1"` | no |
| <a name="input_api_config_tier"></a> [api\_config\_tier](#input\_api\_config\_tier) | Api config Plan tier | `string` | `"Standard"` | no |
| <a name="input_apiconfig_logging_level"></a> [apiconfig\_logging\_level](#input\_apiconfig\_logging\_level) | Logging level of Api Config | `string` | `"INFO"` | no |
| <a name="input_apim_alerts_enabled"></a> [apim\_alerts\_enabled](#input\_apim\_alerts\_enabled) | Enable alerts | `bool` | `true` | no |
| <a name="input_apim_autoscale"></a> [apim\_autoscale](#input\_apim\_autoscale) | Configure Apim autoscale on capacity metric | <pre>object(<br>    {<br>      enabled                       = bool<br>      default_instances             = number<br>      minimum_instances             = number<br>      maximum_instances             = number<br>      scale_out_capacity_percentage = number<br>      scale_out_time_window         = string<br>      scale_out_value               = string<br>      scale_out_cooldown            = string<br>      scale_in_capacity_percentage  = number<br>      scale_in_time_window          = string<br>      scale_in_value                = string<br>      scale_in_cooldown             = string<br>    }<br>  )</pre> | <pre>{<br>  "default_instances": 1,<br>  "enabled": false,<br>  "maximum_instances": 5,<br>  "minimum_instances": 1,<br>  "scale_in_capacity_percentage": 30,<br>  "scale_in_cooldown": "PT30M",<br>  "scale_in_time_window": "PT30M",<br>  "scale_in_value": "1",<br>  "scale_out_capacity_percentage": 60,<br>  "scale_out_cooldown": "PT45M",<br>  "scale_out_time_window": "PT10M",<br>  "scale_out_value": "2"<br>}</pre> | no |
| <a name="input_app_gateway_alerts_enabled"></a> [app\_gateway\_alerts\_enabled](#input\_app\_gateway\_alerts\_enabled) | Enable alerts | `bool` | `true` | no |
| <a name="input_app_gateway_deny_paths"></a> [app\_gateway\_deny\_paths](#input\_app\_gateway\_deny\_paths) | Deny paths on app gateway | `list(string)` | `[]` | no |
| <a name="input_app_gateway_max_capacity"></a> [app\_gateway\_max\_capacity](#input\_app\_gateway\_max\_capacity) | n/a | `number` | `2` | no |
| <a name="input_app_gateway_min_capacity"></a> [app\_gateway\_min\_capacity](#input\_app\_gateway\_min\_capacity) | n/a | `number` | `0` | no |
| <a name="input_app_gateway_waf_enabled"></a> [app\_gateway\_waf\_enabled](#input\_app\_gateway\_waf\_enabled) | Enable waf | `bool` | `true` | no |
| <a name="input_azdo_sp_tls_cert_enabled"></a> [azdo\_sp\_tls\_cert\_enabled](#input\_azdo\_sp\_tls\_cert\_enabled) | Enable Azure DevOps connection for TLS cert management | `string` | `false` | no |
| <a name="input_azuread_service_principal_azure_cdn_frontdoor_id"></a> [azuread\_service\_principal\_azure\_cdn\_frontdoor\_id](#input\_azuread\_service\_principal\_azure\_cdn\_frontdoor\_id) | Azure CDN Front Door Principal ID | `string` | `"f3b3f72f-4770-47a5-8c1e-aa298003be12"` | no |
| <a name="input_base_path_nodo_fatturazione"></a> [base\_path\_nodo\_fatturazione](#input\_base\_path\_nodo\_fatturazione) | base nodo on cloud | `string` | `"/fatturazione-sit"` | no |
| <a name="input_base_path_nodo_oncloud"></a> [base\_path\_nodo\_oncloud](#input\_base\_path\_nodo\_oncloud) | base nodo on cloud | `string` | `"/nodo-sit"` | no |
| <a name="input_base_path_nodo_ppt_lmi"></a> [base\_path\_nodo\_ppt\_lmi](#input\_base\_path\_nodo\_ppt\_lmi) | base nodo on cloud | `string` | `"/ppt-lmi-sit/"` | no |
| <a name="input_base_path_nodo_sync"></a> [base\_path\_nodo\_sync](#input\_base\_path\_nodo\_sync) | base nodo on cloud | `string` | `"/sync-cron-sit/syncWisp"` | no |
| <a name="input_base_path_nodo_web_bo"></a> [base\_path\_nodo\_web\_bo](#input\_base\_path\_nodo\_web\_bo) | base nodo on cloud | `string` | `"/web-bo-sit"` | no |
| <a name="input_base_path_nodo_wfesp"></a> [base\_path\_nodo\_wfesp](#input\_base\_path\_nodo\_wfesp) | base nodo on cloud | `string` | `"/wfesp-sit"` | no |
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
| <a name="input_cidr_subnet_api_config"></a> [cidr\_subnet\_api\_config](#input\_cidr\_subnet\_api\_config) | Address prefixes subnet api config | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_apim"></a> [cidr\_subnet\_apim](#input\_cidr\_subnet\_apim) | Address prefixes subnet api management. | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_buyerbanks"></a> [cidr\_subnet\_buyerbanks](#input\_cidr\_subnet\_buyerbanks) | Address prefixes subnet buyerbanks | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_canoneunico_common"></a> [cidr\_subnet\_canoneunico\_common](#input\_cidr\_subnet\_canoneunico\_common) | Address prefixes subnet canoneunico\_common function | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_checkout_be"></a> [cidr\_subnet\_checkout\_be](#input\_cidr\_subnet\_checkout\_be) | Address prefixes subnet checkout function | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_eventhub"></a> [cidr\_subnet\_eventhub](#input\_cidr\_subnet\_eventhub) | Address prefixes subnet eventhub | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_gpd"></a> [cidr\_subnet\_gpd](#input\_cidr\_subnet\_gpd) | Address prefixes subnet gpd service | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_mock_ec"></a> [cidr\_subnet\_mock\_ec](#input\_cidr\_subnet\_mock\_ec) | Address prefixes subnet mock ec | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_mock_psp"></a> [cidr\_subnet\_mock\_psp](#input\_cidr\_subnet\_mock\_psp) | Address prefixes subnet mock psp | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_pagopa_proxy"></a> [cidr\_subnet\_pagopa\_proxy](#input\_cidr\_subnet\_pagopa\_proxy) | Address prefixes subnet proxy | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_pagopa_proxy_redis"></a> [cidr\_subnet\_pagopa\_proxy\_redis](#input\_cidr\_subnet\_pagopa\_proxy\_redis) | Address prefixes subnet redis for pagopa proxy | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_postgresql"></a> [cidr\_subnet\_postgresql](#input\_cidr\_subnet\_postgresql) | Address prefixes subnet postgresql | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_redis"></a> [cidr\_subnet\_redis](#input\_cidr\_subnet\_redis) | Redis network address space. | `list(string)` | `[]` | no |
| <a name="input_cidr_subnet_reporting_common"></a> [cidr\_subnet\_reporting\_common](#input\_cidr\_subnet\_reporting\_common) | Address prefixes subnet reporting\_common function | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_reporting_fdr"></a> [cidr\_subnet\_reporting\_fdr](#input\_cidr\_subnet\_reporting\_fdr) | Address prefixes subnet reporting\_fdr function | `list(string)` | `null` | no |
| <a name="input_cobadge_hostname"></a> [cobadge\_hostname](#input\_cobadge\_hostname) | Cobadge hostname | `string` | `""` | no |
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
| <a name="input_enable_iac_pipeline"></a> [enable\_iac\_pipeline](#input\_enable\_iac\_pipeline) | If true create the key vault policy to allow used by azure devops iac pipelines. | `bool` | `false` | no |
| <a name="input_eventhub_enabled"></a> [eventhub\_enabled](#input\_eventhub\_enabled) | eventhub enable? | `bool` | `false` | no |
| <a name="input_eventhubs"></a> [eventhubs](#input\_eventhubs) | A list of event hubs to add to namespace. | <pre>list(object({<br>    name              = string<br>    partitions        = number<br>    message_retention = number<br>    consumers         = list(string)<br>    keys = list(object({<br>      name   = string<br>      listen = bool<br>      send   = bool<br>      manage = bool<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_fdr_advanced_threat_protection"></a> [fdr\_advanced\_threat\_protection](#input\_fdr\_advanced\_threat\_protection) | Enable contract threat advanced protection | `bool` | `false` | no |
| <a name="input_fdr_delete_retention_days"></a> [fdr\_delete\_retention\_days](#input\_fdr\_delete\_retention\_days) | Number of days to retain deleted. | `number` | `30` | no |
| <a name="input_fdr_enable_versioning"></a> [fdr\_enable\_versioning](#input\_fdr\_enable\_versioning) | Enable sa versioning | `bool` | `false` | no |
| <a name="input_fesp_hostname"></a> [fesp\_hostname](#input\_fesp\_hostname) | Fesp hostname | `string` | `""` | no |
| <a name="input_gpd_always_on"></a> [gpd\_always\_on](#input\_gpd\_always\_on) | Always on property | `bool` | `true` | no |
| <a name="input_gpd_autoscale_default"></a> [gpd\_autoscale\_default](#input\_gpd\_autoscale\_default) | The number of instances that are available for scaling if metrics are not available for evaluation. | `number` | `3` | no |
| <a name="input_gpd_autoscale_maximum"></a> [gpd\_autoscale\_maximum](#input\_gpd\_autoscale\_maximum) | The maximum number of instances for this resource. | `number` | `10` | no |
| <a name="input_gpd_autoscale_minimum"></a> [gpd\_autoscale\_minimum](#input\_gpd\_autoscale\_minimum) | The minimum number of instances for this resource. | `number` | `3` | no |
| <a name="input_gpd_cron_job_enable"></a> [gpd\_cron\_job\_enable](#input\_gpd\_cron\_job\_enable) | GPD cron job enable | `bool` | `false` | no |
| <a name="input_gpd_cron_schedule_expired_to"></a> [gpd\_cron\_schedule\_expired\_to](#input\_gpd\_cron\_schedule\_expired\_to) | GDP cron scheduling (NCRON example '*/55 * * * * *') | `string` | `null` | no |
| <a name="input_gpd_cron_schedule_valid_to"></a> [gpd\_cron\_schedule\_valid\_to](#input\_gpd\_cron\_schedule\_valid\_to) | GPD cron scheduling (NCRON example '*/35 * * * * *') | `string` | `null` | no |
| <a name="input_gpd_db_name"></a> [gpd\_db\_name](#input\_gpd\_db\_name) | Name of the DB to connect to | `string` | `"apd"` | no |
| <a name="input_gpd_dbms_port"></a> [gpd\_dbms\_port](#input\_gpd\_dbms\_port) | Port number of the DBMS | `number` | `5432` | no |
| <a name="input_gpd_enable_versioning"></a> [gpd\_enable\_versioning](#input\_gpd\_enable\_versioning) | Enable sa versioning | `bool` | `false` | no |
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
| <a name="input_gpd_reporting_advanced_threat_protection"></a> [gpd\_reporting\_advanced\_threat\_protection](#input\_gpd\_reporting\_advanced\_threat\_protection) | Enable contract threat advanced protection | `bool` | `false` | no |
| <a name="input_gpd_reporting_delete_retention_days"></a> [gpd\_reporting\_delete\_retention\_days](#input\_gpd\_reporting\_delete\_retention\_days) | Number of days to retain deleted. | `number` | `30` | no |
| <a name="input_gpd_reporting_schedule_batch"></a> [gpd\_reporting\_schedule\_batch](#input\_gpd\_reporting\_schedule\_batch) | Cron scheduling (NCRON example '*/45 * * * * *') | `string` | `"0 0 1 * * *"` | no |
| <a name="input_gpd_schema_name"></a> [gpd\_schema\_name](#input\_gpd\_schema\_name) | Name of the schema of the DB | `string` | `"apd"` | no |
| <a name="input_io_bpd_hostname"></a> [io\_bpd\_hostname](#input\_io\_bpd\_hostname) | IO BPD hostname | `string` | `""` | no |
| <a name="input_law_daily_quota_gb"></a> [law\_daily\_quota\_gb](#input\_law\_daily\_quota\_gb) | The workspace daily quota for ingestion in GB. | `number` | `-1` | no |
| <a name="input_law_retention_in_days"></a> [law\_retention\_in\_days](#input\_law\_retention\_in\_days) | The workspace data retention in days | `number` | `30` | no |
| <a name="input_law_sku"></a> [law\_sku](#input\_law\_sku) | Sku of the Log Analytics Workspace | `string` | `"PerGB2018"` | no |
| <a name="input_lb_aks"></a> [lb\_aks](#input\_lb\_aks) | IP load balancer AKS Nexi/SIA | `string` | `"0.0.0.0"` | no |
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
| <a name="input_nodo_ip_filter"></a> [nodo\_ip\_filter](#input\_nodo\_ip\_filter) | IP Node | `string` | `""` | no |
| <a name="input_nodo_pagamenti_ec"></a> [nodo\_pagamenti\_ec](#input\_nodo\_pagamenti\_ec) | EC' black list nodo pagamenti (separate comma list). | `string` | `","` | no |
| <a name="input_nodo_pagamenti_enabled"></a> [nodo\_pagamenti\_enabled](#input\_nodo\_pagamenti\_enabled) | nodo pagamenti enabled | `bool` | `false` | no |
| <a name="input_nodo_pagamenti_psp"></a> [nodo\_pagamenti\_psp](#input\_nodo\_pagamenti\_psp) | PSP' white list nodo pagamenti (separate comma list) . | `string` | `","` | no |
| <a name="input_nodo_pagamenti_test_enabled"></a> [nodo\_pagamenti\_test\_enabled](#input\_nodo\_pagamenti\_test\_enabled) | test del nodo dei pagamenti enabled | `bool` | `false` | no |
| <a name="input_nodo_pagamenti_url"></a> [nodo\_pagamenti\_url](#input\_nodo\_pagamenti\_url) | Nodo pagamenti url | `string` | `"https://"` | no |
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
| <a name="input_postgres_private_endpoint_enabled"></a> [postgres\_private\_endpoint\_enabled](#input\_postgres\_private\_endpoint\_enabled) | Private endpoint database enable? | `bool` | `false` | no |
| <a name="input_postgresql_alerts_enabled"></a> [postgresql\_alerts\_enabled](#input\_postgresql\_alerts\_enabled) | Database alerts enabled? | `bool` | `false` | no |
| <a name="input_postgresql_configuration"></a> [postgresql\_configuration](#input\_postgresql\_configuration) | PostgreSQL Server configuration | `map(string)` | `{}` | no |
| <a name="input_postgresql_connection_limit"></a> [postgresql\_connection\_limit](#input\_postgresql\_connection\_limit) | n/a | `number` | `-1` | no |
| <a name="input_postgresql_enable_replica"></a> [postgresql\_enable\_replica](#input\_postgresql\_enable\_replica) | Create a PostgreSQL Server Replica. | `bool` | `false` | no |
| <a name="input_postgresql_geo_redundant_backup_enabled"></a> [postgresql\_geo\_redundant\_backup\_enabled](#input\_postgresql\_geo\_redundant\_backup\_enabled) | Turn Geo-redundant server backups on/off. | `bool` | `false` | no |
| <a name="input_postgresql_name"></a> [postgresql\_name](#input\_postgresql\_name) | n/a | `string` | `null` | no |
| <a name="input_postgresql_network_rules"></a> [postgresql\_network\_rules](#input\_postgresql\_network\_rules) | Network rules restricting access to the postgresql server. | <pre>object({<br>    ip_rules                       = list(string)<br>    allow_access_to_azure_services = bool<br>  })</pre> | <pre>{<br>  "allow_access_to_azure_services": false,<br>  "ip_rules": []<br>}</pre> | no |
| <a name="input_postgresql_public_network_access_enabled"></a> [postgresql\_public\_network\_access\_enabled](#input\_postgresql\_public\_network\_access\_enabled) | database public | `bool` | `false` | no |
| <a name="input_postgresql_storage_mb"></a> [postgresql\_storage\_mb](#input\_postgresql\_storage\_mb) | Max storage allowed for a server | `number` | `5120` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"pagopa"` | no |
| <a name="input_private_dns_zone_db_nodo_pagamenti"></a> [private\_dns\_zone\_db\_nodo\_pagamenti](#input\_private\_dns\_zone\_db\_nodo\_pagamenti) | n/a | `string` | `"dev.db-nodo-pagamenti.com"` | no |
| <a name="input_prostgresql_db_mockpsp"></a> [prostgresql\_db\_mockpsp](#input\_prostgresql\_db\_mockpsp) | n/a | `string` | `null` | no |
| <a name="input_psql_password"></a> [psql\_password](#input\_psql\_password) | n/a | `string` | `null` | no |
| <a name="input_psql_username"></a> [psql\_username](#input\_psql\_username) | n/a | `string` | `null` | no |
| <a name="input_redis_cache_enabled"></a> [redis\_cache\_enabled](#input\_redis\_cache\_enabled) | redis cache enabled | `bool` | `false` | no |
| <a name="input_redis_capacity"></a> [redis\_capacity](#input\_redis\_capacity) | n/a | `number` | `1` | no |
| <a name="input_redis_family"></a> [redis\_family](#input\_redis\_family) | n/a | `string` | `"C"` | no |
| <a name="input_redis_private_endpoint_enabled"></a> [redis\_private\_endpoint\_enabled](#input\_redis\_private\_endpoint\_enabled) | Enable private endpoints for redis instances? | `bool` | `true` | no |
| <a name="input_redis_sku_name"></a> [redis\_sku\_name](#input\_redis\_sku\_name) | n/a | `string` | `"Standard"` | no |
| <a name="input_reporting_analysis_function_always_on"></a> [reporting\_analysis\_function\_always\_on](#input\_reporting\_analysis\_function\_always\_on) | Always on property | `bool` | `false` | no |
| <a name="input_reporting_batch_function_always_on"></a> [reporting\_batch\_function\_always\_on](#input\_reporting\_batch\_function\_always\_on) | Always on property | `bool` | `false` | no |
| <a name="input_reporting_fdr_function_always_on"></a> [reporting\_fdr\_function\_always\_on](#input\_reporting\_fdr\_function\_always\_on) | Always on property | `bool` | `false` | no |
| <a name="input_reporting_fdr_function_autoscale_default"></a> [reporting\_fdr\_function\_autoscale\_default](#input\_reporting\_fdr\_function\_autoscale\_default) | The number of instances that are available for scaling if metrics are not available for evaluation. | `number` | `1` | no |
| <a name="input_reporting_fdr_function_autoscale_maximum"></a> [reporting\_fdr\_function\_autoscale\_maximum](#input\_reporting\_fdr\_function\_autoscale\_maximum) | The maximum number of instances for this resource. | `number` | `3` | no |
| <a name="input_reporting_fdr_function_autoscale_minimum"></a> [reporting\_fdr\_function\_autoscale\_minimum](#input\_reporting\_fdr\_function\_autoscale\_minimum) | The minimum number of instances for this resource. | `number` | `1` | no |
| <a name="input_reporting_fdr_function_kind"></a> [reporting\_fdr\_function\_kind](#input\_reporting\_fdr\_function\_kind) | App service plan kind | `string` | `null` | no |
| <a name="input_reporting_fdr_function_sku_size"></a> [reporting\_fdr\_function\_sku\_size](#input\_reporting\_fdr\_function\_sku\_size) | App service plan sku size | `string` | `null` | no |
| <a name="input_reporting_fdr_function_sku_tier"></a> [reporting\_fdr\_function\_sku\_tier](#input\_reporting\_fdr\_function\_sku\_tier) | App service plan sku tier | `string` | `null` | no |
| <a name="input_reporting_function_autoscale_default"></a> [reporting\_function\_autoscale\_default](#input\_reporting\_function\_autoscale\_default) | The number of instances that are available for scaling if metrics are not available for evaluation. | `number` | `5` | no |
| <a name="input_reporting_function_autoscale_maximum"></a> [reporting\_function\_autoscale\_maximum](#input\_reporting\_function\_autoscale\_maximum) | The maximum number of instances for this resource. | `number` | `10` | no |
| <a name="input_reporting_function_autoscale_minimum"></a> [reporting\_function\_autoscale\_minimum](#input\_reporting\_function\_autoscale\_minimum) | The minimum number of instances for this resource. | `number` | `1` | no |
| <a name="input_reporting_service_function_always_on"></a> [reporting\_service\_function\_always\_on](#input\_reporting\_service\_function\_always\_on) | Always on property | `bool` | `false` | no |
| <a name="input_satispay_hostname"></a> [satispay\_hostname](#input\_satispay\_hostname) | Satispay hostname | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |
| <a name="input_users"></a> [users](#input\_users) | List of psql users with grants. | <pre>list(object({<br>    name = string<br>    grants = list(object({<br>      object_type = string<br>      database    = string<br>      schema      = string<br>      privileges  = list(string)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_vpn_pip_sku"></a> [vpn\_pip\_sku](#input\_vpn\_pip\_sku) | VPN GW PIP SKU | `string` | `"Basic"` | no |
| <a name="input_vpn_sku"></a> [vpn\_sku](#input\_vpn\_sku) | VPN Gateway SKU | `string` | `"VpnGw1"` | no |
| <a name="input_xpay_hostname"></a> [xpay\_hostname](#input\_xpay\_hostname) | Nexi xpay hostname | `string` | `""` | no |
| <a name="input_xsd_cdi"></a> [xsd\_cdi](#input\_xsd\_cdi) | XML Schema of Catalogo Dati Informativi | `string` | `"https://raw.githubusercontent.com/pagopa/pagopa-api/master/general/CatalogoDatiInformativiPSP.xsd"` | no |
| <a name="input_xsd_counterpart"></a> [xsd\_counterpart](#input\_xsd\_counterpart) | XML Schema of Tabelle delle Controparti | `string` | `"https://raw.githubusercontent.com/pagopa/pagopa-api/master/general/TabellaDelleControparti_1_0_8.xsd"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_registry_admin_password"></a> [container\_registry\_admin\_password](#output\_container\_registry\_admin\_password) | n/a |
| <a name="output_container_registry_admin_username"></a> [container\_registry\_admin\_username](#output\_container\_registry\_admin\_username) | n/a |
| <a name="output_container_registry_login_server"></a> [container\_registry\_login\_server](#output\_container\_registry\_login\_server) | # Container registry ## |
| <a name="output_nat_gw_outbound_ip_addresses"></a> [nat\_gw\_outbound\_ip\_addresses](#output\_nat\_gw\_outbound\_ip\_addresses) | n/a |
| <a name="output_nodo_test_sa_blob_connection_string"></a> [nodo\_test\_sa\_blob\_connection\_string](#output\_nodo\_test\_sa\_blob\_connection\_string) | n/a |
| <a name="output_nodo_test_sa_blob_host"></a> [nodo\_test\_sa\_blob\_host](#output\_nodo\_test\_sa\_blob\_host) | Blob storage |
| <a name="output_nodo_test_sa_connection_string"></a> [nodo\_test\_sa\_connection\_string](#output\_nodo\_test\_sa\_connection\_string) | n/a |
| <a name="output_nodo_test_sa_web_host"></a> [nodo\_test\_sa\_web\_host](#output\_nodo\_test\_sa\_web\_host) | n/a |
| <a name="output_sec_storage_id"></a> [sec\_storage\_id](#output\_sec\_storage\_id) | n/a |
| <a name="output_sec_workspace_id"></a> [sec\_workspace\_id](#output\_sec\_workspace\_id) | n/a |
| <a name="output_vnet_address_space"></a> [vnet\_address\_space](#output\_vnet\_address\_space) | n/a |
| <a name="output_vnet_integration_address_space"></a> [vnet\_integration\_address\_space](#output\_vnet\_integration\_address\_space) | n/a |
| <a name="output_vnet_integration_name"></a> [vnet\_integration\_name](#output\_vnet\_integration\_name) | n/a |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | n/a |
