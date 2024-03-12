locals {
  selfcare_services = [
    {
      name : "internal",
      base_path : "/backoffice/v1"
    },
    {
      name : "external",
      base_path : "/backoffice/external/v1"
    },
    {
      name : "helpdesk",
      base_path : "/backoffice/helpdesk/v1"
    }
  ]
}

#resource "azurerm_monitor_scheduled_query_rules_alert" "alert_pagopa-backoffice-responsetime" {
#  for_each            = { for c in local.selfcare_services : c.base_path => c }
#  resource_group_name = "dashboards"
#  name                = "pagopa-${var.env_short}-alert_pagopa-backoffice-${each.value.name}-responsetime @ _backoffice"
#  location            = var.location
#
#  action {
#    action_group           = var.env_short == "p" ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
#    email_subject          = "Backoffice Response Time"
#    custom_webhook_payload = "{}"
#  }
#
#  data_source_id = data.azurerm_api_management.apim.id
#  description    = "Response time for ${each.value.base_path} is less than or equal to 2s"
#  enabled        = true
#  query = (<<-QUERY
#let threshold = 2000;
#AzureDiagnostics
#| where url_s matches regex "${each.value.base_path}"
#| summarize
#    watermark=threshold,
#    duration_percentile_95=percentiles(DurationMs, 95) by bin(TimeGenerated, 5m)
#| where duration_percentile_95 > threshold
#  QUERY
#  )
#  severity    = 2
#  frequency   = 5
#  time_window = 10
#  trigger {
#    operator  = "GreaterThanOrEqual"
#    threshold = 2
#  }
#}


resource "azurerm_monitor_scheduled_query_rules_alert" "alert-pagopa-backoffice-availability" {
  for_each            = { for c in local.selfcare_services : c.base_path => c }
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-alert_pagopa-backoffice-${each.value.name}-availability"
  location            = var.location

  action {
    action_group           = var.env_short == "p" ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Backoffice Availability"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Availability for ${each.value.base_path} is less than or equal to 99%"
  enabled        = true
  query = var.env_short == "p" ? (<<-QUERY
let threshold = 0.99;
AzureDiagnostics
| where url_s matches regex "${each.value.base_path}"
| summarize
    Total=count(),
    Success=count(responseCode_d < 500)
    by bin(TimeGenerated, 5m)
| extend availability=toreal(Success) / Total
| where availability < threshold
  QUERY
    ) : (<<-QUERY
let threshold = 0.99;
ApiManagementGatewayLogs
| where Url matches regex "${each.value.base_path}"
| summarize
    Total=count(),
    Success=count(ResponseCode < 500)
    by bin(TimeGenerated, 5m)
| extend availability=toreal(Success) / Total
| where availability < threshold
  QUERY
  )
  severity    = 1
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}
