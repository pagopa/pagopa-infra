#!/bin/bash
# Generated with `generate_imports.py`

# module.pagopa_proxy_snet
echo 'Importing module.pagopa_proxy_snet.azurerm_subnet.this'
./terraform.sh import weu-uat 'module.pagopa_proxy_snet.azurerm_subnet.this' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-vnet-rg/providers/Microsoft.Network/virtualNetworks/pagopa-u-vnet/subnets/pagopa-u-pagopa-proxy-snet'


# module.pagopa_proxy_app_service
echo 'Importing module.pagopa_proxy_app_service.azurerm_app_service.this'
./terraform.sh import weu-uat 'module.pagopa_proxy_app_service.azurerm_app_service.this' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-pagopa-proxy-rg/providers/Microsoft.Web/sites/pagopa-u-app-pagopa-proxy'


# module.pagopa_proxy_app_service
echo 'Importing module.pagopa_proxy_app_service.azurerm_app_service_plan.this[0]'
./terraform.sh import weu-uat 'module.pagopa_proxy_app_service.azurerm_app_service_plan.this[0]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-pagopa-proxy-rg/providers/Microsoft.Web/serverfarms/pagopa-u-plan-pagopa-proxy'


# module.pagopa_proxy_app_service
echo 'Importing module.pagopa_proxy_app_service.azurerm_app_service_virtual_network_swift_connection.app_service_virtual_network_swift_connection[0]'
./terraform.sh import weu-uat 'module.pagopa_proxy_app_service.azurerm_app_service_virtual_network_swift_connection.app_service_virtual_network_swift_connection[0]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-pagopa-proxy-rg/providers/Microsoft.Web/sites/pagopa-u-app-pagopa-proxy/config/virtualNetwork'


# resource.azurerm_monitor_autoscale_setting.pagopa_proxy_app_service_autoscale
echo 'Importing azurerm_monitor_autoscale_setting.pagopa_proxy_app_service_autoscale'
./terraform.sh import weu-uat 'azurerm_monitor_autoscale_setting.pagopa_proxy_app_service_autoscale' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-pagopa-proxy-rg/providers/Microsoft.Insights/autoscaleSettings/pagopa-u-autoscale-pagopa-proxy'


# resource.azurerm_resource_group.checkout_be_rg[0]
echo 'Importing azurerm_resource_group.checkout_be_rg[0]'
./terraform.sh import weu-uat 'azurerm_resource_group.checkout_be_rg[0]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-checkout-be-rg'


# module.checkout_function_snet[0]
echo 'Importing module.checkout_function_snet[0].azurerm_subnet.this'
./terraform.sh import weu-uat 'module.checkout_function_snet[0].azurerm_subnet.this' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-vnet-rg/providers/Microsoft.Network/virtualNetworks/pagopa-u-vnet/subnets/pagopa-u-checkout-be-snet'


# module.checkout_function[0]
echo 'Importing module.checkout_function[0].azurerm_app_service_plan.this[0]'
./terraform.sh import weu-uat 'module.checkout_function[0].azurerm_app_service_plan.this[0]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-checkout-be-rg/providers/Microsoft.Web/serverfarms/pagopa-u-plan-fncheckout'


# module.checkout_function[0]
echo 'Importing module.checkout_function[0].azurerm_app_service_virtual_network_swift_connection.this[0]'
./terraform.sh import weu-uat 'module.checkout_function[0].azurerm_app_service_virtual_network_swift_connection.this[0]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-checkout-be-rg/providers/Microsoft.Web/sites/pagopa-u-fn-checkout/config/virtualNetwork'


# module.checkout_function[0]
echo 'Importing module.checkout_function[0].azurerm_function_app.this'
./terraform.sh import weu-uat 'module.checkout_function[0].azurerm_function_app.this' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-checkout-be-rg/providers/Microsoft.Web/sites/pagopa-u-fn-checkout'


# module.checkout_function[0]
echo 'Importing module.checkout_function[0].module.storage_account.azurerm_advanced_threat_protection.this'
./terraform.sh import weu-uat 'module.checkout_function[0].module.storage_account.azurerm_advanced_threat_protection.this' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-checkout-be-rg/providers/Microsoft.Storage/storageAccounts/pagopaustfncheckout/providers/Microsoft.Security/advancedThreatProtectionSettings/current'


# module.checkout_function[0]
echo 'Importing module.checkout_function[0].module.storage_account.azurerm_storage_account.this'
./terraform.sh import weu-uat 'module.checkout_function[0].module.storage_account.azurerm_storage_account.this' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-checkout-be-rg/providers/Microsoft.Storage/storageAccounts/pagopaustfncheckout'


