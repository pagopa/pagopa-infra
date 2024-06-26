data "azurerm_api_management" "apim_v2" {
  name                = "${local.product}-weu-core-apim-v2"
  resource_group_name = data.azurerm_resource_group.rg_api.name
}

resource "azurerm_monitor_scheduled_query_rules_alert" "alert-pagopa-backoffice-availability-v2" {
  for_each            = { for c in local.selfcare_services : c.base_path => c }
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-alert_pagopa-backoffice-${each.value.name}-availability-v2"
  location            = var.location

  action {
    action_group = var.env_short == "p" ? [
      data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id,
      data.azurerm_monitor_action_group.opsgenie[0].id
    ] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Backoffice Availability"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim_v2.id
  description    = "Availability for ${each.value.base_path} is less than or equal to 99%"
  enabled        = true
  query = var.env_short == "p" ? (<<-QUERY
let threshold = 0.9;
AzureDiagnostics
| where url_s matches regex "${each.value.base_path}"
| summarize
    Total=count(),
    Success=count(responseCode_d < 500)
    by bin(TimeGenerated, 5m)
| extend availability=toreal(Success) / Total
| where availability < threshold
| where Total > 10
  QUERY
    ) : (<<-QUERY
let threshold = 0.9;
ApiManagementGatewayLogs
| where Url matches regex "${each.value.base_path}"
| summarize
    Total=count(),
    Success=count(ResponseCode < 500)
    by bin(TimeGenerated, 5m)
| extend availability=toreal(Success) / Total
| where availability < threshold
| where Total > 10
  QUERY
  )
  severity    = 1
  frequency   = 10
  time_window = 10
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}
