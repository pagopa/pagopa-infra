## Response Time alert: GPD-Upload REST for organizations ##
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-gpd-upload-rest-responsetime-upd" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-gpd-upload-rest-responsetime @ _gpd"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Email GPD-upload-service-function Response Time"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
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
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-gpd-upload-rest-availability-upd" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-gpd-upload-rest-availability @ _gpd"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id, data.azurerm_monitor_action_group.smo_opsgenie[0].id]
    email_subject          = "Email GPD-upload-rest Availability"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
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

## Availability alert: GPD-Upload service function ##
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-gpd-upload-service-function-availability" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-gpd-upload-service-function-availability @ _gpd"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id, data.azurerm_monitor_action_group.smo_opsgenie[0].id]
    email_subject          = "Email GPD-upload-service-function Availability"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "There were some errors for service function GPD-Upload. \nThis function call in bulk GPD-Core. \nCheck error on application insight."
  enabled        = true
  query = (<<-QUERY
  traces
  | where cloud_RoleName == "pagopa-p-gpd-upload-function"
  | summarize Total=countif(tostring(message) matches regex "[OperationService] Process request in BULK"),
Error=countif(tostring(message) contains "[ServiceFunction] Processing function exception") by length=bin(timestamp, 15m)
  | where Total > 0 and Error > 0
  QUERY
  )
  severity    = 2
  frequency   = 5
  time_window = 10
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

## Availability alert: GPD-Upload validation function ##
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-gpd-upload-validation-function-availability" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-gpd-upload-validation-function-availability @ _gpd"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id, data.azurerm_monitor_action_group.smo_opsgenie[0].id]
    email_subject          = "Email GPD-upload-validation-function Availability"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "There were some errors for service function GPD-Upload. \nThis function validate organization JSON input. \nCheck error on application insight."
  enabled        = true
  query = (<<-QUERY
  traces
  | where cloud_RoleName == "pagopa-p-gpd-upload-function"
  | summarize Total=countif(tostring(message) matches regex "[ValidationFunction] Call event type"),
Error=countif(tostring(message) contains "[ValidationFunction] Processing function exception") by length=bin(timestamp, 15m)
  | where Total > 0 and Error > 0
  QUERY
  )
  severity    = 2
  frequency   = 5
  time_window = 10
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}
