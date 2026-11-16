###################
## NODE CFG SYNC ##
###################

locals {
  pagopa_node_cfg_sync = {
    name = "pagopa-node-cfg-sync"
    eventHubProcessingError = {
      query       = <<-QUERY
          traces
          | where cloud_RoleName == "%s"
          | where message contains "[api-config-cache][ALERT] Error occurred from partition"
          | order by timestamp desc
          | summarize Total=count() by length=bin(timestamp,1m)
          | order by length desc
          QUERY
      severity    = 0
      frequency   = 5
      time_window = 5
    },
    customEvent = {
      query       = <<-QUERY
        customEvents
          | where name == "NODE_CFG_SYNC"
          | where customDimensions.type == "%s"
          | order by timestamp desc
      QUERY
      severity    = 1
      frequency   = 5
      time_window = 5
    },
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "node_cfg_sync_cache_event_hub_error_processor" {
  name                = format("%s-%s", local.pagopa_node_cfg_sync.name, "event-hub-error-processor")
  resource_group_name = data.azurerm_resource_group.node_cfg_sync_rg.name
  location            = var.location

  action {
    action_group           = var.env_short != "d" ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack_pagopa_pagamenti_alert.id]
    email_subject          = "[${var.env}] Error processing event hub message"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "[${var.env}] Error processing event hub message"
  enabled        = true
  query          = format(local.pagopa_node_cfg_sync.eventHubProcessingError.query, local.pagopa_node_cfg_sync.name)

  severity    = local.pagopa_node_cfg_sync.eventHubProcessingError.severity
  frequency   = local.pagopa_node_cfg_sync.eventHubProcessingError.frequency
  time_window = local.pagopa_node_cfg_sync.eventHubProcessingError.time_window
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

# Custom event
###########
# Cache
###########
resource "azurerm_monitor_scheduled_query_rules_alert" "cache-generic-error" {
  count               = var.env_short == "p" ? 1 : 0
  name                = format("%s-%s", local.pagopa_node_cfg_sync.name, "cache-generic-error")
  resource_group_name = data.azurerm_resource_group.node_cfg_sync_rg.name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.smo_opsgenie[0].id]
    email_subject          = "node-cfg-sync-cache-generic-error"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Generic error regarding cache persistence on DB"
  enabled        = true
  query          = format(local.pagopa_node_cfg_sync.customEvent.query, "Cache not ready to be saved")
  severity       = local.pagopa_node_cfg_sync.customEvent.severity
  frequency      = local.pagopa_node_cfg_sync.customEvent.frequency
  time_window    = local.pagopa_node_cfg_sync.customEvent.time_window
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "cache-save-error" {
  count               = var.env_short == "p" ? 1 : 0
  name                = format("%s-%s", local.pagopa_node_cfg_sync.name, "cache-dumping-error")
  resource_group_name = data.azurerm_resource_group.node_cfg_sync_rg.name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.smo_opsgenie[0].id]
    email_subject          = "node-cfg-sync-cache-save-error"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Problem to save cache on DB"
  enabled        = true
  query          = format(local.pagopa_node_cfg_sync.customEvent.query, "Cache not saved")
  severity       = local.pagopa_node_cfg_sync.customEvent.severity
  frequency      = local.pagopa_node_cfg_sync.customEvent.frequency
  time_window    = local.pagopa_node_cfg_sync.customEvent.time_window
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "cache-rollback-error" {
  count               = var.env_short == "p" ? 1 : 0
  name                = format("%s-%s", local.pagopa_node_cfg_sync.name, "cache-rollback-error")
  resource_group_name = data.azurerm_resource_group.node_cfg_sync_rg.name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.smo_opsgenie[0].id]
    email_subject          = "node-cfg-sync-cache-rollback-error"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Problem to rollback saved cache on DB after a failed save"
  enabled        = true
  query          = format(local.pagopa_node_cfg_sync.customEvent.query, "Cache rollback failed")
  severity       = 0
  frequency      = local.pagopa_node_cfg_sync.customEvent.frequency
  time_window    = local.pagopa_node_cfg_sync.customEvent.time_window
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

###########
# Stand-in
###########
# resource "azurerm_monitor_scheduled_query_rules_alert" "stand-in-station-generic-error" {
#   count               = var.env_short == "p" ? 1 : 0
#   name                = format("%s-%s", local.pagopa_node_cfg_sync.name, "stand-in-station-generic-error")
#   resource_group_name = data.azurerm_resource_group.node_cfg_sync_rg.name
#   location            = var.location
#
#   action {
#     action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
#     email_subject          = "stand-in-station-generic-error"
#     custom_webhook_payload = "{}"
#   }
#   data_source_id = data.azurerm_application_insights.application_insights.id
#   description    = "Generic error regarding stand-in-stations persistence on DB"
#   enabled        = true
#   query          = format(local.pagopa_node_cfg_sync.customEvent.query, "Stand-in-Station not updated")
#   severity       = local.pagopa_node_cfg_sync.customEvent.severity
#   frequency      = local.pagopa_node_cfg_sync.customEvent.frequency
#   time_window    = local.pagopa_node_cfg_sync.customEvent.time_window
#   trigger {
#     operator  = "GreaterThanOrEqual"
#     threshold = 1
#   }
# }
#
# resource "azurerm_monitor_scheduled_query_rules_alert" "stand-in-station-fetch-error" {
#   count               = var.env_short == "p" ? 1 : 0
#   name = format("%s-%s", local.pagopa_node_cfg_sync.name, "stand-in-station-fetch-error")
#   resource_group_name = data.azurerm_resource_group.node_cfg_sync_rg.name
#   location            = var.location
#
#   action {
#     action_group = [
#       data.azurerm_monitor_action_group.email.id,
#       data.azurerm_monitor_action_group.slack.id
#     ]
#     email_subject          = "stand-in-station-retrieve-error"
#     custom_webhook_payload = "{}"
#   }
#   data_source_id = data.azurerm_application_insights.application_insights.id
#   description    = "Problem to retrieve stand-in-stations"
#   enabled        = true
#   query = format(local.pagopa_node_cfg_sync.customEvent.query, "Unable to retrieve Stand-in-Stations")
#   severity       = local.pagopa_node_cfg_sync.customEvent.severity
#   frequency      = local.pagopa_node_cfg_sync.customEvent.frequency
#   time_window    = local.pagopa_node_cfg_sync.customEvent.time_window
#   trigger {
#     operator  = "GreaterThanOrEqual"
#     threshold = 1
#   }
# }
#
# resource "azurerm_monitor_scheduled_query_rules_alert" "stand-in-station-save-error" {
#   count               = var.env_short == "p" ? 1 : 0
#   name = format("%s-%s", local.pagopa_node_cfg_sync.name, "stand-in-station-fetch-error")
#   resource_group_name = data.azurerm_resource_group.node_cfg_sync_rg.name
#   location            = var.location
#
#   action {
#     action_group = [
#       data.azurerm_monitor_action_group.email.id,
#       data.azurerm_monitor_action_group.slack.id
#     ]
#     email_subject          = "stand-in-station-retrieve-error"
#     custom_webhook_payload = "{}"
#   }
#   data_source_id = data.azurerm_application_insights.application_insights.id
#   description    = "Problem to retrieve stand-in-stations"
#   enabled        = true
#   query = format(local.pagopa_node_cfg_sync.customEvent.query, "Stand-in-Station not saved")
#   severity       = local.pagopa_node_cfg_sync.customEvent.severity
#   frequency      = local.pagopa_node_cfg_sync.customEvent.frequency
#   time_window    = local.pagopa_node_cfg_sync.customEvent.time_window
#   trigger {
#     operator  = "GreaterThanOrEqual"
#     threshold = 1
#   }
# }
#
# resource "azurerm_monitor_scheduled_query_rules_alert" "stand-in-station-rollback-error" {
#   count               = var.env_short == "p" ? 1 : 0
#   name = format("%s-%s", local.pagopa_node_cfg_sync.name, "stand-in-station-rollback-error")
#   resource_group_name = data.azurerm_resource_group.node_cfg_sync_rg.name
#   location            = var.location
#
#   action {
#     action_group = [
#       data.azurerm_monitor_action_group.email.id,
#       data.azurerm_monitor_action_group.slack.id
#     ]
#     email_subject          = "stand-in-station-rollback-error"
#     custom_webhook_payload = "{}"
#   }
#   data_source_id = data.azurerm_application_insights.application_insights.id
#   description    = "Problem to rollback saved stand-in-stations on DB after a failed save"
#   enabled        = true
#   query = format(local.pagopa_node_cfg_sync.customEvent.query, "Stand-in rollback failed")
#   severity       = 0
#   frequency      = local.pagopa_node_cfg_sync.customEvent.frequency
#   time_window    = local.pagopa_node_cfg_sync.customEvent.time_window
#   trigger {
#     operator  = "GreaterThanOrEqual"
#     threshold = 1
#   }
# }
