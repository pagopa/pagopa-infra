locals {
  aks_api_url = var.env_short == "d" ? data.azurerm_kubernetes_cluster.aks.fqdn : data.azurerm_kubernetes_cluster.aks.private_fqdn
}


## Manual secrets

resource "azurerm_key_vault_secret" "iuv_generator_subscription_key" {
  name         = "apikey-iuv-generator"
  value        = azurerm_api_management_subscription.iuv_generator_subkey.primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.gps_kv.id
}

resource "azurerm_key_vault_secret" "gps_mbd_service_integration_test_subscription_key" {
  name         = "apikey-spontaneous-payments-services"
  value        = azurerm_api_management_subscription.gps_spontaneous_payments_services_subkey.primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.gps_kv.id
}
