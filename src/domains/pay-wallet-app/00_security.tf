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
