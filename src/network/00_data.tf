data "azurerm_key_vault" "kv_domain" {
  name                = "${local.project}-kv"
  resource_group_name = "${local.project}-sec-rg"
}


data "azurerm_key_vault_secret" "external_database_username" {
  for_each     = var.external_database_connection
  name         = each.value.user_secret_name
  key_vault_id = data.azurerm_key_vault.kv_domain.id
}

data "azurerm_key_vault_secret" "external_database_password" {
  for_each     = var.external_database_connection
  name         = each.value.password_secret_name
  key_vault_id = data.azurerm_key_vault.kv_domain.id
}
