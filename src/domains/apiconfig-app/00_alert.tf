##################
### ORACLE     ###
##################
# No memory
resource "azurerm_monitor_scheduled_query_rules_alert" "apiconfig_cache_no_memory_oracle" {
  name                = format("%s-%s", module.apim_apiconfig_cache_product.product_id, "no-memory-oracle")
  resource_group_name = local.pagopa_apim_rg
  location            = var.location

  action {
    action_group           = local.apiconfig_cache_alert_locals.action_group
    email_subject          = "[APICFG-CACHE][ORACLE] No memory to generate cache"
    custom_webhook_payload = "{}"
  }
  data_source_id = local.apiconfig_cache_alert_locals.data_source_id
  description    = "Problem to generate Oracle cache"
  enabled        = true
  query       = replace(local.apiconfig_cache_alert_locals.no_memory.query, "DATABASE", "oracle")
  severity    = local.apiconfig_cache_alert_locals.no_memory.severity
  frequency   = local.apiconfig_cache_alert_locals.no_memory.frequency
  time_window = local.apiconfig_cache_alert_locals.no_memory.time_window
  trigger {
    operator  = local.apiconfig_cache_alert_locals.no_memory.operator
    threshold = local.apiconfig_cache_alert_locals.no_memory.threshold
  }
}

// TODO modify for Core
# JDBC Connection
resource "azurerm_monitor_scheduled_query_rules_alert" "apiconfig_core_jdbc_connection_oracle" {
  name                = format("%s-%s", module.apim_apiconfig_cache_product.product_id, "jdbc-connection-oracle")
  resource_group_name = local.pagopa_apim_rg
  location            = var.location

  action {
    action_group           = local.apiconfig_cache_alert_locals.action_group
    email_subject          = "[APICFG-CORE][ORACLE] JDBC connection Error"
    custom_webhook_payload = "{}"
  }
  data_source_id = local.apiconfig_cache_alert_locals.data_source_id
  description    = "Problem to acquire JDBC connection"
  enabled        = true
  query       = replace(local.apiconfig_cache_alert_locals.jdbc_connection.query, "DATABASE", "oracle")
  severity    = local.apiconfig_cache_alert_locals.jdbc_connection.severity
  frequency   = local.apiconfig_cache_alert_locals.jdbc_connection.frequency
  time_window = local.apiconfig_cache_alert_locals.jdbc_connection.time_window
  trigger {
    operator  = local.apiconfig_cache_alert_locals.jdbc_connection.operator
    threshold = local.apiconfig_cache_alert_locals.jdbc_connection.threshold
  }
}

##################
### POSTGRESQL ###
##################
resource "azurerm_monitor_scheduled_query_rules_alert" "apiconfig_cache_no_memory_postgres" {
  name                = format("%s-%s", module.apim_apiconfig_cache_product.product_id, "no-memory-postgresql")
  resource_group_name = local.pagopa_apim_rg
  location            = var.location

  action {
    action_group           = local.apiconfig_cache_alert_locals.action_group
    email_subject          = "[APICFG-CACHE][POSTGRESQL] No memory to generate cache"
    custom_webhook_payload = "{}"
  }
  data_source_id = local.apiconfig_cache_alert_locals.data_source_id
  description    = "Problem to generate PostgreSQL cache"
  enabled        = true
  query       = replace(local.apiconfig_cache_alert_locals.no_memory.query, "DATABASE", "postgresql")
  severity    = local.apiconfig_cache_alert_locals.no_memory.severity
  frequency   = local.apiconfig_cache_alert_locals.no_memory.frequency
  time_window = local.apiconfig_cache_alert_locals.no_memory.time_window
  trigger {
    operator  = local.apiconfig_cache_alert_locals.no_memory.operator
    threshold = local.apiconfig_cache_alert_locals.no_memory.threshold
  }
}

// TODO modify for Core
# JDBC Connection
resource "azurerm_monitor_scheduled_query_rules_alert" "apiconfig_core_jdbc_connection_postgresql" {
  name                = format("%s-%s", module.apim_apiconfig_cache_product.product_id, "jdbc-connection-postgresql")
  resource_group_name = local.pagopa_apim_rg
  location            = var.location

  action {
    action_group           = local.apiconfig_cache_alert_locals.action_group
    email_subject          = "[APICFG-CORE][POSTGRESQL] JDBC connection Error"
    custom_webhook_payload = "{}"
  }
  data_source_id = local.apiconfig_cache_alert_locals.data_source_id
  description    = "Problem to acquire JDBC connection"
  enabled        = true
  query       = replace(local.apiconfig_cache_alert_locals.jdbc_connection.query, "DATABASE", "postgresql")
  severity    = local.apiconfig_cache_alert_locals.jdbc_connection.severity
  frequency   = local.apiconfig_cache_alert_locals.jdbc_connection.frequency
  time_window = local.apiconfig_cache_alert_locals.jdbc_connection.time_window
  trigger {
    operator  = local.apiconfig_cache_alert_locals.jdbc_connection.operator
    threshold = local.apiconfig_cache_alert_locals.jdbc_connection.threshold
  }
}
