data "azurerm_key_vault" "kv" {
  name                = local.key_vault_name
  resource_group_name = local.key_vault_rg_name
}

data "azurerm_key_vault_secret" "grafana-key" {
  name         = "grafana-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}