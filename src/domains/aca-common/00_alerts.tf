data "azurerm_api_management" "apim" {
  name                = "${local.product}-apim"
  resource_group_name = "${local.product}-api-rg"
}

resource "azurerm_resource_group" "rg_aca_alerts" {
  count    = var.env_short == "p" ? 1 : 0
  name     = "${local.project}-alerts-rg"
  location = var.location
  tags     = module.tag_config.tags
}

resource "azurerm_monitor_scheduled_query_rules_alert" "debt_positions_for_aca_availability_v1" {
  count = var.env_short == "p" ? 1 : 0

  name                = "debt-positions-for-aca-availability-alert-v1"
  resource_group_name = azurerm_resource_group.rg_aca_alerts[0].name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id]
    email_subject          = "[GPD for ACA V1] Availability Alert"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
  description    = "GPD for ACA V1 - Availability less than 90% in the last 30 minutes"
  enabled        = true
  query = (<<-QUERY
AzureDiagnostics
| where url_s startswith "https://api.platform.pagopa.it/aca/debt-positions-service/v1"
| summarize
    Total=count(),
    Success=countif(
        responseCode_d < 500
    )
    by Time = bin(TimeGenerated, 15m)
| extend Availability=((Success * 1.0) / Total) * 100
| where toint(Availability) < 90
  QUERY
  )
  severity    = 1
  frequency   = 30
  time_window = 30
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 2
  }
}
