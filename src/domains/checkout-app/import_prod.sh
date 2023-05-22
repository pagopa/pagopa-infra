#!/bin/bash
# Generated with `generate_imports.py`

# module.pagopa_proxy_snet
echo 'Importing module.pagopa_proxy_snet.azurerm_subnet.this'
./terraform.sh import weu-prod 'module.pagopa_proxy_snet.azurerm_subnet.this' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-vnet-rg/providers/Microsoft.Network/virtualNetworks/pagopa-p-vnet/subnets/pagopa-p-pagopa-proxy-snet'


# module.pagopa_proxy_app_service
echo 'Importing module.pagopa_proxy_app_service.azurerm_app_service.this'
./terraform.sh import weu-prod 'module.pagopa_proxy_app_service.azurerm_app_service.this' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-pagopa-proxy-rg/providers/Microsoft.Web/sites/pagopa-p-app-pagopa-proxy'


# module.pagopa_proxy_app_service
echo 'Importing module.pagopa_proxy_app_service.azurerm_app_service_plan.this[0]'
./terraform.sh import weu-prod 'module.pagopa_proxy_app_service.azurerm_app_service_plan.this[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-pagopa-proxy-rg/providers/Microsoft.Web/serverfarms/pagopa-p-plan-pagopa-proxy'


# module.pagopa_proxy_app_service
echo 'Importing module.pagopa_proxy_app_service.azurerm_app_service_virtual_network_swift_connection.app_service_virtual_network_swift_connection[0]'
./terraform.sh import weu-prod 'module.pagopa_proxy_app_service.azurerm_app_service_virtual_network_swift_connection.app_service_virtual_network_swift_connection[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-pagopa-proxy-rg/providers/Microsoft.Web/sites/pagopa-p-app-pagopa-proxy/config/virtualNetwork'


# module.pagopa_proxy_app_service_slot_staging[0]
echo 'Importing module.pagopa_proxy_app_service_slot_staging[0].azurerm_app_service_slot.this'
./terraform.sh import weu-prod 'module.pagopa_proxy_app_service_slot_staging[0].azurerm_app_service_slot.this' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-pagopa-proxy-rg/providers/Microsoft.Web/sites/pagopa-p-app-pagopa-proxy/slots/staging'


# module.pagopa_proxy_app_service_slot_staging[0]
echo 'Importing module.pagopa_proxy_app_service_slot_staging[0].azurerm_app_service_slot_virtual_network_swift_connection.app_service_virtual_network_swift_connection[0]'
./terraform.sh import weu-prod 'module.pagopa_proxy_app_service_slot_staging[0].azurerm_app_service_slot_virtual_network_swift_connection.app_service_virtual_network_swift_connection[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-pagopa-proxy-rg/providers/Microsoft.Web/sites/pagopa-p-app-pagopa-proxy/slots/staging/config/virtualNetwork'


# resource.azurerm_monitor_autoscale_setting.pagopa_proxy_app_service_autoscale
echo 'Importing azurerm_monitor_autoscale_setting.pagopa_proxy_app_service_autoscale'
./terraform.sh import weu-prod 'azurerm_monitor_autoscale_setting.pagopa_proxy_app_service_autoscale' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-pagopa-proxy-rg/providers/Microsoft.Insights/autoscaleSettings/pagopa-p-autoscale-pagopa-proxy'


# resource.azurerm_resource_group.checkout_be_rg[0]
echo 'Importing azurerm_resource_group.checkout_be_rg[0]'
./terraform.sh import weu-prod 'azurerm_resource_group.checkout_be_rg[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-checkout-be-rg'


# module.checkout_function_snet[0]
echo 'Importing module.checkout_function_snet[0].azurerm_subnet.this'
./terraform.sh import weu-prod 'module.checkout_function_snet[0].azurerm_subnet.this' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-vnet-rg/providers/Microsoft.Network/virtualNetworks/pagopa-p-vnet/subnets/pagopa-p-checkout-be-snet'


# module.checkout_function[0]
echo 'Importing module.checkout_function[0].azurerm_app_service_plan.this[0]'
./terraform.sh import weu-prod 'module.checkout_function[0].azurerm_app_service_plan.this[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-checkout-be-rg/providers/Microsoft.Web/serverfarms/pagopa-p-plan-fncheckout'


