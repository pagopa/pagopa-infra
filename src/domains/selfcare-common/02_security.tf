data "azurerm_resource_group" "sec_rg" {
  name = "${local.product}-${var.domain}-sec-rg"
}

data "azurerm_key_vault" "key_vault" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = data.azurerm_resource_group.sec_rg.name
}

resource "azurerm_key_vault_secret" "ai_connection_string" {
  name         = "ai-${var.env_short}-connection-string"
  value        = data.azurerm_application_insights.application_insights.connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}


resource "azurerm_key_vault_secret" "cosmodb_mongo_bopagopa_connection_string" {
  name         = "cosmodbmongo-${var.env_short}-bopagopa-connection-string"
  value        = module.bopagopa_cosmosdb_mongo_account.connection_strings[0]
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "azurerm_key_vault_secret" "cosmodb_mongo_bopagopa_key" {
  name         = "cosmodbmongo-${var.env_short}-bopagopa-key"
  value        = module.bopagopa_cosmosdb_mongo_account.primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}
