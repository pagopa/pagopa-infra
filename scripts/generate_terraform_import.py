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
│ Error: A resource with the ID "https://pagopa-u-itn-printit-kv.vault.azure.net/secrets/elastic-apm-secret-token/58c0f4f74331496ea079135cde4b99ba" already exists - to be managed via Terraform this resource needs to be imported into the State. Please see the resource documentation for "azurerm_key_vault_secret" for more information.
│
│   with azurerm_key_vault_secret.secret["elastic-apm-secret-token"],
│   on 02_key_secret.tf line 51, in resource "azurerm_key_vault_secret" "secret":
│   51: resource "azurerm_key_vault_secret" "secret" {
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