# module.checkout_function[0]
echo 'Importing module.checkout_function[0].azurerm_app_service_virtual_network_swift_connection.this[0]'
./terraform.sh import weu-prod 'module.checkout_function[0].azurerm_app_service_virtual_network_swift_connection.this[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-checkout-be-rg/providers/Microsoft.Web/sites/pagopa-p-fn-checkout/config/virtualNetwork'


# module.checkout_function[0]
echo 'Importing module.checkout_function[0].azurerm_function_app.this'
./terraform.sh import weu-prod 'module.checkout_function[0].azurerm_function_app.this' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-checkout-be-rg/providers/Microsoft.Web/sites/pagopa-p-fn-checkout'


# module.checkout_function[0]
echo 'Importing module.checkout_function[0].module.storage_account.azurerm_advanced_threat_protection.this'
./terraform.sh import weu-prod 'module.checkout_function[0].module.storage_account.azurerm_advanced_threat_protection.this' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-checkout-be-rg/providers/Microsoft.Storage/storageAccounts/pagopapstfncheckout/providers/Microsoft.Security/advancedThreatProtectionSettings/current'


# module.checkout_function[0]
echo 'Importing module.checkout_function[0].module.storage_account.azurerm_storage_account.this'
./terraform.sh import weu-prod 'module.checkout_function[0].module.storage_account.azurerm_storage_account.this' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-checkout-be-rg/providers/Microsoft.Storage/storageAccounts/pagopapstfncheckout'


# resource.azurerm_monitor_autoscale_setting.checkout_function[0]
echo 'Importing azurerm_monitor_autoscale_setting.checkout_function[0]'
./terraform.sh import weu-prod 'azurerm_monitor_autoscale_setting.checkout_function[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-checkout-be-rg/providers/Microsoft.Insights/autoscaleSettings/pagopa-p-fn-checkout-autoscale'


# resource.azurerm_monitor_scheduled_query_rules_alert.checkout_availability[0]
echo 'Importing azurerm_monitor_scheduled_query_rules_alert.checkout_availability[0]'
./terraform.sh import weu-prod 'azurerm_monitor_scheduled_query_rules_alert.checkout_availability[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-checkout-be-rg/providers/Microsoft.Insights/scheduledQueryRules/pagopa-p-fn-checkout-availability-alert'


# resource.azurerm_monitor_metric_alert.checkout_fn_5xx[0]
echo 'Importing azurerm_monitor_metric_alert.checkout_fn_5xx[0]'
./terraform.sh import weu-prod 'azurerm_monitor_metric_alert.checkout_fn_5xx[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-monitor-rg/providers/Microsoft.Insights/metricAlerts/pagopa-p-fn-checkout-5xx'


# resource.azurerm_resource_group.checkout_fe_rg[0]
echo 'Importing azurerm_resource_group.checkout_fe_rg[0]'
./terraform.sh import weu-prod 'azurerm_resource_group.checkout_fe_rg[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-checkout-fe-rg'


# module.checkout_cdn[0]
echo 'Importing module.checkout_cdn[0].azurerm_cdn_endpoint.this'
./terraform.sh import weu-prod 'module.checkout_cdn[0].azurerm_cdn_endpoint.this' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-checkout-fe-rg/providers/Microsoft.Cdn/profiles/pagopa-p-checkout-cdn-profile/endpoints/pagopa-p-checkout-cdn-endpoint'


# module.checkout_cdn[0]
echo 'Importing module.checkout_cdn[0].azurerm_cdn_profile.this'
./terraform.sh import weu-prod 'module.checkout_cdn[0].azurerm_cdn_profile.this' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-checkout-fe-rg/providers/Microsoft.Cdn/profiles/pagopa-p-checkout-cdn-profile'


# module.checkout_cdn[0]
echo 'Importing module.checkout_cdn[0].azurerm_dns_a_record.hostname[0]'
./terraform.sh import weu-prod 'module.checkout_cdn[0].azurerm_dns_a_record.hostname[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-vnet-rg/providers/Microsoft.Network/dnszones/checkout.pagopa.it/A/@'


# module.checkout_cdn[0]
echo 'Importing module.checkout_cdn[0].azurerm_dns_cname_record.cdnverify[0]'
./terraform.sh import weu-prod 'module.checkout_cdn[0].azurerm_dns_cname_record.cdnverify[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-vnet-rg/providers/Microsoft.Network/dnszones/checkout.pagopa.it/CNAME/cdnverify'


# module.checkout_cdn[0]
echo 'Importing module.checkout_cdn[0].null_resource.custom_domain'
./terraform.sh import weu-prod 'module.checkout_cdn[0].null_resource.custom_domain' '4997386310546923159'


