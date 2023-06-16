######################
## API-CONFIG CACHE ##
######################

locals {

  oracle_version     = "oracle"
  postgresql_version = "postgresql"
}

# Pod OutOfMemory - ORACLE
resource "azurerm_monitor_scheduled_query_rules_alert" "apiconfig_out_of_memory_oracle" {
  name                = format("%s-%s-%s", local.apiconfig_cache_alert.pagopa_api_config_cache_name, "out-of-memory", local.oracle_version)
  resource_group_name = azurerm_resource_group.api_config_rg.name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = format("Out-of-memory %s", local.oracle_version)
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = format("Problem to generate cache - %s", local.oracle_version)
  enabled        = true
  query          = format(local.apiconfig_cache_alert.outOfMemory.query, format("%s-%s-%s", var.prefix, local.apiconfig_cache_locals.path, local.oracle_version))

  severity    = local.apiconfig_cache_alert.outOfMemory.severity
  frequency   = local.apiconfig_cache_alert.outOfMemory.frequency
  time_window = local.apiconfig_cache_alert.outOfMemory.time_window
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

# Pod OutOfMemory - POSTGRESQL
resource "azurerm_monitor_scheduled_query_rules_alert" "apiconfig_out_of_memory_postgresql" {
  name                = format("%s-%s-%s", local.apiconfig_cache_alert.pagopa_api_config_cache_name, "out-of-memory", local.postgresql_version)
  resource_group_name = azurerm_resource_group.api_config_rg.name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = format("Out-of-memory %s", local.postgresql_version)
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = format("Problem to generate cache - %s", local.postgresql_version)
  enabled        = true
  query          = format(local.apiconfig_cache_alert.outOfMemory.query, format("%s-%s-%s", var.prefix, local.apiconfig_cache_locals.path, local.postgresql_version))

  severity    = local.apiconfig_cache_alert.outOfMemory.severity
  frequency   = local.apiconfig_cache_alert.outOfMemory.frequency
  time_window = local.apiconfig_cache_alert.outOfMemory.time_window
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}
