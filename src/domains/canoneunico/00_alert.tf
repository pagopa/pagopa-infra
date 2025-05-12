resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-cup-csv-parsing-function-availability" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-cup-CuCsvParsingFunction-availability"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id]
    email_subject          = "Email CuCsvParsingFunction Availability"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "There were some errors for function CuCsvParsingFunction. Check on application insight"
  enabled        = false # DISABLED
  query = (<<-QUERY
  traces
  | where cloud_RoleName == "pagopa-p-fn-canoneunico"
  | summarize Total=countif(tostring(message) matches regex "Function \"CuCsvParsingFunction\" (.*) invoked"),
Error=countif(tostring(message) contains "CuCsvParsingFunction Error") by length=bin(timestamp, 15m)
  | where Error > 0
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

resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-cup-csv-genearate-csv-batch-function-availability" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-cup-CuGenerateOutputCsvBatchFunction-availability"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id]
    email_subject          = "Email CuGenerateOutputCsvBatchFunction Availability"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "There were some errors for function CuGenerateOutputCsvBatchFunction. Check on application insight"
  enabled        = true
  query = (<<-QUERY
  traces
  | where cloud_RoleName == "pagopa-p-fn-canoneunico"
  | summarize Total=countif(tostring(message) matches regex "Function \"CuGenerateOutputCsvBatchFunction\" (.*) invoked"),
Error=countif(tostring(message) matches regex "CuGenerateOutputCsvBatchFunction](.*)error") by length=bin(timestamp, 15m)
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

resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-cup-create-debt-position-function-availability" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-cup-CuCreateDebtPositionFunction-availability"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id]
    email_subject          = "Email CuCreateDebtPositionFunction Availability"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "There were some errors for function CuCreateDebtPositionFunction. Check on application insight"
  enabled        = true
  query = (<<-QUERY
  traces
  | where cloud_RoleName == "pagopa-p-fn-canoneunico"
  | summarize Total=countif(tostring(message) matches regex "Function \"CuCreateDebtPositionFunction\" (.*) invoked"),
Error=countif(tostring(message) contains "CuCreateDebtPositionFunction ERROR]") by length=bin(timestamp, 15m)
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

