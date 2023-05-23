#!/bin/bash
# Generated with `generate_imports.py`

# module.pagopa_proxy_snet
echo 'Importing module.pagopa_proxy_snet.azurerm_subnet.this'
./terraform.sh import weu-dev 'module.pagopa_proxy_snet.azurerm_subnet.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-vnet-rg/providers/Microsoft.Network/virtualNetworks/pagopa-d-vnet/subnets/pagopa-d-pagopa-proxy-snet'


# module.pagopa_proxy_app_service
echo 'Importing module.pagopa_proxy_app_service.azurerm_app_service.this'
./terraform.sh import weu-dev 'module.pagopa_proxy_app_service.azurerm_app_service.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-pagopa-proxy-rg/providers/Microsoft.Web/sites/pagopa-d-app-pagopa-proxy'


# module.pagopa_proxy_app_service
echo 'Importing module.pagopa_proxy_app_service.azurerm_app_service_plan.this[0]'
./terraform.sh import weu-dev 'module.pagopa_proxy_app_service.azurerm_app_service_plan.this[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-pagopa-proxy-rg/providers/Microsoft.Web/serverfarms/pagopa-d-plan-pagopa-proxy'


# module.pagopa_proxy_app_service
echo 'Importing module.pagopa_proxy_app_service.azurerm_app_service_virtual_network_swift_connection.app_service_virtual_network_swift_connection[0]'
./terraform.sh import weu-dev 'module.pagopa_proxy_app_service.azurerm_app_service_virtual_network_swift_connection.app_service_virtual_network_swift_connection[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-pagopa-proxy-rg/providers/Microsoft.Web/sites/pagopa-d-app-pagopa-proxy/config/virtualNetwork'


# resource.azurerm_monitor_autoscale_setting.pagopa_proxy_app_service_autoscale
echo 'Importing azurerm_monitor_autoscale_setting.pagopa_proxy_app_service_autoscale'
./terraform.sh import weu-dev 'azurerm_monitor_autoscale_setting.pagopa_proxy_app_service_autoscale' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-pagopa-proxy-rg/providers/Microsoft.Insights/autoscaleSettings/pagopa-d-autoscale-pagopa-proxy'


# resource.azurerm_resource_group.checkout_be_rg[0]
echo 'Importing azurerm_resource_group.checkout_be_rg[0]'
./terraform.sh import weu-dev 'azurerm_resource_group.checkout_be_rg[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-checkout-be-rg'


# module.checkout_function_snet[0]
echo 'Importing module.checkout_function_snet[0].azurerm_subnet.this'
./terraform.sh import weu-dev 'module.checkout_function_snet[0].azurerm_subnet.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-vnet-rg/providers/Microsoft.Network/virtualNetworks/pagopa-d-vnet/subnets/pagopa-d-checkout-be-snet'


# module.checkout_function[0]
echo 'Importing module.checkout_function[0].azurerm_app_service_plan.this[0]'
./terraform.sh import weu-dev 'module.checkout_function[0].azurerm_app_service_plan.this[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-checkout-be-rg/providers/Microsoft.Web/serverfarms/pagopa-d-plan-fncheckout'


# module.checkout_function[0]
echo 'Importing module.checkout_function[0].azurerm_app_service_virtual_network_swift_connection.this[0]'
./terraform.sh import weu-dev 'module.checkout_function[0].azurerm_app_service_virtual_network_swift_connection.this[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-checkout-be-rg/providers/Microsoft.Web/sites/pagopa-d-fn-checkout/config/virtualNetwork'


# module.checkout_function[0]
echo 'Importing module.checkout_function[0].azurerm_function_app.this'
./terraform.sh import weu-dev 'module.checkout_function[0].azurerm_function_app.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-checkout-be-rg/providers/Microsoft.Web/sites/pagopa-d-fn-checkout'


# module.checkout_function[0]
echo 'Importing module.checkout_function[0].module.storage_account.azurerm_advanced_threat_protection.this'
./terraform.sh import weu-dev 'module.checkout_function[0].module.storage_account.azurerm_advanced_threat_protection.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-checkout-be-rg/providers/Microsoft.Storage/storageAccounts/pagopadstfncheckout/providers/Microsoft.Security/advancedThreatProtectionSettings/current'


