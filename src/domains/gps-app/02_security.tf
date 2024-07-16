data "azurerm_key_vault" "kv" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}

data "azurerm_key_vault_secret" "gpd_paa_pwd" {
  name         = format("gpd-%s-paa-password", var.env_short)
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "flows_sa_connection_string" {
  name         = format("flows-sa-%s-connection-string", var.env_short)
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