# module.checkout_cdn[0]
echo 'Importing module.checkout_cdn[0].module.cdn_storage_account.azurerm_advanced_threat_protection.this'
./terraform.sh import weu-prod 'module.checkout_cdn[0].module.cdn_storage_account.azurerm_advanced_threat_protection.this' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-checkout-fe-rg/providers/Microsoft.Storage/storageAccounts/pagopapcheckoutsa/providers/Microsoft.Security/advancedThreatProtectionSettings/current'


# module.checkout_cdn[0]
echo 'Importing module.checkout_cdn[0].module.cdn_storage_account.azurerm_storage_account.this'
./terraform.sh import weu-prod 'module.checkout_cdn[0].module.cdn_storage_account.azurerm_storage_account.this' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-checkout-fe-rg/providers/Microsoft.Storage/storageAccounts/pagopapcheckoutsa'


# module.checkout_cdn[0]
echo 'Importing module.checkout_cdn[0].module.cdn_storage_account.azurerm_template_deployment.versioning[0]'
./terraform.sh import weu-prod 'module.checkout_cdn[0].module.cdn_storage_account.azurerm_template_deployment.versioning[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-checkout-fe-rg/providers/Microsoft.Resources/deployments/pagopa-p-checkout-sa-versioning'


# resource.azurerm_application_insights_web_test.checkout_fe_web_test[0]
echo 'Importing azurerm_application_insights_web_test.checkout_fe_web_test[0]'
./terraform.sh import weu-prod 'azurerm_application_insights_web_test.checkout_fe_web_test[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-monitor-rg/providers/Microsoft.Insights/webTests/pagopa-p-checkout-fe-web-test'


# module.apim_checkout_product[0]
echo 'Importing module.apim_checkout_product[0].azurerm_api_management_product.this'
./terraform.sh import weu-prod 'module.apim_checkout_product[0].azurerm_api_management_product.this' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/products/checkout'


# module.apim_checkout_product[0]
echo 'Importing module.apim_checkout_product[0].azurerm_api_management_product_policy.this[0]'
./terraform.sh import weu-prod 'module.apim_checkout_product[0].azurerm_api_management_product_policy.this[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/products/checkout/policies/policy'


# resource.azurerm_api_management_api_version_set.checkout_payment_activations_api
echo 'Importing azurerm_api_management_api_version_set.checkout_payment_activations_api'
./terraform.sh import weu-prod 'azurerm_api_management_api_version_set.checkout_payment_activations_api' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/apiVersionSets/pagopa-p-checkout-payment-activations-api'


# module.apim_checkout_payment_activations_api_v1
echo 'Importing module.apim_checkout_payment_activations_api_v1.azurerm_api_management_api.this'
./terraform.sh import weu-prod 'module.apim_checkout_payment_activations_api_v1.azurerm_api_management_api.this' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/apis/pagopa-p-checkout-payment-activations-api-v1'


# module.apim_checkout_payment_activations_api_v1
echo 'Importing module.apim_checkout_payment_activations_api_v1.azurerm_api_management_api_policy.this[0]'
./terraform.sh import weu-prod 'module.apim_checkout_payment_activations_api_v1.azurerm_api_management_api_policy.this[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/apis/pagopa-p-checkout-payment-activations-api-v1/policies/xml'


# module.apim_checkout_payment_activations_api_v1
echo 'Importing module.apim_checkout_payment_activations_api_v1.azurerm_api_management_product_api.this["checkout"]'
./terraform.sh import weu-prod 'module.apim_checkout_payment_activations_api_v1.azurerm_api_management_product_api.this["checkout"]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/products/checkout/apis/pagopa-p-checkout-payment-activations-api-v1'


# resource.azurerm_api_management_api_operation_policy.get_payment_info_api
echo 'Importing azurerm_api_management_api_operation_policy.get_payment_info_api'
./terraform.sh import weu-prod 'azurerm_api_management_api_operation_policy.get_payment_info_api' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/apis/pagopa-p-checkout-payment-activations-api-v1/operations/getPaymentInfo/policies/policy'


# resource.azurerm_api_management_api_operation_policy.activate_payment_api
echo 'Importing azurerm_api_management_api_operation_policy.activate_payment_api'
./terraform.sh import weu-prod 'azurerm_api_management_api_operation_policy.activate_payment_api' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/apis/pagopa-p-checkout-payment-activations-api-v1/operations/activatePayment/policies/policy'


