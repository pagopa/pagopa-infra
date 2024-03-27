# AppException
resource "azurerm_monitor_scheduled_query_rules_alert" "taxonomy_appexception" {
  for_each            = toset(["Get", "Update", "Update-Triggered"])
  name                = "${module.taxonomy_function.name}-${each.key}-app-exception"
  resource_group_name = data.azurerm_resource_group.taxonomy_rg.name
  location            = var.location

  action {
    action_group           = var.env_short == "p" ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "AppException - ${each.key}"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Problem to generate taxonomy - ${each.key} AppException"
  enabled        = true
  query = format(<<-QUERY
    traces
      | where cloud_RoleName == "%s"
      | where message contains "[ALERT][%s] AppException"
      | order by timestamp desc
      | summarize Total=count() by length=bin(timestamp,1m)
      | order by length desc
  QUERY
    , module.taxonomy_function.name, each.key
  )
  severity    = 3
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

# Generic error
resource "azurerm_monitor_scheduled_query_rules_alert" "taxonomy_genericerror" {
  for_each            = toset(["Get", "Update", "Update-Triggered"])
  name                = "${module.taxonomy_function.name}-${each.key}-generic-error"
  resource_group_name = data.azurerm_resource_group.taxonomy_rg.name
  location            = var.location

  action {
    action_group           = var.env_short == "p" ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "GenericError - ${each.key}"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Problem to generate taxonomy - ${each.key} GenericError"
  enabled        = true
  query = format(<<-QUERY
    traces
      | where cloud_RoleName == "%s"
      | where message contains "[ALERT][%s] GenericError"
      | order by timestamp desc
      | summarize Total=count() by length=bin(timestamp,1m)
      | order by length desc
  QUERY
    , module.taxonomy_function.name, each.key
  )
  severity    = 3
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

# BlobStorageException
resource "azurerm_monitor_scheduled_query_rules_alert" "taxonomy_blobstorageexception" {
  for_each            = toset(["Get", "Update", "Update-Triggered"])
  name                = "${module.taxonomy_function.name}-${each.key}-blobstorageexception"
  resource_group_name = data.azurerm_resource_group.taxonomy_rg.name
  location            = var.location

  action {
    action_group           = var.env_short == "p" ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "GenericError - ${each.key}"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Problem to generate taxonomy(Blob storage exception) - ${each.key} BlobStorageException"
  enabled        = true
  query = format(<<-QUERY
    traces
      | where cloud_RoleName == "%s"
      | where message contains "[ALERT][%s] BlobStorageException"
      | order by timestamp desc
      | summarize Total=count() by length=bin(timestamp,1m)
      | order by length desc
  QUERY
    , module.taxonomy_function.name, each.key
  )
  severity    = 3
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}
