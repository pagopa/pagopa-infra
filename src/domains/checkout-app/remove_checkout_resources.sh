#!/bin/bash

ARGS=("$@")
ARGS_AFTER_FIRST=("${ARGS[@]:1}")
env=$1

resources=(
  'module.pagopa_proxy_snet'
  'module.pagopa_proxy_app_service'
  'module.pagopa_proxy_app_service_slot_staging'
  'azurerm_monitor_autoscale_setting.pagopa_proxy_app_service_autoscale'
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
