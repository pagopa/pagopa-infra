locals {
  fdr_xmltojson = {
    last_retry_query = format(<<-QUERY
    exceptions
      | where cloud_RoleName == "%s"
      | where message contains "[ALERT][FdrXmlToJson][LAST_RETRY]"
      | order by timestamp desc
      | summarize Total=count() by length=bin(timestamp,1m)
      | order by length desc
  QUERY
      , "pagopafdrxmltojson-queuetrigger"
    )
  }
}

# AppException during conversion (Last retry)
resource "azurerm_monitor_scheduled_query_rules_alert" "alert_fdr_xmltojson_appexception_lastretry" {
  count               = (var.enable_fdr3_features && var.env_short == "p") ? 1 : 0
  name                = "fdr-xml-to-json-app-exception-lastretry"
  resource_group_name = data.azurerm_resource_group.fdr_rg.name
  location            = var.location

  action {
    action_group           = local.action_groups_slack_pagopa_pagamenti_alert
    email_subject          = "[FDR-XML-TO-JSON] Last retry"
    custom_webhook_payload = local.fdr_xmltojson.last_retry_query
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Last retry to convert an FdR from XML to JSON. Please, verify the error saved on fdr1conversion table storage and use /fdr-xml-to-json/service/v1/xmlerror API to perform manually the operation."
  enabled        = true
  query = local.fdr_xmltojson.last_retry_query
  severity    = 1
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}
