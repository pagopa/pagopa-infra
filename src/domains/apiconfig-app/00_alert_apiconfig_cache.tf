######################
## API-CONFIG CACHE ##
######################

# Pod OutOfMemory
resource "azurerm_monitor_scheduled_query_rules_alert" "apiconfig_cache_out_of_memory" {
  for_each            = toset(["postgresql"])
  name                = format("%s-%s-%s", local.apiconfig_cache_alert.pagopa_api_config_cache_name, "out-of-memory", each.key)
  resource_group_name = azurerm_resource_group.api_config_rg.name
  location            = var.location

  action {
    action_group           = var.env_short != "d" ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = format("[%s] Out-of-memory %s", var.env, each.key)
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "[${var.env}] Problem to generate cache - ${each.key} - ${var.env}"
  enabled        = true
  query          = format(local.apiconfig_cache_alert.outOfMemory.query, format("%s-%s-%s", var.prefix, local.apiconfig_cache_locals.path, each.key))

  severity    = local.apiconfig_cache_alert.outOfMemory.severity
  frequency   = local.apiconfig_cache_alert.outOfMemory.frequency
  time_window = local.apiconfig_cache_alert.outOfMemory.time_window
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

# WriteOnDB
resource "azurerm_monitor_scheduled_query_rules_alert" "apiconfig_cache_write_on_db" {
  for_each            = toset(["postgresql"])
  name                = format("%s-%s-%s", local.apiconfig_cache_alert.pagopa_api_config_cache_name, "write-on-db", each.key)
  resource_group_name = azurerm_resource_group.api_config_rg.name
  location            = var.location

  action {
    action_group           = var.env_short != "d" ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = format("[%s] Write-On-DB %s", var.env, each.key)
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = format("[%s] Problem to save cache on DB - %s - %s", var.env, each.key, var.env)
  enabled        = true
  query          = format(local.apiconfig_cache_alert.writeOnDB.query, format("%s-%s-%s", var.prefix, local.apiconfig_cache_locals.path, each.key))

  severity    = local.apiconfig_cache_alert.writeOnDB.severity
  frequency   = local.apiconfig_cache_alert.writeOnDB.frequency
  time_window = local.apiconfig_cache_alert.writeOnDB.time_window
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

# Cache generation
resource "azurerm_monitor_scheduled_query_rules_alert" "apiconfig_cache_generation" {
  for_each            = toset(["postgresql"])
  name                = format("%s-%s-%s", local.apiconfig_cache_alert.pagopa_api_config_cache_name, "generation", each.key)
  resource_group_name = azurerm_resource_group.api_config_rg.name
  location            = var.location

  action {
    action_group           = var.env_short != "d" ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = format("[%s] Cache generation %s", var.env, each.key)
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = format("[%s] Problem to generate cache - %s - %s", var.env, each.key, var.env)
  enabled        = true
  query          = format(local.apiconfig_cache_alert.cacheGeneration.query, format("%s-%s-%s", var.prefix, local.apiconfig_cache_locals.path, each.key))

  severity    = local.apiconfig_cache_alert.cacheGeneration.severity
  frequency   = local.apiconfig_cache_alert.cacheGeneration.frequency
  time_window = local.apiconfig_cache_alert.cacheGeneration.time_window
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

# JDBC connection problem
resource "azurerm_monitor_scheduled_query_rules_alert" "apiconfig_cache_jdbc_connection" {
  for_each            = toset(["postgresql"])
  name                = format("%s-%s-%s", local.apiconfig_cache_alert.pagopa_api_config_cache_name, "jdbc-connection", each.key)
  resource_group_name = azurerm_resource_group.api_config_rg.name
  location            = var.location

  action {
    action_group           = var.env_short != "d" ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = format("[%s][APIConfig-Cache] JDBC Connection %s", var.env, each.key)
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = format("[%s][APIConfig-Cache] JDBC Connection %s - %s", var.env, each.key, var.env)
  enabled        = true

  query = format(local.apiconfig_cache_alert.jdbcConnection.query, format("%s-%s-%s", var.prefix, local.apiconfig_cache_locals.path, each.key))

  severity    = local.apiconfig_cache_alert.jdbcConnection.severity
  frequency   = local.apiconfig_cache_alert.jdbcConnection.frequency
  time_window = local.apiconfig_cache_alert.jdbcConnection.time_window
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}


