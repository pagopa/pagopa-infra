resource "azurerm_monitor_scheduled_query_rules_alert" "bizeventsdatastore-availability" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-bizeventsdatastore-availability"
  location            = var.location

  action {
    action_group = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id]
    # action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "pagopabizeventsdatastore Info"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Availability bizeventsdatastore Info https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/b16b9a96-bcbb-4856-9455-2a14a68370a1 "
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
union traces, exceptions
| where cloud_RoleName == "pagopabizeventsdatastore"
| where operation_Name == "Info"
//| summarize count() by operation_Name, itemType, tostring(customDimensions["LogLevel"])
| summarize
    Total=count(),
    Success=count(itemType == "trace")
    by bin(timestamp, 5m)
| extend availability=toreal(Success) / Total
//| render timechart 
| where availability < threshold
  QUERY
  )
  severity    = 1
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 2
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "bizeventsdatastore-availability-eventhubbizeventprocessor" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-bizeventsdatastore-availability-eventhubbizeventprocessor"
  location            = var.location

  action {
    action_group = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id]
    # action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "pagopabizeventsdatastore EventHubBizEventProcessor"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Availability bizeventsdatastore EventHubBizEventProcessor https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/b16b9a96-bcbb-4856-9455-2a14a68370a1 "
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
union traces, exceptions
| where cloud_RoleName == "pagopabizeventsdatastore"
| where operation_Name == "EventHubBizEventProcessor"
//| summarize count() by operation_Name, itemType
| summarize
    Total=count(),
    Success=count(itemType == "trace")
    by bin(timestamp, 10m)
| extend availability=toreal(Success) / Total
//| render timechart 
| where availability < threshold
  QUERY
  )
  severity    = 1
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 2
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "bizeventsdatastore-availability-bizeventenrichmentprocessor" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-bizeventsdatastore-availability-bizeventenrichmentprocessor"
  location            = var.location

  action {
    action_group = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id]
    # action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "bizeventsdatastore BizEventEnrichmentProcessor"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Availability bizeventsdatastore BizEventEnrichmentProcessor https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/b16b9a96-bcbb-4856-9455-2a14a68370a1 "
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
union traces, exceptions
| where cloud_RoleName == "pagopabizeventsdatastore"
| where operation_Name == "BizEventEnrichmentProcessor"
//| where itemType != "trace"
| where customDimensions["FormattedMessage"] !contains "calling the service URL"
//| summarize count() by operation_Name, itemType
| summarize
    Total=count(),
    Success=count(itemType == "trace")
    by bin(timestamp, 10m)
| extend availability=toreal(Success) / Total
//| render timechart 
| where availability < threshold
  QUERY
  )
  severity    = 1
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 2
  }
}