# module.checkout_function[0]
echo 'Importing module.checkout_function[0].module.storage_account.azurerm_storage_account.this'
./terraform.sh import weu-dev 'module.checkout_function[0].module.storage_account.azurerm_storage_account.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-checkout-be-rg/providers/Microsoft.Storage/storageAccounts/pagopadstfncheckout'


# resource.azurerm_resource_group.checkout_fe_rg[0]
echo 'Importing azurerm_resource_group.checkout_fe_rg[0]'
./terraform.sh import weu-dev 'azurerm_resource_group.checkout_fe_rg[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-checkout-fe-rg'


# module.checkout_cdn[0]
echo 'Importing module.checkout_cdn[0].azurerm_cdn_endpoint.this'
./terraform.sh import weu-dev 'module.checkout_cdn[0].azurerm_cdn_endpoint.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-checkout-fe-rg/providers/Microsoft.Cdn/profiles/pagopa-d-checkout-cdn-profile/endpoints/pagopa-d-checkout-cdn-endpoint'


# module.checkout_cdn[0]
echo 'Importing module.checkout_cdn[0].azurerm_cdn_profile.this'
./terraform.sh import weu-dev 'module.checkout_cdn[0].azurerm_cdn_profile.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-checkout-fe-rg/providers/Microsoft.Cdn/profiles/pagopa-d-checkout-cdn-profile'


# module.checkout_cdn[0]
echo 'Importing module.checkout_cdn[0].azurerm_dns_a_record.hostname[0]'
./terraform.sh import weu-dev 'module.checkout_cdn[0].azurerm_dns_a_record.hostname[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-vnet-rg/providers/Microsoft.Network/dnszones/dev.checkout.pagopa.it/A/@'


# module.checkout_cdn[0]
echo 'Importing module.checkout_cdn[0].azurerm_dns_cname_record.cdnverify[0]'
./terraform.sh import weu-dev 'module.checkout_cdn[0].azurerm_dns_cname_record.cdnverify[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-vnet-rg/providers/Microsoft.Network/dnszones/dev.checkout.pagopa.it/CNAME/cdnverify'


# module.checkout_cdn[0]
echo 'Importing module.checkout_cdn[0].null_resource.custom_domain'
./terraform.sh import weu-dev 'module.checkout_cdn[0].null_resource.custom_domain' '8858238341805618174'


# module.checkout_cdn[0]
echo 'Importing module.checkout_cdn[0].module.cdn_storage_account.azurerm_advanced_threat_protection.this'
./terraform.sh import weu-dev 'module.checkout_cdn[0].module.cdn_storage_account.azurerm_advanced_threat_protection.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-checkout-fe-rg/providers/Microsoft.Storage/storageAccounts/pagopadcheckoutsa/providers/Microsoft.Security/advancedThreatProtectionSettings/current'


# module.checkout_cdn[0]
echo 'Importing module.checkout_cdn[0].module.cdn_storage_account.azurerm_storage_account.this'
./terraform.sh import weu-dev 'module.checkout_cdn[0].module.cdn_storage_account.azurerm_storage_account.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-checkout-fe-rg/providers/Microsoft.Storage/storageAccounts/pagopadcheckoutsa'


# module.checkout_cdn[0]
echo 'Importing module.checkout_cdn[0].module.cdn_storage_account.azurerm_template_deployment.versioning[0]'
./terraform.sh import weu-dev 'module.checkout_cdn[0].module.cdn_storage_account.azurerm_template_deployment.versioning[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-checkout-fe-rg/providers/Microsoft.Resources/deployments/pagopa-d-checkout-sa-versioning'


# module.apim_checkout_product[0]
echo 'Importing module.apim_checkout_product[0].azurerm_api_management_product.this'
./terraform.sh import weu-dev 'module.apim_checkout_product[0].azurerm_api_management_product.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/products/checkout'


# module.apim_checkout_product[0]
echo 'Importing module.apim_checkout_product[0].azurerm_api_management_product_policy.this[0]'
./terraform.sh import weu-dev 'module.apim_checkout_product[0].azurerm_api_management_product_policy.this[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/products/checkout/policies/policy'


