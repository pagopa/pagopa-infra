#!/bin/bash
# Generated with `generate_imports.py`

# module.apim_api_config_product
echo 'Importing module.apim_api_config_product.azurerm_api_management_product.this'
./terraform.sh import weu-dev 'module.apim_api_config_product.azurerm_api_management_product.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/products/product-api-config'


# module.apim_api_config_product
echo 'Importing module.apim_api_config_product.azurerm_api_management_product_policy.this[0]'
./terraform.sh import weu-dev 'module.apim_api_config_product.azurerm_api_management_product_policy.this[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/products/product-api-config/policies/xml'


# resource.azurerm_api_management_group.apiconfig_grp
echo 'Importing azurerm_api_management_group.apiconfig_grp'
./terraform.sh import weu-dev 'azurerm_api_management_group.apiconfig_grp' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/groups/api-config-be-writer'


# resource.azurerm_api_management_api_version_set.api_config_api
echo 'Importing azurerm_api_management_api_version_set.api_config_api'
./terraform.sh import weu-dev 'azurerm_api_management_api_version_set.api_config_api' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apiVersionSets/d-api-config-api'


# module.apim_api_config_api
echo 'Importing module.apim_api_config_api.azurerm_api_management_api.this'
./terraform.sh import weu-dev 'module.apim_api_config_api.azurerm_api_management_api.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apis/d-api-config-api-v1'


# module.apim_api_config_api
echo 'Importing module.apim_api_config_api.azurerm_api_management_api_policy.this[0]'
./terraform.sh import weu-dev 'module.apim_api_config_api.azurerm_api_management_api_policy.this[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apis/d-api-config-api-v1/policies/xml'


# module.apim_api_config_api
echo 'Importing module.apim_api_config_api.azurerm_api_management_product_api.this["product-api-config"]'
./terraform.sh import weu-dev 'module.apim_api_config_api.azurerm_api_management_product_api.this["product-api-config"]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/products/product-api-config/apis/d-api-config-api-v1'


# resource.azurerm_api_management_authorization_server.apiconfig-oauth2
echo 'Importing azurerm_api_management_authorization_server.apiconfig-oauth2'
./terraform.sh import weu-dev 'azurerm_api_management_authorization_server.apiconfig-oauth2' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/authorizationServers/apiconfig-oauth2'


# module.apim_api_config_auth_product
echo 'Importing module.apim_api_config_auth_product.azurerm_api_management_product.this'
./terraform.sh import weu-dev 'module.apim_api_config_auth_product.azurerm_api_management_product.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/products/product-api-config-auth'


# module.apim_api_config_auth_product
echo 'Importing module.apim_api_config_auth_product.azurerm_api_management_product_policy.this[0]'
./terraform.sh import weu-dev 'module.apim_api_config_auth_product.azurerm_api_management_product_policy.this[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/products/product-api-config-auth/policies/xml'


# resource.azurerm_api_management_api_version_set.api_config_auth_api
echo 'Importing azurerm_api_management_api_version_set.api_config_auth_api'
./terraform.sh import weu-dev 'azurerm_api_management_api_version_set.api_config_auth_api' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apiVersionSets/d-api-config-auth-api'


# module.apim_api_config_auth_api
echo 'Importing module.apim_api_config_auth_api.azurerm_api_management_api.this'
./terraform.sh import weu-dev 'module.apim_api_config_auth_api.azurerm_api_management_api.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apis/d-api-config-auth-api-v1'


# module.apim_api_config_auth_api
echo 'Importing module.apim_api_config_auth_api.azurerm_api_management_api_policy.this[0]'
./terraform.sh import weu-dev 'module.apim_api_config_auth_api.azurerm_api_management_api_policy.this[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apis/d-api-config-auth-api-v1/policies/xml'


# module.apim_api_config_auth_api
echo 'Importing module.apim_api_config_auth_api.azurerm_api_management_product_api.this["product-api-config-auth"]'
./terraform.sh import weu-dev 'module.apim_api_config_auth_api.azurerm_api_management_product_api.this["product-api-config-auth"]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/products/product-api-config-auth/apis/d-api-config-auth-api-v1'


