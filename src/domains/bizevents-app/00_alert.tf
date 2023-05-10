resource "azurerm_monitor_scheduled_query_rules_alert" "bizeventsdatastore-availability" {
  count               = var.env_short != "d" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-bizeventsdatastore-availability"
  location            = var.location

  action {
    # action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.new_conn_srv_opsgenie[0].id]
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Availability bizeventsdatastore "
  enabled        = true
  query = (<<-QUERY
let threshold = 0.95;
union traces,exceptions
| where cloud_RoleName == "pagopabizeventsdatastore"
| where message contains "Executed 'Functions.Info' (Succeeded" or itemType == "exception"
| extend errore=extract("function - blocking exception occurred for event with id (.*) :(.*) Error (.*) calling (.*)",3,tostring(customDimensions["FormattedMessage"]))
//| summarize count() by errore, itemType
| summarize
    Total=count(),
    Success=count(itemType == "trace")
    by bin(timestamp, 5m)
| extend availability=toreal(Success) / Total
| where availability < threshold
  QUERY
  )
  severity    = 1
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }

}
