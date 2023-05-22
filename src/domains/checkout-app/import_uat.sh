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


echo 'Import executed succesfully on uat environment! ⚡'
