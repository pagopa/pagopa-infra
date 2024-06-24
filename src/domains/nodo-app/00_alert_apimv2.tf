data "azurerm_api_management" "apim_v2" {
  name                = local.pagopa_apim_v2_name
  resource_group_name = local.pagopa_apim_v2_rg
}

// PROD AzureDiagnostics url_s operationId_s
// UAT ApiManagementGatewayLogs Url OperationId
resource "azurerm_monitor_scheduled_query_rules_alert" "alert-nodo-responsetime-v2" {
  for_each            = { for c in local.api_nodo_alerts : c.operationId_s => c }
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-nodoapi-${each.value.primitiva}-responsetime-v2"
  location            = var.location

  action {
    action_group           = local.action_groups_default
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  # data_source_id = data.azurerm_application_insights.application_insights.id
  data_source_id = data.azurerm_api_management.apim_v2.id
  description    = "Response time ${each.value.primitiva} ${each.value.sub_service} nodoapi-responsetime https://portal.azure.com/#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/cbc97060-c05b-48b5-9962-2b229eaa53de and https://portal.azure.com/#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/2b9b319b-5e7d-4efe-aaba-613daef8e9fc"
  enabled        = true
  query = format(<<-QUERY
let threshold = %d;
AzureDiagnostics
| where url_s matches regex "/nodo/${each.value.sub_service}/"
| where operationId_s matches regex "${each.value.operationId_s}"
| summarize
    watermark=threshold,
    duration_percentile_95=percentiles(DurationMs, 95)
    by bin(TimeGenerated, 5m)
| where duration_percentile_95 > threshold
QUERY
  , lookup(each.value, "response_time", "") != "" ? each.value.response_time : 8000)

  # https://learn.microsoft.com/en-us/azure/azure-monitor/best-practices-alerts#alert-severity
  # Sev 2	Warning	A problem that doesn't include any current loss in availability or performance, although it has the potential to lead to more severe problems if unaddressed.
  severity    = 2
  frequency   = 5
  time_window = 10
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 2
  }
}


resource "azurerm_monitor_scheduled_query_rules_alert" "alert-nodo-availability-v2" {
  for_each            = { for c in local.api_nodo_alerts : c.operationId_s => c }
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-nodoapi-${each.value.primitiva}-availability-v2"
  location            = var.location

  action {
    action_group           = local.action_groups
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  # data_source_id = data.azurerm_application_insights.application_insights.id
  data_source_id = data.azurerm_api_management.apim_v2.id
  description    = "Availability ${each.value.primitiva} ${each.value.sub_service} nodoapi-availability https://portal.azure.com/#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/cbc97060-c05b-48b5-9962-2b229eaa53de and https://portal.azure.com/#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/2b9b319b-5e7d-4efe-aaba-613daef8e9fc"
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
AzureDiagnostics
| where url_s matches regex "/nodo/${each.value.sub_service}/"
| where operationId_s matches regex "${each.value.operationId_s}"
| summarize
    Total=count(),
    Success=count(responseCode_d < 500)
    by bin(TimeGenerated, 5m)
| extend availability=toreal(Success) / Total
| where availability < threshold
  QUERY
  )

  # https://learn.microsoft.com/en-us/azure/azure-monitor/best-practices-alerts#alert-severity
  # Sev 1	Error	Degradation of performance or loss of availability of some aspect of an application or service. Requires attention but not immediate
  severity    = 1
  frequency   = 5
  time_window = 10
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 2
  }

}

// PROD AzureDiagnostics url_s operationId_s
// UAT ApiManagementGatewayLogs Url OperationId
resource "azurerm_monitor_scheduled_query_rules_alert" "alert-nodo-auth-responsetime-v2" {
  for_each            = { for c in local.api_nodo_auth_alerts : c.operationId_s => c }
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-nodo-auth-api-${each.value.primitiva}-${each.value.operationId_s}-responsetime-v2"
  location            = var.location

  action {
    action_group           = local.action_groups_default
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  # data_source_id = data.azurerm_application_insights.application_insights.id
  data_source_id = data.azurerm_api_management.apim_v2.id
  description    = "Response time ${each.value.primitiva} ${each.value.sub_service} nodo-auth-api-responsetime https://portal.azure.com/#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/cbc97060-c05b-48b5-9962-2b229eaa53de and https://portal.azure.com/#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/2b9b319b-5e7d-4efe-aaba-613daef8e9fc"
  enabled        = true
  query = format(<<-QUERY
let threshold = %d;
AzureDiagnostics
| where url_s matches regex "/nodo-auth/${each.value.sub_service}/"
| where operationId_s matches regex "${each.value.operationId_s}"
| summarize
    watermark=threshold,
    duration_percentile_95=percentiles(DurationMs, 95)
    by bin(TimeGenerated, 5m)
| where duration_percentile_95 > threshold
QUERY
  , lookup(each.value, "response_time", "") != "" ? each.value.response_time : 8000)

  # https://learn.microsoft.com/en-us/azure/azure-monitor/best-practices-alerts#alert-severity
  # Sev 2	Warning	A problem that doesn't include any current loss in availability or performance, although it has the potential to lead to more severe problems if unaddressed.
  severity    = 2
  frequency   = 5
  time_window = 10
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 2
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "alert-nodo-auth-availability-v2" {
  for_each            = { for c in local.api_nodo_auth_alerts : c.operationId_s => c }
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-nodo-auth-api-${each.value.primitiva}-${each.value.operationId_s}-availability-v2"
  location            = var.location

  action {
    action_group           = local.action_groups
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  # data_source_id = data.azurerm_application_insights.application_insights.id
  data_source_id = data.azurerm_api_management.apim_v2.id
  description    = "Availability ${each.value.primitiva} ${each.value.sub_service} nodo-auth-api-availability https://portal.azure.com/#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/cbc97060-c05b-48b5-9962-2b229eaa53de and https://portal.azure.com/#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/2b9b319b-5e7d-4efe-aaba-613daef8e9fc"
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
AzureDiagnostics
| where url_s matches regex "/nodo-auth/${each.value.sub_service}/"
| where operationId_s matches regex "${each.value.operationId_s}"
| summarize
    Total=count(),
    Success=count(responseCode_d < 500)
    by bin(TimeGenerated, 5m)
| extend availability=toreal(Success) / Total
| where availability < threshold
  QUERY
  )

  # https://learn.microsoft.com/en-us/azure/azure-monitor/best-practices-alerts#alert-severity
  # Sev 1	Error	Degradation of performance or loss of availability of some aspect of an application or service. Requires attention but not immediate
  severity    = 1
  frequency   = 5
  time_window = 10
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 2
  }
}
