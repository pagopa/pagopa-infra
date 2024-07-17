data "azurerm_key_vault" "key_vault" {
  name                = format("%s-kv", local.project)
  resource_group_name = format("%s-sec-rg", local.project)
}

data "azurerm_key_vault_secret" "sec_workspace_id" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "sec-workspace-id"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "sec_storage_id" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "sec-storage-id"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}
