locals {

  message_prefixes = var.env_short == "p" ? {
    "FDR-E1" = {
      description   = "Error while sending to EventHub."
      email_subject = "FdR to EventHub common error FDR-E1"
    },
    "FDR-E2" = {
      description   = "Error while process XML Blob."
      email_subject = "FdR to EventHub common error FDR-E2"
    },
    "FDR1-E1" = {
      description   = "Error processing Blob in processFDR1BlobFiles function"
      email_subject = "FdR to EventHub error FDR1-E1"
    }
  } : {}
}

resource "azurerm_monitor_scheduled_query_rules_alert" "alert-fdr-2-event-hub-exception" {
  count = var.env_short == "p" ? 1 : 0

  name                = "fdr-2-event-hub-alert-exception"
  resource_group_name = data.azurerm_resource_group.fdr_rg.name
  location            = var.location

  action {
    action_group  = local.action_groups
    email_subject = "FdR to EventHub Exception while processing function"
    custom_webhook_payload = jsonencode({
      queryResult = <<-QUERY
        exceptions
        | where timestamp > ago(5m)
        | where cloud_RoleName == 'pagopafdrtoeventhub'
        | summarize count() by outerType
      QUERY
    })
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "FdR to EventHub Exception while processing function"
  enabled        = true
  query = (<<-QUERY
            exceptions
            | where timestamp > ago(10m)
            | where cloud_RoleName == 'pagopafdrtoeventhub'
            | summarize Total=count() by length=bin(timestamp,5m)
          QUERY
  )
  severity    = 1
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "alert" {
  for_each = local.message_prefixes

  name                = "fdr-2-event-hub-alert-${each.key}-common-error"
  resource_group_name = data.azurerm_resource_group.fdr_rg.name
  location            = var.location

  action {
    action_group  = local.action_groups
    email_subject = each.value.email_subject
    custom_webhook_payload = jsonencode({
      queryResult = <<-QUERY
        traces
        | where timestamp > ago(5m)
        | where cloud_RoleName == 'pagopafdrtoeventhub'
        | where message startswith "${each.key}"
        | limit 1
        | project message
      QUERY
    })
  }

  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = each.value.description
  enabled        = true
  query          = <<-QUERY
            traces
            | where timestamp > ago(5m)
            | where cloud_RoleName == 'pagopafdrtoeventhub'
            | where message startswith "${each.key}"
            | summarize Total=count() by length=bin(timestamp,5m)
          QUERY
  severity       = 1
  frequency      = 5
  time_window    = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}
