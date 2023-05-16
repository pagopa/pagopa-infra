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


echo 'Import executed succesfully on uat environment! ⚡'
