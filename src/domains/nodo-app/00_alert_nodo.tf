resource "azurerm_monitor_scheduled_query_rules_alert" "nodo_all_api_availability" {
  # One alert for each single API operation (see local.single_operation_data)
  for_each = local.single_operation_data

  name                = "pagopa-${var.env_short}-nodo-${each.value.group}-${each.value.primitiva}-api-availability"
  resource_group_name = "dashboards"
  location            = var.location
  data_source_id      = data.azurerm_api_management.apim.id
  description         = "Alert when Nodo ${upper(each.value.group)} ${each.value.primitiva} API operation falls below expected availability."
  enabled             = true
  severity            = 1
  # timing per environment, see local.alert_config
  # (prod: 7m window because the delay between the call and log sometimes can be 2 minutes)
  frequency   = local.alert_timing.frequency
  time_window = local.alert_timing.time_window
  throttling  = local.alert_timing.throttling

  action {
    action_group           = local.nodo_alert_action_groups
    email_subject          = "[${var.env}] Nodo ${upper(each.value.group)} ${each.value.primitiva} API Availability Alert"
    custom_webhook_payload = "{}"
  }

  query = <<-EOT
    let minCalls = ${local.alert_thresholds.apim_availability.min_calls};
    let thresholdTrafficMin = ${local.alert_thresholds.apim_availability.traffic_min};
    let thresholdTrafficLinear = ${local.alert_thresholds.apim_availability.traffic_linear};
    let lowTrafficAvailability = ${local.alert_thresholds.apim_availability.low_availability};
    let highTrafficAvailability = ${local.alert_thresholds.apim_availability.high_availability};
    let thresholdDelta = thresholdTrafficLinear - thresholdTrafficMin;
    let availabilityDelta = highTrafficAvailability - lowTrafficAvailability;
    AzureDiagnostics
    | where TimeGenerated > ago(${local.alert_timing.time_window}m)
    | where url_s matches regex "${each.value.sub_service}"
    | where operationId_s == "${each.value.operation_id}"
    | summarize
        Total = count(),
        Success = countif(todouble(responseCode_d) < 500)
        by TimeGenerated = ${local.alert_bin_kql["TimeGenerated"]}
    | where Total >= minCalls
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
// Alert to monitor availability based on fault code, it does not filter by target, so monitors all node types.
resource "azurerm_monitor_scheduled_query_rules_alert" "nodo_all_psp_api_fault_code_availability_alert" {
  # One alert for each single API operation of the groups in local.fault_code_alert_groups
  for_each = {
    for key, op in local.single_operation_data : key => op
    if contains(local.fault_code_alert_groups, op.group)
  }

  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-nodo-${each.value.group}-${each.value.primitiva}-api-fault-code-availability"
  location            = var.location

  action {
    action_group           = local.nodo_alert_action_groups
    email_subject          = "[${var.env}] Nodo ${upper(each.value.group)} ${each.value.primitiva} API Fault Code Availability Alert"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Alert when Nodo ${upper(each.value.group)} ${each.value.primitiva} API operation falls, based on fault code, below expected availability."
  enabled        = true

  severity = 1
  # timing per environment, see local.alert_config
  # (prod: 7m window because the delay between the call and log sometimes can be 2 minutes)
  frequency   = local.alert_timing.frequency
  time_window = local.alert_timing.time_window
  throttling  = local.alert_timing.throttling
  query       = <<-EOT
    let minCalls = ${local.alert_thresholds.fault_code_availability.min_calls};
    let thresholdTrafficMin = ${local.alert_thresholds.fault_code_availability.traffic_min};
    let thresholdTrafficLinear = ${local.alert_thresholds.fault_code_availability.traffic_linear};
    let lowTrafficAvailability = ${local.alert_thresholds.fault_code_availability.low_availability};
    let highTrafficAvailability = ${local.alert_thresholds.fault_code_availability.high_availability};
    let thresholdDelta = thresholdTrafficLinear - thresholdTrafficMin;
    let availabilityDelta = highTrafficAvailability - lowTrafficAvailability;
    dependencies
    | where timestamp > ago(${local.alert_timing.time_window}m)
    | where name == "POST ${local.nodo_soap_path_short}/"
    | extend operationId_s = tostring(split(operation_Name, " - ")[1])
    | where operationId_s == "${each.value.operation_id}"
    | extend response = tostring(customDimensions["Response-Body"])
    | extend outcome = extract("<outcome>(.*?)</outcome>", 1, response)
    | extend faultCode = extract("<faultCode>(.*?)</faultCode>", 1, response)
    | summarize
        Total=count(),
        Success=countif(outcome == "OK" or faultCode !in ${local.error_fault_code})
        by timestamp = ${local.alert_bin_kql["timestamp"]}
    | where Total >= minCalls
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
