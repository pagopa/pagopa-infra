data "azurerm_key_vault" "key_vault" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}

resource "azurerm_key_vault_secret" "ehub_verifyko_tx_connection_string" {
  name         = format("ehub-%s-verifyko-tx-connection-string", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns02_nodo-dei-pagamenti-verify-ko_nodo-dei-pagamenti-verify-ko-tx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "azurerm_key_vault_secret" "ehub_verifyko_tx_key" {
  name         = format("ehub-%s-verifyko-tx-key", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns02_nodo-dei-pagamenti-verify-ko_nodo-dei-pagamenti-verify-ko-tx.primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "azurerm_key_vault_secret" "ehub_verifyko_datastore_rx_connection_string" {
  name         = format("ehub-%s-verifyko-datastore-rx-connection-string", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns02_nodo-dei-pagamenti-verify-ko_nodo-dei-pagamenti-verify-ko-datastore-rx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "azurerm_key_vault_secret" "ehub_verifyko_tablestorage_rx_connection_string" {
  name         = format("ehub-%s-verifyko-tablestorage-rx-connection-string", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns02_nodo-dei-pagamenti-verify-ko_nodo-dei-pagamenti-verify-ko-tablestorage-rx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}
