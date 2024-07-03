resource "azurerm_resource_group" "payment_manager_monitor_rg" {
  count    = var.env_short == "p" ? 1 : 0
  name     = format("%s-payment-manager-monitor-rg", local.project)
  location = var.location
  tags     = var.tags
}

# Availability: Payment Manager - pp-restapi - only for checkout
resource "azurerm_monitor_scheduled_query_rules_alert" "pm_restapi_availability" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "${local.project}-pm-restapi-availability-alert"
  resource_group_name = azurerm_resource_group.payment_manager_monitor_rg[0].name
  location            = var.location

  action {
    action_group           = [azurerm_monitor_action_group.email.id, azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.mo_email.id, azurerm_monitor_action_group.pm_opsgenie[0].id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_gateway.app_gw.id
  description    = "Availability pm-restapi (for pagopa - checkout) greater than or equal 99%"
  enabled        = true
  query = (<<-QUERY
AzureDiagnostics
| where ResourceType == 'APPLICATIONGATEWAYS'
    and OperationName == 'ApplicationGatewayAccess'
    and requestUri_s startswith "/payment-manager/pp-restapi/"
| summarize
    Total=count(),
    Success=count((toint(httpStatus_d) >= 200 and toint(httpStatus_d) < 500 and timeTaken_d < 2))
    by Time=bin(TimeGenerated, 15m)
| extend Availability=((Success * 1.0) / Total) * 100
| where toint(Availability) < 99
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
    action_group           = [azurerm_monitor_action_group.email.id, azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.mo_email.id, azurerm_monitor_action_group.pm_opsgenie[0].id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_gateway.app_gw.id
  description    = "Availability pm-restapi-cd greater than or equal 99%"
  enabled        = true
  query = (<<-QUERY
AzureDiagnostics
| where ResourceType == 'APPLICATIONGATEWAYS'
    and OperationName == 'ApplicationGatewayAccess'
    and requestUri_s startswith '/pp-restapi-CD'
| summarize
    Total=count(),
    Success=count((toint(httpStatus_d) >= 200 and toint(httpStatus_d) < 500 and timeTaken_d < 2))
    by Time=bin(TimeGenerated, 15m)
| extend Availability=((Success * 1.0) / Total) * 100
| where toint(Availability) < 99
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


# Availability: Payment Manager - pp-wallet
resource "azurerm_monitor_scheduled_query_rules_alert" "pm_wallet_availability" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "${local.project}-pm-restapi-wallet-availability-alert"
  resource_group_name = azurerm_resource_group.payment_manager_monitor_rg[0].name
  location            = var.location

  action {
    action_group           = [azurerm_monitor_action_group.email.id, azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.mo_email.id, azurerm_monitor_action_group.pm_opsgenie[0].id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_gateway.app_gw.id
  description    = "Availability pm-wallet greater than or equal 99%"
  enabled        = true
  query = (<<-QUERY
AzureDiagnostics
| where ResourceType == "APPLICATIONGATEWAYS"
    and OperationName == "ApplicationGatewayAccess"
    and requestUri_s startswith "/wallet"
| summarize
    Total=count(),
    Success=count((toint(httpStatus_d) >= 200 and toint(httpStatus_d) < 500 and timeTaken_d < 3))
    by Time=bin(TimeGenerated, 15m)
| extend Availability=((Success * 1.0) / Total) * 100
| where toint(Availability) < 99
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

# Availability: Payment Manager - payment-gateway
resource "azurerm_monitor_scheduled_query_rules_alert" "pm_payment_gateway_availability" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "${local.project}-pm-payment-gateway-availability-alert"
  resource_group_name = azurerm_resource_group.payment_manager_monitor_rg[0].name
  location            = var.location

  action {
    action_group           = [azurerm_monitor_action_group.email.id, azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = azurerm_application_insights.application_insights.id
  description    = "Availability pm-payment-gateway greater than or equal 99%"
  enabled        = true
  query = (<<-QUERY
requests
| where url startswith 'https://api.platform.pagopa.it/payment-manager/payment-gateway/'
| summarize
    Total=count(),
    Success=count(toint(resultCode) >= 200 and toint(resultCode) < 500)
    by Time=bin(timestamp, 15m)
| extend Availability=((Success * 1.0) / Total) * 100
| extend Watermark=99
| where toint(Availability) < 99
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
