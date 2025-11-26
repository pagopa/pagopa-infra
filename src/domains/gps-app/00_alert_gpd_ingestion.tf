locals {

  fn_name_for_alerts_exceptions = var.env_short != "p" ? [] : [
    {
      id : "cdc-raw-auto.apd.payment_option"
      name : "cdc-raw-auto.apd.payment_option"
    },
    {
      id : "cdc-raw-auto.apd.payment_position"
      name : "cdc-raw-auto.apd.payment_position"
    },
    {
      id : "cdc-raw-auto.apd.transfer"
      name : "cdc-raw-auto.apd.transfer"
    }
  ]


  action_groups_default = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]

  # ENABLE PROD afert deploy
  action_groups = var.env_short == "p" ? concat(local.action_groups_default, [data.azurerm_monitor_action_group.opsgenie[0].id, data.azurerm_monitor_action_group.smo_opsgenie[0].id]) : local.action_groups_default
  # action_groups = local.action_groups_default
}

resource "azurerm_monitor_scheduled_query_rules_alert" "gpd-ingestion-manager-availability" {
  for_each            = { for c in local.fn_name_for_alerts_exceptions : c.name => c }
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-gpd-ingestion-manager-availability-${each.value.id}"
  location            = var.location

  action {
    action_group = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id, data.azurerm_monitor_action_group.smo_opsgenie[0].id]
    # action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "gpd-ingestion-manager-availability ${each.value.name}"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Availability gpd-ingestion ${each.value.name}"
  enabled        = true
  query = format(<<-QUERY
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
    action_group = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id, data.azurerm_monitor_action_group.smo_opsgenie[0].id]
    # action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
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
  for_each            = { for c in local.fn_name_for_alerts_exceptions : c.name => c }
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-gpd-ingestion-manager-error-generic-${each.value.id}"
  location            = var.location

  action {
    action_group = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id, data.azurerm_monitor_action_group.smo_opsgenie[0].id]
    # action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
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
    action_group = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id, data.azurerm_monitor_action_group.smo_opsgenie[0].id]
    # action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
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
    action_group = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id, data.azurerm_monitor_action_group.smo_opsgenie[0].id]
    # action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
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
  for_each = { for c in local.fn_name_for_alerts_exceptions : c.name => c }

  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-gpd-ingestion-manager-error-alert-${each.value.id}"
  location            = var.location

  action {
    # action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    action_group           = local.action_groups
    email_subject          = "Unexpected error while managing gpd ingestion events"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Binding exception on gpd-ingestion-manager"
  enabled        = true
  query = format(<<-QUERY
  exceptions
    | where cloud_RoleName == "%s"
    //| where outerMessage contains "${each.value.name} ingestion error Generic exception"
    | where operation_Name startswith "${each.value.name}"
    | order by timestamp desc
  QUERY
    , "pagopagpdingestionmanager" # from HELM's parameter WEBSITE_SITE_NAME
  )
  severity    = 2 // Sev 2	Warning
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 30
  }

}
