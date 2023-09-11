
locals {

  fn_name_for_alerts_exceptions = var.env_short == "d" ? [] : [
    {
      name : "BizEventToReceiptProcessor"
    }
  ]
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
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id] # future need add opsgenie hook
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
    | where message contains "Error sending message to queue"
  QUERY
    , "pagopareceiptpdfdatastore" # from HELM's parameter WEBSITE_SITE_NAME
  )
  severity    = 2 // Sev 2	Warning
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
    | where message contains "saving new entry to the retry error to review"
  QUERY
    , "pagopareceiptpdfdatastore" # from HELM's parameter WEBSITE_SITE_NAME
  )
  severity    = 2 // Sev 2	Warning
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
  for_each = { for c in local.fn_name_for_alerts_exceptions : c.name => c }

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
  exceptions
    | where cloud_RoleName == "%s"
    | where outerMessage contains "Exception while executing function: Functions.${each.value.name}"
    | order by timestamp desc
  QUERY
    , "pagopareceiptpdfdatastore" # from HELM's parameter WEBSITE_SITE_NAME
  )
  severity    = 2 // Sev 2	Warning
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }

}

## Alert
# This alert cover the following case:
# 1. BizEventToReceiptProcessor receive a biz event related to a cart (totalNotice > 1)
#
resource "azurerm_monitor_scheduled_query_rules_alert" "receipts-cart-event-discarded-alert" {
  for_each = { for c in local.fn_name_for_alerts_exceptions : c.name => c }

  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-receipt-cart-event-discarded-alert"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[Receipts] biz event related to a cart"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "BizEventToReceiptProcessor received a biz event related to a cart (totalNotice > 1), the event has been discarded"
  enabled        = true
  query = format(<<-QUERY
  traces
    | where cloud_RoleName == "%s"
    | where outerMessage contains "discarded because is part of a payment cart" 
    | order by timestamp desc
  QUERY
    , "pagopareceiptpdfdatastore" # from HELM's parameter WEBSITE_SITE_NAME
  )
  severity    = 2 // Sev 2	Warning
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}
