import re
import sys


if len(sys.argv) <= 1:
  print('Error: env expected. \nUsage:')
  print("\tpython3 ./generate_terraform_import.py <env>")
  exit(1)
env = sys.argv[1]

# change this with you terraform log
log = """

╷
│ Error: A resource with the ID "/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/apis/p-node-forwarder-api-v1" already exists - to be managed via Terraform this resource needs to be imported into the State. Please see the resource documentation for "azurerm_api_management_api_policy" for more information.
│
│   with module.apim_node_forwarder_api.azurerm_api_management_api_policy.this[0],
│   on .terraform/modules/__v3__/api_management_api/main.tf line 46, in resource "azurerm_api_management_api_policy" "this":
│   46: resource "azurerm_api_management_api_policy" "this" {
│
╵
╷
│ Error: A resource with the ID "/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/products/product-node-forwarder/apis/p-node-forwarder-api-v1" already exists - to be managed via Terraform this resource needs to be imported into the State. Please see the resource documentation for "azurerm_api_management_product_api" for more information.
│
│   with module.apim_node_forwarder_api.azurerm_api_management_product_api.this["product-node-forwarder"],
│   on .terraform/modules/__v3__/api_management_api/main.tf line 55, in resource "azurerm_api_management_product_api" "this":
│   55: resource "azurerm_api_management_product_api" "this" {
│
╵
╷
│ Error: A resource with the ID "/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/products/apim_for_node/apis/p-node-forwarder-api-v1" already exists - to be managed via Terraform this resource needs to be imported into the State. Please see the resource documentation for "azurerm_api_management_product_api" for more information.
│
│   with module.apim_node_forwarder_api.azurerm_api_management_product_api.this["apim_for_node"],
│   on .terraform/modules/__v3__/api_management_api/main.tf line 55, in resource "azurerm_api_management_product_api" "this":
│   55: resource "azurerm_api_management_product_api" "this" {
│
╵
"""

# Regex patterns to extract resource ID and type information
resource_pattern = re.compile(
  r'Error: A resource with the ID (?P<id>.+?) already exists(.|\n)+?with (?P<name>.+?),')
error_blocks = log.split("╷")

import_commands = []

for block in error_blocks:
  match = resource_pattern.search(block)
  if match:
    resource_id = match.group("id")
    resource_name = match.group("name").replace('\"', "\\")
    import_commands.append(
      f'sh ./terraform.sh import {env} "{resource_name}" {resource_id}')

# Print
print("All done :)\nrun this command:\n")
print(" ; ".join(import_commands))

