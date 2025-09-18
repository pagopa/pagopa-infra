## Availability alert: GPD-Reporting-Analysis ##
resource "azurerm_monitor_scheduled_query_rules_alert" "pagopa-gpd-reporting-analysis-rest-availability-getFlow" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-gpd-reporting-analysis-rest-availability @ _gpd"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id, data.azurerm_monitor_action_group.smo_opsgenie[0].id]
    email_subject          = "Email GPD-Reporting-Analysis-rest Availability"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Availability for /gpd-reporting/api/v1/organizations/ is less than or equal to threshold - https://portal.azure.com/#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/pagopa-p-opex_pagopa-gpd-reporting-analysis"
  enabled        = true
  query = (<<-QUERY
let lowTrafficThreshold = 70; // the lower threshold that can be calculated regarding the number of invocations
let highTrafficThreshold = 95; // the upper threshold that can be calculated regarding the number of invocations
let trafficMin = 100; // the minimum number of invocations (traffic) below which 'lowTrafficThreshold' guideline is used
let trafficLinear = 500;  // the minimum number of invocations (traffic) above which 'highTrafficThreshold' guideline is used
let thresholdDelta = trafficLinear - trafficMin; // the difference of the traffic guideline on which the expected availability is calculated
let availabilityDelta = highTrafficThreshold - lowTrafficThreshold; // the difference of the threshold limits on which the expected availability is calculated
// -----------------------------------------
AzureDiagnostics
| where url_s matches regex "/gpd-reporting/api/v1/organizations/" 
| summarize
  Total=count(),
  Success=count(responseCode_d < 500)
  by timeslot = bin(TimeGenerated, 5m)
| extend availability=toreal(Success) / Total
| extend trafficUp = Total - trafficMin
| extend deltaRatio = todouble(todouble(trafficUp) / todouble(thresholdDelta))
| extend expectedAvailability = iff(Total >= trafficLinear, toreal(highTrafficThreshold), iff(Total <= trafficMin, toreal(lowTrafficThreshold), (deltaRatio * (availabilityDelta)) + lowTrafficThreshold))
| extend availability = ((Success * 1.0) / Total) * 100
| project timeslot, availability, threshold=expectedAvailability
| where availability < threshold
  QUERY
  )
  severity    = 1
  frequency   = 5
  time_window = 10
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 2
  }
}
