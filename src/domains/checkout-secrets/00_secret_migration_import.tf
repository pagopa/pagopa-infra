#TODO TO REMOVE: this file can be deleted once all secrets are imported in terraform state for all ENVs
locals {
  common_secrets_to_import = [
    "elastic-otel-token-header",
    "checkout-oneidentity-onboarding-api-key",
    "checkout-oneidentity-onboarding-params",
    "checkout-one-identity-client-secret",
    "checkout-feature-flags-map",
    "checkout-one-identity-admin-for-checkout",
  ]

  uat_only_secrets_to_import = var.env_short == "u" ? [
    "checkout-one-identity-client-secret-test",
  ] : []

  prod_only_secrets_to_import = var.env_short == "p" ? [
    "checkout-opsgenie-webhook-token",
    "checkout-gha-bot-pat",
    "checkout-github-token-for-tas-integration",
  ] : []

  secrets_to_import = concat(
    local.common_secrets_to_import,
    local.uat_only_secrets_to_import,
    local.prod_only_secrets_to_import,
  )
}

data "azurerm_key_vault_secret" "to_import" {
  for_each     = toset(local.secrets_to_import)
  name         = each.value
  key_vault_id = data.azurerm_key_vault.checkout_kv.id
}

import {
  for_each = toset(local.secrets_to_import)

  to = azurerm_key_vault_secret.secret[each.value]
  id = data.azurerm_key_vault_secret.to_import[each.value].id
}