# resource.azurerm_monitor_autoscale_setting.checkout_function[0]
echo 'Importing azurerm_monitor_autoscale_setting.checkout_function[0]'
./terraform.sh import weu-uat 'azurerm_monitor_autoscale_setting.checkout_function[0]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-checkout-be-rg/providers/Microsoft.Insights/autoscaleSettings/pagopa-u-fn-checkout-autoscale'


# resource.azurerm_resource_group.checkout_fe_rg[0]
echo 'Importing azurerm_resource_group.checkout_fe_rg[0]'
./terraform.sh import weu-uat 'azurerm_resource_group.checkout_fe_rg[0]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-checkout-fe-rg'


# module.checkout_cdn[0]
echo 'Importing module.checkout_cdn[0].azurerm_cdn_endpoint.this'
./terraform.sh import weu-uat 'module.checkout_cdn[0].azurerm_cdn_endpoint.this' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-checkout-fe-rg/providers/Microsoft.Cdn/profiles/pagopa-u-checkout-cdn-profile/endpoints/pagopa-u-checkout-cdn-endpoint'


# module.checkout_cdn[0]
echo 'Importing module.checkout_cdn[0].azurerm_cdn_profile.this'
./terraform.sh import weu-uat 'module.checkout_cdn[0].azurerm_cdn_profile.this' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-checkout-fe-rg/providers/Microsoft.Cdn/profiles/pagopa-u-checkout-cdn-profile'


# module.checkout_cdn[0]
echo 'Importing module.checkout_cdn[0].azurerm_dns_a_record.hostname[0]'
./terraform.sh import weu-uat 'module.checkout_cdn[0].azurerm_dns_a_record.hostname[0]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-vnet-rg/providers/Microsoft.Network/dnszones/uat.checkout.pagopa.it/A/@'


# module.checkout_cdn[0]
echo 'Importing module.checkout_cdn[0].azurerm_dns_cname_record.cdnverify[0]'
./terraform.sh import weu-uat 'module.checkout_cdn[0].azurerm_dns_cname_record.cdnverify[0]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-vnet-rg/providers/Microsoft.Network/dnszones/uat.checkout.pagopa.it/CNAME/cdnverify'


# module.checkout_cdn[0]
echo 'Importing module.checkout_cdn[0].null_resource.custom_domain'
./terraform.sh import weu-uat 'module.checkout_cdn[0].null_resource.custom_domain' '5776404664123634236'


# module.checkout_cdn[0]
echo 'Importing module.checkout_cdn[0].module.cdn_storage_account.azurerm_advanced_threat_protection.this'
./terraform.sh import weu-uat 'module.checkout_cdn[0].module.cdn_storage_account.azurerm_advanced_threat_protection.this' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-checkout-fe-rg/providers/Microsoft.Storage/storageAccounts/pagopaucheckoutsa/providers/Microsoft.Security/advancedThreatProtectionSettings/current'


# module.checkout_cdn[0]
echo 'Importing module.checkout_cdn[0].module.cdn_storage_account.azurerm_storage_account.this'
./terraform.sh import weu-uat 'module.checkout_cdn[0].module.cdn_storage_account.azurerm_storage_account.this' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-checkout-fe-rg/providers/Microsoft.Storage/storageAccounts/pagopaucheckoutsa'


# module.checkout_cdn[0]
echo 'Importing module.checkout_cdn[0].module.cdn_storage_account.azurerm_template_deployment.versioning[0]'
./terraform.sh import weu-uat 'module.checkout_cdn[0].module.cdn_storage_account.azurerm_template_deployment.versioning[0]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-checkout-fe-rg/providers/Microsoft.Resources/deployments/pagopa-u-checkout-sa-versioning'


# module.apim_checkout_product[0]
echo 'Importing module.apim_checkout_product[0].azurerm_api_management_product.this'
./terraform.sh import weu-uat 'module.apim_checkout_product[0].azurerm_api_management_product.this' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/products/checkout'


# module.apim_checkout_product[0]
echo 'Importing module.apim_checkout_product[0].azurerm_api_management_product_policy.this[0]'
./terraform.sh import weu-uat 'module.apim_checkout_product[0].azurerm_api_management_product_policy.this[0]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/products/checkout/policies/policy'


# resource.azurerm_api_management_api_version_set.checkout_payment_activations_api
echo 'Importing azurerm_api_management_api_version_set.checkout_payment_activations_api'
./terraform.sh import weu-uat 'azurerm_api_management_api_version_set.checkout_payment_activations_api' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/apiVersionSets/pagopa-u-checkout-payment-activations-api'


