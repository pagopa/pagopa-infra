data "azurerm_key_vault" "kv" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}

data "azurerm_key_vault_secret" "pagopa_payment_wallet_service_rest_api_primary_key" {
  name         = "payment-wallet-service-primary-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "pagopa_payment_wallet_service_rest_api_secondary_key" {
  name         = "payment-wallet-service-secondary-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "payment_wallet_service_for_event_dispatcher_api_key" {
  name         = "payment-wallet-service-for-event-dispatcher-api-key"
  value        = var.payment_wallet_service_api_key_use_primary ? data.azurerm_key_vault_secret.pagopa_payment_wallet_service_rest_api_primary_key.value : data.azurerm_key_vault_secret.pagopa_payment_wallet_service_rest_api_secondary_key.value
  key_vault_id = data.azurerm_key_vault.kv.id
}
