# nodo-app

<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | <= 1.3.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | <= 2.30.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.116.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | <= 2.16.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | <= 2.30.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.2.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module___v3__"></a> [\_\_v3\_\_](#module\_\_\_v3\_\_) | git::https://github.com/pagopa/terraform-azurerm-v3 | f3485105e35ce8c801209dcbb4ef72f3d944f0e5 |
| <a name="module_apim_api_mock_ec_api_replica_v1"></a> [apim\_api\_mock\_ec\_api\_replica\_v1](#module\_apim\_api\_mock\_ec\_api\_replica\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_mock_ec_api_v1"></a> [apim\_api\_mock\_ec\_api\_v1](#module\_apim\_api\_mock\_ec\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_mock_ec_secondary_api_replica_v1"></a> [apim\_api\_mock\_ec\_secondary\_api\_replica\_v1](#module\_apim\_api\_mock\_ec\_secondary\_api\_replica\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_mock_ec_secondary_api_v1"></a> [apim\_api\_mock\_ec\_secondary\_api\_v1](#module\_apim\_api\_mock\_ec\_secondary\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_mock_pm_api_v1"></a> [apim\_api\_mock\_pm\_api\_v1](#module\_apim\_api\_mock\_pm\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_mock_psp_api_replica_v1"></a> [apim\_api\_mock\_psp\_api\_replica\_v1](#module\_apim\_api\_mock\_psp\_api\_replica\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_mock_psp_api_v1"></a> [apim\_api\_mock\_psp\_api\_v1](#module\_apim\_api\_mock\_psp\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_mock_psp_secondary_api_replica_v1"></a> [apim\_api\_mock\_psp\_secondary\_api\_replica\_v1](#module\_apim\_api\_mock\_psp\_secondary\_api\_replica\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_mock_psp_secondary_api_v1"></a> [apim\_api\_mock\_psp\_secondary\_api\_v1](#module\_apim\_api\_mock\_psp\_secondary\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_nododatamigration_api_v1"></a> [apim\_api\_nododatamigration\_api\_v1](#module\_apim\_api\_nododatamigration\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_prometheus_api_v1"></a> [apim\_api\_prometheus\_api\_v1](#module\_apim\_api\_prometheus\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_receipt_for_ndp_api_v1"></a> [apim\_api\_receipt\_for\_ndp\_api\_v1](#module\_apim\_api\_receipt\_for\_ndp\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_web_bo_api_v1"></a> [apim\_api\_web\_bo\_api\_v1](#module\_apim\_api\_web\_bo\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_wfesp_api_replica_v1"></a> [apim\_api\_wfesp\_api\_replica\_v1](#module\_apim\_api\_wfesp\_api\_replica\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_api_wfesp_api_v1"></a> [apim\_api\_wfesp\_api\_v1](#module\_apim\_api\_wfesp\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_apim_for_node_product"></a> [apim\_apim\_for\_node\_product](#module\_apim\_apim\_for\_node\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_cfg_for_node_product"></a> [apim\_cfg\_for\_node\_product](#module\_apim\_cfg\_for\_node\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_mbd_product"></a> [apim\_mbd\_product](#module\_apim\_mbd\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_mock_ec_product"></a> [apim\_mock\_ec\_product](#module\_apim\_mock\_ec\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_mock_ec_product_replica"></a> [apim\_mock\_ec\_product\_replica](#module\_apim\_mock\_ec\_product\_replica) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_mock_ec_secondary_product"></a> [apim\_mock\_ec\_secondary\_product](#module\_apim\_mock\_ec\_secondary\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_mock_ec_secondary_product_replica"></a> [apim\_mock\_ec\_secondary\_product\_replica](#module\_apim\_mock\_ec\_secondary\_product\_replica) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_mock_pm_product"></a> [apim\_mock\_pm\_product](#module\_apim\_mock\_pm\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_mock_psp_product"></a> [apim\_mock\_psp\_product](#module\_apim\_mock\_psp\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_mock_psp_product_replica"></a> [apim\_mock\_psp\_product\_replica](#module\_apim\_mock\_psp\_product\_replica) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_mock_psp_secondary_product"></a> [apim\_mock\_psp\_secondary\_product](#module\_apim\_mock\_psp\_secondary\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_mock_psp_secondary_product_replica"></a> [apim\_mock\_psp\_secondary\_product\_replica](#module\_apim\_mock\_psp\_secondary\_product\_replica) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_node_for_ecommerce_api_v1"></a> [apim\_node\_for\_ecommerce\_api\_v1](#module\_apim\_node\_for\_ecommerce\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_node_for_ecommerce_api_v2"></a> [apim\_node\_for\_ecommerce\_api\_v2](#module\_apim\_node\_for\_ecommerce\_api\_v2) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_node_for_ecommerce_product"></a> [apim\_node\_for\_ecommerce\_product](#module\_apim\_node\_for\_ecommerce\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_nodo_dei_pagamenti_product_ndp"></a> [apim\_nodo\_dei\_pagamenti\_product\_ndp](#module\_apim\_nodo\_dei\_pagamenti\_product\_ndp) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_nodo_dei_pagamenti_product_replica_ndp"></a> [apim\_nodo\_dei\_pagamenti\_product\_replica\_ndp](#module\_apim\_nodo\_dei\_pagamenti\_product\_replica\_ndp) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_nodo_monitoring_api_ndp"></a> [apim\_nodo\_monitoring\_api\_ndp](#module\_apim\_nodo\_monitoring\_api\_ndp) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_nodo_monitoring_api_replica_ndp"></a> [apim\_nodo\_monitoring\_api\_replica\_ndp](#module\_apim\_nodo\_monitoring\_api\_replica\_ndp) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_nodo_per_pm_api_v1_ndp"></a> [apim\_nodo\_per\_pm\_api\_v1\_ndp](#module\_apim\_nodo\_per\_pm\_api\_v1\_ndp) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_nodo_per_pm_api_v1_replica_ndp"></a> [apim\_nodo\_per\_pm\_api\_v1\_replica\_ndp](#module\_apim\_nodo\_per\_pm\_api\_v1\_replica\_ndp) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_nodo_per_pm_api_v2_ndp"></a> [apim\_nodo\_per\_pm\_api\_v2\_ndp](#module\_apim\_nodo\_per\_pm\_api\_v2\_ndp) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_nodo_per_pm_api_v2_replica_ndp"></a> [apim\_nodo\_per\_pm\_api\_v2\_replica\_ndp](#module\_apim\_nodo\_per\_pm\_api\_v2\_replica\_ndp) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_nododatamigration_product"></a> [apim\_nododatamigration\_product](#module\_apim\_nododatamigration\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_prometheus_product"></a> [apim\_prometheus\_product](#module\_apim\_prometheus\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_receipt_for_ndp_product"></a> [apim\_receipt\_for\_ndp\_product](#module\_apim\_receipt\_for\_ndp\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_web_bo_product"></a> [apim\_web\_bo\_product](#module\_apim\_web\_bo\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_wfesp_product"></a> [apim\_wfesp\_product](#module\_apim\_wfesp\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_wfesp_product_replica"></a> [apim\_wfesp\_product\_replica](#module\_apim\_wfesp\_product\_replica) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_wisp_converter_product"></a> [apim\_wisp\_converter\_product](#module\_apim\_wisp\_converter\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_cert_mounter"></a> [cert\_mounter](#module\_cert\_mounter) | ./.terraform/modules/__v3__/cert_mounter | n/a |
| <a name="module_gh_runner_job"></a> [gh\_runner\_job](#module\_gh\_runner\_job) | ./.terraform/modules/__v3__/gh_runner_container_app_job_domain_setup | n/a |
| <a name="module_load_balancer_nodo_egress"></a> [load\_balancer\_nodo\_egress](#module\_load\_balancer\_nodo\_egress) | ./.terraform/modules/__v3__/load_balancer | n/a |
| <a name="module_nodo_re_to_datastore_function"></a> [nodo\_re\_to\_datastore\_function](#module\_nodo\_re\_to\_datastore\_function) | ./.terraform/modules/__v3__/function_app | n/a |
| <a name="module_nodo_re_to_datastore_function_slot_staging"></a> [nodo\_re\_to\_datastore\_function\_slot\_staging](#module\_nodo\_re\_to\_datastore\_function\_slot\_staging) | ./.terraform/modules/__v3__/function_app_slot | n/a |
| <a name="module_nodo_re_to_datastore_function_snet"></a> [nodo\_re\_to\_datastore\_function\_snet](#module\_nodo\_re\_to\_datastore\_function\_snet) | ./.terraform/modules/__v3__/subnet | n/a |
| <a name="module_nodo_re_to_tablestorage_function"></a> [nodo\_re\_to\_tablestorage\_function](#module\_nodo\_re\_to\_tablestorage\_function) | ./.terraform/modules/__v3__/function_app | n/a |
| <a name="module_nodo_re_to_tablestorage_function_slot_staging"></a> [nodo\_re\_to\_tablestorage\_function\_slot\_staging](#module\_nodo\_re\_to\_tablestorage\_function\_slot\_staging) | ./.terraform/modules/__v3__/function_app_slot | n/a |
| <a name="module_nodo_re_to_tablestorage_function_snet"></a> [nodo\_re\_to\_tablestorage\_function\_snet](#module\_nodo\_re\_to\_tablestorage\_function\_snet) | ./.terraform/modules/__v3__/subnet | n/a |
| <a name="module_nodo_verifyko_to_datastore_function"></a> [nodo\_verifyko\_to\_datastore\_function](#module\_nodo\_verifyko\_to\_datastore\_function) | ./.terraform/modules/__v3__/function_app | n/a |
| <a name="module_nodo_verifyko_to_datastore_function_slot_staging"></a> [nodo\_verifyko\_to\_datastore\_function\_slot\_staging](#module\_nodo\_verifyko\_to\_datastore\_function\_slot\_staging) | ./.terraform/modules/__v3__/function_app_slot | n/a |
| <a name="module_nodo_verifyko_to_datastore_function_snet"></a> [nodo\_verifyko\_to\_datastore\_function\_snet](#module\_nodo\_verifyko\_to\_datastore\_function\_snet) | ./.terraform/modules/__v3__/subnet | n/a |
| <a name="module_nodo_verifyko_to_tablestorage_function"></a> [nodo\_verifyko\_to\_tablestorage\_function](#module\_nodo\_verifyko\_to\_tablestorage\_function) | ./.terraform/modules/__v3__/function_app | n/a |
| <a name="module_nodo_verifyko_to_tablestorage_function_slot_staging"></a> [nodo\_verifyko\_to\_tablestorage\_function\_slot\_staging](#module\_nodo\_verifyko\_to\_tablestorage\_function\_slot\_staging) | ./.terraform/modules/__v3__/function_app_slot | n/a |
| <a name="module_nodo_verifyko_to_tablestorage_function_snet"></a> [nodo\_verifyko\_to\_tablestorage\_function\_snet](#module\_nodo\_verifyko\_to\_tablestorage\_function\_snet) | ./.terraform/modules/__v3__/subnet | n/a |
| <a name="module_pod_identity"></a> [pod\_identity](#module\_pod\_identity) | ./.terraform/modules/__v3__/kubernetes_pod_identity | n/a |
| <a name="module_route_table_peering_nexi"></a> [route\_table\_peering\_nexi](#module\_route\_table\_peering\_nexi) | ./.terraform/modules/__v3__/route_table | n/a |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../../tag_config | n/a |
| <a name="module_tls_checker"></a> [tls\_checker](#module\_tls\_checker) | ./.terraform/modules/__v3__/tls_checker | n/a |
| <a name="module_vmss_snet"></a> [vmss\_snet](#module\_vmss\_snet) | ./.terraform/modules/__v3__/subnet | n/a |
| <a name="module_wisp_converter_caching_api_v1"></a> [wisp\_converter\_caching\_api\_v1](#module\_wisp\_converter\_caching\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_workload_identity"></a> [workload\_identity](#module\_workload\_identity) | ./.terraform/modules/__v3__/kubernetes_workload_identity_configuration | n/a |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.ndphost_header](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.wisp_batch_migration](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.wisp_cache_4_decoupler](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.wisp_cache_4_decoupler_cart](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.wisp_disable_payment_token_timer](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.wisp_receipt_ko](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azurerm_api_management_api.apim_node_for_io_api_v1_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_node_for_io_api_v1_replica_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_node_for_psp_api_v1_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_node_for_psp_api_v1_replica_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_nodo_per_pa_api_v1_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_nodo_per_pa_api_v1_replica_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_nodo_per_psp_api_v1_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_nodo_per_psp_api_v1_replica_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_nodo_per_psp_richiesta_avvisi_api_v1_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_nodo_per_psp_richiesta_avvisi_api_v1_replica_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_psp_for_node_api_v1_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_psp_for_node_api_v1_replica_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api_operation_policy.auth_close_payment_api_v2_wisp_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.close_payment_api_v1_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.close_payment_api_v1_replica_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.close_payment_api_v2_ndp_wisp_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.delete_sessionId_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.nm3_activate_v2_verify_policy_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.nm3_activate_verify_policy_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.nodoInviaCarrelloRPT_api_v1_policy_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.nodoInviaCarrelloRPT_api_v1_policy_replica_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.nodoInviaRPT_api_v1_policy_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.nodoInviaRPT_api_v1_policy_replica_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.parked_list_api_v1_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.parked_list_api_v1_replica_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.payments_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.save_cart_mapping_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.save_mapping_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_policy.apim_node_for_io_policy_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_node_for_io_policy_replica_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_node_for_psp_policy_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_node_for_psp_policy_replica_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_nodo_per_pa_policy_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_nodo_per_pa_policy_replica_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_nodo_per_psp_policy_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_nodo_per_psp_policy_replica_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_nodo_per_psp_richiesta_avvisi_policy_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_nodo_per_psp_richiesta_avvisi_policy_replica_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_psp_for_node_policy_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_psp_for_node_policy_replica_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_version_set.api_datamigration_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_mock_ec_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_mock_ec_api_replica](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_mock_ec_secondary_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_mock_ec_secondary_api_replica](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_mock_pm_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_mock_psp_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_mock_psp_api_replica](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_mock_psp_secondary_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_mock_psp_secondary_api_replica](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_receipt_for_ndp_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_version_set_wisp_converter_caching](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_wfesp_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.api_wfesp_api_replica](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.node_for_ecommerce_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.node_for_io_api_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.node_for_io_api_replica_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.node_for_psp_api_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.node_for_psp_api_replica_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_monitoring_api_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_monitoring_api_replica_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_per_pa_api_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_per_pa_api_replica_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_per_pm_api_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_per_pm_api_replica_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_per_psp_api_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_per_psp_api_replica_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_per_psp_richiesta_avvisi_api_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.nodo_per_psp_richiesta_avvisi_api_replica_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.psp_for_node_api_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.psp_for_node_api_replica_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_named_value.enable_wisp_dismantling_switch_named_value](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.wfesp_channel_list_named_value](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.wfesp_fixed_url_named_value](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.wisp_brokerPSP_whitelist_named_value](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.wisp_channel_whitelist_named_value](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.wisp_checkout_predefined_expiration_time](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.wisp_dismantling_backend_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.wisp_dismantling_converter_base_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.wisp_dismantling_primitives](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.wisp_dismantling_rt_primitives](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.wisp_ecommerce_channels](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.wisp_nodoinviarpt_paymenttype_whitelist_named_value](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_product_api.apim_nodo_dei_pagamenti_product_api_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_api) | resource |
| [azurerm_api_management_product_api.apim_nodo_dei_pagamenti_product_api_replica_ndp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_api) | resource |
| [azurerm_api_management_product_group.access_control_developers_for_cfg_for_node](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_group) | resource |
| [azurerm_api_management_product_group.access_control_developers_for_wisp_converter](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_group) | resource |
| [azurerm_key_vault_secret.aks_apiserver_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_cacrt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_kubernetes_cluster_node_pool.nodo_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |
| [azurerm_kusto_database_principal_assignment.nodo_pod_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_database_principal_assignment) | resource |
| [azurerm_kusto_database_principal_assignment.nodo_workload_identity_kusto_principal_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_database_principal_assignment) | resource |
| [azurerm_linux_virtual_machine_scale_set.vmss-egress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | resource |
| [azurerm_logic_app_action_custom.custom](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_action_custom) | resource |
| [azurerm_logic_app_action_http.create_branch](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_action_http) | resource |
| [azurerm_logic_app_action_http.delete_branch](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_action_http) | resource |
| [azurerm_logic_app_action_http.get_sha256](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_action_http) | resource |
| [azurerm_logic_app_trigger_http_request.trigger](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_trigger_http_request) | resource |
| [azurerm_logic_app_workflow.logic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_workflow) | resource |
| [azurerm_monitor_action_group.logic_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_autoscale_setting.nodo_re_to_datastore_function](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.nodo_re_to_tablestorage_function](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.nodo_verifyko_to_datastore_function](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.nodo_verifyko_to_tablestorage_function](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.vmss-scale](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_metric_alert.aks_nodo_metrics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.aks_nodo_metrics_error](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.alert-fault-code-availability](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.alert-fault-code-specific-threshold](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.alert-nodo-auth-availability](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.alert-nodo-auth-responsetime](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.alert-nodo-availability](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.alert-nodo-responsetime](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.node_cfg_sync_dump_problem](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.node_cfg_sync_generic_problem](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.node_cfg_sync_sync_dumping_generic_problem](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.node_cfg_sync_trigger_problem](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.nodo_verifyko_to_datastore_appexception](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.nodo_verifyko_to_datastore_appexception_lastretry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.nodo_verifyko_to_datastore_cosmosexception](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.nodo_verifyko_to_tablestorage_appexception](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.nodo_verifyko_to_tablestorage_appexception_lastretry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.nodo_verifyko_to_tablestorage_persistenceexception](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-wisp-converter-ai-availability](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-wisp-converter-ai-error](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-wisp-converter-availability](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-wisp-converter-redirect-availability](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.opex_pagopa-wisp-converter-wic-error](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_resource_group.nodo_re_to_datastore_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.vmss_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet_route_table_association.snet_vmss_to_sia](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_virtual_machine_scale_set_extension.vmss-extension](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_scale_set_extension) | resource |
| [helm_release.reloader](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.namespace_system](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_pod_disruption_budget_v1.nodo](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod_disruption_budget_v1) | resource |
| [kubernetes_role_binding.deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_role_binding.deployer_binding_2](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_role_binding.kube_system_reader_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_role_binding.system_deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_role_binding.system_deployer_binding_2](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_service_account.azure_devops](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [terraform_data.sha256_delete_sessionId_api_v1](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.sha256_ndphost_header](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.sha256_payments_api_v1](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.sha256_save_cart_mapping_api_v1](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.sha256_save_mapping_api_v1](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.sha256_wisp_batch_migration](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.sha256_wisp_cache_4_decoupler](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.sha256_wisp_cache_4_decoupler_cart](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.sha256_wisp_disable_payment_token_timer](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.sha256_wisp_receipt_ko](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_api_management_group.group_developers](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management_group) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/container_registry) | data source |
| [azurerm_cosmosdb_account.nodo_re_cosmosdb_nosql](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/cosmosdb_account) | data source |
| [azurerm_cosmosdb_account.nodo_verifyko_cosmosdb_nosql](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/cosmosdb_account) | data source |
| [azurerm_cosmosdb_sql_database.nodo_re_cosmosdb_nosql_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/cosmosdb_sql_database) | data source |
| [azurerm_cosmosdb_sql_database.nodo_verifyko_cosmosdb_nosql_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/cosmosdb_sql_database) | data source |
| [azurerm_eventhub.pagopa-evh-ns03_nodo-dei-pagamenti-re_nodo-dei-pagamenti-re](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub) | data source |
| [azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-re_nodo-dei-pagamenti-re-to-datastore-rx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-re_nodo-dei-pagamenti-re-to-tablestorage-rx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-verify-ko_nodo-dei-pagamenti-verify-ko-datastore-rx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-verify-ko_nodo-dei-pagamenti-verify-ko-tablestorage-rx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_namespace.pagopa-evh-ns03](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_namespace) | data source |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.kv_core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.client_id_swclient](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.client_secret_swclient](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.github_pat](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.subscriptionkey_ecomm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.vmss_admin_login](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.vmss_admin_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_kusto_cluster.data_explorer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kusto_cluster) | data source |
| [azurerm_kusto_database.data_explorer_re](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kusto_database) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.infra_opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slacknodo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.smo_opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_resource_group.identity_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.node_cfg_sync_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.nodo_verify_ko_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_route_table.route_sia](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/route_table) | data source |
| [azurerm_storage_account.nodo_re_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.nodo_verifyko_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subnet.aks_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.apim_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_user_assigned_identity.uai_nodo_pod_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |
| [azurerm_user_assigned_identity.workload_identity_clientid](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [kubernetes_secret.azure_devops_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_cidr_subnet"></a> [aks\_cidr\_subnet](#input\_aks\_cidr\_subnet) | Aks network address space. | `list(string)` | n/a | yes |
| <a name="input_apim_dns_zone_prefix"></a> [apim\_dns\_zone\_prefix](#input\_apim\_dns\_zone\_prefix) | The dns subdomain for apim. | `string` | `null` | no |
| <a name="input_apim_nodo_auth_decoupler_enable"></a> [apim\_nodo\_auth\_decoupler\_enable](#input\_apim\_nodo\_auth\_decoupler\_enable) | Apply decoupler to nodo-auth product apim policy | `bool` | `true` | no |
| <a name="input_apim_nodo_decoupler_enable"></a> [apim\_nodo\_decoupler\_enable](#input\_apim\_nodo\_decoupler\_enable) | Apply decoupler to nodo product apim policy | `bool` | `true` | no |
| <a name="input_app_gateway_allowed_paths_pagopa_onprem_only"></a> [app\_gateway\_allowed\_paths\_pagopa\_onprem\_only](#input\_app\_gateway\_allowed\_paths\_pagopa\_onprem\_only) | Allowed paths from pagopa onprem only | <pre>object({<br/>    paths = list(string)<br/>    ips   = list(string)<br/>  })</pre> | n/a | yes |
| <a name="input_cidr_subnet_vmss"></a> [cidr\_subnet\_vmss](#input\_cidr\_subnet\_vmss) | VMSS network address space. | `list(string)` | n/a | yes |
| <a name="input_cname_record_name"></a> [cname\_record\_name](#input\_cname\_record\_name) | n/a | `string` | `"config"` | no |
| <a name="input_create_wisp_converter"></a> [create\_wisp\_converter](#input\_create\_wisp\_converter) | CREATE WISP dismantling system infra | `bool` | `false` | no |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_enable_nodo_re"></a> [enable\_nodo\_re](#input\_enable\_nodo\_re) | Enables dumping nodo re | `bool` | `false` | no |
| <a name="input_enable_sendPaymentResultV2_SWClient"></a> [enable\_sendPaymentResultV2\_SWClient](#input\_enable\_sendPaymentResultV2\_SWClient) | Gestione clientId per integrazione Software Client | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_function_app_storage_account_replication_type"></a> [function\_app\_storage\_account\_replication\_type](#input\_function\_app\_storage\_account\_replication\_type) | (Optional) Storage account replication type used for function apps | `string` | `"ZRS"` | no |
| <a name="input_gh_runner_job_location"></a> [gh\_runner\_job\_location](#input\_gh\_runner\_job\_location) | (Optional) The GH runner container app job location. Consistent with the container app environment location | `string` | `"westeurope"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_k8s_kube_config_path_prefix"></a> [k8s\_kube\_config\_path\_prefix](#input\_k8s\_kube\_config\_path\_prefix) | n/a | `string` | `"~/.kube"` | no |
| <a name="input_lb_frontend_private_ip_address"></a> [lb\_frontend\_private\_ip\_address](#input\_lb\_frontend\_private\_ip\_address) | load balancer egress nodo private ip | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_location_string"></a> [location\_string](#input\_location\_string) | One of West Europe, North Europe | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_node_decoupler_primitives"></a> [node\_decoupler\_primitives](#input\_node\_decoupler\_primitives) | Node decoupler primitives | `string` | `"nodoChiediNumeroAvviso,nodoChiediCatalogoServizi,nodoAttivaRPT,nodoVerificaRPT,nodoChiediInformativaPA,nodoChiediInformativaPSP,nodoChiediTemplateInformativaPSP,nodoPAChiediInformativaPA,nodoChiediSceltaWISP,demandPaymentNotice"` | no |
| <a name="input_nodo_auth_subscription_limit"></a> [nodo\_auth\_subscription\_limit](#input\_nodo\_auth\_subscription\_limit) | subscriptions limit | `number` | `1000` | no |
| <a name="input_nodo_ndp_subscription_limit"></a> [nodo\_ndp\_subscription\_limit](#input\_nodo\_ndp\_subscription\_limit) | subscriptions limit | `number` | `1000` | no |
| <a name="input_nodo_pagamenti_auth_password"></a> [nodo\_pagamenti\_auth\_password](#input\_nodo\_pagamenti\_auth\_password) | Default password used for nodo-auth | `string` | `"PLACEHOLDER"` | no |
| <a name="input_nodo_pagamenti_subkey_required"></a> [nodo\_pagamenti\_subkey\_required](#input\_nodo\_pagamenti\_subkey\_required) | Enabled subkeys for nodo dei pagamenti api | `bool` | `false` | no |
| <a name="input_nodo_pagamenti_x_forwarded_for"></a> [nodo\_pagamenti\_x\_forwarded\_for](#input\_nodo\_pagamenti\_x\_forwarded\_for) | X-Forwarded-For IP address used for nodo-auth | `string` | n/a | yes |
| <a name="input_nodo_re_to_datastore_function"></a> [nodo\_re\_to\_datastore\_function](#input\_nodo\_re\_to\_datastore\_function) | Nodo RE to datastore function | <pre>object({<br/>    always_on                    = bool<br/>    kind                         = string<br/>    sku_size                     = string<br/>    sku_tier                     = string<br/>    maximum_elastic_worker_count = number<br/>  })</pre> | <pre>{<br/>  "always_on": true,<br/>  "kind": "Linux",<br/>  "maximum_elastic_worker_count": 1,<br/>  "sku_size": "B1",<br/>  "sku_tier": "Basic"<br/>}</pre> | no |
| <a name="input_nodo_re_to_datastore_function_app_image_tag"></a> [nodo\_re\_to\_datastore\_function\_app\_image\_tag](#input\_nodo\_re\_to\_datastore\_function\_app\_image\_tag) | Nodo RE to Datastore function app docker image tag. Defaults to 'latest' | `string` | `"latest"` | no |
| <a name="input_nodo_re_to_datastore_function_autoscale"></a> [nodo\_re\_to\_datastore\_function\_autoscale](#input\_nodo\_re\_to\_datastore\_function\_autoscale) | Nodo RE functions autoscaling parameters | <pre>object({<br/>    default = number<br/>    minimum = number<br/>    maximum = number<br/>  })</pre> | n/a | yes |
| <a name="input_nodo_re_to_datastore_function_subnet"></a> [nodo\_re\_to\_datastore\_function\_subnet](#input\_nodo\_re\_to\_datastore\_function\_subnet) | Address prefixes subnet | `list(string)` | `null` | no |
| <a name="input_nodo_re_to_datastore_network_policies_enabled"></a> [nodo\_re\_to\_datastore\_network\_policies\_enabled](#input\_nodo\_re\_to\_datastore\_network\_policies\_enabled) | Network policies enabled | `bool` | `false` | no |
| <a name="input_nodo_re_to_tablestorage_function"></a> [nodo\_re\_to\_tablestorage\_function](#input\_nodo\_re\_to\_tablestorage\_function) | Nodo RE to datastore function | <pre>object({<br/>    always_on                    = bool<br/>    kind                         = string<br/>    sku_size                     = string<br/>    sku_tier                     = string<br/>    maximum_elastic_worker_count = number<br/>  })</pre> | n/a | yes |
| <a name="input_nodo_re_to_tablestorage_function_app_image_tag"></a> [nodo\_re\_to\_tablestorage\_function\_app\_image\_tag](#input\_nodo\_re\_to\_tablestorage\_function\_app\_image\_tag) | Nodo RE to Table Storage function app docker image tag. Defaults to 'latest' | `string` | `"latest"` | no |
| <a name="input_nodo_re_to_tablestorage_function_autoscale"></a> [nodo\_re\_to\_tablestorage\_function\_autoscale](#input\_nodo\_re\_to\_tablestorage\_function\_autoscale) | Nodo RE functions autoscaling parameters | <pre>object({<br/>    default = number<br/>    minimum = number<br/>    maximum = number<br/>  })</pre> | n/a | yes |
| <a name="input_nodo_re_to_tablestorage_function_subnet"></a> [nodo\_re\_to\_tablestorage\_function\_subnet](#input\_nodo\_re\_to\_tablestorage\_function\_subnet) | Address prefixes subnet | `list(string)` | `null` | no |
| <a name="input_nodo_re_to_tablestorage_network_policies_enabled"></a> [nodo\_re\_to\_tablestorage\_network\_policies\_enabled](#input\_nodo\_re\_to\_tablestorage\_network\_policies\_enabled) | Network policies enabled | `bool` | `false` | no |
| <a name="input_nodo_user_node_pool"></a> [nodo\_user\_node\_pool](#input\_nodo\_user\_node\_pool) | AKS node pool user configuration | <pre>object({<br/>    enabled            = bool,<br/>    name               = string,<br/>    vm_size            = string,<br/>    os_disk_type       = string,<br/>    os_disk_size_gb    = string,<br/>    node_count_min     = number,<br/>    node_count_max     = number,<br/>    node_labels        = map(any),<br/>    node_taints        = list(string),<br/>    node_tags          = map(any),<br/>    nodo_pool_max_pods = number,<br/>  })</pre> | n/a | yes |
| <a name="input_nodo_verifyko_to_datastore_function"></a> [nodo\_verifyko\_to\_datastore\_function](#input\_nodo\_verifyko\_to\_datastore\_function) | Nodo Verify KO events to datastore function | <pre>object({<br/>    always_on                    = bool<br/>    kind                         = string<br/>    sku_size                     = string<br/>    sku_tier                     = string<br/>    maximum_elastic_worker_count = number<br/>    zone_balancing_enabled       = bool<br/>  })</pre> | n/a | yes |
| <a name="input_nodo_verifyko_to_datastore_function_app_image_tag"></a> [nodo\_verifyko\_to\_datastore\_function\_app\_image\_tag](#input\_nodo\_verifyko\_to\_datastore\_function\_app\_image\_tag) | Nodo Verify KO to Datastore function app docker image tag. Defaults to 'latest' | `string` | `"latest"` | no |
| <a name="input_nodo_verifyko_to_datastore_function_autoscale"></a> [nodo\_verifyko\_to\_datastore\_function\_autoscale](#input\_nodo\_verifyko\_to\_datastore\_function\_autoscale) | Nodo Verify KO event functions autoscaling parameters | <pre>object({<br/>    default = number<br/>    minimum = number<br/>    maximum = number<br/>  })</pre> | n/a | yes |
| <a name="input_nodo_verifyko_to_datastore_function_subnet"></a> [nodo\_verifyko\_to\_datastore\_function\_subnet](#input\_nodo\_verifyko\_to\_datastore\_function\_subnet) | Address prefixes subnet | `list(string)` | `null` | no |
| <a name="input_nodo_verifyko_to_datastore_network_policies_enabled"></a> [nodo\_verifyko\_to\_datastore\_network\_policies\_enabled](#input\_nodo\_verifyko\_to\_datastore\_network\_policies\_enabled) | Network policies enabled | `bool` | `false` | no |
| <a name="input_nodo_verifyko_to_tablestorage_function"></a> [nodo\_verifyko\_to\_tablestorage\_function](#input\_nodo\_verifyko\_to\_tablestorage\_function) | Nodo Verify KO events to table storage function | <pre>object({<br/>    always_on                    = bool<br/>    kind                         = string<br/>    sku_size                     = string<br/>    sku_tier                     = string<br/>    maximum_elastic_worker_count = number<br/>    zone_balancing_enabled       = bool<br/>  })</pre> | n/a | yes |
| <a name="input_nodo_verifyko_to_tablestorage_function_app_image_tag"></a> [nodo\_verifyko\_to\_tablestorage\_function\_app\_image\_tag](#input\_nodo\_verifyko\_to\_tablestorage\_function\_app\_image\_tag) | Nodo Verify KO events to Table Storage function app docker image tag. Defaults to 'latest' | `string` | `"latest"` | no |
| <a name="input_nodo_verifyko_to_tablestorage_function_autoscale"></a> [nodo\_verifyko\_to\_tablestorage\_function\_autoscale](#input\_nodo\_verifyko\_to\_tablestorage\_function\_autoscale) | Nodo Verify KO events to Table Storage functions autoscaling parameters | <pre>object({<br/>    default = number<br/>    minimum = number<br/>    maximum = number<br/>  })</pre> | n/a | yes |
| <a name="input_nodo_verifyko_to_tablestorage_function_subnet"></a> [nodo\_verifyko\_to\_tablestorage\_function\_subnet](#input\_nodo\_verifyko\_to\_tablestorage\_function\_subnet) | Address prefixes subnet | `list(string)` | `null` | no |
| <a name="input_nodo_verifyko_to_tablestorage_network_policies_enabled"></a> [nodo\_verifyko\_to\_tablestorage\_network\_policies\_enabled](#input\_nodo\_verifyko\_to\_tablestorage\_network\_policies\_enabled) | Network policies enabled | `bool` | `false` | no |
| <a name="input_pod_disruption_budgets"></a> [pod\_disruption\_budgets](#input\_pod\_disruption\_budgets) | Pod disruption budget for domain namespace | <pre>map(object({<br/>    name         = optional(string, null)<br/>    minAvailable = optional(number, null)<br/>    matchLabels  = optional(map(any), {})<br/>  }))</pre> | `{}` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_route_aks"></a> [route\_aks](#input\_route\_aks) | AKS routing table | <pre>list(object({<br/>    name                   = string<br/>    address_prefix         = string<br/>    next_hop_type          = string<br/>    next_hop_in_ip_address = string<br/>  }))</pre> | n/a | yes |
| <a name="input_storage_account_info"></a> [storage\_account\_info](#input\_storage\_account\_info) | Storage account | <pre>object({<br/>    account_kind                      = string<br/>    account_tier                      = string<br/>    account_replication_type          = string<br/>    access_tier                       = string<br/>    advanced_threat_protection_enable = bool<br/>    use_legacy_defender_version       = bool<br/>    public_network_access_enabled     = bool<br/>  })</pre> | <pre>{<br/>  "access_tier": "Hot",<br/>  "account_kind": "StorageV2",<br/>  "account_replication_type": "LRS",<br/>  "account_tier": "Standard",<br/>  "advanced_threat_protection_enable": true,<br/>  "public_network_access_enabled": false,<br/>  "use_legacy_defender_version": true<br/>}</pre> | no |
| <a name="input_tls_cert_check_helm"></a> [tls\_cert\_check\_helm](#input\_tls\_cert\_check\_helm) | tls cert helm chart configuration | <pre>object({<br/>    chart_version = string,<br/>    image_name    = string,<br/>    image_tag     = string<br/>  })</pre> | n/a | yes |
| <a name="input_vmss_instance_number"></a> [vmss\_instance\_number](#input\_vmss\_instance\_number) | availability zones for vmss | `number` | n/a | yes |
| <a name="input_vmss_zones"></a> [vmss\_zones](#input\_vmss\_zones) | availability zones for vmss | `list(string)` | n/a | yes |
| <a name="input_wfesp_dismantling"></a> [wfesp\_dismantling](#input\_wfesp\_dismantling) | n/a | <pre>object({<br/>    channel_list    = string<br/>    wfesp_fixed_url = string<br/>  })</pre> | n/a | yes |
| <a name="input_wisp_converter"></a> [wisp\_converter](#input\_wisp\_converter) | n/a | <pre>object({<br/>    enable_apim_switch                  = bool # enable WISP dismantling<br/>    brokerPSP_whitelist                 = string<br/>    channel_whitelist                   = string<br/>    nodoinviarpt_paymenttype_whitelist  = string<br/>    dismantling_primitives              = string<br/>    dismantling_rt_primitives           = string<br/>    checkout_predefined_expiration_time = number<br/>    wisp_ecommerce_channels             = string<br/>  })</pre> | n/a | yes |
| <a name="input_workflow"></a> [workflow](#input\_workflow) | (Optional) Specify the workflow input parameters and schema version to use. | <pre>object({<br/>    workflow_parameters = optional(map(string), {})<br/>    workflow_schema     = optional(string)<br/>    workflow_version    = optional(string)<br/>  })</pre> | <pre>{<br/>  "workflow_parameters": {},<br/>  "workflow_schema": "https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#",<br/>  "workflow_version": "1.0.0.0"<br/>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
