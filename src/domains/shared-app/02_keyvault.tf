data "azurerm_key_vault" "kv" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}


data "azurerm_key_vault_secret" "authorizer_cosmos_uri" {
  name         = format("auth-%s-cosmos-uri", var.env_short)
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "authorizer_cosmos_key" {
  name         = format("auth-%s-cosmos-key", var.env_short)
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "authorizer_cosmos_db" {
  name         = format("auth-%s-cosmos-db", var.env_short)
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "authorizer_cosmos_container" {
  name         = format("auth-%s-cosmos-container", var.env_short)
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "authorizer_cosmos_connection_string" {
  name         = format("auth-%s-cosmos-connection-string", var.env_short)
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "authorizer_refresh_configuration_url" {
  name         = format("auth-%s-refresh-configuration-url", var.env_short)
  key_vault_id = data.azurerm_key_vault.kv.id
}