# resource.azurerm_api_management_api_version_set.checkout_payment_activations_api
echo 'Importing azurerm_api_management_api_version_set.checkout_payment_activations_api'
./terraform.sh import weu-dev 'azurerm_api_management_api_version_set.checkout_payment_activations_api' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apiVersionSets/pagopa-d-checkout-payment-activations-api'


# module.apim_checkout_payment_activations_api_v1
echo 'Importing module.apim_checkout_payment_activations_api_v1.azurerm_api_management_api.this'
./terraform.sh import weu-dev 'module.apim_checkout_payment_activations_api_v1.azurerm_api_management_api.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apis/pagopa-d-checkout-payment-activations-api-v1'


# module.apim_checkout_payment_activations_api_v1
echo 'Importing module.apim_checkout_payment_activations_api_v1.azurerm_api_management_api_policy.this[0]'
./terraform.sh import weu-dev 'module.apim_checkout_payment_activations_api_v1.azurerm_api_management_api_policy.this[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apis/pagopa-d-checkout-payment-activations-api-v1/policies/xml'


# module.apim_checkout_payment_activations_api_v1
echo 'Importing module.apim_checkout_payment_activations_api_v1.azurerm_api_management_product_api.this["checkout"]'
./terraform.sh import weu-dev 'module.apim_checkout_payment_activations_api_v1.azurerm_api_management_product_api.this["checkout"]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/products/checkout/apis/pagopa-d-checkout-payment-activations-api-v1'


# resource.azurerm_api_management_api_operation_policy.get_payment_info_api
echo 'Importing azurerm_api_management_api_operation_policy.get_payment_info_api'
./terraform.sh import weu-dev 'azurerm_api_management_api_operation_policy.get_payment_info_api' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apis/pagopa-d-checkout-payment-activations-api-v1/operations/getPaymentInfo/policies/policy'


# resource.azurerm_api_management_api_operation_policy.activate_payment_api
echo 'Importing azurerm_api_management_api_operation_policy.activate_payment_api'
./terraform.sh import weu-dev 'azurerm_api_management_api_operation_policy.activate_payment_api' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apis/pagopa-d-checkout-payment-activations-api-v1/operations/activatePayment/policies/policy'


# resource.azurerm_api_management_api_version_set.checkout_payment_activations_auth_api
echo 'Importing azurerm_api_management_api_version_set.checkout_payment_activations_auth_api'
./terraform.sh import weu-dev 'azurerm_api_management_api_version_set.checkout_payment_activations_auth_api' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apiVersionSets/pagopa-d-checkout-payment-activations-auth-api'


# module.apim_checkout_payment_activations_api_auth_v1
echo 'Importing module.apim_checkout_payment_activations_api_auth_v1.azurerm_api_management_api.this'
./terraform.sh import weu-dev 'module.apim_checkout_payment_activations_api_auth_v1.azurerm_api_management_api.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apis/pagopa-d-checkout-payment-activations-auth-api-v1'


# module.apim_checkout_payment_activations_api_auth_v1
echo 'Importing module.apim_checkout_payment_activations_api_auth_v1.azurerm_api_management_api_policy.this[0]'
./terraform.sh import weu-dev 'module.apim_checkout_payment_activations_api_auth_v1.azurerm_api_management_api_policy.this[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apis/pagopa-d-checkout-payment-activations-auth-api-v1/policies/xml'


# module.apim_checkout_payment_activations_api_auth_v1
echo 'Importing module.apim_checkout_payment_activations_api_auth_v1.azurerm_api_management_product_api.this["checkout"]'
./terraform.sh import weu-dev 'module.apim_checkout_payment_activations_api_auth_v1.azurerm_api_management_product_api.this["checkout"]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/products/checkout/apis/pagopa-d-checkout-payment-activations-auth-api-v1'


# module.apim_checkout_payment_activations_api_auth_v2
echo 'Importing module.apim_checkout_payment_activations_api_auth_v2.azurerm_api_management_api.this'
./terraform.sh import weu-dev 'module.apim_checkout_payment_activations_api_auth_v2.azurerm_api_management_api.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apis/pagopa-d-checkout-payment-activations-auth-api-v2'


