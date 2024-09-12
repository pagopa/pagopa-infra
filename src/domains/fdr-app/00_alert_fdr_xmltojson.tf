# AppException during conversion
resource "azurerm_monitor_scheduled_query_rules_alert" "alert_fdr_xmltojson_appexception" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "${module.fdr_xml_to_json_function.name}-app-exception"
  resource_group_name = data.azurerm_resource_group.fdr_rg.name
  location            = var.location

  action {
    action_group           = local.action_groups_sev3
    email_subject          = "AppException on FdR's XML-to-JSON conversion"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "An AppException occurred during the conversion of FdR from XML to JSON"
  enabled        = true
  query = format(<<-QUERY
    traces
      | where cloud_RoleName == "%s"
      | where message contains "[ALERT][FdrXmlToJson]"
      | order by timestamp desc
      | summarize Total=count() by length=bin(timestamp,1m)
      | order by length desc
  QUERY
    , module.fdr_xml_to_json_function.name
  )
  severity    = 3
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

# AppException during conversion (Last retry)
resource "azurerm_monitor_scheduled_query_rules_alert" "alert_fdr_xmltojson_appexception_lastretry" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "${module.fdr_xml_to_json_function.name}-app-exception-lastretry"
  resource_group_name = data.azurerm_resource_group.fdr_rg.name
  location            = var.location

  action {
    action_group           = local.action_groups
    email_subject          = "AppException on FdR's XML-to-JSON conversion"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Last retry to convert an FdR from XML to JSON. Verify that the event specified in the log is saved properly, otherwise use /xmlerror API to manually perform the operation."
  enabled        = true
  query = format(<<-QUERY
    traces
      | where cloud_RoleName == "%s"
      | where message contains "[ALERT][FdrXmlToJson][LAST_RETRY]"
      | order by timestamp desc
      | summarize Total=count() by length=bin(timestamp,1m)
      | order by length desc
  QUERY
    , module.fdr_xml_to_json_function.name
  )
  severity    = 1
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}