data "azurerm_key_vault" "key_vault" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}

###############
## Event Hub ##
###############
resource "azurerm_key_vault_secret" "fdr-re-tx" {
  name         = "azure-event-hub-re-connection-string"
  value        = data.azurerm_eventhub_authorization_rule.pagopa-weu-core-evh-ns03_fdr-re-fdr-re-tx.primary_connection_string
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

############
## Cosmos ##
############
resource "azurerm_key_vault_secret" "fdr_mongodb_connection_string" {
  name         = "mongodb-connection-string"
  value        = module.cosmosdb_account_mongodb.connection_strings[0]
  key_vault_id = data.azurerm_key_vault.key_vault.id

  depends_on = [
    module.cosmosdb_account_mongodb
  ]
}

resource "azurerm_key_vault_secret" "fdr_re_mongodb_connection_string" {
  name         = "mongodb-re-connection-string"
  value        = module.cosmosdb_account_mongodb_fdr_re.connection_strings[0]
  key_vault_id = data.azurerm_key_vault.key_vault.id

  depends_on = [
    module.cosmosdb_account_mongodb_fdr_re
  ]
}

#####################
## Storage Account ##
#####################
resource "azurerm_key_vault_secret" "fdr_storage_account_connection_string" {
  name         = "fdr-sa-connection-string"
  value        = module.fdr_conversion_sa.primary_connection_string
  key_vault_id = data.azurerm_key_vault.key_vault.id

  depends_on = [
    module.fdr_conversion_sa
  ]
}

resource "azurerm_key_vault_secret" "fdr_re_storage_account_connection_string" {
  name         = "fdr-re-sa-connection-string"
  value        = module.fdr_re_sa.primary_connection_string
  key_vault_id = data.azurerm_key_vault.key_vault.id

  depends_on = [
    module.fdr_re_sa
  ]
}

resource "azurerm_key_vault_secret" "fdr_history_storage_account_connection_string" {
  name         = "fdr-history-sa-connection-string"
  value        = module.fdr_history_sa.primary_connection_string
  key_vault_id = data.azurerm_key_vault.key_vault.id

  depends_on = [
    module.fdr_history_sa
  ]
}