# module.apim_checkout_payment_activations_api_auth_v2
echo 'Importing module.apim_checkout_payment_activations_api_auth_v2.azurerm_api_management_api_policy.this[0]'
./terraform.sh import weu-dev 'module.apim_checkout_payment_activations_api_auth_v2.azurerm_api_management_api_policy.this[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apis/pagopa-d-checkout-payment-activations-auth-api-v2/policies/xml'


# module.apim_checkout_payment_activations_api_auth_v2
echo 'Importing module.apim_checkout_payment_activations_api_auth_v2.azurerm_api_management_product_api.this["checkout"]'
./terraform.sh import weu-dev 'module.apim_checkout_payment_activations_api_auth_v2.azurerm_api_management_product_api.this["checkout"]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/products/checkout/apis/pagopa-d-checkout-payment-activations-auth-api-v2'


# resource.azurerm_api_management_api_version_set.cd_info_wisp
echo 'Importing azurerm_api_management_api_version_set.cd_info_wisp'
./terraform.sh import weu-dev 'azurerm_api_management_api_version_set.cd_info_wisp' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apiVersionSets/pagopa-d-cd-info-wisp'


# resource.azurerm_api_management_api.apim_cd_info_wisp_v1
echo 'Importing azurerm_api_management_api.apim_cd_info_wisp_v1'
./terraform.sh import weu-dev 'azurerm_api_management_api.apim_cd_info_wisp_v1' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apis/pagopa-d-cd-info-wisp'


# resource.azurerm_api_management_api_policy.apim_cd_info_wisp_policy_v1
echo 'Importing azurerm_api_management_api_policy.apim_cd_info_wisp_policy_v1'
./terraform.sh import weu-dev 'azurerm_api_management_api_policy.apim_cd_info_wisp_policy_v1' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apis/pagopa-d-cd-info-wisp/policies/xml'


# resource.azurerm_api_management_product_api.apim_cd_info_wisp_product_v1
echo 'Importing azurerm_api_management_product_api.apim_cd_info_wisp_product_v1'
./terraform.sh import weu-dev 'azurerm_api_management_product_api.apim_cd_info_wisp_product_v1' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/products/checkout/apis/pagopa-d-cd-info-wisp'


# resource.azurerm_api_management_api_version_set.checkout_transactions_api[0]
echo 'Importing azurerm_api_management_api_version_set.checkout_transactions_api[0]'
./terraform.sh import weu-dev 'azurerm_api_management_api_version_set.checkout_transactions_api[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apiVersionSets/d-checkout-transactions-api'


# module.apim_checkout_transactions_api_v1[0]
echo 'Importing module.apim_checkout_transactions_api_v1[0].azurerm_api_management_api.this'
./terraform.sh import weu-dev 'module.apim_checkout_transactions_api_v1[0].azurerm_api_management_api.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apis/d-checkout-transactions-api-v1'


# module.apim_checkout_transactions_api_v1[0]
echo 'Importing module.apim_checkout_transactions_api_v1[0].azurerm_api_management_api_policy.this[0]'
./terraform.sh import weu-dev 'module.apim_checkout_transactions_api_v1[0].azurerm_api_management_api_policy.this[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apis/d-checkout-transactions-api-v1/policies/policy'


# module.apim_checkout_transactions_api_v1[0]
echo 'Importing module.apim_checkout_transactions_api_v1[0].azurerm_api_management_product_api.this["checkout"]'
./terraform.sh import weu-dev 'module.apim_checkout_transactions_api_v1[0].azurerm_api_management_product_api.this["checkout"]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/products/checkout/apis/d-checkout-transactions-api-v1'


# resource.azurerm_api_management_api_version_set.checkout_ecommerce_api_v1
echo 'Importing azurerm_api_management_api_version_set.checkout_ecommerce_api_v1'
./terraform.sh import weu-dev 'azurerm_api_management_api_version_set.checkout_ecommerce_api_v1' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apiVersionSets/pagopa-d-checkout-ecommerce-api'


# module.apim_checkout_ecommerce_api_v1
echo 'Importing module.apim_checkout_ecommerce_api_v1.azurerm_api_management_api.this'
./terraform.sh import weu-dev 'module.apim_checkout_ecommerce_api_v1.azurerm_api_management_api.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apis/pagopa-d-checkout-ecommerce-api-v1'


