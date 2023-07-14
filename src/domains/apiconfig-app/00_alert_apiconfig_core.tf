#####################
## API-CONFIG CORE ##
#####################

# Node database availability
resource "azurerm_monitor_scheduled_query_rules_alert" "apiconfig_db_healthcheck" {
  name                = format("%s-%s", module.api_config_app_service.name, "db-healthcheck")
  resource_group_name = azurerm_resource_group.api_config_rg.name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.opsgenie[0].id]
    email_subject          = "DB Nodo Healthcheck"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Availability less than 99%"
  enabled        = true
  query = format(<<-QUERY
  traces
    | where cloud_RoleName == "%s" and tostring(message) contains "dbConnection"
    | order by timestamp desc
    | summarize Total=count(), Success=countif(tostring(message) contains "dbConnection=up") by length=bin(timestamp,15m)
    | extend Availability=((Success*1.0)/Total)*100
    | where toint(Availability) < 99
  QUERY
    , module.api_config_app_service.name
  )
  severity    = 1
  frequency   = 45
  time_window = 45
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 3
  }
}

# JDBC connection problem
resource "azurerm_monitor_scheduled_query_rules_alert" "apiconfig_jdbc_connection" {
  name                = format("%s-%s", module.api_config_app_service.name, "jdbc-connection")
  resource_group_name = azurerm_resource_group.api_config_rg.name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.opsgenie[0].id]
    email_subject          = "JDBC Connection"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Problem to acquire JDBC connection"
  enabled        = true

  query = format(<<-QUERY
    let threshold = 5;
    traces
    | where cloud_RoleName == "%s"
    | where message contains "Invoking API operation" or message contains "Unable to acquire JDBC Connection"
    | order by timestamp desc
    | summarize Total=countif(message contains "Invoking API operation"), Error=countif(message contains "Unable to acquire JDBC Connection") by length=bin(timestamp, 5m)
    | extend Problem=(toreal(Error) / Total) * 100
    | where Problem > threshold
    | order by length desc
    QUERY
    , module.api_config_app_service.name
  )

  severity    = 1
  frequency   = 5
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 3
  }
}
