resource "azurerm_monitor_scheduled_query_rules_alert" "nodo_all_api_availability" {
  # One alert for each single API operation (see local.single_operation_data)
  for_each = local.single_operation_data

  name                = "pagopa-${var.env_short}-nodo-${each.value.group}-${each.value.primitiva}-api-availability"
  resource_group_name = "dashboards"
  location            = var.location
  data_source_id      = data.azurerm_api_management.apim.id
  description         = "Alert when PagoPA Nodo ${upper(each.value.group)} ${each.value.primitiva} API operation falls below expected availability."
  enabled             = true
  severity            = 1
  frequency           = 5

  # Keep the original 7-minute window for all Nodo API availability alerts.
  # Use a 14-minute window only for operations of nodo_for_pa_auth so the query can evaluate
  # two consecutive 7-minute bins before firing the alert.
  time_window = each.value.require_two_consecutive_bins ? 14 : 7

  action {
    action_group           = local.action_groups
    email_subject          = "Nodo PagoPA ${upper(each.value.group)} ${each.value.primitiva} API Availability Alert"
    custom_webhook_payload = "{}"
  }

  query = <<-EOT
    let thresholdTrafficMin = 20;
    let thresholdTrafficLinear = 90;
    let lowTrafficAvailability = 80;
    let highTrafficAvailability = 98;
    let thresholdDelta = thresholdTrafficLinear - thresholdTrafficMin;
    let availabilityDelta = highTrafficAvailability - lowTrafficAvailability;
    // Enable the two-consecutive-bin rule only for nodo_for_pa_auth operations.
    // Other API availability alerts keep the existing single-bin behavior.
    let requireTwoConsecutiveBins = ${each.value.require_two_consecutive_bins};
    AzureDiagnostics
    // Match the query lookback window with the Terraform alert evaluation window.
    // nodo_for_pa_auth needs 14 minutes to inspect two 7-minute bins.
    | where TimeGenerated > ago(${each.value.require_two_consecutive_bins ? "14m" : "7m"})
    | where url_s matches regex "${each.value.sub_service}"
    | where operationId_s == "${each.value.operation_id}"
    | summarize
        Total = count(),
        Success = countif(todouble(responseCode_d) < 500)
        by TimeBin = bin(TimeGenerated, 7m)
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
    // Order and serialize rows so prev() can compare each bin with the previous one.
    // Since the query is scoped to a single operation, no per-operation partitioning is needed.
    | order by TimeBin asc
    | serialize
    | extend previousBelowThreshold = prev(belowThreshold, 1, false)
    // For nodo_for_pa_auth, fire only when both the current and previous bins are degraded.
    // For all other alerts, preserve the previous behavior and fire on a single degraded bin.
    | where belowThreshold == true
    | where requireTwoConsecutiveBins == false or previousBelowThreshold == true
    | project
        TimeGenerated = TimeBin,
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
// Alert to monitor availability based on fault code, it does not filter by target, so monitors all node types.
resource "azurerm_monitor_scheduled_query_rules_alert" "nodo_all_psp_api_fault_code_availability_alert" {
  # One alert for each single API operation of the groups in local.fault_code_alert_groups (prod only)
  for_each = {
    for key, op in local.single_operation_data : key => op
    if contains(local.fault_code_alert_groups, op.group)
  }

  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-nodo-${each.value.group}-${each.value.primitiva}-api-fault-code-availability"
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
