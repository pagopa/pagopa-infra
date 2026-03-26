#
# 🔒 Secrets
#

data "azurerm_key_vault" "key_vault" {
  name                = local.key_vault_name
  resource_group_name = local.key_vault_rg_name
}