# module.apim_api_config_checkout_product
echo 'Importing module.apim_api_config_checkout_product.azurerm_api_management_product.this'
./terraform.sh import weu-dev 'module.apim_api_config_checkout_product.azurerm_api_management_product.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/products/product-api-config-checkout'


# module.apim_api_config_checkout_product
echo 'Importing module.apim_api_config_checkout_product.azurerm_api_management_product_policy.this[0]'
./terraform.sh import weu-dev 'module.apim_api_config_checkout_product.azurerm_api_management_product_policy.this[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/products/product-api-config-checkout/policies/xml'


# resource.azurerm_api_management_api_version_set.api_config_checkout_api
echo 'Importing azurerm_api_management_api_version_set.api_config_checkout_api'
./terraform.sh import weu-dev 'azurerm_api_management_api_version_set.api_config_checkout_api' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apiVersionSets/d-api-config-checkout-api'


# module.apim_api_config_checkout_api
echo 'Importing module.apim_api_config_checkout_api.azurerm_api_management_api.this'
./terraform.sh import weu-dev 'module.apim_api_config_checkout_api.azurerm_api_management_api.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apis/d-api-config-checkout-api-v1'


# module.apim_api_config_checkout_api
echo 'Importing module.apim_api_config_checkout_api.azurerm_api_management_api_policy.this[0]'
./terraform.sh import weu-dev 'module.apim_api_config_checkout_api.azurerm_api_management_api_policy.this[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/apis/d-api-config-checkout-api-v1/policies/xml'


# module.apim_api_config_checkout_api
echo 'Importing module.apim_api_config_checkout_api.azurerm_api_management_product_api.this["product-api-config-checkout"]'
./terraform.sh import weu-dev 'module.apim_api_config_checkout_api.azurerm_api_management_product_api.this["product-api-config-checkout"]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/products/product-api-config-checkout/apis/d-api-config-checkout-api-v1'


# resource.azurerm_resource_group.api_config_rg
echo 'Importing azurerm_resource_group.api_config_rg'
./terraform.sh import weu-dev 'azurerm_resource_group.api_config_rg' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-config-rg'


# module.api_config_snet[0]
echo 'Importing module.api_config_snet[0].azurerm_subnet.this'
./terraform.sh import weu-dev 'module.api_config_snet[0].azurerm_subnet.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-vnet-rg/providers/Microsoft.Network/virtualNetworks/pagopa-d-vnet-integration/subnets/pagopa-d-api-config-snet'


# module.api_config_app_service
echo 'Importing module.api_config_app_service.azurerm_app_service.this'
./terraform.sh import weu-dev 'module.api_config_app_service.azurerm_app_service.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-config-rg/providers/Microsoft.Web/sites/pagopa-d-app-api-config'


# module.api_config_app_service
echo 'Importing module.api_config_app_service.azurerm_app_service_plan.this[0]'
./terraform.sh import weu-dev 'module.api_config_app_service.azurerm_app_service_plan.this[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-config-rg/providers/Microsoft.Web/serverfarms/pagopa-d-plan-api-config'


# module.api_config_app_service
echo 'Importing module.api_config_app_service.azurerm_app_service_virtual_network_swift_connection.app_service_virtual_network_swift_connection[0]'
./terraform.sh import weu-dev 'module.api_config_app_service.azurerm_app_service_virtual_network_swift_connection.app_service_virtual_network_swift_connection[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-config-rg/providers/Microsoft.Web/sites/pagopa-d-app-api-config/config/virtualNetwork'


# resource.azurerm_monitor_scheduled_query_rules_alert.apiconfig_db_healthcheck
echo 'Importing azurerm_monitor_scheduled_query_rules_alert.apiconfig_db_healthcheck'
./terraform.sh import weu-dev 'azurerm_monitor_scheduled_query_rules_alert.apiconfig_db_healthcheck' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-config-rg/providers/Microsoft.Insights/scheduledQueryRules/pagopa-d-app-api-config-db-healthcheck'


