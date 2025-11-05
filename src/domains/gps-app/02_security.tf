data "azurerm_key_vault" "kv" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}

data "azurerm_key_vault_secret" "gpd_paa_pwd" {
  name         = format("gpd-%s-paa-password", var.env_short)
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "monitor_notification_email" {
  name         = "monitor-notification-email"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "monitor_notification_slack_email" {
  name         = "monitor-notification-slack-email"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "config_cache_subscription_key" {
  name         = "config-cache-subscription-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

# KV placeholder for subkey
#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "gpd_subscription_key" {
  count        = var.env_short != "p" ? 1 : 0 # only in DEV and UAT
  name         = "gpd-api-subscription-key"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

// apikey test apim_gpd_payments_pull_product_and_debt_positions_product_test and save keys on KV
resource "azurerm_api_management_subscription" "test_gpd_payments_pull_and_debt_positions_subkey" {
  count               = 1 # var.env_short != "p" ? 1 : 0 # ppull-prod-test
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  product_id    = module.apim_gpd_payments_pull_product_and_debt_positions_product_test[0].id
  display_name  = "TEST gpd-payments-pull and debt-positions"
  allow_tracing = false
  state         = "active"
}

resource "azurerm_key_vault_secret" "test_gpd_payments_pull_and_debt_positions_subkey_kv" {
  count        = 1 # var.env_short != "p" ? 1 : 0 # ppull-prod-test
  depends_on   = [azurerm_api_management_subscription.test_gpd_payments_pull_and_debt_positions_subkey[0]]
  name         = "integration-test-subkey" # "tst-gpd-ppull-debt-position-key"
  value        = azurerm_api_management_subscription.test_gpd_payments_pull_and_debt_positions_subkey[0].primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}


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

#### QA secrets for integration testing
resource "azurerm_key_vault_secret" "gpd_qa_integration_testing_subscription_key" {
  count        = contains(["d", "u"], var.env_short) ? 1 : 0
  name         = "apikey-gpd-qa-services"
  value        = azurerm_api_management_subscription.gpd_integration_qa_subkey[count.index].primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.gps_kv.id
}

### FDR1-FDR3 secrets
resource "azurerm_key_vault_secret" "fdr1_subscription_key" {
  name         = "apikey-fdr1"
  value        = azurerm_api_management_subscription.fdr1_flow_subkey.primary_key
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.gps_kv.id
}

resource "azurerm_key_vault_secret" "fdr3_subscription_key" {
  name         = "apikey-fdr3"
  value        = azurerm_api_management_subscription.fdr3_flow_subkey.primary_key
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.gps_kv.id
}
