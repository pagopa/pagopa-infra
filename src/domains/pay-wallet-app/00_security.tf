data "azurerm_key_vault" "kv" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}

data "azurerm_key_vault_secret" "pay_wallet_jwt_issuer_service_primary_api_key" {
  name         = "pay-wallet-jwt-issuer-service-primary-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "pay_wallet_jwt_issuer_service_secondary_api_key" {
  name         = "pay-wallet-jwt-issuer-service-secondary-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}
