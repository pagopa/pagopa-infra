
locals {

  fn_name_for_alerts_exceptions = var.env_short != "p" ? [] : [
    {
      id   = "cdc-raw-auto.apd.payment_option"
      name = "cdc-raw-auto.apd.payment_option"
    },
    {
      id   = "cdc-raw-auto.apd.payment_position"
      name = "cdc-raw-auto.apd.payment_position"
    },
    {
      id   = "cdc-raw-auto.apd.transfer"
      name = "cdc-raw-auto.apd.transfer"
    }
  ]

  gpd_eventhub_topics = var.env_short != "p" ? [] : [
    {
      id   = "cdc-raw-auto.apd.payment_option"
      name = "cdc-raw-auto.apd.payment_option"
    },
    {
      id   = "cdc-raw-auto.apd.payment_position"
      name = "cdc-raw-auto.apd.payment_position"
    },
    {
      id   = "cdc-raw-auto.apd.transfer"
      name = "cdc-raw-auto.apd.transfer"
    },
    {
      id   = "gpd-ingestion.apd.payment_option"
      name = "gpd-ingestion.apd.payment_option"
    },
    {
      id   = "gpd-ingestion.apd.payment_position"
      name = "gpd-ingestion.apd.payment_position"
    },
    {
      id   = "gpd-ingestion.apd.transfer"
      name = "gpd-ingestion.apd.transfer"
    }
  ]

  gpd_ingestion_deadletter_table_name = "gpdingestiondeadletter"

  action_groups_id_default = [
    data.azurerm_monitor_action_group.email.id,
    data.azurerm_monitor_action_group.slack.id
  ]

  action_groups_id = var.env_short == "p" ? concat(
    local.action_groups_id_default,
    [
      data.azurerm_monitor_action_group.opsgenie[0].id,
      data.azurerm_monitor_action_group.smo_opsgenie[0].id
    ]
  ) : local.action_groups_id_default
}


data "azurerm_eventhub_namespace" "gpd_ingestion_evh" {
  name                = "pagopa-${var.env_short}-itn-observ-gpd-evh"
  resource_group_name = "pagopa-${var.env_short}-itn-observ-evh-rg"
}

data "azurerm_storage_account" "gpd_ingestion_sa" {
  name                = "pagopa${var.env_short}gpdingestsa"
  resource_group_name = "pagopa-${var.env_short}-itn-observ-gpd-rg"
}


resource "azurerm_monitor_metric_alert" "gpd_eventhub_incoming_messages" {
  for_each = {
    for topic in local.gpd_eventhub_topics :
    topic.name => topic
  }

  dynamic "action" {
    for_each = local.action_groups_id
    content {
      action_group_id = action.value
    }
  }
  name                = "pagopa-${var.env_short}-gpd-eventhub-incoming-messages-${replace(each.value.id, ".", "-")}"
  resource_group_name = "dashboards"

  scopes      = [data.azurerm_eventhub_namespace.gpd_ingestion_evh.id]
  description = "Alert when no messages arrive on Event Hub topic ${each.value.name} in 15 minutes"
  severity    = 2
  frequency   = "PT15M"
  window_size = "PT15M"

  criteria {
    metric_namespace = "Microsoft.EventHub/namespaces"
    metric_name      = "IncomingMessages"
    aggregation      = "Total"
    operator         = "LessThan"
    threshold        = 1

    dimension {
      name     = "EntityName"
      operator = "Include"
      values   = [each.value.name]
    }
  }
}


resource "azurerm_monitor_diagnostic_setting" "gpd_ingestion_storage_table_diagnostics" {
  count                      = var.env_short == "p" ? 1 : 0
  name                       = "${data.azurerm_storage_account.gpd_ingestion_sa.name}-table-diagnostics"
  target_resource_id         = "${data.azurerm_storage_account.gpd_ingestion_sa.id}/tableServices/default/"
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics.id

  enabled_log {
    category = "StorageWrite"

    retention_policy {
      enabled = true
      days    = 1
    }
  }

  metric {
    category = "Capacity"
    enabled  = false

    retention_policy {
      days    = 0
      enabled = false
    }
  }

  metric {
    category = "Transaction"
    enabled  = false

    retention_policy {
      days    = 0
      enabled = false
    }
  }
}


resource "azurerm_monitor_scheduled_query_rules_alert" "gpd_ingestion_deadletter_table_growth" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-gpd-ingestion-deadletter-table-growth"
  location            = var.location

  action {
    action_group           = local.action_groups_id
    email_subject          = "gpd-ingestion-deadletter table growth"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_log_analytics_workspace.log_analytics.id
  description    = "Alert when gpdingestiondeadletter receives more than 100 inserts in 5 minutes"
  enabled        = true
  query = format(
    <<-QUERY
StorageTableLogs
| where TimeGenerated >= ago(5m)
| where OperationName == "InsertEntity"
| where ObjectKey has "%s"
| summarize RecordCount = count()
| where RecordCount > 100
QUERY
    ,
    local.gpd_ingestion_deadletter_table_name
  )

  severity    = 2
  frequency   = 5
  time_window = 5

  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}


