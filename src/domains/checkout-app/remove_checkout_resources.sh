#!/bin/bash

ARGS=("$@")
ARGS_AFTER_FIRST=("${ARGS[@]:1}")
env=$1

resources=(
  'azurerm_resource_group.checkout_fe_rg'
  'module.checkout_cdn'
  'azurerm_application_insights_web_test.checkout_fe_web_test'
  'azurerm_dns_zone.checkout_public'
  'azurerm_dns_ns_record.dev_checkout'
  'azurerm_dns_ns_record.uat_checkout'
  'azurerm_dns_caa_record.checkout_pagopa_it'
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
