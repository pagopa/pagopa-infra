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
│ Error: A resource with the ID "/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/products/nodo-monitoring" already exists - to be managed via Terraform this resource needs to be imported into the State. Please see the resource documentation for "azurerm_api_management_product" for more information.
│
│   with module.apim_nodo_dei_pagamenti_monitoring_product.azurerm_api_management_product.this,
│   on .terraform/modules/__v3__/api_management_product/main.tf line 1, in resource "azurerm_api_management_product" "this":
│    1: resource "azurerm_api_management_product" "this" {
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