# module.apim_checkout_ecommerce_api_v1
echo 'Importing module.apim_checkout_ecommerce_api_v1.azurerm_api_management_api_policy.this[0]'
./terraform.sh import weu-dev 'module.apim_checkout_ecommerce_api_v1.azurerm_api_management_api_policy.this[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apis/pagopa-d-checkout-ecommerce-api-v1/policies/xml'


# module.apim_checkout_ecommerce_api_v1
echo 'Importing module.apim_checkout_ecommerce_api_v1.azurerm_api_management_product_api.this["checkout"]'
./terraform.sh import weu-dev 'module.apim_checkout_ecommerce_api_v1.azurerm_api_management_product_api.this["checkout"]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/products/checkout/apis/pagopa-d-checkout-ecommerce-api-v1'


# resource.azurerm_api_management_api_operation_policy.get_payment_request_info_api
echo 'Importing azurerm_api_management_api_operation_policy.get_payment_request_info_api'
./terraform.sh import weu-dev 'azurerm_api_management_api_operation_policy.get_payment_request_info_api' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apis/pagopa-d-checkout-ecommerce-api-v1/operations/getPaymentRequestInfo/policies/xml'


# resource.azurerm_api_management_api_operation_policy.transaction_authorization_request
echo 'Importing azurerm_api_management_api_operation_policy.transaction_authorization_request'
./terraform.sh import weu-dev 'azurerm_api_management_api_operation_policy.transaction_authorization_request' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apis/pagopa-d-checkout-ecommerce-api-v1/operations/requestTransactionAuthorization/policies/xml'


# module.apim_checkout_ec_product
echo 'Importing module.apim_checkout_ec_product.azurerm_api_management_product.this'
./terraform.sh import weu-dev 'module.apim_checkout_ec_product.azurerm_api_management_product.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/products/checkout-ec'


# module.apim_checkout_ec_product
echo 'Importing module.apim_checkout_ec_product.azurerm_api_management_product_policy.this[0]'
./terraform.sh import weu-dev 'module.apim_checkout_ec_product.azurerm_api_management_product_policy.this[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/products/checkout-ec/policies/xml'


# resource.azurerm_api_management_api_version_set.checkout_ec_api_v1
echo 'Importing azurerm_api_management_api_version_set.checkout_ec_api_v1'
./terraform.sh import weu-dev 'azurerm_api_management_api_version_set.checkout_ec_api_v1' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apiVersionSets/pagopa-d-checkout-ec-api'


# resource.azurerm_api_management_api_diagnostic.apim_logs["pagopa-d-checkout-payment-activations-api-v1"]
echo 'Importing azurerm_api_management_api_diagnostic.apim_logs["pagopa-d-checkout-payment-activations-api-v1"]'
./terraform.sh import weu-dev 'azurerm_api_management_api_diagnostic.apim_logs["pagopa-d-checkout-payment-activations-api-v1"]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apis/pagopa-d-checkout-payment-activations-api-v1/diagnostics/applicationinsights'


# resource.azurerm_api_management_api_diagnostic.apim_logs["pagopa-d-checkout-payment-activations-auth-api-v1"]
echo 'Importing azurerm_api_management_api_diagnostic.apim_logs["pagopa-d-checkout-payment-activations-auth-api-v1"]'
./terraform.sh import weu-dev 'azurerm_api_management_api_diagnostic.apim_logs["pagopa-d-checkout-payment-activations-auth-api-v1"]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apis/pagopa-d-checkout-payment-activations-auth-api-v1/diagnostics/applicationinsights'


# resource.azurerm_api_management_api_diagnostic.apim_logs["pagopa-d-checkout-payment-activations-auth-api-v2"]
echo 'Importing azurerm_api_management_api_diagnostic.apim_logs["pagopa-d-checkout-payment-activations-auth-api-v2"]'
./terraform.sh import weu-dev 'azurerm_api_management_api_diagnostic.apim_logs["pagopa-d-checkout-payment-activations-auth-api-v2"]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apis/pagopa-d-checkout-payment-activations-auth-api-v2/diagnostics/applicationinsights'


echo 'Import executed succesfully on dev environment! ⚡'
