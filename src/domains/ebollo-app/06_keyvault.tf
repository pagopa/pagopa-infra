locals {
  aks_api_url = var.env_short == "d" ? data.azurerm_kubernetes_cluster.aks.fqdn : data.azurerm_kubernetes_cluster.aks.private_fqdn
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "aks_apiserver_url" {
  name         = "${local.aks_name}-apiserver-url"
  value        = "https://${local.aks_api_url}:443"
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

## Manual secrets

resource "azurerm_key_vault_secret" "application_insights_connection_string" {
  name         = "app-insight-connection-string"
  value        = data.azurerm_application_insights.application_insights_italy.connection_string
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "tenant_id" {
  name         = "tenant-id"
  value        = data.azurerm_subscription.current.tenant_id
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "node_subscription_key" {
  name         = "apikey-node-for-psp"
  value        = azurerm_api_management_subscription.nodo_subkey.primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "carts_subscription_key" {
  name         = "apikey-checkout-carts"
  value        = azurerm_api_management_subscription.carts_subkey.primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "payments_key_subscription_key" {
  name         = "apikey-gpd-payments"
  value        = azurerm_api_management_subscription.payments_subkey.primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "gps_mbd_service_integration_test_subscription_key" {
  count        = var.env_short != "p" ? 1 : 0
  name         = "apikey-gps-mbd-integration-test"
  value        = azurerm_api_management_subscription.gps_mbd_service_integration_test_subkey[0].primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "mbd_service_integration_test_subscription_key" {
  count        = var.env_short != "p" ? 1 : 0
  name         = "apikey-mbd-integration-test"
  value        = azurerm_api_management_subscription.mbd_service_integration_test_subkey[0].primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "gdp_debt_positions_test_sub_key" {
  count        = var.env_short != "p" ? 1 : 0
  name         = "gpd-api-key-test"
  value        = azurerm_api_management_subscription.gdp_debt_positions_product_integration_test_subkey[0].primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "redis_password" {
  name  = "redis-password"
  value = data.azurerm_redis_cache.redis_cache.primary_access_key

  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "ehub_nodo_pagamenti_cache_jaas_config" {
  name         = "evh-cache-jaas-config"
  value        = "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"$ConnectionString\" password=\"${data.azurerm_eventhub_authorization_rule.pagopa_weu_core_evh_ns04_nodo_dei_pagamenti_cache_sync_reader.primary_connection_string}\";"
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}
