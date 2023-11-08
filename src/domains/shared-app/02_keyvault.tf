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

data "azurerm_key_vault_secret" "authorizer_cosmos_connection_string" {
  name         = format("auth-%s-cosmos-connection-string", var.env_short)
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "authorizer_refresh_configuration_url" {
  name         = format("auth-%s-refresh-configuration-url", var.env_short)
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "apiconfig_selfcare_integration_url" {
  name         = format("auth-%s-apiconfig-selfcare-integration-url", var.env_short)
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "apiconfig_selfcare_integration_subkey" {
  name         = format("auth-%s-apiconfig-selfcare-integration-subkey", var.env_short)
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "elastic_otel_token_header" {
  name         = "elastic-otel-token-header"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "pdf_engine_node_subkey" {
  name         = "pdf-engine-node-subkey"
  key_vault_id = data.azurerm_key_vault.kv.id
}

