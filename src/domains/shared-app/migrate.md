# Migration to V3

the TF state (in dev, at least) contains a property that causes a marshalling error which blocks the migrations script provided in `eng-common-scripts`
So the TF state needs to be updated manually executing the following commands

## Dev
To migrate to v3, follow the steps below:

1. Run the command `./terraform.sh import weu-dev module.authorizer_function_app.azurerm_linux_function_app.this "/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-weu-shared-rg/providers/Microsoft.Web/sites/pagopa-d-weu-shared-authorizer-fn"`
2. Execute `./terraform.sh state weu-dev rm "module.authorizer_function_app.azurerm_function_app.this"`
3. Import the service plan using `./terraform.sh import weu-dev "module.authorizer_function_app.azurerm_service_plan.this[0]" "/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-weu-shared-rg/providers/Microsoft.Web/serverfarms/pagopa-d-weu-shared-plan-authorizer-fn"`
4. Remove the app service plan by running `./terraform.sh state weu-dev rm "module.authorizer_function_app.azurerm_app_service_plan.this[0]"`

Make sure to follow the steps in order to avoid any errors during migration.
