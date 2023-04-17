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
