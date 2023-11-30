resource "azurerm_resource_group" "rg_ecommerce_alerts" {
  count    = var.env_short == "p" ? 1 : 0
  name     = "${local.project}-alerts-rg"
  location = var.location
  tags     = var.tags
}

data "azurerm_key_vault_secret" "monitor_ecommerce_opsgenie_webhook_key" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "ecommerce-opsgenie-webhook-token"
  key_vault_id = module.key_vault.id
}

resource "azurerm_monitor_action_group" "ecommerce_opsgenie" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "EcomOpsgenie"
  resource_group_name = azurerm_resource_group.rg_ecommerce_alerts[0].name
  short_name          = "EcomOpsgenie"

  webhook_receiver {
    name                    = "EcommerceOpsgenieWebhook"
    service_uri             = "https://api.opsgenie.com/v1/json/azure?apiKey=${data.azurerm_key_vault_secret.monitor_ecommerce_opsgenie_webhook_key[0].value}"
    use_common_alert_schema = true
  }

  tags = var.tags
}
