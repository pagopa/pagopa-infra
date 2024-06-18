data "azurerm_api_management" "apim_v2" {
  name                = "${local.product}-weu-core-apim-v2"
  resource_group_name = data.azurerm_resource_group.rg_api.name
}


resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-afm-calculator-responsetime-fees-v2" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-afm-calculator-v1-responsetime_fees-v2"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim_v2.id
  description    = "Response time for V1 version of /fees is less than or equal to 1.5s - ${local.afm-calculator-dash.calculator-v1}"
  enabled        = true
  query = (<<-QUERY
let threshold = 1500;
AzureDiagnostics
| where url_s matches regex "/v1/fees"
| summarize
    watermark=threshold,
    duration_percentile_95=percentiles(DurationMs, 95) by bin(TimeGenerated, 5m)
| where duration_percentile_95 > threshold
  QUERY
  )
  severity    = 2
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-afm-calculator-availability-fees-v2" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-afm-calculator-v1-availability_fees-v2"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim_v2.id
  description    = "Availability for V1 version of /fees is less than or equal to 99% - ${local.afm-calculator-dash.calculator-v1}"
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
AzureDiagnostics
| where url_s matches regex "/v1/fees"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-afm-calculator-responsetime-feesbypsp-v2" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-afm-calculator-v1-responsetime_psps_idPsp_fees-v2"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim_v2.id
  description    = "Response time for V1 version of /psps/[^/]+/fees is less than or equal to 1.5s - ${local.afm-calculator-dash.calculator-v1}"
  enabled        = true
  query = (<<-QUERY
let threshold = 1500;
AzureDiagnostics
| where url_s matches regex "/v1/psps/[^/]+/fees"
| summarize
    watermark=threshold,
    duration_percentile_95=percentiles(DurationMs, 95) by bin(TimeGenerated, 5m)
| where duration_percentile_95 > threshold
  QUERY
  )
  severity    = 2
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-afm-calculator-availability-feesbypsp-v2" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-afm-calculator-v1-availability_psps_idPsp_fees-v2"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim_v2.id
  description    = "Availability for V1 version of /psps/[^/]+/fees is less than or equal to 99% - ${local.afm-calculator-dash.calculator-v1}"
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
AzureDiagnostics
| where url_s matches regex "/v1/psps/[^/]+/fees"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-afm-calculator-v2-responsetime-fees-v2" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-afm-calculator-v2-responsetime_fees_multi-v2"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim_v2.id
  description    = "Response time for V2 version of /fees is less than or equal to 1.5s - ${local.afm-calculator-dash.calculator-v2}"
  enabled        = true
  query = (<<-QUERY
let threshold = 1500;
AzureDiagnostics
| where url_s matches regex "/v2/fees"
| summarize
    watermark=threshold,
    duration_percentile_95=percentiles(DurationMs, 95) by bin(TimeGenerated, 5m)
| where duration_percentile_95 > threshold
  QUERY
  )
  severity    = 2
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-afm-calculator-v2-availability-fees-v2" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-afm-calculator-v2-availability_fees_multi-v2"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim_v2.id
  description    = "Availability for V2 version of /fees is less than or equal to 99% - ${local.afm-calculator-dash.calculator-v2}"
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
AzureDiagnostics
| where url_s matches regex "/v2/fees"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-afm-calculator-v2-responsetime-feesbypsp-v2" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-afm-calculator-v2-responsetime_psps_idPsp_fees_multi-v2"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim_v2.id
  description    = "Response time for V2 version of /psps/[^/]+/fees is less than or equal to 1.5s - ${local.afm-calculator-dash.calculator-v2}"
  enabled        = true
  query = (<<-QUERY
let threshold = 1500;
AzureDiagnostics
| where url_s matches regex "/v2/psps/[^/]+/fees"
| summarize
    watermark=threshold,
    duration_percentile_95=percentiles(DurationMs, 95) by bin(TimeGenerated, 5m)
| where duration_percentile_95 > threshold
  QUERY
  )
  severity    = 2
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-afm-calculator-v2-availability-feesbypsp-v2" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-afm-calculator-availability_psps_idPsp_fees_multi-v2"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim_v2.id
  description    = "Availability for V2 version of /psps/[^/]+/fees is less than or equal to 99% - ${local.afm-calculator-dash.calculator-v2}"
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
AzureDiagnostics
| where url_s matches regex "/v2/psps/[^/]+/fees"
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
