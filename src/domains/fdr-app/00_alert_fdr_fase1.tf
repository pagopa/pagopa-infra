// PROD AzureDiagnostics url_s operationId_s
// UAT ApiManagementGatewayLogs Url OperationId
resource "azurerm_monitor_scheduled_query_rules_alert" "alert-fdr-nodo-error" {
  for_each            = { for c in local.api_fdr_nodo_alerts : c.operationId_s => c }
  name                = "fdr-nodo-${each.value.primitiva}-app-exception"
  resource_group_name = data.azurerm_resource_group.fdr_rg.name
  location            = var.location

  action {
    action_group           = local.action_groups
    email_subject          = "FdR Nodo Error - ${each.value.primitiva}"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Problem calling - ${each.value.primitiva} Error"
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
  severity    = 3
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "pagopa-fdr-nodo-rest-availability" {
  count = var.env_short == "p" ? 1 : 0

  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-pagopa-fdr-nodo-rest-availability"
  location            = var.location

  action {
    action_group           = concat(local.action_groups_default, [data.azurerm_monitor_action_group.opsgenie[0].id])
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Availability of pagopa-fdr-nodo REST APIs is less than or equal to 99%"
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
AzureDiagnostics
| where url_s matches regex "/fdr-legacy/"
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
    action_group           = local.action_groups
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
  severity    = 1
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}