

resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-node-forwarder-responsetime-upd-v2" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-node-forwarder-responsetime @ _forward2-v2"
  location            = var.location

  action {
    action_group           = [azurerm_monitor_action_group.email.id, azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.mo_email.id, azurerm_monitor_action_group.new_conn_srv_opsgenie[0].id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim_v2[0].id
  description    = "Response time for /forward is less than or equal to 9s - https://portal.azure.com/#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/dashboards/providers/Microsoft.Portal/dashboards/pagopa-p-opex_pagopa-node-forwarder"
  enabled        = true
  query = (<<-QUERY
let threshold = 9000;
AzureDiagnostics
| where url_s matches regex "/forward"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-node-forwarder-availability-upd-v2" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-node-forwarder-availability @ _forward2-v2"
  location            = var.location

  action {
    action_group           = [azurerm_monitor_action_group.email.id, azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.mo_email.id, azurerm_monitor_action_group.new_conn_srv_opsgenie[0].id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim_v2[0].id
  description    = "Availability for /forward is less than or equal to 99% - https://portal.azure.com/#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/dashboards/providers/Microsoft.Portal/dashboards/pagopa-p-opex_pagopa-node-forwarder"
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
AzureDiagnostics
| where url_s matches regex "/forward"
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


