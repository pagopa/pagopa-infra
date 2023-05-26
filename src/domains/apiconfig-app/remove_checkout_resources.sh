#!/bin/bash

ARGS=("$@")
ARGS_AFTER_FIRST=("${ARGS[@]:1}")
env=$1

resources=(
  'module.apim_api_config_product'
  'azurerm_api_management_group.apiconfig_grp'
  'azurerm_api_management_api_version_set.api_config_api'
  'module.apim_api_config_api'
  'azurerm_api_management_authorization_server.apiconfig-oauth2'
  'module.apim_api_config_auth_product'
  'azurerm_api_management_api_version_set.api_config_auth_api'
  'module.apim_api_config_auth_api'
  'module.apim_api_config_checkout_product'
  'azurerm_api_management_api_version_set.api_config_checkout_api'
  'module.apim_api_config_checkout_api'
  'azurerm_resource_group.api_config_rg'
  'module.api_config_snet[0]'
  'module.api_config_app_service'
  'azurerm_monitor_scheduled_query_rules_alert.apiconfig_db_healthcheck'
  'azurerm_monitor_autoscale_setting.apiconfig_app_service_autoscale'
  'azurerm_resource_group.api_config_fe_rg[0]'
  'module.api_config_fe_cdn[0]'
  'azurerm_key_vault_secret.storage_account_key'
)

cd ../../core

for resource in "${resources[@]}"
do
  echo "Removing $resource on $env"
  ./terraform.sh state "$env" rm "${ARGS_AFTER_FIRST[@]}" "$resource"
done

targets=""
for resource in "${resources[@]}"
do
  targets="$targets -target=$resource"
done

echo "Checking terraform plan..."

./terraform.sh plan "$env" "$targets"
