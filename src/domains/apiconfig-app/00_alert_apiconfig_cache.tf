######################
## API-CONFIG CACHE ##
######################

# Pod OutOfMemory
resource "azurerm_monitor_scheduled_query_rules_alert" "apiconfig_cache_out_of_memory" {
  for_each = toset(["oracle", "postgresql"])
  name                = format("%s-%s-%s", local.apiconfig_cache_alert.pagopa_api_config_cache_name, "out-of-memory", each.key)
  resource_group_name = azurerm_resource_group.api_config_rg.name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = format("Out-of-memory %s", each.key)
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = format("Problem to generate cache - %s", each.key)
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
