data "azurerm_key_vault" "kv" {
  name                = "${local.project}-kv"
  resource_group_name = "${local.project}-sec-rg"
}

data "azurerm_key_vault_secret" "elastic_otel_token_header" {
  name         = "elastic-otel-token-header"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "pdf_engine_node_subkey" {
  name         = "pdf-engine-node-subkey"
  key_vault_id = data.azurerm_key_vault.kv.id
}

