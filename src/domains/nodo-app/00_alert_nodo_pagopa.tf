resource "azurerm_monitor_scheduled_query_rules_alert" "nodo_pagopa_api_availability" {
  # One alert for each single API operation of the groups in local.nodo_pagopa_alert_groups (prod only)
  for_each = {
    for key, op in local.single_operation_data : key => op
    if contains(local.nodo_pagopa_alert_groups, op.group)
  }

  name                = "pagopa-${var.env_short}-nodo-pagopa-${each.value.group}-${each.value.primitiva}-api-availability"
  resource_group_name = "dashboards"
  location            = var.location
  data_source_id      = data.azurerm_api_management.apim.id
  description         = "Alert when PagoPA Nodo ${upper(each.value.group)} (NM3-NMU) ${each.value.primitiva} API operation falls below expected availability."
  enabled             = true
  severity            = 1
  frequency           = 5
  # the time window was updated from 5 to 7 because the delay between the call and log
  # sometimes can be 2 minutes, this can affect the alert query
  time_window = 7

  action {
    action_group           = local.action_groups
    email_subject          = "Nodo PagoPA ${upper(each.value.group)} ${each.value.primitiva} API Availability Alert"
    custom_webhook_payload = "{}"
  }

  query = <<-EOT
    let thresholdTrafficMin = 100;
    let thresholdTrafficLinear = 200;
    let lowTrafficAvailability = 92;
    let highTrafficAvailability = 99;
    let thresholdDelta = thresholdTrafficLinear - thresholdTrafficMin;
    let availabilityDelta = highTrafficAvailability - lowTrafficAvailability;
    AzureDiagnostics
    | where TimeGenerated > ago(7m)
    | where backendUrl_s == "${local.pagopa_nodo_ingress}${local.nodo_soap_path}/"
    | where url_s matches regex "${each.value.sub_service}"
    | where operationId_s == "${each.value.operation_id}"
    | summarize
        Total = count(),
        Success = countif(todouble(responseCode_d) < 500)
        by bin(TimeGenerated, 7m)
    | extend trafficUp = Total-thresholdTrafficMin
    | extend deltaRatio = todouble(todouble(trafficUp)/todouble(thresholdDelta))
    | extend expectedAvailability = iff(Total >= thresholdTrafficLinear, toreal(highTrafficAvailability), iff(Total <= thresholdTrafficMin, toreal(lowTrafficAvailability), (deltaRatio*(availabilityDelta))+lowTrafficAvailability))
    | extend availability=((Success * 1.0) / Total) * 100
    | where availability < expectedAvailability
    | project
        TimeGenerated,
        apiName = "${each.value.primitiva}",
        operationId_s = "${each.value.operation_id}",
        availability,
        Total,
        Success
  EOT

  trigger {
    operator  = "GreaterThan"
    threshold = 0
  }
}

// Alert to monitor fault code based availability
resource "azurerm_monitor_scheduled_query_rules_alert" "nodo_pagopa_psp_api_fault_code_availability_alert" {
  # One alert for each single API operation of the groups in local.nodo_pagopa_alert_groups (prod only)
  for_each = {
    for key, op in local.single_operation_data : key => op
    if contains(local.nodo_pagopa_alert_groups, op.group)
  }

  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-nodo-pagopa-${each.value.group}-${each.value.primitiva}-api-fault-code-availability"
  location            = var.location

  action {
    action_group           = local.action_groups
    email_subject          = "Nodo PagoPA ${upper(each.value.group)} ${each.value.primitiva} API Fault Code Availability Alert"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Alert when PagoPA Nodo ${upper(each.value.group)} ${each.value.primitiva} API operation falls, based on fault code, below expected availability."
  enabled        = true

  severity  = 1
  frequency = 5
  # the time window was updated from 5 to 7 because the delay between the call and log
  # sometimes can be 2 minutes, this can affect the alert query
  time_window = 7
  query       = <<-EOT
    let thresholdTrafficMin = 100;
    let thresholdTrafficLinear = 200;
    let lowTrafficAvailability = 95;
    let highTrafficAvailability = 97;
    let thresholdDelta = thresholdTrafficLinear - thresholdTrafficMin;
    let availabilityDelta = highTrafficAvailability - lowTrafficAvailability;
    dependencies
    | where timestamp > ago(7m)
    | where name == "POST ${local.nodo_soap_path}/"
    | where target == "${local.pagopa_nodo_ingress}"
    | extend operationId_s = tostring(split(operation_Name, " - ")[1])
    | where operationId_s == "${each.value.operation_id}"
    | extend response = tostring(customDimensions["Response-Body"])
    | extend outcome = extract("<outcome>(.*?)</outcome>", 1, response)
    | extend faultCode = extract("<faultCode>(.*?)</faultCode>", 1, response)
    | summarize
        Total=count(),
        Success=countif(outcome == "OK" or faultCode !in ${local.error_fault_code})
        by bin(timestamp, 7m)
    | extend trafficUp = Total-thresholdTrafficMin
    | extend deltaRatio = todouble(todouble(trafficUp)/todouble(thresholdDelta))
    | extend expectedAvailability = iff(Total >= thresholdTrafficLinear, toreal(highTrafficAvailability), iff(Total <= thresholdTrafficMin, toreal(lowTrafficAvailability), (deltaRatio*(availabilityDelta))+lowTrafficAvailability))
    | extend availability=((Success * 1.0) / Total) * 100
    | where availability < expectedAvailability
    | project
        timestamp,
        apiName = "${each.value.primitiva}",
        operationId_s = "${each.value.operation_id}",
        availability,
        Total,
        Success
  EOT
  trigger {
    operator  = "GreaterThan"
    threshold = 0
  }
}

// Alert to monitor invocation of unexpected API on PagoPA Nodo
resource "azurerm_monitor_scheduled_query_rules_alert" "nodo_pagopa_unhandled_api_invocation_alert" {
  count = var.env_short == "p" ? 1 : 0

  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-nodo-pagopa-unhandled-api-invocation"
  location            = var.location

  action {
    action_group           = local.action_groups
    email_subject          = "API invocations that should not be handled by Nodo PagoPA Alert"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Alert when an API not handled by Nodo PagoPA is invoked on it."
  enabled        = true

  severity  = 1
  frequency = 5
  # the time window was updated from 5 to 7 because the delay between the call and log
  # sometimes can be 2 minutes, this can affect the alert query
  time_window = 7
  query       = <<-EOT
    // Map operationId -> API name for the operations exposed on node-for-psp (AUTH, group node_for_psp_v1)
    let opNames = datatable(operationId_s: string, apiName: string)
    [
        ${local.formatted_operation_data["node_for_psp_v1"].formatted_operations}
    ];
    // Operations that are expected to be handled by Nodo PagoPA
    let handledOperationIds = dynamic([${join(", ", [for id in local.nodo_pagopa_handled_operation_ids : "\"${id}\""])}]);
    AzureDiagnostics
    | where TimeGenerated > ago(7m)
    | where url_s matches regex "/nodo-auth/node-for-psp/v1"
    | where backendUrl_s has "${local.pagopa_nodo_ingress}/nodo"
    | where operationId_s !in (handledOperationIds)
    | join kind=leftouter (opNames) on operationId_s
    // Fallback to the operationId when the operation is not mapped
    | extend apiName = iff(isempty(apiName), operationId_s, apiName)
    | summarize Count = count() by bin(TimeGenerated, 7m), apiName, operationId_s
  EOT
  trigger {
    operator  = "GreaterThan"
    threshold = 0
  }
}
