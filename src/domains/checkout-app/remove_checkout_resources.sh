#!/bin/bash

ARGS=("$@")
ARGS_AFTER_FIRST=("${ARGS[@]:1}")
env=$1

resources=(
    'azurerm_api_management_api.apim_cd_info_wisp_v1'
    'module.apim_checkout_payment_activations_api_auth_v1'
    'module.apim_checkout_payment_activations_api_auth_v2'
    'module.apim_checkout_payment_activations_api_v1'
    'azurerm_api_management_named_value.io_backend_subscription_key'
    'module.apim_checkout_product'
    'azurerm_api_management_api_version_set.checkout_payment_activations_api'
    'module.apim_checkout_payment_activations_api_v1'
    'azurerm_api_management_api_operation_policy.get_payment_info_api'
    'azurerm_api_management_api_operation_policy.activate_payment_api'
    'azurerm_api_management_api_version_set.checkout_payment_activations_auth_api'
    'azurerm_api_management_api_version_set.cd_info_wisp'
    'azurerm_api_management_api.apim_cd_info_wisp_v1'
    'azurerm_api_management_api_policy.apim_cd_info_wisp_policy_v1'
    'azurerm_api_management_product_api.apim_cd_info_wisp_product_v1'
    'azurerm_api_management_api_version_set.checkout_transactions_api'
    'module.apim_checkout_transactions_api_v1'
    'azurerm_api_management_api_version_set.checkout_ecommerce_api_v1'
    'module.apim_checkout_ecommerce_api_v1'
    'azurerm_api_management_api_operation_policy.get_payment_request_info_api'
    'azurerm_api_management_api_operation_policy.transaction_authorization_request'
    'azurerm_api_management_api_diagnostic.apim_logs["pagopa-u-cd-info-wisp"]'
    'azurerm_api_management_api_diagnostic.apim_logs["pagopa-u-checkout-payment-activations-api-v1"]'
    'azurerm_api_management_api_diagnostic.apim_logs["pagopa-u-checkout-payment-activations-auth-api-v1"]'
    'azurerm_api_management_api_diagnostic.apim_logs["pagopa-u-checkout-payment-activations-auth-api-v2"]'
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
