# TODO TO REMOVE: this file can be deleted once all secrets are imported in terraform state for all ENVs
locals {
  common_secrets_to_import = [
    "personal-data-vault-api-key",
    "wallet-jwt-signing-key",
    "payment-method-api-key",
    "elastic-otel-token-header",
    "npg-service-api-key",
    "paypal-psp-api-key",
    "npg-notifications-jwt-secret-key"
  ]

  not_prod_secrets_to_import = contains(["d", "u"], var.env_short) ? [
    "wallet-token-test-key",
    "wallet-migration-api-key-test-dev",
    "wallet-migration-cstar-api-key-test-dev",
    "migration-wallet-token-test-dev"
  ] : []


  prod_only_secrets_to_import = var.env_short == "p" ? [
    "payment-wallet-opsgenie-webhook-token",
    "payment-wallet-gha-bot-pat",
  ] : []

  secrets_to_import = concat(
    local.common_secrets_to_import,
    local.not_prod_secrets_to_import,
    local.prod_only_secrets_to_import,
  )
}

data "azurerm_key_vault_secret" "to_import" {
  for_each     = toset(local.secrets_to_import)
  name         = each.value
  key_vault_id = data.azurerm_key_vault.pay_wallet_kv.id
}

import {
  for_each = toset(local.secrets_to_import)

  to = azurerm_key_vault_secret.secret[each.value]
  id = data.azurerm_key_vault_secret.to_import[each.value].id
}
