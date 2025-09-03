## Response Time alert: GPD-Upload for ACA REST for organizations ##
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-aca-upload-rest-responsetime-upd" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-aca-upload-rest-responsetime @ _gpd"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Email GPD-Upload for ACA Response Time"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Response time for /upload/aca/debt-positions-service is less than or equal to 2s - <dashboard-link-here>"
  enabled        = true
  query = (<<-QUERY
let threshold = 2000;
AzureDiagnostics
| where url_s matches regex "/upload/aca/debt-positions-service"
| summarize
    watermark=threshold,
    duration_percentile_95=percentiles(DurationMs, 95) by bin(TimeGenerated, 5m)
| where duration_percentile_95 > threshold
  QUERY
  )
  severity    = 2
  frequency   = 5
  time_window = 10
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 2
  }
}
## Availability alert: GPD-Upload for ACA REST for organizations ##
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-aca-upload-rest-availability-upd" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-aca-upload-rest-availability @ _gpd"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id, data.azurerm_monitor_action_group.smo_opsgenie[0].id]
    email_subject          = "Email GPD-Upload for ACA REST Availability"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Availability for /upload/aca/debt-positions-service/ is less than or equal to 99% - <dashboard-link-here>"
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
AzureDiagnostics
| where url_s matches regex "/upload/aca/debt-positions-service"
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
