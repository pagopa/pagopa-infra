locals {
  // The pairs operation_id, primitive_name that we want monitor
  operation_psp_map_entries = [
    // nodo node-for-psp
    ["63b6e2daea7c4a25440fda9f", "verifyPaymentNotice"],
    ["63b6e2daea7c4a25440fdaa0", "activatePaymentNotice"],
    ["63b6e2daea7c4a25440fdaa5", "activatePaymentNoticeV2"],
    ["63b6e2daea7c4a25440fdaa1", "sendPaymentOutcome"],
    ["63b6e2daea7c4a25440fdaa6", "sendPaymentOutcomeV2"],
    ["61dedb1eea7c4a07cc7d47b8", "activateIOPaymentReq"], // node-for-io
    // demandPaymentNotice: it is not necessary to monitor it for the PagoPA node because routing is disabled
    // ["63b6e2daea7c4a25440fdaa3", "demandPaymentNotice"],

    // nodo auth node-for-psp
    ["63b6e2daea7c4a25440fda9f", "verifyPaymentNotice"],
    ["61dedafc2a92e81a0c7a58fc", "activatePaymentNotice"],
    ["63c559672a92e811a8f33a00", "activatePaymentNoticeV2"],
    ["61dedafc2a92e81a0c7a58fd", "sendPaymentOutcome"],
    ["63c559672a92e811a8f33a01", "sendPaymentOutcomeV2"],
    ["63b6e2da2a92e811a8f338ec", "activateIOPayment"], // node-for-io
    // demandPaymentNotice: it is not necessary to monitor it for the PagoPA node because routing is disabled
    // ["62bb23bdea7c4a0f183fc065", "demandPaymentNotice"],
  ]

  // Convert from list to tuple
  operation_psp_map_rows = join(", ", [for pair in local.operation_psp_map_entries : "\"${pair[0]}\", \"${pair[1]}\""])

  // The pairs operation_id, primitive_name. It's a temp variable, that we use to keep track of primitive name, a documentation purpose.
  operation_fault_code_monitoring = [
    // nodo node-for-psp
    ["63b6e2daea7c4a25440fdaa0", "activatePaymentNotice"],
    ["63b6e2daea7c4a25440fdaa5", "activatePaymentNoticeV2"],
    ["63b6e2daea7c4a25440fdaa1", "sendPaymentOutcome"],
    ["63b6e2daea7c4a25440fdaa6", "sendPaymentOutcomeV2"],

    // nodo auth node-for-psp
    ["61dedafc2a92e81a0c7a58fc", "activatePaymentNotice"],
    ["63c559672a92e811a8f33a00", "activatePaymentNoticeV2"],
    ["61dedafc2a92e81a0c7a58fd", "sendPaymentOutcome"],
    ["63c559672a92e811a8f33a01", "sendPaymentOutcomeV2"]
  ]

  // Convert from list to tuple: the operation ids in the form of ("op1",...) build starting from operation_fault_code_monitoring pairs.
  operation_ids_fault_code = join(", ", [for pair in local.operation_fault_code_monitoring : pair[0]])

  error_fault_code = "('${join("', '", ["PPT_AUTENTICAZIONE", "PPT_SYSTEM_ERROR", "PPT_ERRORE_IDEMPOTENZA"])}')"

  // Nodo SOAP path
  pagopa_nodo_path = "/webservices/input"
  // PagoPA Nodo ingress
  pagopa_nodo_ingress = "https://weuprod.nodo.internal.platform.pagopa.it/nodopagamenti"
}


// Alert to monitor HTTP availability
resource "azurerm_monitor_scheduled_query_rules_alert" "nodo_pagopa_psp_api_availability_alert" {
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-nodo-pagoapa-psp-api-availability"
  location            = var.location

  action {
    action_group       = local.action_groups
    email_subject      = "Nodo PagoPA PSP API Availability Alert"
    webhook_properties = {}
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Alert when any PagoPA Nodo PSP operation API falls below 99% availability."
  enabled        = true

  severity    = 1
  frequency   = 5
  time_window = 5
  query       = <<-EOT
    let threshold = 0.99;
    let operationMap = datatable(operationId_s: string, apiName: string)
    [
        ${local.operation_psp_map_rows}
    ];
    let operationIds = toscalar(operationMap | summarize make_list(operationId_s, 20));
    AzureDiagnostics
    | where TimeGenerated > ago(5m)
    | where backendUrl_s == "${local.pagopa_nodo_ingress}${local.pagopa_nodo_path}"
    | where url_s matches regex "nodo(-auth){0,1}/((node-for-psp))" or url_s matches regex "nodo(-auth){0,1}/((node-for-io))"
    | where operationId_s in (operationIds)
    | summarize
        Total = count(),
        Success = countif(todouble(responseCode_d) < 500)
        by bin(TimeGenerated, 5m), operationId_s
    | extend availability = toreal(Success) / Total
    | where availability < threshold
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
    action_group       = local.action_groups
    email_subject      = "Nodo PagoPA PSP API Fault Code Availability Alert"
    webhook_properties = {}
  }

  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Alert when any PagoPA Nodo PSP operation API falls, based on fault code, below 99% availability."
  enabled        = true

  severity    = 1
  frequency   = 5
  time_window = 5
  query       = <<-EOT
    let threshold = 0.99;
    dependencies
    | where timestamp > ago(5m)
    | where name == "POST ${local.pagopa_nodo_path}/"
    | where target == "${local.pagopa_nodo_ingress}"
    | extend operationId_s = tostring(split(operation_Name, " - ")[1])
    | where operationId_s in ${local.operation_ids_fault_code}
    | extend response = tostring(customDimensions["Response-Body"])
    | extend outcome = extract("<outcome>(.*?)</outcome>", 1, response)
    | extend faultCode = extract("<faultCode>(.*?)</faultCode>", 1, response)
    | summarize
    Total=count(),
    Success=countif(outcome == "OK" or faultCode !in ${local.error_fault_code})
    by bin(timestamp, 5m)
    | extend availability=toreal(Success) / Total
    | where availability < threshold
  EOT
  trigger {
    operator  = "GreaterThan"
    threshold = 0
  }
}
