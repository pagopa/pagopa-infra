## Print Notice Service ##

resource "azurerm_monitor_scheduled_query_rules_alert" "pagopa-print-payment-notice-service-responsetime-upd" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-pagopa-print-payment-notice-service-rest-responsetime @ _print-payment-notice-service"
  location            = var.location

  action {
    action_group           = can(data.azurerm_monitor_action_group.opsgenie[0]) ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Response time for /print-payment-notice-service is less than or equal to 1.5s - https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/pagopa-p-opex_pagopa-print-payment-notice-service"
  enabled        = false
  query = (<<-QUERY
let threshold = 1500;
AzureDiagnostics
| where url_s matches regex "/print-payment-notice-service"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "pagopa-print-payment-notice-service-rest-availability-upd" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-pagopa-print-payment-notice-service-rest-availability @ _print-payment-notice-service"
  location            = var.location

  action {
    action_group           = can(data.azurerm_monitor_action_group.opsgenie[0]) ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Availability for /print-payment-notice-service is less than or equal to 99% - https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/pagopa-p-opex_pagopa-print-payment-notice-service"
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
AzureDiagnostics
| where url_s matches regex "/print-payment-notice-service'"
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

## Print Notice Generator ##

resource "azurerm_monitor_scheduled_query_rules_alert" "pagopa-print-payment-notice-generator-responsetime-upd" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-pagopa-print-payment-notice-generator-rest-responsetime @ _print-payment-notice-generator"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Response time for /print-payment-notice-generator is less than or equal to 1.5s - https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/pagopa-p-opex_pagopa-print-payment-notice-generator"
  enabled        = true
  query = (<<-QUERY
let threshold = 1500;
AzureDiagnostics
| where url_s matches regex "/print-payment-notice-generator"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "pagopa-print-payment-notice-generator-rest-availability-upd" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-pagopa-print-payment-notice-generator-rest-availability @ _print-payment-notice-generator"
  location            = var.location

  action {
    action_group           = can(data.azurerm_monitor_action_group.opsgenie[0]) ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Availability for /print-payment-notice-generator is less than or equal to 99% - https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/pagopa-p-opex_pagopa-print-payment-notice-generator"
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
AzureDiagnostics
| where url_s matches regex "/print-payment-notice-generator'"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "print-generator-save-error-alert" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-print-generator-save-error-alert"
  location            = var.location

  action {
    action_group           = can(data.azurerm_monitor_action_group.opsgenie[0]) ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[Print Notice] error on generated notice save on blob storage"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights_italy.id
  description    = "Exception occurred while attempting to save generated notice"
  enabled        = true
  query = format(<<-QUERY
  exceptions
    | where cloud_RoleName == "%s"
    | where outerMessage contains "Encountered an error calling the PDF Engine"
    | order by timestamp desc
  QUERY
    , "print-payment-notice-generator" # from HELM's parameter WEBSITE_SITE_NAME
  )
  severity    = 2 // Sev 2	Warning
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 20
  }

}

resource "azurerm_monitor_scheduled_query_rules_alert" "print-generator-retry-save-error-alert" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-print-generator-error-save-error-alert"
  location            = var.location

  action {
    action_group           = can(data.azurerm_monitor_action_group.opsgenie[0]) ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[Print Notice] error on generated notice save on retry related repository"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights_italy.id
  description    = "Exception occurred while attempting to save generated item to retry"
  enabled        = true
  query = format(<<-QUERY
  exceptions
    | where cloud_RoleName == "%s"
    | where outerMessage contains "Unable to save notice data into error repository for notice"
    | order by timestamp desc
  QUERY
    , "print-payment-notice-generator" # from HELM's parameter WEBSITE_SITE_NAME
  )
  severity    = 2 // Sev 2	Warning
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 20
  }

}

## PDF Engine ##

resource "azurerm_monitor_scheduled_query_rules_alert" "pdf-engine-fun-error-alert" {
  count = var.env_short == "p" ? 1 : 0

  resource_group_name = "dashboards"
  name                = "${local.project}-pdf-engine-fun-error-alert"
  location            = var.location

  action {
    action_group           = can(data.azurerm_monitor_action_group.opsgenie[0]) ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[PDF ENGINE] error while executing generation"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights_italy.id
  description    = "Exception for function PDF Engine"
  enabled        = true
  query = format(<<-QUERY
  exceptions
    | where cloud_RoleName == "%s"
    | where outerMessage contains "Exception while executing function: Functions.generate-pdf"
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


resource "azurerm_monitor_scheduled_query_rules_alert" "generate-pdf-engine-generate-responsetime" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "${local.project}-responsetime @ _generate-pdf"
  location            = var.location

  action {
    action_group           = can(data.azurerm_monitor_action_group.opsgenie[0]) ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
  description    = "Response time for /generate-pdf is less than or equal to 5s"
  enabled        = false
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

resource "azurerm_monitor_scheduled_query_rules_alert" "pagopa-pdf-engine-pdf-availability" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "${local.project}-availability @ _generate-pdf"
  location            = var.location

  action {
    action_group           = can(data.azurerm_monitor_action_group.opsgenie[0]) ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
  description    = "Availability for /generate-pdf is less than or equal to 90%"
  enabled        = true
  query = (<<-QUERY
let threshold = 0.90;
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

## Print Notice Functions ##

resource "azurerm_monitor_scheduled_query_rules_alert" "print-notice-retry-fn-error-alert" {
  count = var.env_short == "p" ? 1 : 0

  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-print-notice-retry-fn-error-alert"
  location            = var.location

  action {
    action_group           = can(data.azurerm_monitor_action_group.opsgenie[0]) ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[Print Notice] error on retry management"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights_italy.id
  description    = "Retry Function Error"
  enabled        = true
  query = format(<<-QUERY
  exceptions
    | where cloud_RoleName == "%s"
    | where outerMessage contains "Retry Error"
    | order by timestamp desc
  QUERY
    , "print-payment-notice-functions" # from HELM's parameter WEBSITE_SITE_NAME
  )
  severity    = 2 // Sev 2	Warning
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 20
  }

}

resource "azurerm_monitor_scheduled_query_rules_alert" "print-notice-compress-fn-error-alert" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-print-notice-compress-fn-error-alert"
  location            = var.location

  action {
    action_group           = can(data.azurerm_monitor_action_group.opsgenie[0]) ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[Print Notice] error on completion function for massive request"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights_italy.id
  description    = "Compression Function Error"
  enabled        = true
  query = format(<<-QUERY
  exceptions
    | where cloud_RoleName == "%s"
    | where outerMessage contains "Massive Request FAILED"
    | order by timestamp desc
  QUERY
    , "print-payment-notice-functions" # from HELM's parameter WEBSITE_SITE_NAME
  )
  severity    = 2 // Sev 2	Warning
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 20
  }

}


