data azurerm_key_vault "key_vault_core" {
  name = local.key_vault_itn_core_name
  resource_group_name = local.key_vault_itn_core_rg_name
}

data "azurerm_key_vault_secret" "metabase_api_key" {
  key_vault_id = data.azurerm_key_vault.key_vault_core.id
  name = "" #TODO
}


data "azurerm_key_vault_secret" "database_password" {
  for_each = var.databases
  key_vault_id = data.azurerm_key_vault.key_vault_core.id
  name = each.value.password_secret_key
}
