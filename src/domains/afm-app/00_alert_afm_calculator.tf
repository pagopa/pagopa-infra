locals {
  afm-calculator-dash = {
    node-v1       = "https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/dashboards/providers/Microsoft.Portal/dashboards/pagopa-p-opex_pagopa-afm-calculator-node-v1"
    node-v2       = "https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/dashboards/providers/Microsoft.Portal/dashboards/pagopa-p-opex_pagopa-afm-calculator-node-v2"
    calculator-v1 = "https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/dashboards/providers/Microsoft.Portal/dashboards/pagopa-p-opex_pagopa-afm-calculator-v1"
    calculator-v2 = "https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/dashboards/providers/Microsoft.Portal/dashboards/pagopa-p-opex_pagopa-afm-calculator-v2"
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-afm-calculator-responsetime-fees" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-afm-calculator-v1-responsetime_fees"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
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
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-afm-calculator-availability-fees" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-afm-calculator-v1-availability_fees"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
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

resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-afm-calculator-responsetime-feesbypsp" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-afm-calculator-v1-responsetime_psps_idPsp_fees"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
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
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-afm-calculator-availability-feesbypsp" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-afm-calculator-v1-availability_psps_idPsp_fees"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
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
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-afm-calculator-responsetime-searchpaymentmethods" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-afm-calculator-v1-responsetime_search_payment_method"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Response time for V1 version of /payment-methods/search is less than or equal to 1.5s - ${local.afm-calculator-dash.calculator-v1}"
  enabled        = true
  query = (<<-QUERY
let threshold = 1500;
AzureDiagnostics
| where url_s matches regex "/payment-methods/search"
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
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-afm-calculator-availability-searchpaymentmethods" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-afm-calculator-v1-availability_search_payment_method"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Availability for /payment-methods/search is less than or equal to 99% - ${local.afm-calculator-dash.calculator-v1}"
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
AzureDiagnostics
| where url_s matches regex "/payment-methods/search"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-afm-calculator-v2-responsetime-fees" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-afm-calculator-v2-responsetime_fees_multi"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
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

// Query explanation: https://pagopa.atlassian.net/wiki/spaces/I/pages/574751186/Razionalizzazione+Alert
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-afm-calculator-v2-availability-fees" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-afm-calculator-v2-availability_fees_multi"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Availability for V2 version of /fees is less than or equal to 99% - ${local.afm-calculator-dash.calculator-v2}"
  enabled        = true
  query = (<<-QUERY
  let lowTrafficThreshold = 70; // the lower threshold used if traffic is low
  let highTrafficThreshold = 95; // the upper threshold if traffic is high
  let trafficMin = 100; // below this, we tolerate lower availability
  let trafficLinear = 500; // above this, high availability is expected
  let thresholdDelta = trafficLinear - trafficMin;
  let availabilityDelta = highTrafficThreshold - lowTrafficThreshold;
  // -----------------------------------------
  AzureDiagnostics
  | where url_s matches regex "/v2/fees"
  | summarize
	    total = count(),
	    success = count(responseCode_d < 500)
	    by timeslot = bin(TimeGenerated, 5m)
  | extend trafficUp = total - trafficMin
  | extend deltaRatio = todouble(trafficUp) / todouble(thresholdDelta)
  | extend expectedAvailability = iff(
	    total >= trafficLinear,
	    toreal(highTrafficThreshold),
	    iff(
	        total <= trafficMin,
	        toreal(lowTrafficThreshold),
	        (deltaRatio * availabilityDelta) + lowTrafficThreshold
	    )
	)
   | extend availability = ((success * 1.0) / total) * 100
   | project timeslot, availability, threshold = expectedAvailability
   | where availability < threshold
   QUERY
  )
  severity    = 1
  frequency   = 5
  time_window = 10
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 2
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-afm-calculator-v2-responsetime-feesbypsp" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-afm-calculator-v2-responsetime_psps_idPsp_fees_multi"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
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
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-afm-calculator-v2-availability-feesbypsp" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-afm-calculator-availability_psps_idPsp_fees_multi"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
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
