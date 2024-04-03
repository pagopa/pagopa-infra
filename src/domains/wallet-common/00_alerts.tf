resource "azurerm_resource_group" "rg_wallet_alerts" {
  count    = var.env_short == "p" ? 1 : 0
  name     = "${local.project}-alerts-rg"
  location = var.location
  tags     = var.tags
}

data "azurerm_key_vault_secret" "monitor_wallet_opsgenie_webhook_key" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "wallet-opsgenie-webhook-token"
  key_vault_id = module.key_vault.id
}

resource "azurerm_monitor_action_group" "wallet_opsgenie" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "WalletAlerts"
  resource_group_name = azurerm_resource_group.rg_wallet_alerts[0].name
  short_name          = "WalletAlerts"

  webhook_receiver {
    name                    = "walletOpsgenieWebhook"
    service_uri             = "https://api.opsgenie.com/v1/json/azure?apiKey=${data.azurerm_key_vault_secret.monitor_wallet_opsgenie_webhook_key[0].value}"
    use_common_alert_schema = true
  }

  tags = var.tags
}
