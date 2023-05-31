#!/bin/bash

ARGS=("$@")
ARGS_AFTER_FIRST=("${ARGS[@]:1}")
env=$1

resources=(
  'azurerm_resource_group.checkout_be_rg'
  'module.checkout_function_snet'
  'module.checkout_function'
  'azurerm_monitor_autoscale_setting.checkout_function'
  'azurerm_monitor_scheduled_query_rules_alert.checkout_availability'
  'azurerm_monitor_metric_alert.checkout_fn_5xx'
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