# module.apim_checkout_payment_activations_api_v1
echo 'Importing module.apim_checkout_payment_activations_api_v1.azurerm_api_management_api.this'
./terraform.sh import weu-uat 'module.apim_checkout_payment_activations_api_v1.azurerm_api_management_api.this' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/apis/pagopa-u-checkout-payment-activations-api-v1'


# module.apim_checkout_payment_activations_api_v1
echo 'Importing module.apim_checkout_payment_activations_api_v1.azurerm_api_management_api_policy.this[0]'
./terraform.sh import weu-uat 'module.apim_checkout_payment_activations_api_v1.azurerm_api_management_api_policy.this[0]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/apis/pagopa-u-checkout-payment-activations-api-v1/policies/xml'


# module.apim_checkout_payment_activations_api_v1
echo 'Importing module.apim_checkout_payment_activations_api_v1.azurerm_api_management_product_api.this["checkout"]'
./terraform.sh import weu-uat 'module.apim_checkout_payment_activations_api_v1.azurerm_api_management_product_api.this["checkout"]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/products/checkout/apis/pagopa-u-checkout-payment-activations-api-v1'


# resource.azurerm_api_management_api_operation_policy.get_payment_info_api
echo 'Importing azurerm_api_management_api_operation_policy.get_payment_info_api'
./terraform.sh import weu-uat 'azurerm_api_management_api_operation_policy.get_payment_info_api' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/apis/pagopa-u-checkout-payment-activations-api-v1/operations/getPaymentInfo/policies/xml'


# resource.azurerm_api_management_api_operation_policy.activate_payment_api
echo 'Importing azurerm_api_management_api_operation_policy.activate_payment_api'
./terraform.sh import weu-uat 'azurerm_api_management_api_operation_policy.activate_payment_api' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/apis/pagopa-u-checkout-payment-activations-api-v1/operations/activatePayment/policies/xml'


# resource.azurerm_api_management_api_version_set.checkout_payment_activations_auth_api
echo 'Importing azurerm_api_management_api_version_set.checkout_payment_activations_auth_api'
./terraform.sh import weu-uat 'azurerm_api_management_api_version_set.checkout_payment_activations_auth_api' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/apiVersionSets/pagopa-u-checkout-payment-activations-auth-api'


# module.apim_checkout_payment_activations_api_auth_v1
echo 'Importing module.apim_checkout_payment_activations_api_auth_v1.azurerm_api_management_api.this'
./terraform.sh import weu-uat 'module.apim_checkout_payment_activations_api_auth_v1.azurerm_api_management_api.this' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/apis/pagopa-u-checkout-payment-activations-auth-api-v1'


# module.apim_checkout_payment_activations_api_auth_v1
echo 'Importing module.apim_checkout_payment_activations_api_auth_v1.azurerm_api_management_api_policy.this[0]'
./terraform.sh import weu-uat 'module.apim_checkout_payment_activations_api_auth_v1.azurerm_api_management_api_policy.this[0]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/apis/pagopa-u-checkout-payment-activations-auth-api-v1/policies/xml'


# module.apim_checkout_payment_activations_api_auth_v1
echo 'Importing module.apim_checkout_payment_activations_api_auth_v1.azurerm_api_management_product_api.this["checkout"]'
./terraform.sh import weu-uat 'module.apim_checkout_payment_activations_api_auth_v1.azurerm_api_management_product_api.this["checkout"]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/products/checkout/apis/pagopa-u-checkout-payment-activations-auth-api-v1'


# module.apim_checkout_payment_activations_api_auth_v2
echo 'Importing module.apim_checkout_payment_activations_api_auth_v2.azurerm_api_management_api.this'
./terraform.sh import weu-uat 'module.apim_checkout_payment_activations_api_auth_v2.azurerm_api_management_api.this' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/apis/pagopa-u-checkout-payment-activations-auth-api-v2'


# module.apim_checkout_payment_activations_api_auth_v2
echo 'Importing module.apim_checkout_payment_activations_api_auth_v2.azurerm_api_management_api_policy.this[0]'
./terraform.sh import weu-uat 'module.apim_checkout_payment_activations_api_auth_v2.azurerm_api_management_api_policy.this[0]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/apis/pagopa-u-checkout-payment-activations-auth-api-v2/policies/xml'