resource "azurerm_monitor_scheduled_query_rules_alert" "gpd-ingestion-manager-availability" {
  for_each = {
    for c in local.fn_name_for_alerts_exceptions :
    c.name => c
  }

  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-gpd-ingestion-manager-availability-${each.value.id}"
  location            = var.location

  action {
    action_group           = local.action_groups_id
    email_subject          = "gpd-ingestion-manager-availability ${each.value.name}"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Availability gpd-ingestion ${each.value.name}"
  enabled        = true
  query = format(
    <<-QUERY
let threshold = 0.99;
union traces, exceptions
| where cloud_RoleName == "pagopagpdingestionmanager"
| where operation_Name == "%s"
//| summarize count() by operation_Name, itemType
| summarize
    Total=count(),
    Success=count(itemType == "trace")
    by bin(timestamp, 10m)
| extend availability=toreal(Success) / Total
//| render timechart
| where availability < threshold
  QUERY
  , each.value.name)
  severity    = 1
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 2
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "gpd-ingestion-manager-error-json" {
  for_each            = { for c in local.fn_name_for_alerts_exceptions : c.name => c }
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-gpd-ingestion-manager-error-json-${each.value.id}"
  location            = var.location

  action {
    action_group           = local.action_groups_id
    email_subject          = "gpd-ingestion-manager-error-json ${each.value.name}"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "${each.value.name} ingestion error JsonProcessingException"
  enabled        = true
  query = format(<<-QUERY
  traces
    | where cloud_RoleName == "%s"
    | order by timestamp desc
    | where message contains "${each.value.name} ingestion error JsonProcessingException"
  QUERY
    , "pagopagpdingestionmanager"
  )
  severity    = 2 // Sev 2	Warning
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 20
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "gpd-ingestion-manager-error-generic" {
  for_each = {
    for c in local.fn_name_for_alerts_exceptions :
    c.name => c
  }

  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-gpd-ingestion-manager-error-generic-${each.value.id}"
  location            = var.location

  action {
    action_group           = local.action_groups_id
    email_subject          = "gpd-ingestion-manager-error-generic ${each.value.name}"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Error on GenericError gpd-ingestion ${each.value.name}"
  enabled        = true
  query = format(<<-QUERY
  traces
    | where cloud_RoleName == "%s"
    | order by timestamp desc
    | where message contains "function error Generic exception at"
  QUERY
    , "pagopagpdingestionmanager"
  )
  severity    = 2 // Sev 2	Warning
  frequency   = 15
  time_window = 15

  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 20
  }
}


resource "azurerm_monitor_scheduled_query_rules_alert" "gpd-ingestion-manager-error-pdv-tokenizer" {
  for_each            = { for c in local.fn_name_for_alerts_exceptions : c.name => c }
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-gpd-ingestion-manager-error-pdv-tokenizer-${each.value.id}"
  location            = var.location

  action {
    action_group           = local.action_groups_id
    email_subject          = "gpd-ingestion-manager-error-pdv-tokenizer ${each.value.name}"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "${each.value.name} ingestion error PDVTokenizerException"
  enabled        = true
  query = format(<<-QUERY
  traces
    | where cloud_RoleName == "%s"
    | order by timestamp desc
    | where message contains "${each.value.name} ingestion error PDVTokenizerException"
  QUERY
    , "pagopagpdingestionmanager"
  )
  severity    = 2 // Sev 2	Warning
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 20
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "gpd-ingestion-manager-error-unexpected-pdv-tokenizer" {
  for_each            = { for c in local.fn_name_for_alerts_exceptions : c.name => c }
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-gpd-ingestion-manager-error-unexpected-pdv-tokenizer-${each.value.id}"
  location            = var.location

  action {
    action_group           = local.action_groups_id
    email_subject          = "gpd-ingestion-manager-error-unexpected-pdv-tokenizer ${each.value.name}"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "${each.value.name} ingestion error PDVTokenizerUnexpectedException"
  enabled        = true
  query = format(<<-QUERY
  traces
    | where cloud_RoleName == "%s"
    | order by timestamp desc
    | where message contains "${each.value.name} ingestion error PDVTokenizerUnexpectedException"
  QUERY
    , "pagopagpdingestionmanager"
  )
  severity    = 2 // Sev 2	Warning
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 20
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "gpd-ingestion-manager-error-alert" {
  for_each = {
    for c in local.fn_name_for_alerts_exceptions :
    c.name => c
  }

  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-gpd-ingestion-manager-error-alert-${each.value.id}"
  location            = var.location

  action {
    action_group           = local.action_groups_id
    email_subject          = "Unexpected error while managing gpd ingestion events"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Binding exceptions on gpd-ingestion-manager"
  enabled        = true
  query = format(
    <<-QUERY
exceptions
    | where cloud_RoleName == "%s"
    //| where outerMessage contains "${each.value.name} ingestion error Generic exception"
    | where operation_Name startswith "${each.value.name}"
    | order by timestamp desc
QUERY
    , "pagopagpdingestionmanager" # from HELM's parameter WEBSITE_SITE_NAME
  )

  severity    = 2
  frequency   = 15
  time_window = 15

  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 30
  }
}
