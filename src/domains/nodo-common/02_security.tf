data "azurerm_key_vault" "key_vault" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}

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
resource "azurerm_key_vault_secret" "evthub_nodo_dei_pagamenti_cache_sync_rx" {
  name         = "nodo-dei-pagamenti-cache-sync-rx-connection-string-key"
  value        = data.azurerm_eventhub_authorization_rule.pagopa-weu-core-evh-ns04_nodo-dei-pagamenti-cache-sync-rx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}

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
