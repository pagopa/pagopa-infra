# PROD AzureDiagnostics url_s operationId_s
# UAT ApiManagementGatewayLogs Url OperationId
# severity -> 0: critical, 1: error, 2: warning, 3: informational, 4: verbose
resource "azurerm_monitor_scheduled_query_rules_alert" "alert-fdr-nodo-error" {
  count = var.env_short == "p" ? 1 : 0

  name                = "fdr-nodo-PPT_SYSTEM_ERROR-app-exception"
  resource_group_name = data.azurerm_resource_group.fdr_rg.name
  location            = var.location

  action {
    action_group           = local.action_groups_opsgenie
    email_subject          = "FdR Nodo Error - PPT_SYSTEM_ERROR"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Problem calling - PPT_SYSTEM_ERROR Error"
  enabled        = true
  query = (<<-QUERY
      traces
        | where cloud_RoleName == "fdr-nodo"
        | where message contains "PPT_SYSTEM_ERROR"
        | order by timestamp desc
        | summarize Total=count() by length=bin(timestamp,1m)
        | order by length desc
    QUERY
  )
  severity    = 0
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 150 # gt
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "pagopa-fdr-nodo-rest-availability" {
  count = var.env_short == "p" ? 1 : 0

  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-pagopa-fdr-nodo-rest-availability"
  location            = var.location

  action {
    action_group           = local.action_groups_slack_pagopa_pagamenti_alert
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Availability of pagopa-fdr-nodo Internal REST APIs is less than or equal to 99%"
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
AzureDiagnostics
| where url_s matches regex "/fdr-nodo/"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "alert-fdr-nodo-register-for-validation-error" {
  name                = "fdr-nodo-register-for-validation-request-exception"
  resource_group_name = data.azurerm_resource_group.fdr_rg.name
  location            = var.location

  action {
    action_group           = local.action_groups_opsgenie
    email_subject          = "FdR Nodo Error - RegisterForValidation"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Problem calling - RegisterForValidation Error"
  enabled        = true
  query = (<<-QUERY
      traces
        | where cloud_RoleName == "fdr-nodo"
        | where message contains "[ALERT][FDR1][RegisterForValidation]"
        | order by timestamp desc
        | summarize Total=count() by length=bin(timestamp,1m)
        | order by length desc
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
