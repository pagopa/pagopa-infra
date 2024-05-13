# Exception FdR Fase3 - Internal APIs
resource "azurerm_monitor_scheduled_query_rules_alert" "alert_fdr_internal_availability" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "fdr-internal-app-exception"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id]
    email_subject          = "FdR Internal - Error"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Availability for /fdr-internal/service is less than or equal to 99% - [DASHBOARD LINK]"
  enabled        = true
  query = (<<-QUERY
      let threshold = 0.99;
      AzureDiagnostics
      | where url_s matches regex "/fdr-internal/service/"
      | summarize
          Total=count(),
          Success=count(responseCode_d < 500)
          by bin(TimeGenerated, 5m)
      | extend availability=toreal(Success) / Total
      | where availability < threshold
    QUERY
  )
  severity    = 3
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

# Exception FdR Fase3 - PSP APIs
resource "azurerm_monitor_scheduled_query_rules_alert" "alert_fdr_psp_availability" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "fdr-psp-app-exception"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id]
    email_subject          = "FdR PSP - Error"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Availability for /fdr-psp/service is less than or equal to 99% - [DASHBOARD LINK]"
  enabled        = true
  query = (<<-QUERY
      let threshold = 0.99;
      AzureDiagnostics
      | where url_s matches regex "/fdr-psp/service/"
      | summarize
          Total=count(),
          Success=count(responseCode_d < 500)
          by bin(TimeGenerated, 5m)
      | extend availability=toreal(Success) / Total
      | where availability < threshold
    QUERY
  )
  severity    = 3
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

# Exception FdR Fase3 - Organizations APIs
resource "azurerm_monitor_scheduled_query_rules_alert" "alert_fdr_org_availability" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "fdr-org-app-exception"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id]
    email_subject          = "FdR Orgs - Error"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Availability for /fdr-org/service is less than or equal to 99% - [DASHBOARD LINK]"
  enabled        = true
  query = (<<-QUERY
      let threshold = 0.99;
      AzureDiagnostics
      | where url_s matches regex "/fdr-org/service/"
      | summarize
          Total=count(),
          Success=count(responseCode_d < 500)
          by bin(TimeGenerated, 5m)
      | extend availability=toreal(Success) / Total
      | where availability < threshold
    QUERY
  )
  severity    = 3
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

