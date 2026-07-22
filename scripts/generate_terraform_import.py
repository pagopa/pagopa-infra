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
│ Error: A resource with the ID "/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/apis/p-node-for-psp-api;rev=1" already exists - to be managed via Terraform this resource needs to be imported into the State. Please see the resource documentation for "azurerm_api_management_api" for more information.
│
│   with azurerm_api_management_api.apim_node_for_psp_api_v1,
│   on 04_apim_nodo_services_03_node_for_psp.tf line 23, in resource "azurerm_api_management_api" "apim_node_for_psp_api_v1":
│   23: resource "azurerm_api_management_api" "apim_node_for_psp_api_v1" {
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

