data "azurerm_resource_group" "monitor_rg" {
  name = var.monitor_resource_group_name
}

data "azurerm_application_insights" "application_insights" {
  name                = local.monitor_appinsights_name
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
}

data "azurerm_monitor_action_group" "slack" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_slack_name
}

data "azurerm_monitor_action_group" "email" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_email_name
}


data "azurerm_key_vault_secret" "checkout_opsgenie_webhook_key" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "checkout-opsgenie-webhook-token"
  key_vault_id = module.key_vault.id
}

resource "azurerm_monitor_action_group" "checkout_opsgenie" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "ChkOpsgenie"
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
  short_name          = "ChkOpsgenie"

  webhook_receiver {
    name                    = "CheckoutOpsgenieWebhook"
    service_uri             = "https://api.opsgenie.com/v1/json/azure?apiKey=${data.azurerm_key_vault_secret.checkout_opsgenie_webhook_key[0].value}"
    use_common_alert_schema = true
  }

  tags = module.tag_config.tags
}