# module.apim_checkout_payment_activations_api_auth_v2
echo 'Importing module.apim_checkout_payment_activations_api_auth_v2.azurerm_api_management_product_api.this["checkout"]'
./terraform.sh import weu-uat 'module.apim_checkout_payment_activations_api_auth_v2.azurerm_api_management_product_api.this["checkout"]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/products/checkout/apis/pagopa-u-checkout-payment-activations-auth-api-v2'


# resource.azurerm_api_management_api_version_set.cd_info_wisp
echo 'Importing azurerm_api_management_api_version_set.cd_info_wisp'
./terraform.sh import weu-uat 'azurerm_api_management_api_version_set.cd_info_wisp' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/apiVersionSets/pagopa-u-cd-info-wisp'


# resource.azurerm_api_management_api.apim_cd_info_wisp_v1
echo 'Importing azurerm_api_management_api.apim_cd_info_wisp_v1'
./terraform.sh import weu-uat 'azurerm_api_management_api.apim_cd_info_wisp_v1' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/apis/pagopa-u-cd-info-wisp'


# resource.azurerm_api_management_api_policy.apim_cd_info_wisp_policy_v1
echo 'Importing azurerm_api_management_api_policy.apim_cd_info_wisp_policy_v1'
./terraform.sh import weu-uat 'azurerm_api_management_api_policy.apim_cd_info_wisp_policy_v1' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/apis/pagopa-u-cd-info-wisp/policies/xml'


# resource.azurerm_api_management_product_api.apim_cd_info_wisp_product_v1
echo 'Importing azurerm_api_management_product_api.apim_cd_info_wisp_product_v1'
./terraform.sh import weu-uat 'azurerm_api_management_product_api.apim_cd_info_wisp_product_v1' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/products/checkout/apis/pagopa-u-cd-info-wisp'


# resource.azurerm_api_management_api_version_set.checkout_transactions_api[0]
echo 'Importing azurerm_api_management_api_version_set.checkout_transactions_api[0]'
./terraform.sh import weu-uat 'azurerm_api_management_api_version_set.checkout_transactions_api[0]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/apiVersionSets/u-checkout-transactions-api'


# module.apim_checkout_transactions_api_v1[0]
echo 'Importing module.apim_checkout_transactions_api_v1[0].azurerm_api_management_api.this'
./terraform.sh import weu-uat 'module.apim_checkout_transactions_api_v1[0].azurerm_api_management_api.this' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/apis/u-checkout-transactions-api-v1'


# module.apim_checkout_transactions_api_v1[0]
echo 'Importing module.apim_checkout_transactions_api_v1[0].azurerm_api_management_api_policy.this[0]'
./terraform.sh import weu-uat 'module.apim_checkout_transactions_api_v1[0].azurerm_api_management_api_policy.this[0]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/apis/u-checkout-transactions-api-v1/policies/policy'


# module.apim_checkout_transactions_api_v1[0]
echo 'Importing module.apim_checkout_transactions_api_v1[0].azurerm_api_management_product_api.this["checkout"]'
./terraform.sh import weu-uat 'module.apim_checkout_transactions_api_v1[0].azurerm_api_management_product_api.this["checkout"]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/products/checkout/apis/u-checkout-transactions-api-v1'


# resource.azurerm_api_management_api_version_set.checkout_ecommerce_api_v1
echo 'Importing azurerm_api_management_api_version_set.checkout_ecommerce_api_v1'
./terraform.sh import weu-uat 'azurerm_api_management_api_version_set.checkout_ecommerce_api_v1' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/apiVersionSets/pagopa-u-checkout-ecommerce-api'


# module.apim_checkout_ecommerce_api_v1
echo 'Importing module.apim_checkout_ecommerce_api_v1.azurerm_api_management_api.this'
./terraform.sh import weu-uat 'module.apim_checkout_ecommerce_api_v1.azurerm_api_management_api.this' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/apis/pagopa-u-checkout-ecommerce-api-v1'


# module.apim_checkout_ecommerce_api_v1
echo 'Importing module.apim_checkout_ecommerce_api_v1.azurerm_api_management_api_policy.this[0]'
./terraform.sh import weu-uat 'module.apim_checkout_ecommerce_api_v1.azurerm_api_management_api_policy.this[0]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/apis/pagopa-u-checkout-ecommerce-api-v1/policies/xml'


# module.apim_checkout_ecommerce_api_v1
echo 'Importing module.apim_checkout_ecommerce_api_v1.azurerm_api_management_product_api.this["checkout"]'
./terraform.sh import weu-uat 'module.apim_checkout_ecommerce_api_v1.azurerm_api_management_product_api.this["checkout"]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/products/checkout/apis/pagopa-u-checkout-ecommerce-api-v1'


