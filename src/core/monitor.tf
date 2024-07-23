data "azurerm_key_vault_secret" "monitor_notification_email" {
  name         = "monitor-notification-email"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "monitor_notification_slack_email" {
  name         = "monitor-notification-slack-email"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "monitor_mo_notification_email" {
  name         = "monitor-mo-notification-email"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

#
# Alerts
#
data "azurerm_key_vault_secret" "alert_error_notification_email" {
  name         = "alert-error-notification-email"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "alert_error_notification_slack" {
  name         = "alert-error-notification-slack"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "monitor_pm_opsgenie_webhook_key" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "pm-opsgenie-webhook-token"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

# DEPRECATED use opsgenie-webhook-token
data "azurerm_key_vault_secret" "monitor_new_conn_srv_webhook_key" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "new-conn-srv-opsgenie-webhook-token"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_resource_group" "monitor_rg" {
  name = format("%s-monitor-rg", local.project)
}

data "azurerm_application_insights" "application_insights" {
  name                = format("%s-appinsights", local.project)
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
}


data "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = format("%s-law", local.project)
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
}



data "azurerm_monitor_action_group" "email" {
  name                = "PagoPA"
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
}

data "azurerm_monitor_action_group" "slack" {
  name                = "SlackPagoPA"
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
}

data "azurerm_monitor_action_group" "mo_email" {
  name                = "MoManagement"
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
}

data "azurerm_monitor_action_group" "pm_opsgenie" { # https://pagopa.atlassian.net/wiki/spaces/PPR/pages/647921690/PM
  count               = var.env_short == "p" ? 1 : 0
  name                = "PaymentManagerOpsgenie"
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
}

data "azurerm_monitor_action_group" "new_conn_srv_opsgenie" { # https://pagopa.atlassian.net/wiki/spaces/PPR/pages/647921720/Nuova+Connettivit
  count               = var.env_short == "p" ? 1 : 0
  name                = "NuovaConnettivitOpsgenie"
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
}

#
# Alerts
#
data "azurerm_monitor_action_group" "error_action_group" {
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
  name                = "${var.prefix}${var.env_short}error"
}


