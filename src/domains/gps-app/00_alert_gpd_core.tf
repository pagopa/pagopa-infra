## called by internal pagoPA hosts Response Time ##
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-gpd-core-internal-responsetime-upd" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-gpd-core-internal-responsetime @ _gpd"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Response time for /gpd/api is less than or equal to 1.5s - https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/pagopa-p-opex_pagopa-debt-position"
  enabled        = true
  query = (<<-QUERY
let threshold = 1500;
AzureDiagnostics
| where url_s matches regex "/gpd/api"
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

## called by internal pagoPA hosts Availability ##
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-gpd-core-internal-availability-upd" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-gpd-core-internal-availability @ _gpd"
  location            = var.location


  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.opsgenie[0].id, data.azurerm_monitor_action_group.smo_opsgenie[0].id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Availability for /gpd/api is less than or equal to 99% - https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/pagopa-p-opex_pagopa-debt-position"
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
AzureDiagnostics
| where url_s matches regex "/gpd/api" and not(url_s matches regex "/gpd/api/.*/report")
| summarize
    Total=count(),
    Success=count(responseCode_d < 500)
    by bin(TimeGenerated, 5m)
| extend availability=toreal(Success) / Total
| where availability < threshold
  QUERY
  )
  severity    = 0
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

## called by internal pagoPA hosts Availability ##
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-gpd-core-internal-availability-lock-exception" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-gpd-core-internal-availability @ _gpd-lock-exception"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.opsgenie[0].id, data.azurerm_monitor_action_group.smo_opsgenie[0].id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = <<EOT
  On /gpd/api identified errors due to LockAcquisitionException that may occur during report transfer calls.
  In these cases, it is necessary to verify that the retry attempt was correctly made, thus avoiding inconsistent states.
  https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/pagopa-p-opex_pagopa-debt-position
  EOT
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
requests
| where url matches regex "/gpd/api"
| where tolong(resultCode) > 499
| where customDimensions["Response-Body"] contains "LockAcquisitionException"
| summarize count() by name
| where count_ > 1
  QUERY
  )
  severity    = 0
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

## GPD-Core for organizations (alias external) Response Time ##
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-gpd-core-external-responsetime-upd" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-gpd-core-external-responsetime @ _gpd"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Response time for /gpd/debt-positions-service is less than or equal to 1.5s - https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/pagopa-p-opex_pagopa-debt-position"
  enabled        = true
  query = (<<-QUERY
let threshold = 2300;
AzureDiagnostics
| where url_s matches regex "/gpd/debt-positions-service"
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
## GPD-Core for organizations (alias external) Availability ##
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-gpd-core-external-availability-upd" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-gpd-core-external-availability @ _gpd"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.opsgenie[0].id, data.azurerm_monitor_action_group.smo_opsgenie[0].id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Availability for /gpd/debt-positions-service is less than or equal to 99% - https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/pagopa-p-opex_pagopa-debt-position"
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
AzureDiagnostics
| where url_s matches regex "/gpd/debt-positions-service/"
| summarize
    Total=count(),
    Success=count(responseCode_d < 500)
    by bin(TimeGenerated, 5m)
| extend availability=toreal(Success) / Total
| where availability < threshold
  QUERY
  )
  severity    = 0
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

## GPD-SEND communication status ##
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-gpd-send-communication-exception" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-gpd-send-comm-exception"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.slack_pagopa_pagamenti_alert.id]
    email_subject          = "GPD-SEND-STATUS"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "An exception occurred when GPD tries to call SEND for updating notifications, it does NOT cause failures to asynchronous payments."
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
traces
| where cloud_RoleName == 'pagopa-p-gpd-core-service'
| where timestamp > ago(10m)
| where message startswith "[GPD-ERR-SEND-00]"
| where message !contains "404 Not Found"
| summarize count()
| where count_ > 1
  QUERY
  )
  severity    = 2
  frequency   = 10
  time_window = 10
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}


# -----------------------------------------------------------------------------
# GPD – API v3 – OPEX ALERTS
# Scope: availability, latency, burst 5xx
# -----------------------------------------------------------------------------

