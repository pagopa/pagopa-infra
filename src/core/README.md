
<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | <= 1.3.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | <= 2.6.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 2.99.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | <= 2.3.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.2.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | <= 3.4.3 |
| <a name="requirement_time"></a> [time](#requirement\_time) | <= 0.11.1 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | <= 4.0.5 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apim_api_donations_api"></a> [apim\_api\_donations\_api](#module\_apim\_api\_donations\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.1.13 |
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
| <a name="module_apim_pm_adminpanel_api_v1"></a> [apim\_pm\_adminpanel\_api\_v1](#module\_apim\_pm\_adminpanel\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_auth_rtd_api_v1"></a> [apim\_pm\_auth\_rtd\_api\_v1](#module\_apim\_pm\_auth\_rtd\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.18.3 |
| <a name="module_apim_pm_auth_rtd_api_v2"></a> [apim\_pm\_auth\_rtd\_api\_v2](#module\_apim\_pm\_auth\_rtd\_api\_v2) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.18.3 |
| <a name="module_apim_pm_bpd_api_v1"></a> [apim\_pm\_bpd\_api\_v1](#module\_apim\_pm\_bpd\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_cobadge_api_v4"></a> [apim\_pm\_cobadge\_api\_v4](#module\_apim\_pm\_cobadge\_api\_v4) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_events_v1"></a> [apim\_pm\_events\_v1](#module\_apim\_pm\_events\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_fesp_api_v1"></a> [apim\_pm\_fesp\_api\_v1](#module\_apim\_pm\_fesp\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_logging_api_v1"></a> [apim\_pm\_logging\_api\_v1](#module\_apim\_pm\_logging\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_paypalpsp_api_v1"></a> [apim\_pm\_paypalpsp\_api\_v1](#module\_apim\_pm\_paypalpsp\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_per_nodo_v1"></a> [apim\_pm\_per\_nodo\_v1](#module\_apim\_pm\_per\_nodo\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_per_nodo_v2"></a> [apim\_pm\_per\_nodo\_v2](#module\_apim\_pm\_per\_nodo\_v2) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_restapi_api_old_v4"></a> [apim\_pm\_restapi\_api\_old\_v4](#module\_apim\_pm\_restapi\_api\_old\_v4) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.18.3 |
| <a name="module_apim_pm_restapi_api_v4"></a> [apim\_pm\_restapi\_api\_v4](#module\_apim\_pm\_restapi\_api\_v4) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.18.3 |
| <a name="module_apim_pm_restapi_cd_assets"></a> [apim\_pm\_restapi\_cd\_assets](#module\_apim\_pm\_restapi\_cd\_assets) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_restapi_server_api_v4"></a> [apim\_pm\_restapi\_server\_api\_v4](#module\_apim\_pm\_restapi\_server\_api\_v4) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_restapicd_api_v1"></a> [apim\_pm\_restapicd\_api\_v1](#module\_apim\_pm\_restapicd\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.18.3 |
| <a name="module_apim_pm_restapicd_api_v2"></a> [apim\_pm\_restapicd\_api\_v2](#module\_apim\_pm\_restapicd\_api\_v2) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.18.3 |
| <a name="module_apim_pm_restapicd_api_v3"></a> [apim\_pm\_restapicd\_api\_v3](#module\_apim\_pm\_restapicd\_api\_v3) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.18.3 |
| <a name="module_apim_pm_restapirtd_api_v1"></a> [apim\_pm\_restapirtd\_api\_v1](#module\_apim\_pm\_restapirtd\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.18.3 |
| <a name="module_apim_pm_restapirtd_api_v2"></a> [apim\_pm\_restapirtd\_api\_v2](#module\_apim\_pm\_restapirtd\_api\_v2) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.18.3 |
| <a name="module_apim_pm_satispay_api_v1"></a> [apim\_pm\_satispay\_api\_v1](#module\_apim\_pm\_satispay\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_wisp_api_v1"></a> [apim\_pm\_wisp\_api\_v1](#module\_apim\_pm\_wisp\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pm_xpay_api_v1"></a> [apim\_pm\_xpay\_api\_v1](#module\_apim\_pm\_xpay\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_pmclient_iobpd_api_v1"></a> [apim\_pmclient\_iobpd\_api\_v1](#module\_apim\_pmclient\_iobpd\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_tkm_acquirer_manager_api_v1"></a> [apim\_tkm\_acquirer\_manager\_api\_v1](#module\_apim\_tkm\_acquirer\_manager\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_tkm_card_manager_api_v1"></a> [apim\_tkm\_card\_manager\_api\_v1](#module\_apim\_tkm\_card\_manager\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_tkm_consent_manager_api_v1"></a> [apim\_tkm\_consent\_manager\_api\_v1](#module\_apim\_tkm\_consent\_manager\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_tkm_consent_manager_internal_api_v1"></a> [apim\_tkm\_consent\_manager\_internal\_api\_v1](#module\_apim\_tkm\_consent\_manager\_internal\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_tkm_mock_circuit_api_v1"></a> [apim\_tkm\_mock\_circuit\_api\_v1](#module\_apim\_tkm\_mock\_circuit\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_tkm_product"></a> [apim\_tkm\_product](#module\_apim\_tkm\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_tkm_test_utility_api_v1"></a> [apim\_tkm\_test\_utility\_api\_v1](#module\_apim\_tkm\_test\_utility\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_postgresql_snet"></a> [postgresql\_snet](#module\_postgresql\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.90 |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../tag_config | n/a |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.decoupler_activate_inbound](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.decoupler_activate_outbound](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.decoupler_algorithm](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.decoupler_configuration](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.on_erro_soap_handler](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.wisp_nodoinviarpt_nodoinviacarrellorpt_outbound_policy](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
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
| [azurerm_api_management_api_operation_policy.close_payment_api_v2_wisp_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.donazioni_activate_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.donazioni_sendrt_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.donazioni_verify_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.get_donations](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.nm3_activate_v2_verify_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.nm3_activate_v2_verify_policy_auth](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.nm3_activate_verify_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.nm3_activate_verify_policy_auth](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.nodoInviaCarrelloRPT_api_auth_v1_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.nodoInviaCarrelloRPT_api_v1_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.nodoInviaRPT_api_auth_v1_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.nodoInviaRPT_api_v1_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.parked_list_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.parked_list_api_v1_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.send_payment_result_api_v2_wisp_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_operation_policy) | resource |
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
| [azurerm_api_management_api_version_set.apim_pm_paypalpsp_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_pm_satispay_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_pm_xpay_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
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
| [azurerm_api_management_api_version_set.pm_adminpanel_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pm_auth_rtd_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pm_events_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pm_per_nodo_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pm_restapi_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pm_restapi_old_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pm_restapi_server_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pm_restapicd_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pm_restapirtd_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pmclient_iobpd_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.tkm_acquirer_manager_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.tkm_card_manager_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.tkm_consent_manager_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.tkm_consent_manager_internal_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.tkm_mock_circuit_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.tkm_test_utility_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_named_value.ndp_disable_activate](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.node_decoupler_primitives](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.nodo_auth_password_value](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.x_forwarded_for_value](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_product_api.apim_nodo_dei_pagamenti_product_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_product_api) | resource |
| [azurerm_api_management_product_api.apim_nodo_dei_pagamenti_product_api_auth](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_product_api) | resource |
| [azurerm_api_management_product_api.apim_nodo_dei_pagamenti_product_api_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_product_api) | resource |
| [azurerm_dns_a_record.dns_a_nexi_at](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.dns_a_testnexi_at](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_a_record) | resource |
| [azurerm_dns_caa_record.ndp_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_caa_record) | resource |
| [azurerm_dns_cname_record.dkim-aws-ses-backoffice-platform-pagopa-it](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_cname_record) | resource |
| [azurerm_dns_cname_record.dkim-aws-ses-ndp-platform-pagopa-it](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_cname_record) | resource |
| [azurerm_dns_cname_record.dkim-aws-ses-platform-pagopa-it](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_cname_record) | resource |
| [azurerm_dns_mx_record.dns-mx-backoffice-platform-pagopa-it](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_mx_record) | resource |
| [azurerm_dns_mx_record.dns-mx-email-platform-pagopa-it](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_mx_record) | resource |
| [azurerm_dns_mx_record.dns-mx-ndp-platform-pagopa-it](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_mx_record) | resource |
| [azurerm_dns_txt_record.dns-txt-backoffice-platform-pagopa-it-aws-ses](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_txt_record) | resource |
| [azurerm_dns_txt_record.dns-txt-backoffice-platform-pagopa-it-aws-ses-txt](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_txt_record) | resource |
| [azurerm_dns_txt_record.dns-txt-email-platform-pagopa-it-aws-ses](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_txt_record) | resource |
| [azurerm_dns_txt_record.dns-txt-ndp-platform-pagopa-it-aws-ses](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_txt_record) | resource |
| [azurerm_dns_txt_record.dns-txt-ndp-platform-pagopa-it-aws-ses-txt](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_txt_record) | resource |
| [azurerm_dns_txt_record.dns-txt-platform-pagopa-it-aws-ses](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_txt_record) | resource |
| [azurerm_dns_zone.ndp_public](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_postgres_database_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_postgres_database_azure_com_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [null_resource.decoupler_configuration_from_json_2_xml](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [terraform_data.sha256_decoupler_activate_inbound](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.sha256_decoupler_activate_outbound](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.sha256_decoupler_algorithm](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.sha256_decoupler_configuration](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.sha256_nodoInviaCarrelloRPT_api_auth_v1_policy](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.sha256_nodoInviaCarrelloRPT_api_v1_policy](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.sha256_nodoInviaRPT_api_auth_v1_policy](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.sha256_nodoInviaRPT_api_v1_policy](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.sha256_nodoinviarpt_wisp_nodoinviacarrellorpt_outbound_policy](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.sha256_on_erro_soap_handler](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.sha256_send_payment_result_api_v2_wisp_policy](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [azurerm_api_management.apim_migrated](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/api_management) | data source |
| [azurerm_api_management_api.apim_aca_api_v1_](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/api_management_api) | data source |
| [azurerm_api_management_product.technical_support_api_product](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/api_management_product) | data source |
| [azurerm_app_service.node_forwarder](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/app_service) | data source |
| [azurerm_app_service.node_forwarder_ha](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/app_service) | data source |
| [azurerm_application_gateway.app_gw](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/application_gateway) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/client_config) | data source |
| [azurerm_dns_zone.public](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/dns_zone) | data source |
| [azurerm_dns_zone.public_prf](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/dns_zone) | data source |
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.alert_error_notification_email](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.alert_error_notification_slack](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_mo_notification_email](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_new_conn_srv_webhook_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_notification_email](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_notification_slack_email](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_pm_opsgenie_webhook_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pm_logging_ip](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pm_restapi_ip](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pm_wisp_metadata](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.sec_storage_id](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.sec_workspace_id](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_log_analytics_workspace.log_analytics_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.error_action_group](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.mo_email](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.new_conn_srv_opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.pm_opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.privatelink_documents_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet_ita](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.apim_snet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/subnet) | data source |
| [azurerm_subnet.eventhub_snet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet_ita](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_fdr_nodo_pagopa_enable"></a> [apim\_fdr\_nodo\_pagopa\_enable](#input\_apim\_fdr\_nodo\_pagopa\_enable) | Enable Fdr Service Nodo pagoPA side | `bool` | `false` | no |
| <a name="input_apim_logger_resource_id"></a> [apim\_logger\_resource\_id](#input\_apim\_logger\_resource\_id) | Resource id for the APIM logger | `string` | `null` | no |
| <a name="input_apim_nodo_auth_decoupler_enable"></a> [apim\_nodo\_auth\_decoupler\_enable](#input\_apim\_nodo\_auth\_decoupler\_enable) | Apply decoupler to nodo-auth product apim policy | `bool` | `false` | no |
| <a name="input_apim_nodo_decoupler_enable"></a> [apim\_nodo\_decoupler\_enable](#input\_apim\_nodo\_decoupler\_enable) | Apply decoupler to nodo product apim policy | `bool` | `false` | no |
| <a name="input_app_gateway_allowed_paths_pagopa_onprem_only"></a> [app\_gateway\_allowed\_paths\_pagopa\_onprem\_only](#input\_app\_gateway\_allowed\_paths\_pagopa\_onprem\_only) | Allowed paths from pagopa onprem only | <pre>object({<br/>    paths = list(string)<br/>    ips   = list(string)<br/>  })</pre> | n/a | yes |
| <a name="input_bpd_hostname"></a> [bpd\_hostname](#input\_bpd\_hostname) | BPD hostname | `string` | `""` | no |
| <a name="input_cidr_subnet_postgresql"></a> [cidr\_subnet\_postgresql](#input\_cidr\_subnet\_postgresql) | Address prefixes subnet postgresql | `list(string)` | `null` | no |
| <a name="input_cobadge_hostname"></a> [cobadge\_hostname](#input\_cobadge\_hostname) | Cobadge hostname | `string` | `""` | no |
| <a name="input_create_wisp_converter"></a> [create\_wisp\_converter](#input\_create\_wisp\_converter) | CREATE WISP dismantling system infra | `bool` | `false` | no |
| <a name="input_cstar_outbound_ip_1"></a> [cstar\_outbound\_ip\_1](#input\_cstar\_outbound\_ip\_1) | CSTAR ip 1 | `string` | n/a | yes |
| <a name="input_cstar_outbound_ip_2"></a> [cstar\_outbound\_ip\_2](#input\_cstar\_outbound\_ip\_2) | CSTAR ip 2 | `string` | n/a | yes |
| <a name="input_dns_default_ttl_sec"></a> [dns\_default\_ttl\_sec](#input\_dns\_default\_ttl\_sec) | value | `number` | `3600` | no |
| <a name="input_dns_zone_checkout"></a> [dns\_zone\_checkout](#input\_dns\_zone\_checkout) | The checkout dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_prefix"></a> [dns\_zone\_prefix](#input\_dns\_zone\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_prefix_prf"></a> [dns\_zone\_prefix\_prf](#input\_dns\_zone\_prefix\_prf) | The dns subdomain. | `string` | `""` | no |
| <a name="input_ecommerce_ingress_hostname"></a> [ecommerce\_ingress\_hostname](#input\_ecommerce\_ingress\_hostname) | ecommerce ingress hostname | `string` | `null` | no |
| <a name="input_enabled_features"></a> [enabled\_features](#input\_enabled\_features) | Features enabled in this domain | <pre>object({<br/>    vnet_ita          = bool<br/>    node_forwarder_ha = optional(bool, false)<br/>  })</pre> | <pre>{<br/>  "vnet_ita": false<br/>}</pre> | no |
| <a name="input_env"></a> [env](#input\_env) | Contains env description in extend format (dev,uat,prod) | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | Environment shot version | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_fesp_hostname"></a> [fesp\_hostname](#input\_fesp\_hostname) | Fesp hostname | `string` | `""` | no |
| <a name="input_function_app_storage_account_info"></a> [function\_app\_storage\_account\_info](#input\_function\_app\_storage\_account\_info) | n/a | <pre>object({<br/>    account_kind                      = optional(string, "StorageV2")<br/>    account_tier                      = optional(string, "Standard")<br/>    account_replication_type          = optional(string, "LRS")<br/>    access_tier                       = optional(string, "Hot")<br/>    advanced_threat_protection_enable = optional(bool, true)<br/>  })</pre> | <pre>{<br/>  "access_tier": "Hot",<br/>  "account_kind": "StorageV2",<br/>  "account_replication_type": "LRS",<br/>  "account_tier": "Standard",<br/>  "advanced_threat_protection_enable": true<br/>}</pre> | no |
| <a name="input_io_bpd_hostname"></a> [io\_bpd\_hostname](#input\_io\_bpd\_hostname) | IO BPD hostname | `string` | `""` | no |
| <a name="input_location"></a> [location](#input\_location) | Main location | `string` | `"westeurope"` | no |
| <a name="input_location_ita"></a> [location\_ita](#input\_location\_ita) | Main location | `string` | `"italynorth"` | no |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | `"weu"` | no |
| <a name="input_location_short_ita"></a> [location\_short\_ita](#input\_location\_short\_ita) | Location short for italy: itn | `string` | `"itn"` | no |
| <a name="input_node_decoupler_primitives"></a> [node\_decoupler\_primitives](#input\_node\_decoupler\_primitives) | Node decoupler primitives | `string` | `"nodoChiediNumeroAvviso,nodoChiediCatalogoServizi,nodoChiediInformativaPA,nodoChiediInformativaPSP,nodoChiediTemplateInformativaPSP,nodoPAChiediInformativaPA,nodoChiediSceltaWISP,demandPaymentNotice"` | no |
| <a name="input_nodo_auth_subscription_limit"></a> [nodo\_auth\_subscription\_limit](#input\_nodo\_auth\_subscription\_limit) | subscriptions limit | `number` | `1000` | no |
| <a name="input_nodo_pagamenti_auth_password"></a> [nodo\_pagamenti\_auth\_password](#input\_nodo\_pagamenti\_auth\_password) | Default password used for nodo-auth | `string` | `"PLACEHOLDER"` | no |
| <a name="input_nodo_pagamenti_subkey_required"></a> [nodo\_pagamenti\_subkey\_required](#input\_nodo\_pagamenti\_subkey\_required) | Enabled subkeys for nodo dei pagamenti api | `bool` | `false` | no |
| <a name="input_paytipper_hostname"></a> [paytipper\_hostname](#input\_paytipper\_hostname) | Paytipper hostname | `string` | `""` | no |
| <a name="input_postgres_private_endpoint_enabled"></a> [postgres\_private\_endpoint\_enabled](#input\_postgres\_private\_endpoint\_enabled) | Private endpoint database enable? | `bool` | `false` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"pagopa"` | no |
| <a name="input_satispay_hostname"></a> [satispay\_hostname](#input\_satispay\_hostname) | Satispay hostname | `string` | `""` | no |
| <a name="input_xpay_hostname"></a> [xpay\_hostname](#input\_xpay\_hostname) | Nexi xpay hostname | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_insights_instrumentation_key"></a> [application\_insights\_instrumentation\_key](#output\_application\_insights\_instrumentation\_key) | n/a |
| <a name="output_vnet_address_space"></a> [vnet\_address\_space](#output\_vnet\_address\_space) | n/a |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | n/a |
| <a name="output_vnet_integration_address_space"></a> [vnet\_integration\_address\_space](#output\_vnet\_integration\_address\_space) | n/a |
| <a name="output_vnet_integration_name"></a> [vnet\_integration\_name](#output\_vnet\_integration\_name) | n/a |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | n/a |
<!-- END_TF_DOCS -->
