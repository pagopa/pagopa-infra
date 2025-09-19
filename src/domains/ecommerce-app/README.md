<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.38.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.116.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | <= 2.12.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | = 2.30.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | = 3.2.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module___v3__"></a> [\_\_v3\_\_](#module\_\_\_v3\_\_) | git::https://github.com/pagopa/terraform-azurerm-v3 | 63f6181a6f3a51707a2ab4795bdbed2d888c708b |
| <a name="module_apim_ecommerce_checkout_api_v1"></a> [apim\_ecommerce\_checkout\_api\_v1](#module\_apim\_ecommerce\_checkout\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_ecommerce_checkout_api_v2"></a> [apim\_ecommerce\_checkout\_api\_v2](#module\_apim\_ecommerce\_checkout\_api\_v2) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_ecommerce_checkout_api_v3"></a> [apim\_ecommerce\_checkout\_api\_v3](#module\_apim\_ecommerce\_checkout\_api\_v3) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_ecommerce_checkout_product"></a> [apim\_ecommerce\_checkout\_product](#module\_apim\_ecommerce\_checkout\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_ecommerce_healthcheck_api_v1"></a> [apim\_ecommerce\_healthcheck\_api\_v1](#module\_apim\_ecommerce\_healthcheck\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_ecommerce_helpdesk_commands_product"></a> [apim\_ecommerce\_helpdesk\_commands\_product](#module\_apim\_ecommerce\_helpdesk\_commands\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_ecommerce_helpdesk_product"></a> [apim\_ecommerce\_helpdesk\_product](#module\_apim\_ecommerce\_helpdesk\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_ecommerce_io_api_v2"></a> [apim\_ecommerce\_io\_api\_v2](#module\_apim\_ecommerce\_io\_api\_v2) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_ecommerce_io_outcomes_api_v1"></a> [apim\_ecommerce\_io\_outcomes\_api\_v1](#module\_apim\_ecommerce\_io\_outcomes\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_ecommerce_io_product"></a> [apim\_ecommerce\_io\_product](#module\_apim\_ecommerce\_io\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_ecommerce_payment_methods_handler_api_v1"></a> [apim\_ecommerce\_payment\_methods\_handler\_api\_v1](#module\_apim\_ecommerce\_payment\_methods\_handler\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_ecommerce_payment_methods_handler_product"></a> [apim\_ecommerce\_payment\_methods\_handler\_product](#module\_apim\_ecommerce\_payment\_methods\_handler\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_ecommerce_payment_methods_product"></a> [apim\_ecommerce\_payment\_methods\_product](#module\_apim\_ecommerce\_payment\_methods\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_ecommerce_payment_methods_service_api_v1"></a> [apim\_ecommerce\_payment\_methods\_service\_api\_v1](#module\_apim\_ecommerce\_payment\_methods\_service\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_ecommerce_payment_methods_service_api_v2"></a> [apim\_ecommerce\_payment\_methods\_service\_api\_v2](#module\_apim\_ecommerce\_payment\_methods\_service\_api\_v2) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_ecommerce_payment_requests_service_api_v1"></a> [apim\_ecommerce\_payment\_requests\_service\_api\_v1](#module\_apim\_ecommerce\_payment\_requests\_service\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_ecommerce_product"></a> [apim\_ecommerce\_product](#module\_apim\_ecommerce\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_ecommerce_redirect_outcome_api_v1"></a> [apim\_ecommerce\_redirect\_outcome\_api\_v1](#module\_apim\_ecommerce\_redirect\_outcome\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_ecommerce_redirect_product"></a> [apim\_ecommerce\_redirect\_product](#module\_apim\_ecommerce\_redirect\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_ecommerce_transaction_auth_requests_service_api_v1"></a> [apim\_ecommerce\_transaction\_auth\_requests\_service\_api\_v1](#module\_apim\_ecommerce\_transaction\_auth\_requests\_service\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_ecommerce_transaction_auth_requests_service_api_v2"></a> [apim\_ecommerce\_transaction\_auth\_requests\_service\_api\_v2](#module\_apim\_ecommerce\_transaction\_auth\_requests\_service\_api\_v2) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_ecommerce_transaction_user_receipts_service_api_v1"></a> [apim\_ecommerce\_transaction\_user\_receipts\_service\_api\_v1](#module\_apim\_ecommerce\_transaction\_user\_receipts\_service\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_ecommerce_transactions_service_api_v1"></a> [apim\_ecommerce\_transactions\_service\_api\_v1](#module\_apim\_ecommerce\_transactions\_service\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_ecommerce_transactions_service_api_v2"></a> [apim\_ecommerce\_transactions\_service\_api\_v2](#module\_apim\_ecommerce\_transactions\_service\_api\_v2) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_ecommerce_user_stats_service_api_v1"></a> [apim\_ecommerce\_user\_stats\_service\_api\_v1](#module\_apim\_ecommerce\_user\_stats\_service\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_ecommerce_webview_api_v1"></a> [apim\_ecommerce\_webview\_api\_v1](#module\_apim\_ecommerce\_webview\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_ecommerce_webview_api_v2"></a> [apim\_ecommerce\_webview\_api\_v2](#module\_apim\_ecommerce\_webview\_api\_v2) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_ecommerce_webview_product"></a> [apim\_ecommerce\_webview\_product](#module\_apim\_ecommerce\_webview\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_pagopa_ecommerce_helpdesk_commands_service_api_v1"></a> [apim\_pagopa\_ecommerce\_helpdesk\_commands\_service\_api\_v1](#module\_apim\_pagopa\_ecommerce\_helpdesk\_commands\_service\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_pagopa_ecommerce_helpdesk_service_api_v1"></a> [apim\_pagopa\_ecommerce\_helpdesk\_service\_api\_v1](#module\_apim\_pagopa\_ecommerce\_helpdesk\_service\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_pagopa_ecommerce_helpdesk_service_api_v2"></a> [apim\_pagopa\_ecommerce\_helpdesk\_service\_api\_v2](#module\_apim\_pagopa\_ecommerce\_helpdesk\_service\_api\_v2) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_pagopa_ecommerce_technical_helpdesk_service_api_v1"></a> [apim\_pagopa\_ecommerce\_technical\_helpdesk\_service\_api\_v1](#module\_apim\_pagopa\_ecommerce\_technical\_helpdesk\_service\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_pagopa_ecommerce_technical_helpdesk_service_api_v2"></a> [apim\_pagopa\_ecommerce\_technical\_helpdesk\_service\_api\_v2](#module\_apim\_pagopa\_ecommerce\_technical\_helpdesk\_service\_api\_v2) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_pagopa_notifications_service_api_v1"></a> [apim\_pagopa\_notifications\_service\_api\_v1](#module\_apim\_pagopa\_notifications\_service\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_cert_mounter"></a> [cert\_mounter](#module\_cert\_mounter) | ./.terraform/modules/__v3__/cert_mounter | n/a |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../../tag_config | n/a |
| <a name="module_tls_checker"></a> [tls\_checker](#module\_tls\_checker) | ./.terraform/modules/__v3__/tls_checker | n/a |
| <a name="module_workload_identity"></a> [workload\_identity](#module\_workload\_identity) | ./.terraform/modules/__v3__/kubernetes_workload_identity_configuration | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_api.apim_ecommerce_gec_mock_v1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_ecommerce_gec_mock_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_ecommerce_node_forwarder_mock](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_ecommerce_nodo_mock](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_ecommerce_nodo_per_pm_mock](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_ecommerce_npg_mock](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_ecommerce_npg_notifications](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api.apim_ecommerce_pdv_mock](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api_operation_policy.auth_request_gateway_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.auth_request_gateway_policy_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.confirm_payment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.create_session](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.create_transactions_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.delete_transaction](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.get_card_data](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.get_card_data_information](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.get_carts_redirect](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.get_fees](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.get_fees_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.get_method_testing](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.get_order](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.get_payment_request_info_api_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.get_payment_request_info_api_policy_v3](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.get_state](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.get_transaction_info](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.get_transaction_info_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.get_transaction_outcomes](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.helpdesk_pgs_vpos](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.helpdesk_pgs_xpay](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.helpdesk_pm_search_bulk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.io_calculate_fee_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.io_post_wallet_transactions_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.io_transaction_authorization_request_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.nodo_per_pm_check_position_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.nodo_per_pm_close_payment_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.npg_notifications_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.post_orders_build](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.refund_payment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.transaction_activation_request](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.transaction_activation_request_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.transaction_activation_request_v3](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.transaction_authorization_request](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_policy.apim_ecommerce_gec_mock_policy_v1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_ecommerce_gec_mock_policy_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_ecommerce_node_forwarder_mock_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_ecommerce_nodo_mock_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_ecommerce_nodo_per_pm_mock_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_ecommerce_npg_mock_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_ecommerce_npg_notifications_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_policy.apim_ecommerce_pdv_mock_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_version_set.apim_ecommerce_gec_mock_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_ecommerce_node_forwarder_mock_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_ecommerce_nodo_mock_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_ecommerce_nodo_per_pm_mock_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_ecommerce_npg_mock_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_ecommerce_npg_notification_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_ecommerce_pdv_mock_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_ecommerce_redirect_outcome_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_ecommerce_webview_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.ecommerce_checkout_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.ecommerce_healthcheck_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.ecommerce_io_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.ecommerce_io_outcomes_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.ecommerce_payment_methods_handler_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.ecommerce_payment_methods_service_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.ecommerce_payment_requests_service_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.ecommerce_transaction_auth_requests_service_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.ecommerce_transaction_user_receipts_service_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.ecommerce_transactions_service_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.ecommerce_user_stats_service_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pagopa_ecommerce_helpdesk_commands_service_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pagopa_ecommerce_helpdesk_service_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pagopa_ecommerce_technical_helpdesk_service_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.pagopa_notifications_service_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_group.ecommerce-methods-full-read](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_named_value.ecommerce-io-jwt-signing-key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.ecommerce-personal-data-vault-api-key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.ecommerce-webview-jwt-signing-key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.ecommerce_checkout_transaction_jwt_signing_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.ecommerce_dev_sendpaymentresult_subscription_key_named_value](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.ecommerce_for_checkout_google_recaptcha_secret_named_value](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.ecommerce_helpdesk_command_service_api_key_value](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.ecommerce_io_transaction_jwt_signing_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.ecommerce_notification_service_api_key_value](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.ecommerce_payment_methods_api_key_value](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.ecommerce_payment_requests_api_key_value](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.ecommerce_transactions_service_api_key_value](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.ecommerce_user_stats_service_api_key_value](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.npg_notification_jwt_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.pagopa_ecommerce_helpdesk_service_rest_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_product_api.apim_ecommerce_gec_mock_product_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_api) | resource |
| [azurerm_api_management_product_api.apim_ecommerce_gec_mock_product_api_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_api) | resource |
| [azurerm_api_management_product_api.apim_ecommerce_node_forwarder_mock_product_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_api) | resource |
| [azurerm_api_management_product_api.apim_ecommerce_nodo_mock_product_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_api) | resource |
| [azurerm_api_management_product_api.apim_ecommerce_nodo_per_pm_mock_product_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_api) | resource |
| [azurerm_api_management_product_api.apim_ecommerce_npg_mock_product_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_api) | resource |
| [azurerm_api_management_product_api.apim_ecommerce_npg_notifications_product_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_api) | resource |
| [azurerm_api_management_product_api.apim_ecommerce_pdv_mock_product_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_api) | resource |
| [azurerm_key_vault_secret.aks_apiserver_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_cacrt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [helm_release.reloader](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/2.30.0/docs/resources/namespace) | resource |
| [kubernetes_namespace.namespace_system](https://registry.terraform.io/providers/hashicorp/kubernetes/2.30.0/docs/resources/namespace) | resource |
| [kubernetes_pod_disruption_budget_v1.ecommerce](https://registry.terraform.io/providers/hashicorp/kubernetes/2.30.0/docs/resources/pod_disruption_budget_v1) | resource |
| [kubernetes_role_binding.deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/2.30.0/docs/resources/role_binding) | resource |
| [kubernetes_role_binding.system_deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/2.30.0/docs/resources/role_binding) | resource |
| [kubernetes_service_account.azure_devops](https://registry.terraform.io/providers/hashicorp/kubernetes/2.30.0/docs/resources/service_account) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/data-sources/group) | data source |
| [azurerm_api_management_product.technical_support_api_product](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management_product) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.ecommerce_checkout_sessions_jwt_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.ecommerce_dev_sendpaymentresult_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.ecommerce_for_checkout_google_recaptcha_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.ecommerce_helpdesk_command_service_primary_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.ecommerce_helpdesk_command_service_secondary_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.ecommerce_io_jwt_signing_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.ecommerce_io_sessions_jwt_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.ecommerce_notification_service_primary_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.ecommerce_notification_service_secondary_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.ecommerce_payment_methods_primary_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.ecommerce_payment_methods_secondary_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.ecommerce_payment_requests_primary_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.ecommerce_payment_requests_secondary_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.ecommerce_transactions_service_primary_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.ecommerce_transactions_service_secondary_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.ecommerce_user_stats_service_primary_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.ecommerce_user_stats_service_secondary_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.ecommerce_webview_jwt_signing_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.npg_notification_jwt_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pagopa_ecommerce_helpdesk_service_rest_api_primary_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pagopa_ecommerce_helpdesk_service_rest_api_secondary_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.personal_data_vault_api_key_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.apim_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [kubernetes_secret.azure_devops_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/2.30.0/docs/data-sources/secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_dns_zone_prefix"></a> [apim\_dns\_zone\_prefix](#input\_apim\_dns\_zone\_prefix) | The dns subdomain for apim. | `string` | `null` | no |
| <a name="input_dns_zone_checkout"></a> [dns\_zone\_checkout](#input\_dns\_zone\_checkout) | The checkout dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_ecommerce_helpdesk_command_service_api_key_use_primary"></a> [ecommerce\_helpdesk\_command\_service\_api\_key\_use\_primary](#input\_ecommerce\_helpdesk\_command\_service\_api\_key\_use\_primary) | Whenever to use primary or secondary key invoking helpdesk-command-service | `bool` | `true` | no |
| <a name="input_ecommerce_helpdesk_service_api_key_use_primary"></a> [ecommerce\_helpdesk\_service\_api\_key\_use\_primary](#input\_ecommerce\_helpdesk\_service\_api\_key\_use\_primary) | If true the current active API key used for helpdesk service requests will be the primary one. | `bool` | `true` | no |
| <a name="input_ecommerce_io_with_pm_enabled"></a> [ecommerce\_io\_with\_pm\_enabled](#input\_ecommerce\_io\_with\_pm\_enabled) | ecommerce for IO using Payment Manager enabled | `bool` | `false` | no |
| <a name="input_ecommerce_notification_service_api_key_use_primary"></a> [ecommerce\_notification\_service\_api\_key\_use\_primary](#input\_ecommerce\_notification\_service\_api\_key\_use\_primary) | If true the current active API key used for notification service will be the primary one. | `bool` | `true` | no |
| <a name="input_ecommerce_payment_methods_api_key_use_primary"></a> [ecommerce\_payment\_methods\_api\_key\_use\_primary](#input\_ecommerce\_payment\_methods\_api\_key\_use\_primary) | If true the current active API key used for payment methods will be the primary one. | `bool` | `true` | no |
| <a name="input_ecommerce_payment_requests_api_key_use_primary"></a> [ecommerce\_payment\_requests\_api\_key\_use\_primary](#input\_ecommerce\_payment\_requests\_api\_key\_use\_primary) | If true the current active API key used for payment requests will be the primary one. | `bool` | `true` | no |
| <a name="input_ecommerce_transactions_service_api_key_use_primary"></a> [ecommerce\_transactions\_service\_api\_key\_use\_primary](#input\_ecommerce\_transactions\_service\_api\_key\_use\_primary) | Whenever to use primary or secondary key invoking transactions-service | `bool` | `true` | no |
| <a name="input_ecommerce_user_stats_service_api_key_use_primary"></a> [ecommerce\_user\_stats\_service\_api\_key\_use\_primary](#input\_ecommerce\_user\_stats\_service\_api\_key\_use\_primary) | Whenever to use primary or secondary key invoking user-stats-service | `bool` | `true` | no |
| <a name="input_ecommerce_vpos_psps_list"></a> [ecommerce\_vpos\_psps\_list](#input\_ecommerce\_vpos\_psps\_list) | psps list using vpos as comma separated value | `string` | `""` | no |
| <a name="input_ecommerce_xpay_psps_list"></a> [ecommerce\_xpay\_psps\_list](#input\_ecommerce\_xpay\_psps\_list) | psps list using xpay as comma separated value | `string` | `""` | no |
| <a name="input_enabled_payment_wallet_method_ids_pm"></a> [enabled\_payment\_wallet\_method\_ids\_pm](#input\_enabled\_payment\_wallet\_method\_ids\_pm) | Comma separated list of eCommerce payment method ids that are enabled with PM APIs | `string` | `""` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_io_backend_base_path"></a> [io\_backend\_base\_path](#input\_io\_backend\_base\_path) | io backend api base path | `string` | `null` | no |
| <a name="input_k8s_kube_config_path_prefix"></a> [k8s\_kube\_config\_path\_prefix](#input\_k8s\_kube\_config\_path\_prefix) | n/a | `string` | `"~/.kube"` | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_location_string"></a> [location\_string](#input\_location\_string) | One of West Europe, North Europe | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_pagopa_vpn"></a> [pagopa\_vpn](#input\_pagopa\_vpn) | pagoPA on prem VPN | <pre>object({<br/>    ips = list(string)<br/>  })</pre> | n/a | yes |
| <a name="input_pagopa_vpn_dr"></a> [pagopa\_vpn\_dr](#input\_pagopa\_vpn\_dr) | pagoPA on prem VPN DR | <pre>object({<br/>    ips = list(string)<br/>  })</pre> | n/a | yes |
| <a name="input_pdv_api_base_path"></a> [pdv\_api\_base\_path](#input\_pdv\_api\_base\_path) | Personal data vault api base path | `string` | `null` | no |
| <a name="input_pod_disruption_budgets"></a> [pod\_disruption\_budgets](#input\_pod\_disruption\_budgets) | Pod disruption budget for domain namespace | <pre>map(object({<br/>    name         = optional(string, null)<br/>    minAvailable = optional(number, null)<br/>    matchLabels  = optional(map(any), {})<br/>  }))</pre> | `{}` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_tls_cert_check_helm"></a> [tls\_cert\_check\_helm](#input\_tls\_cert\_check\_helm) | tls cert helm chart configuration | <pre>object({<br/>    chart_version = string,<br/>    image_name    = string,<br/>    image_tag     = string<br/>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
