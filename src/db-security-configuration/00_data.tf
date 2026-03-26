data "azurerm_key_vault" "key_vault_core" {
  name                = local.key_vault_itn_core_name
  resource_group_name = local.key_vault_itn_core_rg_name
}

data "azurerm_key_vault_secret" "metabase_api_key" {
  key_vault_id = data.azurerm_key_vault.key_vault_core.id
  name         = "metabase-api-key"
}


data "azurerm_key_vault" "password_keyvault" {
  for_each            = { for k, db in var.databases : k => db if db.password_required }
  name                = each.value.password_secret_kv_name
  resource_group_name = each.value.password_secret_kv_rg
}

data "azurerm_key_vault_secret" "database_password" {
  for_each     = { for k, db in var.databases : k => db if db.password_required }
  key_vault_id = data.azurerm_key_vault.password_keyvault[each.key].id
  name         = each.value.password_secret_key
}
