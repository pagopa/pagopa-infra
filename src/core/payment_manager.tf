resource "azurerm_resource_group" "payment_manager_monitor_rg" {
  count    = var.env_short == "p" ? 1 : 0
  name     = format("%s-payment-manager-monitor-rg", local.project)
  location = var.location
  tags     = var.tags
}

# Availability: Payment Manager - pp-restapi
resource "azurerm_monitor_scheduled_query_rules_alert" "pm_restapi_availability" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "${local.project}-pm-restapi-availability-alert"
  resource_group_name = azurerm_resource_group.payment_manager_monitor_rg[0].name
  location            = var.location

  action {
    action_group           = [azurerm_monitor_action_group.email.id, azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = azurerm_application_insights.application_insights.id
  description    = "Availability pm-restapi greater than or equal 99%"
  enabled        = true
  query = (<<-QUERY
requests
| where url startswith 'https://api.platform.pagopa.it/payment-manager/pp-restapi'
| summarize
    Total=count(),
    Success=count(toint(resultCode) >= 200 and toint(resultCode) < 500 and toint(duration) < 2000)
    by Time=bin(timestamp, 15m)
| extend Availability=((Success * 1.0) / Total) * 100
| extend Watermark=99
| project Watermark, Availability, Time
  QUERY
  )
  severity    = 1
  frequency   = 30
  time_window = 30
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 2
  }
}

# Availability: Payment Manager - pp-restapi-CD
resource "azurerm_monitor_scheduled_query_rules_alert" "pm_restapi_cd_availability" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "${local.project}-pm-restapi-cd-availability-alert"
  resource_group_name = azurerm_resource_group.payment_manager_monitor_rg[0].name
  location            = var.location

  action {
    action_group           = [azurerm_monitor_action_group.email.id, azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = azurerm_application_insights.application_insights.id
  description    = "Availability pm-restapi-cd greater than or equal 99%"
  enabled        = true
  query = (<<-QUERY
requests
| where url startswith 'https://api.platform.pagopa.it/pp-restapi-CD'
| summarize
    Total=count(),
    Success=count(toint(resultCode) >= 200 and toint(resultCode) < 500 and toint(duration) < 2000)
    by Time=bin(timestamp, 15m)
| extend Availability=((Success * 1.0) / Total) * 100
| extend Watermark=99
| project Watermark, Availability, Time
  QUERY
  )
  severity    = 1
  frequency   = 30
  time_window = 30
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 2
  }
}


# Availability: Payment Manager - pp-wallet-CD
resource "azurerm_monitor_scheduled_query_rules_alert" "pm_wallet_availability" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "${local.project}-pm-restapi-wallet-availability-alert"
  resource_group_name = azurerm_resource_group.payment_manager_monitor_rg[0].name
  location            = var.location

  action {
    action_group           = [azurerm_monitor_action_group.email.id, azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = azurerm_application_insights.application_insights.id
  description    = "Availability pm-wallet greater than or equal 99%"
  enabled        = true
  query = (<<-QUERY
requests
| where url startswith 'https://api.platform.pagopa.it/wallet'
| summarize
    Total=count(),
    Success=count(toint(resultCode) >= 200 and toint(resultCode) < 500 and toint(duration) < 2000)
    by Time=bin(timestamp, 15m)
| extend Availability=((Success * 1.0) / Total) * 100
| extend Watermark=99
| project Watermark, Availability, Time
  QUERY
  )
  severity    = 1
  frequency   = 30
  time_window = 30
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 2
  }
}