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

# resource.azurerm_resource_group.checkout_be_rg[0]
echo 'Importing azurerm_resource_group.checkout_be_rg[0]'
./terraform.sh import weu-prod 'azurerm_resource_group.checkout_be_rg[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-checkout-be-rg'

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

echo 'Import executed succesfully on prod environment! ⚡'
