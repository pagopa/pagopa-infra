data "azurerm_key_vault" "kv" {
  name                = local.key_vault_name
  resource_group_name = local.key_vault_rg_name
}
