data "azurerm_log_analytics_workspace" "log_analytics" {
  name                = var.log_analytics_workspace_name
  resource_group_name = var.log_analytics_workspace_resource_group_name
}

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

data "azurerm_key_vault_secret" "opsgenie_webhook_key" {
  count        = var.env_short != "d" ? 1 : 0
  name         = "opsgenie-webhook-token"
  key_vault_id = data.azurerm_key_vault.core_kv.id
}

resource "azurerm_monitor_action_group" "opsgenie" {
  count               = var.env_short != "d" ? 1 : 0
  name                = "Opsgenie"
  resource_group_name = var.monitor_resource_group_name
  short_name          = "opsgenie"

  webhook_receiver {
    name                    = "Opsgenie-WebHook"
    service_uri             = "https://api.opsgenie.com/v1/json/azure?apiKey=${data.azurerm_key_vault_secret.opsgenie_webhook_key[0].value}"
    use_common_alert_schema = true
  }

  tags = module.tag_config.tags
}
