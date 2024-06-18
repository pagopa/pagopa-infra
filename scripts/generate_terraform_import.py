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
│ Error: A resource with the ID "/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-weu-core-apim-v2/apis/u-pagopa-selfcare-ms-backoffice-backend-v1/policies/xml" already exists - to be managed via Terraform this resource needs to be imported into the State. Please see the resource documentation for "azurerm_api_management_api_policy" for more information.
│
│   with module.apim_api_backoffice_api_v1_weu_core[0].azurerm_api_management_api_policy.this[0],
│   on .terraform/modules/apim_api_backoffice_api_v1_weu_core/api_management_api/main.tf line 31, in resource "azurerm_api_management_api_policy" "this":
│   31: resource "azurerm_api_management_api_policy" "this" {
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
