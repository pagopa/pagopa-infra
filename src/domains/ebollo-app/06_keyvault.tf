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

resource "azurerm_key_vault_secret" "node_key_subscription_key" {
  count = var.env_short != "p" ? 1 : 0

  name         = "apikey-node-for-psp"
  value        = azurerm_api_management_subscription.nodo_subkey[0].primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "node_key_subscription_key" {
  count = var.env_short != "p" ? 1 : 0

  name         = "apikey-carts"
  value        = azurerm_api_management_subscription.carts_subkey[0].primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "payments_key_subscription_key" {
  count = var.env_short != "p" ? 1 : 0

  name         = "apikey-payments"
  value        = azurerm_api_management_subscription.payments_subkey[0].primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}



