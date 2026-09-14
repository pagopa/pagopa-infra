# TODO TO REMOVE: this file can be deleted once all secrets are imported in terraform state for all ENVs
locals {
  common_secrets_to_import = [
    "personal-data-vault-api-key",
    "elastic-apm-secret-token",
    "notifications-sender",
    "sessions-jwt-secret",
    "aws-ses-accesskey-id",
    "aws-ses-secretaccess-key",
    "ecommerce-storage-transient-connection-string",
    "ecommerce-storage-deadletter-connection-string",
    "ecommerce-storage-transient-account-key",
    "mongo-ecommerce-password",
    "redis-ecommerce-password",
    "nodo-connection-string",
    "notifications-service-api-key",
    "payment-method-api-key",
    "elastic-otel-token-header",
    "npg-api-key",
    "pm-oracle-db-host",
    "pm-oracle-db-password",
    "npg-cards-psp-keys",
    "nodo-nodeforpsp-api-key",
    "nodo-nodeforpm-api-key",
    "node-for-ecommerce-api-v1-key",
    "node-for-ecommerce-api-v2-key",
    "ecommerce-io-jwt-signing-key",
    "wallet-api-key",
    "npg-notification-signing-key",
    "node-forwarder-api-key",
    "transactions-service-auth-update-api-key",
    "user-stats-for-event-dispatcher-api-key",
    "redirect-url-configurations",
    "npg-paypal-psp-keys",
    "npg-bancomatpay-psp-keys",
    "npg-mybank-psp-keys",
    "npg-apple-pay-psp-keys",
    "npg-satispay-psp-keys",
    "ecommerce-for-checkout-google-recaptcha-secret",
    "transactions-service-auth-update-api-key-v2",
    "npg-google-pay-psp-keys",
    "ecommerce-reporting-webhook-url-slack",
    "helpdesk-service-api-key-for-reporting",
    "ecommerce-storage-reporting-connection-string",
    "ecommerce-helpdesk-service-api-key-for-watchdog",
    "nodo-helpdesk-service-api-key-for-watchdog",
    "afm-api-key",
    "ecommerce-storage-account-key"
  ]

  not_prod_secrets_to_import = contains(["d", "u"], var.env_short) ? [
    "helpdesk-service-testing-api-key",
    "helpdesk-service-testing-email",
    "helpdesk-service-testing-fiscalCode",
    "wallet-token-test-key",
    "helpdesk-service-testing-email-history",
    "checkout-payment-methods-handler-api-key",
    "io-payment-methods-handler-api-key",
    "api-config-for-ecommerce-key",
    "helpdesk-ecommerce-commands-testing-api-key",
    "notifications-service-ai-instrumentation-key",
    "notifications-service-testing-api-key",
    "notifications-service-testing-mail"
  ] : []

  dev_only_secrets_to_import = contains(["d"], var.env_short) ? [
    "afm-api-key-blue",
    "db-mock-psp-user-login",
    "db-mock-psp-user-login-password",
    "ecommerce-for-checkout-api-key",
    "token-release"
  ] : []

  uat_only_secrets_to_import = contains(["u"], var.env_short) ? [
    "ecommerce-dev-sendpaymentresult-subscription-key",
    "ecommerce-load-test-subscription-key",
    "ecommerce-storage-connection-string",
    "help-desk-api-key-ecommerce-prod",
    "mock-gmp-api-key"
  ] : []

  prod_only_secrets_to_import = var.env_short == "p" ? [
    "touchpoint-mail",
    "ecommerce-opsgenie-webhook-token",
    "ecommerce-gha-bot-pat",
    "service-management-opsgenie-webhook-token",
    "ecommerce-github-packages-read-bot-token",
    "ecommerce-ratemyopenapi-api-key",
    "touchpoint-pagopa-apim-user-password",
    "ecommerce-storage-connection-string"
  ] : []

  secrets_to_import = concat(
    local.common_secrets_to_import,
    local.not_prod_secrets_to_import,
    local.dev_only_secrets_to_import,
    local.uat_only_secrets_to_import,
    local.prod_only_secrets_to_import,
  )
}

data "azurerm_key_vault_secret" "to_import" {
  for_each     = toset(local.secrets_to_import)
  name         = each.value
  key_vault_id = data.azurerm_key_vault.ecommerce_kv.id
}

import {
  for_each = toset(local.secrets_to_import)

  to = azurerm_key_vault_secret.secret[each.value]
  id = data.azurerm_key_vault_secret.to_import[each.value].id
}
