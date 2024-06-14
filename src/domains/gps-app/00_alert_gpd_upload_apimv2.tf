


## Response Time alert: GPD-Upload REST for organizations ##
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-gpd-upload-rest-responsetime-upd-v2" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-gpd-upload-rest-responsetime @ _gpd-v2"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Email GPD-upload-service-function Response Time"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim_v2.id
  description    = "Response time for /upload/gpd/debt-positions-service is less than or equal to 2s - <dashboard-link-here>"
  enabled        = true
  query = (<<-QUERY
let threshold = 2000;
AzureDiagnostics
| where url_s matches regex "/upload/gpd/debt-positions-service"
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
## Availability alert: GPD-Upload REST for organizations ##
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-gpd-upload-rest-availability-upd-v2" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-gpd-upload-rest-availability @ _gpd-v2"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id]
    email_subject          = "Email GPD-upload-rest Availability"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim_v2.id
  description    = "Availability for /upload/gpd/debt-positions-service/ is less than or equal to 99% - <dashboard-link-here>"
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
AzureDiagnostics
| where url_s matches regex "/upload/gpd/debt-positions-service"
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

