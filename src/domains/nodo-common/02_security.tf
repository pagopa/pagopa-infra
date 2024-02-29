data "azurerm_key_vault" "key_vault" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}

/*****************
Storage Account
*****************/
resource "azurerm_key_vault_secret" "node_cfg_sync_re_sa_connection_string" {
  name         = "node-cfg-sync-re-sa-connection-string-key"
  value        = module.nodo_cfg_sync_re_storage_account.primary_connection_string
  key_vault_id = data.azurerm_key_vault.key_vault.id

  depends_on = [
    module.nodo_cfg_sync_re_storage_account
  ]
}

/**********
Event Hub
***********/
### cache
resource "azurerm_key_vault_secret" "evthub_nodo_dei_pagamenti_cache_sync_rx" {
  name         = "nodo-dei-pagamenti-cache-sync-rx-connection-string-key"
  value        = data.azurerm_eventhub_authorization_rule.pagopa-weu-core-evh-ns04_nodo-dei-pagamenti-cache-sync-rx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}

### stand-in
resource "azurerm_key_vault_secret" "evthub_nodo_dei_pagamenti_stand_in_tx" {
  name         = "nodo-dei-pagamenti-stand-in-tx-connection-string-key"
  value        = data.azurerm_eventhub_authorization_rule.pagopa-weu-core-evh-ns04_nodo-dei-pagamenti-stand-in-tx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "azurerm_key_vault_secret" "evthub_nodo_dei_pagamenti_stand_in_sync_rx" {
  name         = "nodo-dei-pagamenti-stand-in-sync-rx-connection-string-key"
  value        = data.azurerm_eventhub_authorization_rule.pagopa-weu-core-evh-ns04_nodo-dei-pagamenti-stand-in-sync-rx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}

### verify ko
resource "azurerm_key_vault_secret" "evthub_nodo_dei_pagamenti_verify_ko_tx" {
  name         = "azure-event-hub-verify-ko-evt-connection-string"
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns01_nodo-dei-pagamenti-verify-ko-tx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "azurerm_key_vault_secret" "evthub_nodo_dei_pagamenti_verify_ko_datastore_rx" {
  name         = "ehub-verifyko-datastore-rx-connection-string"
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns01_nodo-dei-pagamenti-verify-ko-datastore-rx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "azurerm_key_vault_secret" "evthub_nodo_dei_pagamenti_verify_ko_tablestorage_rx" {
  name         = "ehub-verifyko-tablestorage-rx-connection-string"
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns01_nodo-dei-pagamenti-verify-ko-tablestorage-rx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "azurerm_key_vault_secret" "verifyko_tablestorage_connection_string" {
  name         = "verifyko-tablestorage-connection-string"
  value        = module.nodo_verifyko_storage_account.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "azurerm_key_vault_secret" "verifyko_datastore_key" {
  name         = "verifyko-datastore-key"
  value        = module.cosmosdb_account_nodo_verifyko.primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}