# resource.azurerm_api_management_api_version_set.checkout_payment_activations_auth_api
echo 'Importing azurerm_api_management_api_version_set.checkout_payment_activations_auth_api'
./terraform.sh import weu-prod 'azurerm_api_management_api_version_set.checkout_payment_activations_auth_api' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/apiVersionSets/pagopa-p-checkout-payment-activations-auth-api'


# module.apim_checkout_payment_activations_api_auth_v1
echo 'Importing module.apim_checkout_payment_activations_api_auth_v1.azurerm_api_management_api.this'
./terraform.sh import weu-prod 'module.apim_checkout_payment_activations_api_auth_v1.azurerm_api_management_api.this' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/apis/pagopa-p-checkout-payment-activations-auth-api-v1'


# module.apim_checkout_payment_activations_api_auth_v1
echo 'Importing module.apim_checkout_payment_activations_api_auth_v1.azurerm_api_management_api_policy.this[0]'
./terraform.sh import weu-prod 'module.apim_checkout_payment_activations_api_auth_v1.azurerm_api_management_api_policy.this[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/apis/pagopa-p-checkout-payment-activations-auth-api-v1/policies/xml'


# module.apim_checkout_payment_activations_api_auth_v1
echo 'Importing module.apim_checkout_payment_activations_api_auth_v1.azurerm_api_management_product_api.this["checkout"]'
./terraform.sh import weu-prod 'module.apim_checkout_payment_activations_api_auth_v1.azurerm_api_management_product_api.this["checkout"]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/products/checkout/apis/pagopa-p-checkout-payment-activations-auth-api-v1'


# module.apim_checkout_payment_activations_api_auth_v2
echo 'Importing module.apim_checkout_payment_activations_api_auth_v2.azurerm_api_management_api.this'
./terraform.sh import weu-prod 'module.apim_checkout_payment_activations_api_auth_v2.azurerm_api_management_api.this' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/apis/pagopa-p-checkout-payment-activations-auth-api-v2'


# module.apim_checkout_payment_activations_api_auth_v2
echo 'Importing module.apim_checkout_payment_activations_api_auth_v2.azurerm_api_management_api_policy.this[0]'
./terraform.sh import weu-prod 'module.apim_checkout_payment_activations_api_auth_v2.azurerm_api_management_api_policy.this[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/apis/pagopa-p-checkout-payment-activations-auth-api-v2/policies/xml'


# module.apim_checkout_payment_activations_api_auth_v2
echo 'Importing module.apim_checkout_payment_activations_api_auth_v2.azurerm_api_management_product_api.this["checkout"]'
./terraform.sh import weu-prod 'module.apim_checkout_payment_activations_api_auth_v2.azurerm_api_management_product_api.this["checkout"]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/products/checkout/apis/pagopa-p-checkout-payment-activations-auth-api-v2'


# resource.azurerm_api_management_api_version_set.cd_info_wisp
echo 'Importing azurerm_api_management_api_version_set.cd_info_wisp'
./terraform.sh import weu-prod 'azurerm_api_management_api_version_set.cd_info_wisp' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/apiVersionSets/pagopa-p-cd-info-wisp'


# resource.azurerm_api_management_api.apim_cd_info_wisp_v1
echo 'Importing azurerm_api_management_api.apim_cd_info_wisp_v1'
./terraform.sh import weu-prod 'azurerm_api_management_api.apim_cd_info_wisp_v1' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/apis/pagopa-p-cd-info-wisp'


# resource.azurerm_api_management_api_policy.apim_cd_info_wisp_policy_v1
echo 'Importing azurerm_api_management_api_policy.apim_cd_info_wisp_policy_v1'
./terraform.sh import weu-prod 'azurerm_api_management_api_policy.apim_cd_info_wisp_policy_v1' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/apis/pagopa-p-cd-info-wisp/policies/xml'


# resource.azurerm_api_management_product_api.apim_cd_info_wisp_product_v1
echo 'Importing azurerm_api_management_product_api.apim_cd_info_wisp_product_v1'
./terraform.sh import weu-prod 'azurerm_api_management_product_api.apim_cd_info_wisp_product_v1' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/products/checkout/apis/pagopa-p-cd-info-wisp'


# resource.azurerm_api_management_api_version_set.checkout_transactions_api[0]
echo 'Importing azurerm_api_management_api_version_set.checkout_transactions_api[0]'
./terraform.sh import weu-prod 'azurerm_api_management_api_version_set.checkout_transactions_api[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/apiVersionSets/p-checkout-transactions-api'


