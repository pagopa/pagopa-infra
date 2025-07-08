# resource "azurerm_monitor_metric_alert" "function_app_health_check_v2" {
#   count = var.env_short != "d" ? 1 : 0
#
#   name                = "[${var.domain != null ? "${var.domain} | " : ""}${module.authorizer_function_app.name}] Health Check Failed V2"
#   resource_group_name = "dashboards"
#   scopes              = [module.authorizer_function_app.id]
#   description         = "Availability for platform-authorizer is less than to 99%"
#   severity            = 1
#   frequency           = "PT5M"
#   auto_mitigate       = false
#   enabled             = true
#
#   criteria {
#     metric_namespace = "Microsoft.Web/sites"
#     metric_name      = "HealthCheckStatus"
#     aggregation      = "Average"
#     operator         = "LessThan"
#     threshold        = 99
#   }
#
#   dynamic "action" {
#     for_each = local.authorizer_healthcheck_action
#     content {
#       action_group_id    = action.value["action_group_id"]
#       webhook_properties = action.value["webhook_properties"]
#     }
#   }
# }


resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-platform-authorizer-config-availability" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-platform-authorizer-config-availability @ _platform-authorizer-config"
  location            = var.location

  action {
    action_group = [
      data.azurerm_monitor_action_group.email.id,
      data.azurerm_monitor_action_group.slack.id,
      data.azurerm_monitor_action_group.opsgenie[0].id
    ]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Availability for /shared/authorizer-config is less than or equal to 99% - https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/pagopa-p-opex_pagopa-platform-authorizer-config"
  enabled        = true
  query          = (<<-QUERY
let threshold = 0.99;
AzureDiagnostics
| where url_s matches regex "/shared/authorizer-config/"
| summarize
    Total=count(),
    Success=count(responseCode_d < 500)
    by bin(TimeGenerated, 5m)
| extend availability=toreal(Success) / Total
| where availability < threshold
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

resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-platform-authorizer-availability" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-platform-authorizer-availability @ _platform-authorizer"
  location            = var.location

  action {
    action_group = [
      data.azurerm_monitor_action_group.email.id,
      data.azurerm_monitor_action_group.slack.id,
      data.azurerm_monitor_action_group.opsgenie[0].id
    ]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Availability for /shared/authorizer is less than or equal to 99% - https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/pagopa-p-opex_pagopa-platform-authorizer"
  enabled        = true
  query          = (<<-QUERY
let threshold = 0.99;
AzureDiagnostics
| where url_s matches regex "/shared/authorizer/"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-platform-authorizer-responsetime" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-platform-authorizer-responsetime @ _platform-authorizer"
  location            = var.location

  action {
    action_group = [
      data.azurerm_monitor_action_group.email.id,
      data.azurerm_monitor_action_group.slack.id
    ]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Response time for /shared/authorizer is greater than or equal to 1.5s - https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/pagopa-p-opex_pagopa-platform-authorizer"
  enabled        = true
  query          = (<<-QUERY
let threshold = 1500;
AzureDiagnostics
| where url_s matches regex "/shared/authorizer/"
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
    threshold = 2
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "pagopa-platform-authorizer-exceptions" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-pagopa-platform-authorizer-exceptions"
  location            = var.location

  action {
    action_group = [
      data.azurerm_monitor_action_group.email.id,
      data.azurerm_monitor_action_group.slack.id
    ]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Exceptions occurred for Authorizer"
  enabled        = true
  query = format(<<-QUERY
    let threshold = 1;
exceptions
| where cloud_RoleName == "pagopa-${var.env_short}-shared-authorizer"
| summarize
    Total=count()
    by bin(timestamp, 5m)
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
