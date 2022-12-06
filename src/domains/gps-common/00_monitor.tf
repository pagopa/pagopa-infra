data "azurerm_log_analytics_workspace" "log_analytics" {
  name                = var.log_analytics_workspace_name
  resource_group_name = var.log_analytics_workspace_resource_group_name
}

data "azurerm_resource_group" "monitor_rg" {
  name = var.monitor_resource_group_name
}

data "azurerm_application_insights" "application_insights" {
  name                = var.application_insights_name
  resource_group_name = var.monitor_resource_group_name
}

data "azurerm_monitor_action_group" "slack" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_slack_name
}

data "azurerm_monitor_action_group" "email" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_email_name
}

##Alert
resource "azurerm_monitor_scheduled_query_rules_alert" "payments_gpd_inconsistency_error" {
  count = var.env_short == "p" ? 1 : 0

  name                = format("%s-gpd-payments-api-alert", var.env_short)
  resource_group_name = azurerm_resource_group.gps_rg.name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.name, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[Payments] call GPD payment position error"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Payments API Call Warning"
  enabled        = true
  query = format(<<-QUERY
  traces
    | where cloud_RoleName == "%s"
    | order by timestamp desc
    | where message contains "[getGPDCheckedReceiptsList] Non-blocking error"
  QUERY
    , format("%s-gpd-payments-api-alert", var.env_short)
  )
  severity    = 1
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}
