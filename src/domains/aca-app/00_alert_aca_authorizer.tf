resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-aca-unauthorized" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-aca-unauthorized @ _aca"
  location            = var.location

  action {
    action_group = [
      data.azurerm_monitor_action_group.email.id,
      data.azurerm_monitor_action_group.slack.id,
      data.azurerm_monitor_action_group.opsgenie[0].id,
      data.azurerm_monitor_action_group.smo_opsgenie[0].id
    ]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Unauthorized for ACA APIs is greater than or equal to 10%"
  enabled        = true
  query          = (<<-QUERY
let threshold = 0.10;
AzureDiagnostics
| where url_s matches regex "/aca"
| and url_s matches regex "/aca/debt-positions-service"
| summarize
    Total=count(),
    Unauthorized=count(responseCode_d = 403)
    by bin(TimeGenerated, 5m)
| extend KO=toreal(Unauthorized) / Total
| where KO > threshold
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
