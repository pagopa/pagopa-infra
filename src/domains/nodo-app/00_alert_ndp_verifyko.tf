# AppException during datastore dumping
resource "azurerm_monitor_scheduled_query_rules_alert" "nodo_verifyko_to_datastore_appexception" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "${module.nodo_verifyko_to_datastore_function.name}-app-exception"
  resource_group_name = data.azurerm_resource_group.nodo_verify_ko_rg.name
  location            = var.location

  action {
    action_group           = local.action_groups
    email_subject          = "AppException on Verify KO Event dumping"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "An AppException occurred on saving Verify KO events on CosmosDB"
  enabled        = true
  query = format(<<-QUERY
    traces
      | where cloud_RoleName == "%s"
      | where message contains "[ALERT][VerifyKOToDS] AppException"
      | order by timestamp desc
      | summarize Total=count() by length=bin(timestamp,1m)
      | order by length desc
  QUERY
    , module.nodo_verifyko_to_datastore_function.name
  )
  severity    = 3
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

# AppException during table storage dumping
resource "azurerm_monitor_scheduled_query_rules_alert" "nodo_verifyko_to_tablestorage_appexception" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "${module.nodo_verifyko_to_tablestorage_function.name}-app-exception"
  resource_group_name = data.azurerm_resource_group.nodo_verify_ko_rg.name
  location            = var.location

  action {
    action_group           = local.action_groups
    email_subject          = "AppException on Verify KO Event dumping"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "An AppException occurred on saving Verify KO events on TableStorage"
  enabled        = true
  query = format(<<-QUERY
    traces
      | where cloud_RoleName == "%s"
      | where message contains "[ALERT][VerifyKOToTS] AppException"
      | order by timestamp desc
      | summarize Total=count() by length=bin(timestamp,1m)
      | order by length desc
  QUERY
    , module.nodo_verifyko_to_tablestorage_function.name
  )
  severity    = 3
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

# CosmosException
resource "azurerm_monitor_scheduled_query_rules_alert" "nodo_verifyko_to_datastore_cosmosexception" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "${module.nodo_verifyko_to_datastore_function.name}-cosmosexception"
  resource_group_name = data.azurerm_resource_group.nodo_verify_ko_rg.name
  location            = var.location

  action {
    action_group           = local.action_groups
    email_subject          = "CosmosException on Verify KO Event dumping"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "A CosmosException occurred on saving Verify KO events on CosmosDB"
  enabled        = true
  query = format(<<-QUERY
    exceptions
      | where cloud_RoleName == "%s"
      | where operation_Name == "EventHubNodoVerifyKOEventToDSProcessor"
      | where type has "Microsoft.Azure.Cosmos.CosmosException"
      | order by timestamp desc
      | summarize Total=count() by length=bin(timestamp,1m)
      | order by length desc
  QUERY
    , module.nodo_verifyko_to_datastore_function.name
  )
  severity    = 3
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}


# Exception during table storage saving
resource "azurerm_monitor_scheduled_query_rules_alert" "nodo_verifyko_to_tablestorage_persistenceexception" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "${module.nodo_verifyko_to_tablestorage_function.name}-persistence-exception"
  resource_group_name = data.azurerm_resource_group.nodo_verify_ko_rg.name
  location            = var.location

  action {
    action_group           = local.action_groups
    email_subject          = "Persistence exception on Verify KO Event dumping"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "An Exception occurred during persisting Verify KO events on TableStorage"
  enabled        = true
  query = format(<<-QUERY
    traces
      | where cloud_RoleName == "%s"
      | where message contains "[ALERT][VerifyKOToTS] Persistence Exception"
      | order by timestamp desc
      | summarize Total=count() by length=bin(timestamp,1m)
      | order by length desc
  QUERY
    , module.nodo_verifyko_to_tablestorage_function.name
  )
  severity    = 3
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}
