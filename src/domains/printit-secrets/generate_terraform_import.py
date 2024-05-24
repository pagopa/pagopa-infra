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
│ Error: A resource with the ID "/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-itn-printit-sec-rg/providers/Microsoft.KeyVault/vaults/pagopa-u-itn-printit-kv/objectId/3858f2bd-32df-45c3-896a-15d68614d046" already exists - to be managed via Terraform this resource needs to be imported into the State. Please see the resource documentation for "azurerm_key_vault_access_policy" for more information.
│
│   with azurerm_key_vault_access_policy.ad_group_policy,
│   on 01_keyvault.tf line 21, in resource "azurerm_key_vault_access_policy" "ad_group_policy":
│   21: resource "azurerm_key_vault_access_policy" "ad_group_policy" {
│
╵
╷
│ Error: A resource with the ID "/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-itn-printit-sec-rg/providers/Microsoft.KeyVault/vaults/pagopa-u-itn-printit-kv/objectId/087a43af-8386-4b5e-afc8-5e66eaca7df7" already exists - to be managed via Terraform this resource needs to be imported into the State. Please see the resource documentation for "azurerm_key_vault_access_policy" for more information.
│
│   with azurerm_key_vault_access_policy.adgroup_developers_policy[0],
│   on 01_keyvault.tf line 34, in resource "azurerm_key_vault_access_policy" "adgroup_developers_policy":
│   34: resource "azurerm_key_vault_access_policy" "adgroup_developers_policy" {
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
    resource_name = match.group("name")
    import_commands.append(
      f'sh ./terraform.sh import {env} {resource_name} {resource_id}')

# Print
print("All done :)\nrun this command:\n")
print(" ; ".join(import_commands))