# module.apim_checkout_transactions_api_v1[0]
echo 'Importing module.apim_checkout_transactions_api_v1[0].azurerm_api_management_api.this'
./terraform.sh import weu-prod 'module.apim_checkout_transactions_api_v1[0].azurerm_api_management_api.this' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/apis/p-checkout-transactions-api-v1'


# module.apim_checkout_transactions_api_v1[0]
echo 'Importing module.apim_checkout_transactions_api_v1[0].azurerm_api_management_api_policy.this[0]'
./terraform.sh import weu-prod 'module.apim_checkout_transactions_api_v1[0].azurerm_api_management_api_policy.this[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/apis/p-checkout-transactions-api-v1/policies/policy'


# module.apim_checkout_transactions_api_v1[0]
echo 'Importing module.apim_checkout_transactions_api_v1[0].azurerm_api_management_product_api.this["checkout"]'
./terraform.sh import weu-prod 'module.apim_checkout_transactions_api_v1[0].azurerm_api_management_product_api.this["checkout"]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/products/checkout/apis/p-checkout-transactions-api-v1'


# resource.azurerm_api_management_api_version_set.checkout_ecommerce_api_v1
echo 'Importing azurerm_api_management_api_version_set.checkout_ecommerce_api_v1'
./terraform.sh import weu-prod 'azurerm_api_management_api_version_set.checkout_ecommerce_api_v1' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/apiVersionSets/pagopa-p-checkout-ecommerce-api'


# module.apim_checkout_ecommerce_api_v1
echo 'Importing module.apim_checkout_ecommerce_api_v1.azurerm_api_management_api.this'
./terraform.sh import weu-prod 'module.apim_checkout_ecommerce_api_v1.azurerm_api_management_api.this' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/apis/pagopa-p-checkout-ecommerce-api-v1'


# module.apim_checkout_ecommerce_api_v1
echo 'Importing module.apim_checkout_ecommerce_api_v1.azurerm_api_management_api_policy.this[0]'
./terraform.sh import weu-prod 'module.apim_checkout_ecommerce_api_v1.azurerm_api_management_api_policy.this[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/apis/pagopa-p-checkout-ecommerce-api-v1/policies/xml'


# module.apim_checkout_ecommerce_api_v1
echo 'Importing module.apim_checkout_ecommerce_api_v1.azurerm_api_management_product_api.this["checkout"]'
./terraform.sh import weu-prod 'module.apim_checkout_ecommerce_api_v1.azurerm_api_management_product_api.this["checkout"]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/products/checkout/apis/pagopa-p-checkout-ecommerce-api-v1'


# resource.azurerm_api_management_api_operation_policy.get_payment_request_info_api
echo 'Importing azurerm_api_management_api_operation_policy.get_payment_request_info_api'
./terraform.sh import weu-prod 'azurerm_api_management_api_operation_policy.get_payment_request_info_api' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/apis/pagopa-p-checkout-ecommerce-api-v1/operations/getPaymentRequestInfo/policies/xml'


# resource.azurerm_api_management_api_operation_policy.transaction_authorization_request
echo 'Importing azurerm_api_management_api_operation_policy.transaction_authorization_request'
./terraform.sh import weu-prod 'azurerm_api_management_api_operation_policy.transaction_authorization_request' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/apis/pagopa-p-checkout-ecommerce-api-v1/operations/requestTransactionAuthorization/policies/xml'


# module.apim_checkout_ec_product
echo 'Importing module.apim_checkout_ec_product.azurerm_api_management_product.this'
./terraform.sh import weu-prod 'module.apim_checkout_ec_product.azurerm_api_management_product.this' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/products/checkout-ec'


# module.apim_checkout_ec_product
echo 'Importing module.apim_checkout_ec_product.azurerm_api_management_product_policy.this[0]'
./terraform.sh import weu-prod 'module.apim_checkout_ec_product.azurerm_api_management_product_policy.this[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/products/checkout-ec/policies/xml'


# resource.azurerm_api_management_api_version_set.checkout_ec_api_v1
echo 'Importing azurerm_api_management_api_version_set.checkout_ec_api_v1'
./terraform.sh import weu-prod 'azurerm_api_management_api_version_set.checkout_ec_api_v1' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/apiVersionSets/pagopa-p-checkout-ec-api'


echo 'Import executed succesfully on prod environment! ⚡'
