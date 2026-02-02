###################
## NODE CFG SYNC ##
###################

locals {
  pagopa_node_cfg_sync = {
    name = "pagopa-node-cfg-sync"
    dumpProblem = {
      query       = <<-QUERY
          traces
          | where cloud_RoleName == "%s"
          | where message contains "[api-config-cache][ALERT] Problem to dump cache"
          | order by timestamp desc
          | summarize Total=count() by length=bin(timestamp,1m)
          | order by length desc
          QUERY
      severity    = 0
      frequency   = 5
      time_window = 5
    },
    dumpTrigger = {
      query       = <<-QUERY
          let start = datetime_local_to_utc(startofday(now()), 'Europe/Rome');
          let end = start + 30m;
          traces
          | where timestamp between(start .. end)
          | where cloud_RoleName == "%s"
          | where message contains "[api-config-cache][ALERT-OK]"
          | summarize Total=count() by length=bin(timestamp,1d)
          | order by length desc
          QUERY
      severity    = 0
      frequency   = 30
      time_window = 1440
    },
    genericProblem = {
      query       = <<-QUERY
          traces
          | where cloud_RoleName == "%s"
          | where message contains "[api-config-cache][ALERT] Generic Error"
          | order by timestamp desc
          | summarize Total=count() by length=bin(timestamp,1m)
          | order by length desc
          QUERY
      severity    = 0
      frequency   = 5
      time_window = 5
    },
    syncDumpingError = {
      query       = <<-QUERY
        customEvents
          | where name == "NODE_CFG_SYNC"
          | where customDimensions.type == "%s"
          | order by timestamp desc
      QUERY
      severity    = 0
      frequency   = 5
      time_window = 5
    },
  }
}

# Problem to write cache on DB
resource "azurerm_monitor_scheduled_query_rules_alert" "node_cfg_sync_dump_problem" {
  name                = format("%s-%s", local.pagopa_node_cfg_sync.name, "cache-dump-problem")
  resource_group_name = data.azurerm_resource_group.node_cfg_sync_rg.name
  location            = var.location

  action {
    action_group           = var.env_short != "d" ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[${var.env}] Problem to dump cache on DB"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "[${var.env}] Problem to dump cache on DB"
  enabled        = true
  query          = format(local.pagopa_node_cfg_sync.dumpProblem.query, local.pagopa_node_cfg_sync.name)

  severity    = local.pagopa_node_cfg_sync.dumpProblem.severity
  frequency   = local.pagopa_node_cfg_sync.dumpProblem.frequency
  time_window = local.pagopa_node_cfg_sync.dumpProblem.time_window
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

# No trigger received in the range 00:00 - 00:30
resource "azurerm_monitor_scheduled_query_rules_alert" "node_cfg_sync_trigger_problem" {
  name                = format("%s-%s", local.pagopa_node_cfg_sync.name, "cache-trigger-problem")
  resource_group_name = data.azurerm_resource_group.node_cfg_sync_rg.name
  location            = var.location

  action {
    action_group           = var.env_short != "d" ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[${var.env}] No trigger received at midnight"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "[${var.env}] No trigger received at midnight"
  enabled        = false # PSFC-TODO should per active and apply on 23.59
  query          = format(local.pagopa_node_cfg_sync.dumpTrigger.query, local.pagopa_node_cfg_sync.name)

  severity    = local.pagopa_node_cfg_sync.dumpTrigger.severity
  frequency   = local.pagopa_node_cfg_sync.dumpTrigger.frequency
  time_window = local.pagopa_node_cfg_sync.dumpTrigger.time_window
  trigger {
    operator  = "LessThan"
    threshold = 1
  }
}

# Cache Generic error
resource "azurerm_monitor_scheduled_query_rules_alert" "node_cfg_sync_generic_problem" {
  name                = format("%s-%s", local.pagopa_node_cfg_sync.name, "cache-generic-problem")
  resource_group_name = data.azurerm_resource_group.node_cfg_sync_rg.name
  location            = var.location

  action {
    action_group           = var.env_short != "d" ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[${var.env}] Generic problem regarding cache dumping"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "[${var.env}] Generic problem regarding cache dumping"
  enabled        = true
  query          = format(local.pagopa_node_cfg_sync.dumpProblem.query, local.pagopa_node_cfg_sync.name)

  severity    = local.pagopa_node_cfg_sync.genericProblem.severity
  frequency   = local.pagopa_node_cfg_sync.genericProblem.frequency
  time_window = local.pagopa_node_cfg_sync.genericProblem.time_window
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

# Custom event
# Cache
resource "azurerm_monitor_scheduled_query_rules_alert" "cache-dumping-error" {
  count               = var.env_short == "p" ? 1 : 0
  name                = format("%s-%s", local.pagopa_node_cfg_sync.name, "cache-dumping-error")
  resource_group_name = data.azurerm_resource_group.node_cfg_sync_rg.name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.smo_opsgenie[0].id]
    email_subject          = "node-cfg-sync-cache-dumping-error"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Problem to dump cache on DBs"
  enabled        = true
  query          = format(local.pagopa_node_cfg_sync.syncDumpingError.query, "Cache not ready to be saved")
  severity       = local.pagopa_node_cfg_sync.syncDumpingError.severity
  frequency      = local.pagopa_node_cfg_sync.syncDumpingError.frequency
  time_window    = local.pagopa_node_cfg_sync.syncDumpingError.time_window
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

# Stand-in
resource "azurerm_monitor_scheduled_query_rules_alert" "stand-in-station-dumping-error" {
  count               = var.env_short == "p" ? 1 : 0
  name                = format("%s-%s", local.pagopa_node_cfg_sync.name, "stand-in-station-dumping-error")
  resource_group_name = data.azurerm_resource_group.node_cfg_sync_rg.name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "stand-in-station-dumping-error"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Problem to dump stand-in-stations on DBs"
  enabled        = true
  query          = format(local.pagopa_node_cfg_sync.syncDumpingError.query, "Stand-in-Station not updated")
  severity       = local.pagopa_node_cfg_sync.syncDumpingError.severity
  frequency      = local.pagopa_node_cfg_sync.syncDumpingError.frequency
  time_window    = local.pagopa_node_cfg_sync.syncDumpingError.time_window
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}