# resource.azurerm_api_management_api_operation_policy.get_payment_request_info_api
echo 'Importing azurerm_api_management_api_operation_policy.get_payment_request_info_api'
./terraform.sh import weu-uat 'azurerm_api_management_api_operation_policy.get_payment_request_info_api' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/apis/pagopa-u-checkout-ecommerce-api-v1/operations/getPaymentRequestInfo/policies/xml'


# resource.azurerm_api_management_api_operation_policy.transaction_authorization_request
echo 'Importing azurerm_api_management_api_operation_policy.transaction_authorization_request'
./terraform.sh import weu-uat 'azurerm_api_management_api_operation_policy.transaction_authorization_request' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/apis/pagopa-u-checkout-ecommerce-api-v1/operations/requestTransactionAuthorization/policies/xml'


# module.apim_checkout_ec_product
echo 'Importing module.apim_checkout_ec_product.azurerm_api_management_product.this'
./terraform.sh import weu-uat 'module.apim_checkout_ec_product.azurerm_api_management_product.this' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/products/checkout-ec'


# module.apim_checkout_ec_product
echo 'Importing module.apim_checkout_ec_product.azurerm_api_management_product_policy.this[0]'
./terraform.sh import weu-uat 'module.apim_checkout_ec_product.azurerm_api_management_product_policy.this[0]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/products/checkout-ec/policies/xml'


# resource.azurerm_api_management_api_version_set.checkout_ec_api_v1
echo 'Importing azurerm_api_management_api_version_set.checkout_ec_api_v1'
./terraform.sh import weu-uat 'azurerm_api_management_api_version_set.checkout_ec_api_v1' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/apiVersionSets/pagopa-u-checkout-ec-api'


# resource.azurerm_api_management_api_diagnostic.apim_logs["pagopa-u-checkout-payment-activations-api-v1"]
echo 'Importing azurerm_api_management_api_diagnostic.apim_logs["pagopa-u-checkout-payment-activations-api-v1"]'
./terraform.sh import weu-uat 'azurerm_api_management_api_diagnostic.apim_logs["pagopa-u-checkout-payment-activations-api-v1"]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/apis/pagopa-u-checkout-payment-activations-api-v1/diagnostics/applicationinsights'


# resource.azurerm_api_management_api_diagnostic.apim_logs["pagopa-u-checkout-payment-activations-auth-api-v1"]
echo 'Importing azurerm_api_management_api_diagnostic.apim_logs["pagopa-u-checkout-payment-activations-auth-api-v1"]'
./terraform.sh import weu-uat 'azurerm_api_management_api_diagnostic.apim_logs["pagopa-u-checkout-payment-activations-auth-api-v1"]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/apis/pagopa-u-checkout-payment-activations-auth-api-v1/diagnostics/applicationinsights'


# resource.azurerm_api_management_api_diagnostic.apim_logs["pagopa-u-checkout-payment-activations-auth-api-v2"]
echo 'Importing azurerm_api_management_api_diagnostic.apim_logs["pagopa-u-checkout-payment-activations-auth-api-v2"]'
./terraform.sh import weu-uat 'azurerm_api_management_api_diagnostic.apim_logs["pagopa-u-checkout-payment-activations-auth-api-v2"]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/apis/pagopa-u-checkout-payment-activations-auth-api-v2/diagnostics/applicationinsights'


# module.apim_checkout_ec_api_v1
echo 'Importing module.apim_checkout_ec_api_v1.azurerm_api_management_api.this'
./terraform.sh import weu-uat 'module.apim_checkout_ec_api_v1.azurerm_api_management_api.this' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/apis/pagopa-u-checkout-ec-api-v1'


# module.apim_checkout_ec_api_v1
echo 'Importing module.apim_checkout_ec_api_v1.azurerm_api_management_api_policy.this[0]'
./terraform.sh import weu-uat 'module.apim_checkout_ec_api_v1.azurerm_api_management_api_policy.this[0]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/apis/pagopa-u-checkout-ec-api-v1/policies/xml'


# module.apim_checkout_ec_api_v1
echo 'Importing module.apim_checkout_ec_api_v1.azurerm_api_management_product_api.this["checkout-ec"]'
./terraform.sh import weu-uat 'module.apim_checkout_ec_api_v1.azurerm_api_management_product_api.this["checkout-ec"]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/products/checkout-ec/apis/pagopa-u-checkout-ec-api-v1'


echo 'Import executed succesfully on uat environment! ⚡'
