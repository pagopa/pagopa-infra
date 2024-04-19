data "azurerm_key_vault" "kv" {
  name                = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}-kv"
  resource_group_name = "${var.prefix}-${var.env_short}-${var.domain}-sec-rg"
}

data "azurerm_key_vault_secret" "elastic_otel_token_header" {
  name         = "elastic-apm-secret-token"
  key_vault_id = data.azurerm_key_vault.kv.id
}

# data "azurerm_key_vault_secret" "pdf_engine_node_subkey" {
#   name         = "pdf-engine-node-subkey"
#   key_vault_id = data.azurerm_key_vault.kv.id
# }

