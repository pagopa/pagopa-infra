resource "azurerm_monitor_scheduled_query_rules_alert" "fdr_1_exception_alert" {
  count = var.env_short == "p" ? 1 : 0

  name                = "fdr-2-event-hub-alert-fdr-1-error"
  resource_group_name = data.azurerm_resource_group.fdr_rg.name
  location            = var.location

  action {
    action_group           = local.action_groups_opsgenie
    email_subject          = "FdR to EventHub error FDR1"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Error processing Blob in processFDR1BlobFiles function"
  enabled        = true
  query          = <<-QUERY
     customEvents
      | where name == "FDR_TO_EVH_ALERT"
      | where customDimensions.type == "FDR1-E1"
      | order by timestamp desc
  QUERY
  severity       = 0
  frequency      = 5
  time_window    = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "fdr_3_exception_alert" {
  count = var.env_short == "p" ? 1 : 0

  name                = "fdr-2-event-hub-alert-fdr-3-error"
  resource_group_name = data.azurerm_resource_group.fdr_rg.name
  location            = var.location

  action {
    action_group           = local.action_groups_opsgenie
    email_subject          = "FdR to EventHub error FDR3"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Error processing Blob in processFDR3BlobFiles function"
  enabled        = true
  query          = <<-QUERY
     customEvents
      | where name == "FDR_TO_EVH_ALERT"
      | where customDimensions.type == "FDR3-E1"
      | order by timestamp desc
  QUERY
  severity       = 0
  frequency      = 5
  time_window    = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}
