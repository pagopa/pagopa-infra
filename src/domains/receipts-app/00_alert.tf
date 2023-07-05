data "azurerm_log_analytics_workspace" "log_analytics" {
  name                = var.log_analytics_workspace_name
  resource_group_name = var.log_analytics_workspace_resource_group_name
}

data "azurerm_resource_group" "monitor_rg" {
  name = var.monitor_resource_group_name
}

data "azurerm_application_insights" "application_insights" {
  name                = local.monitor_appinsights_name
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
}

data "azurerm_monitor_action_group" "slack" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_slack_name
}

data "azurerm_monitor_action_group" "email" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_email_name
}


## Alert
# This alert cover the following error case:
# 1. BizEventToReceiptProcessor execution logs that a Receipt instance has been set to NOT_QUEUE_SENT
#
resource "azurerm_monitor_scheduled_query_rules_alert" "receipts-datastore-not-sent-to-queue-alert" {
  count               = var.env_short != "d" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-receiptsdatastore-not-sent-to-queue-alert"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[Receipt] queue insertion error"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Receipt unable to be sent to process queue"
  enabled        = true
  query = format(<<-QUERY
  traces
    | where cloud_RoleName == "%s"
    | order by timestamp desc
    | where message contains "[BizEventToReceiptService] Error sending message to queue"
  QUERY
    , format("pagopareceiptpdfdatastore", var.env_short) # from HELM's parameter WEBSITE_SITE_NAME
  )
  severity    = 1
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

## Alert
# This alert cover the following error case:
# 1. ManageReceiptPoisonQueueProcessor execution logs that a new entry has been set in error
#
resource "azurerm_monitor_scheduled_query_rules_alert" "receipts-in-error-alert" {
  count               = var.env_short != "d" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-receipt-in-error-alert"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[Receipt] entry in error to review"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "ManageReceiptPoisonQueueProcessor saving new error in collection to review"
  enabled        = true
  query = format(<<-QUERY
  traces
    | where cloud_RoleName == "%s"
    | order by timestamp desc
    | where message contains "[ManageReceiptPoisonQueueProcessor] saving new entry to the retry error to review"
  QUERY
    , format("pagopareceiptpdfdatastore", var.env_short) # from HELM's parameter WEBSITE_SITE_NAME
  )
  severity    = 1
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

## Alert
# This alert cover the following error case:
# 1. BizEventToReceiptProcessor throws an exception for the function execution (CosmosDB related errors)
#
resource "azurerm_monitor_scheduled_query_rules_alert" "receipts-sending-receipt-error-alert" {
  count               = var.env_short != "d" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-receipt-in-poison-queue-alert"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[Receipts] error on initial saving receipt to Cosmos"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Binding exception for function BizEventToReceiptProcessor"
  enabled        = true
  query = format(<<-QUERY
  traces
    | where cloud_RoleName == "%s"
    | order by timestamp desc
    | where message contains "System.Private.CoreLib: Exception while executing function: Functions.BizEventToReceiptProcessor"
  QUERY
    , format("pagopareceiptpdfdatastore", var.env_short) # from HELM's parameter WEBSITE_SITE_NAME
  )
  severity    = 1
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}
