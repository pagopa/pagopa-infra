###################
## NODE CFG SYNC ##
###################

locals {
  pagopa_node_cfg_sync = {
    name = "pagopa-node-cfg-sync"
    dumpProblem               = {
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
    }
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