## GPD-Core for organizations (alias external) Availability - v3 ##
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-gpd-core-external-availability-gpd-v3" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-gpd-core-external-availability @ _gpd-v3"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.opsgenie[0].id, data.azurerm_monitor_action_group.smo_opsgenie[0].id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description = "Availability for /gpd/debt-positions-service/v3 is less than or equal to 99% - https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/pagopa-p-opex_pagopa-debt-position"
  enabled        = true

  query = (<<-QUERY
let threshold = 0.99;
AzureDiagnostics
| where url_s matches regex "/gpd/debt-positions-service/v3"
| summarize
    Total=count(),
    Success=count(responseCode_d < 500)
    by bin(TimeGenerated, 5m)
| extend availability = toreal(Success) / Total
| where availability < threshold
  QUERY
  )

  severity    = 0
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

## GPD-Core for organizations (alias external) Response Time - v3 ##
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-gpd-core-external-responsetime-gpd-v3" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-gpd-core-external-responsetime @ _gpd-v3"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description = "Response time (p95) for /gpd/debt-positions-service/v3 is greater than or equal to 2.3s - https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/pagopa-p-opex_pagopa-debt-position"
  enabled        = true

  query = (<<-QUERY
let threshold = 2300;
AzureDiagnostics
| where url_s matches regex "/gpd/debt-positions-service/v3"
| summarize
    watermark = threshold,
    duration_percentile_95 = percentiles(DurationMs, 95)
    by bin(TimeGenerated, 5m)
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

## GPD-Core for organizations (alias external) Burst 5xx - v3 (Anomalous spikes before degradation) ##
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-gpd-core-external-burst-5xx-gpd-v3" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-gpd-core-external-burst-5xx @ _gpd-v3"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.opsgenie[0].id, data.azurerm_monitor_action_group.smo_opsgenie[0].id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "5xx spike vs baseline detected on /gpd/debt-positions-service/v3 (pre-degradation burst detector) - https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/pagopa-p-opex_pagopa-debt-position"
  enabled        = true

  # KQL early-warning burst detector:
  # - Detects anomalous growth in error-rate.
  # - Small rates can trigger if the spike is large enough.
  # - Conditions:
  #     * current_rate (last 5m) > baseline_rate (prev 15m average) * mult
  #     * both current and baseline bins have sufficient traffic (minVol)
  query = (<<-QUERY
let lookback = 20m;      // total lookback window (baseline 15m + current 5m)
let binSize  = 5m;       // 5-minute bins
let minVol   = 100;      // guardrail: minimum total requests per bin
let mult     = 5.0;      // spike multiplier: current must be > 5x the baseline
let floor    = 0.0;      // NO absolute floor: allow early detection

// Aggregate APIM logs by 5-minute bins, counting total requests and 5xx errors
let data = materialize(
  AzureDiagnostics
  | where TimeGenerated > ago(lookback)
  | where url_s matches regex "/gpd/debt-positions-service/v3"
  | summarize
      errors = countif(todouble(responseCode_d) >= 500),
      total  = count()
      by bin(TimeGenerated, binSize)
  | extend rate = iif(total == 0, 0.0, todouble(errors) / todouble(total))
);

// Baseline = average rate over the first 3 bins (~15m before the current bin)
let baseline_rate =
  toscalar(
    data
    | top 3 by TimeGenerated asc
    | summarize avg(rate)
  );

// Baseline min volume (stability): ensure each baseline bin has enough traffic
let baseline_min_total =
  toscalar(
    data
    | top 3 by TimeGenerated asc
    | summarize min(total)
  );

// Current bin = most recent 5-minute bin
let current_rate =
  toscalar(
    data
    | top 1 by TimeGenerated desc
    | project rate
  );

let current_total =
  toscalar(
    data
    | top 1 by TimeGenerated desc
    | project total
  );

// Spike condition: large relative jump vs baseline + volume guardrails
let is_spike =
  current_rate > (baseline_rate * mult)
  and current_rate > floor
  and current_total >= minVol
  and baseline_min_total >= minVol;

// Emit numeric signal (>=1 triggers the rule)
print spike_signal = iif(is_spike, 1, 0)
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