# resource.azurerm_monitor_autoscale_setting.apiconfig_app_service_autoscale
echo 'Importing azurerm_monitor_autoscale_setting.apiconfig_app_service_autoscale'
./terraform.sh import weu-dev 'azurerm_monitor_autoscale_setting.apiconfig_app_service_autoscale' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-config-rg/providers/Microsoft.Insights/autoscaleSettings/pagopa-d-autoscale-apiconfig'


# resource.azurerm_resource_group.api_config_fe_rg[0]
echo 'Importing azurerm_resource_group.api_config_fe_rg[0]'
./terraform.sh import weu-dev 'azurerm_resource_group.api_config_fe_rg[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-config-fe-rg'


# module.api_config_fe_cdn[0]
echo 'Importing module.api_config_fe_cdn[0].azurerm_cdn_endpoint.this'
./terraform.sh import weu-dev 'module.api_config_fe_cdn[0].azurerm_cdn_endpoint.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-config-fe-rg/providers/Microsoft.Cdn/profiles/pagopa-d-api-config-fe-cdn-profile/endpoints/pagopa-d-api-config-fe-cdn-endpoint'


# module.api_config_fe_cdn[0]
echo 'Importing module.api_config_fe_cdn[0].azurerm_cdn_profile.this'
./terraform.sh import weu-dev 'module.api_config_fe_cdn[0].azurerm_cdn_profile.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-config-fe-rg/providers/Microsoft.Cdn/profiles/pagopa-d-api-config-fe-cdn-profile'


# module.api_config_fe_cdn[0]
echo 'Importing module.api_config_fe_cdn[0].azurerm_dns_cname_record.custom_subdomain[0]'
./terraform.sh import weu-dev 'module.api_config_fe_cdn[0].azurerm_dns_cname_record.custom_subdomain[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-vnet-rg/providers/Microsoft.Network/dnszones/dev.platform.pagopa.it/CNAME/config'


# module.api_config_fe_cdn[0]
echo 'Importing module.api_config_fe_cdn[0].null_resource.custom_domain'
./terraform.sh import weu-dev 'module.api_config_fe_cdn[0].null_resource.custom_domain' '3094831938934975637'


# module.api_config_fe_cdn[0]
echo 'Importing module.api_config_fe_cdn[0].module.cdn_storage_account.azurerm_advanced_threat_protection.this'
./terraform.sh import weu-dev 'module.api_config_fe_cdn[0].module.cdn_storage_account.azurerm_advanced_threat_protection.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-config-fe-rg/providers/Microsoft.Storage/storageAccounts/pagopadapiconfigfesa/providers/Microsoft.Security/advancedThreatProtectionSettings/current'


# module.api_config_fe_cdn[0]
echo 'Importing module.api_config_fe_cdn[0].module.cdn_storage_account.azurerm_storage_account.this'
./terraform.sh import weu-dev 'module.api_config_fe_cdn[0].module.cdn_storage_account.azurerm_storage_account.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-config-fe-rg/providers/Microsoft.Storage/storageAccounts/pagopadapiconfigfesa'


# module.api_config_fe_cdn[0]
echo 'Importing module.api_config_fe_cdn[0].module.cdn_storage_account.azurerm_template_deployment.versioning[0]'
./terraform.sh import weu-dev 'module.api_config_fe_cdn[0].module.cdn_storage_account.azurerm_template_deployment.versioning[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-config-fe-rg/providers/Microsoft.Resources/deployments/pagopa-d-api-config-fe-sa-versioning'


# resource.azurerm_key_vault_secret.storage_account_key
echo 'Importing azurerm_key_vault_secret.storage_account_key'
./terraform.sh import weu-dev 'azurerm_key_vault_secret.storage_account_key' 'https://pagopa-d-kv.vault.azure.net/secrets/api-config-fe-storage-account-key/964fe575bc774622b96d59badede978c'


echo 'Import executed succesfully on dev environment! ⚡'
