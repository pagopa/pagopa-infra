resource "azurerm_monitor_scheduled_query_rules_alert" "nodo_all_api_availability" {
  for_each = local.formatted_operation_data

  name                = "pagopa-${var.env_short}-nodo-${each.key}-api-availability"
  resource_group_name = "dashboards"
  location            = var.location
  data_source_id      = data.azurerm_api_management.apim.id
  description         = "Alert when any PagoPA Nodo ${upper(each.key)} API operation falls below 99% availability."
  enabled             = true
  severity            = 1
  frequency           = 5

  # Keep the original 7-minute window for all Nodo API availability alerts.
  # Use a 14-minute window only for nodo_for_pa_auth so the query can evaluate
  # two consecutive 7-minute bins before firing the alert.
  time_window = each.key == "nodo_for_pa_auth" ? 14 : 7

  action {
    action_group           = local.action_groups
    email_subject          = "Nodo PagoPA ${upper(each.key)} API Availability Alert"
    custom_webhook_payload = "{}"
  }

  query = <<-EOT
    let operationMap = datatable(operationId_s: string, apiName: string)
    [
        ${each.value.formatted_operations}
    ];
    let operationIds = toscalar(operationMap | summarize make_list(operationId_s, 20));
    let thresholdTrafficMin = 20;
    let thresholdTrafficLinear = 90;
    let lowTrafficAvailability = 80;
    let highTrafficAvailability = 98;
    let thresholdDelta = thresholdTrafficLinear - thresholdTrafficMin;
    let availabilityDelta = highTrafficAvailability - lowTrafficAvailability;
    // Enable the two-consecutive-bin rule only for nodo_for_pa_auth.
    // Other API availability alerts keep the existing single-bin behavior.
    let requireTwoConsecutiveBins = "${each.key}" == "nodo_for_pa_auth";
    AzureDiagnostics
    // Match the query lookback window with the Terraform alert evaluation window.
    // nodo_for_pa_auth needs 14 minutes to inspect two 7-minute bins.
    | where TimeGenerated > ago(${each.key == "nodo_for_pa_auth" ? "14m" : "7m"})
    | where url_s matches regex "${each.value.sub_service}"
    | where operationId_s in (operationIds)
    | summarize
        Total = count(),
        Success = countif(todouble(responseCode_d) < 500)
        by TimeBin = bin(TimeGenerated, 7m), operationId_s
    | where Total > 5
    | extend trafficUp = Total - thresholdTrafficMin
    | extend deltaRatio = todouble(todouble(trafficUp) / todouble(thresholdDelta))
    | extend expectedAvailability = iff(
        Total >= thresholdTrafficLinear,
        toreal(highTrafficAvailability),
        iff(
          Total <= thresholdTrafficMin,
          toreal(lowTrafficAvailability),
          (deltaRatio * availabilityDelta) + lowTrafficAvailability
        )
      )
    | extend availability = ((Success * 1.0) / Total) * 100
    // Mark each 7-minute bin as degraded without filtering it immediately.
    // This is required to compare the current bin with the previous one.
    | extend belowThreshold = availability < expectedAvailability
    // Order and serialize rows so prev() can safely compare each bin
    // with the previous bin of the same operation.
    // For nodo_for_pa_auth, this allows firing only after two consecutive degraded bins.
    | order by operationId_s asc, TimeBin asc
    | serialize
    // Read the previous bin status only when it belongs to the same operation.
    // This prevents comparing degraded bins from different API operations.
    | extend previousBelowThreshold = iff(
        operationId_s == prev(operationId_s, 1, ""),
        prev(belowThreshold, 1, false),
        false
      )
    // For nodo_for_pa_auth, fire only when both the current and previous bins are degraded.
    // For all other alerts, preserve the previous behavior and fire on a single degraded bin.
    | where belowThreshold == true
    | where requireTwoConsecutiveBins == false or previousBelowThreshold == true
    | join kind=inner (operationMap) on operationId_s
    | project TimeGenerated = TimeBin, apiName, operationId_s, availability, Total, Success
  EOT

  trigger {
    operator  = "GreaterThan"
    threshold = 0
  }
}
// Alert to monitor availability based on fault code, it does not filter by target, so monitors all node types.
resource "azurerm_monitor_scheduled_query_rules_alert" "nodo_all_psp_api_fault_code_availability_alert" {
  count = var.env_short == "p" ? 1 : 0

  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-nodo-psp-api-fault-code-availability"
  location            = var.location

  action {
    action_group           = local.action_groups
    email_subject          = "Nodo PagoPA PSP API Fault Code Availability Alert"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Alert when any PagoPA Nodo PSP operation API falls, based on fault code, below 99% availability."
  enabled        = true

  severity  = 1
  frequency = 5
  # the time window was updated from 5 to 7 because the delay between the call and log
  # sometimes can be 2 minutes, this can affect the alert query
  time_window = 7
  query       = <<-EOT
    let operationMap = datatable(operationId_s: string, apiName: string)
    [
        ${local.formatted_operation_data["node_for_psp_auth"].formatted_operations}
    ];
    let operationIds = toscalar(operationMap | summarize make_list(operationId_s, 20));
    let thresholdTrafficMin = 150;
    let thresholdTrafficLinear = 400;
    let lowTrafficAvailability = 95;
    let highTrafficAvailability = 97;
    let thresholdDelta = thresholdTrafficLinear - thresholdTrafficMin;
    let availabilityDelta = highTrafficAvailability - lowTrafficAvailability;
    dependencies
    | where timestamp > ago(7m)
    | where name == "POST ${local.nodo_soap_path_short}/"
    | extend operationId_s = tostring(split(operation_Name, " - ")[1])
    | where operationId_s in (operationIds)
    | extend response = tostring(customDimensions["Response-Body"])
    | extend outcome = extract("<outcome>(.*?)</outcome>", 1, response)
    | extend faultCode = extract("<faultCode>(.*?)</faultCode>", 1, response)
    | summarize
        Total=count(),
        Success=countif(outcome == "OK" or faultCode !in ${local.error_fault_code})
        by bin(timestamp, 7m), operationId_s
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
