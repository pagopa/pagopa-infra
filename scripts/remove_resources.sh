#!/bin/bash

# How to use:
#
# 1. Fill `resources` array down here
#
# 2. Link this script inside the new domain folder, e.g. 
#    `ln -s ../../../scripts/remove_resources.sh .`
#
# 3. Run the script from the domain folder

if [ "$#" -eq 0 ]; then
    echo "Must provide at least one parameter for the target environment!"
    exit 1
fi

ARGS=("$@")
ARGS_AFTER_FIRST=("${ARGS[@]:1}")
env=$1

resources=(
  # TODO: Add resource addresses here,
  # e.g.:
  #
  #  'module.apim_checkout_ec_product'
  #  'azurerm_api_management_api_version_set.checkout_ec_api_v1'
  #  'module.apim_checkout_ec_api_v1'
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
