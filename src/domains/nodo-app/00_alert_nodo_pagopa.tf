resource "azurerm_monitor_scheduled_query_rules_alert" "nodo_pagopa_api_availability" {
  name                = "pagopa-${var.env_short}-nodo-pagopa-node_for_psp_auth-api-availability"
  resource_group_name = "dashboards"
  location            = var.location
  data_source_id      = data.azurerm_api_management.apim.id
  description         = "Alert when any PagoPA Nodo NODE_FOR_PSP_AUTH (NM3-NMU) API operation falls below 99% availability."
  enabled             = true
  severity            = 1
  frequency           = 5
  time_window         = 5

  action {
    action_group           = local.action_groups
    email_subject          = "Nodo PagoPA NODE_FOR_PSP_AUTH API Availability Alert"
    custom_webhook_payload = "{}"
  }

  query = <<-EOT
    let operationMap = datatable(operationId_s: string, apiName: string)
    [
        ${local.formatted_operation_data["node_for_psp_auth"].formatted_operations}
    ];
    let operationIds = toscalar(operationMap | summarize make_list(operationId_s, 20));
    let thresholdTrafficMin = 150;
    let thresholdTrafficLinear = 400;
    let lowTrafficAvailability = 96;
    let highTrafficAvailability = 99;
    let thresholdDelta = thresholdTrafficLinear - thresholdTrafficMin;
    let availabilityDelta = highTrafficAvailability - lowTrafficAvailability;
    AzureDiagnostics
    | where TimeGenerated > ago(5m)
    | where backendUrl_s == "${local.pagopa_nodo_ingress}${local.nodo_soap_path}"
    | where url_s matches regex "${local.formatted_operation_data["node_for_psp_auth"].sub_service}"
    | where operationId_s in (operationIds)
    | summarize
        Total = count(),
        Success = countif(todouble(responseCode_d) < 500)
        by bin(TimeGenerated, 5m), operationId_s
    | extend trafficUp = Total-thresholdTrafficMin
    | extend deltaRatio = todouble(todouble(trafficUp)/todouble(thresholdDelta))
    | extend expectedAvailability = iff(Total >= thresholdTrafficLinear, toreal(highTrafficAvailability), iff(Total <= thresholdTrafficMin, toreal(lowTrafficAvailability), (deltaRatio*(availabilityDelta))+lowTrafficAvailability))
    | extend availability=((Success * 1.0) / Total) * 100
    | where availability < expectedAvailability
    | join kind=inner (operationMap) on operationId_s
    | project TimeGenerated, apiName, operationId_s, availability, Total, Success
  EOT

  trigger {
    operator  = "GreaterThan"
    threshold = 0
  }
}

// Alert to monitor fault code based availability
resource "azurerm_monitor_scheduled_query_rules_alert" "nodo_pagopa_psp_api_fault_code_availability_alert" {
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-nodo-pagoapa-psp-api-fault-code-availability"
  location            = var.location

  action {
    action_group           = local.action_groups
    email_subject          = "Nodo PagoPA PSP API Fault Code Availability Alert"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Alert when any PagoPA Nodo PSP operation API falls, based on fault code, below 99% availability."
  enabled        = true

  severity    = 1
  frequency   = 5
  time_window = 5
  query       = <<-EOT
    let operationMap = datatable(operationId_s: string, apiName: string)
    [
        ${local.formatted_operation_data["node_for_psp_auth"].formatted_operations}
    ];
    let operationIds = toscalar(operationMap | summarize make_list(operationId_s, 20));
    let thresholdTrafficMin = 150;
    let thresholdTrafficLinear = 400;
    let lowTrafficAvailability = 96;
    let highTrafficAvailability = 99;
    let thresholdDelta = thresholdTrafficLinear - thresholdTrafficMin;
    let availabilityDelta = highTrafficAvailability - lowTrafficAvailability;
    dependencies
    | where timestamp > ago(5m)
    | where name == "POST ${local.nodo_soap_path}/"
    | where target == "${local.pagopa_nodo_ingress}"
    | extend operationId_s = tostring(split(operation_Name, " - ")[1])
    | where operationId_s in (operationIds)
    | extend response = tostring(customDimensions["Response-Body"])
    | extend outcome = extract("<outcome>(.*?)</outcome>", 1, response)
    | extend faultCode = extract("<faultCode>(.*?)</faultCode>", 1, response)
    | summarize
        Total=count(),
        Success=countif(outcome == "OK" or faultCode !in ${local.error_fault_code})
        by bin(timestamp, 5m), operationId_s
    | extend trafficUp = Total-thresholdTrafficMin
    | extend deltaRatio = todouble(todouble(trafficUp)/todouble(thresholdDelta))
    | extend expectedAvailability = iff(Total >= thresholdTrafficLinear, toreal(highTrafficAvailability), iff(Total <= thresholdTrafficMin, toreal(lowTrafficAvailability), (deltaRatio*(availabilityDelta))+lowTrafficAvailability))
    | extend availability=((Success * 1.0) / Total) * 100
    | where availability < expectedAvailability
    | join kind=inner (operationMap) on operationId_s
    | project timestamp, apiName, operationId_s, availability, Total, Success
  EOT
  trigger {
    operator  = "GreaterThan"
    threshold = 0
  }
}
