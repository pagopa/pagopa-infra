// PROD AzureDiagnostics url_s operationId_s
// UAT ApiManagementGatewayLogs Url OperationId
resource "azurerm_monitor_scheduled_query_rules_alert" "alert-fdr-nodo-auth-error" {
  for_each            = { for c in local.api_fdr_nodo_auth_alerts : c.operationId_s => c }
  name                = "fdr-nodo-auth-${each.value.primitiva}-app-exception"
  resource_group_name = data.azurerm_resource_group.fdr_rg.name
  location            = var.location

  action {
    action_group           = var.env_short == "p" ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "FdR Nodo Auth Error - ${each.value.primitiva}"
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

// PROD AzureDiagnostics url_s operationId_s
// UAT ApiManagementGatewayLogs Url OperationId
resource "azurerm_monitor_scheduled_query_rules_alert" "alert-fdr-nodo-error" {
  for_each            = { for c in local.api_fdr_nodo_alerts : c.operationId_s => c }
  name                = "fdr-nodo-${each.value.primitiva}-app-exception"
  resource_group_name = data.azurerm_resource_group.fdr_rg.name
  location            = var.location

  action {
    action_group           = var.env_short == "p" ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
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


