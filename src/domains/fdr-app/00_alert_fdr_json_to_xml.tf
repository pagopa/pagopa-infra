# AppException during conversion (Last retry)
resource "azurerm_monitor_scheduled_query_rules_alert" "alert_fdr_jsontoxml_appexception_lastretry" {
  count = var.env_short == "p" ? 1 : 0

  name                = "fdr-json-to-xml-app-exception-lastretry"
  resource_group_name = data.azurerm_resource_group.fdr_rg.name
  location            = var.location

  action {
    action_group           = local.action_groups_slack_pagopa_pagamenti_alert
    email_subject          = "[FDR-JSON-TO-XML] Last retry"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Last retry to convert an FdR from JSON to XML. Please, verify the error saved on fdr3conversionerror table storage and use /fdr-json-to-xml/service/v1/errors/{blobName}/retry API to perform manually the operation."
  enabled        = true
  query          = <<-QUERY
     customEvents
      | where name == "FDR_JSON_TO_XML_ALERT"
      | where customDimensions.type == "FDR_JSON_TO_XML_ERROR"
      | order by timestamp desc
  QUERY
  severity       = 1
  frequency      = 15
  time_window    = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}
