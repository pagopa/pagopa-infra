resource "azurerm_key_vault_secret" "nodo_dei_pagamenti_re_observability_connection_string" {
  name         = "evh-nodo-re-observability-connection-string"
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-re_observability.primary_connection_string
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "nodo_observability_storage_account_connection_string" {
  count        = var.nodo_observability_enabled ? 1 : 0
  depends_on   = [module.nodo_observability_cdn]
  name         = "nodo-observability-storage-account-connection-string"
  value        = module.nodo_observability_cdn[0].storage_primary_blob_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "nodo_monitoring_product_subscription_key" {
  count        = var.nodo_observability_enabled ? 1 : 0
  depends_on   = [azurerm_api_management_subscription.nodo_monitoring_product_subkey]
  name         = "nodo-monitoring-product-subscription-key"
  value        = azurerm_api_management_subscription.nodo_monitoring_product_subkey.primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "apiconfig_auth_product_subscription_key" {
  count        = var.nodo_observability_enabled ? 1 : 0
  depends_on   = [azurerm_api_management_subscription.apiconfig_product_subkey]
  name         = "apiconfig-auth-product-subscription-key"
  value        = azurerm_api_management_subscription.apiconfig_product_subkey.primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

