
locals {

  fn_name_for_alerts_exceptions = var.env_short != "p" ? [] : [
    {
      name : "generate-pdf"
    }
  ]
}


## Alert
# This alert cover the following error case:
# 1. generate-pdf api throws an exception for the function execution unmanaged programmatically
#
resource "azurerm_monitor_scheduled_query_rules_alert" "pdf-engine-fun-error-alert" {
  for_each = { for c in local.fn_name_for_alerts_exceptions : c.name => c }

  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-pdf-engine-fun-error-alert"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[PDF ENGINE] error while executing generation"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Exception for function PDF Engine"
  enabled        = true
  query = format(<<-QUERY
  exceptions
    | where cloud_RoleName == "%s"
    | where outerMessage contains "Exception while executing function: Functions.${each.value.name}"
    | order by timestamp desc
  QUERY
    , "pagopapdfengine" # from HELM's parameter WEBSITE_SITE_NAME
  )
  severity    = 2 // Sev 2	Warning
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}


resource "azurerm_monitor_scheduled_query_rules_alert" "opex_generate-pdf-engine-generate-responsetime" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-responsetime @ _generate-pdf"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
  description    = "Response time for /generate-pdf is less than or equal to 5s"
  enabled        = true
  query = (<<-QUERY
let threshold = 5000;
AzureDiagnostics
| where url_s matches regex "/generate-pdf"
| summarize
    watermark=threshold,
    duration_percentile_95=percentiles(DurationMs, 95) by bin(TimeGenerated, 5m)
| where duration_percentile_95 > threshold
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

resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-pdf-engine-pdf-availability" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-availability @ _generate-pdf"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
  description    = "Availability for /generate-pdf is less than or equal to 99%"
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
AzureDiagnostics
| where url_s matches regex "/generate-pdf"
| summarize
    Total=count(),
    Success=count(responseCode_d < 500)
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

