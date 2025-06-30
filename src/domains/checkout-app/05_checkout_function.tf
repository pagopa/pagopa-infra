resource "azurerm_resource_group" "checkout_be_rg" {
  count    = var.checkout_enabled ? 1 : 0
  name     = format("%s-checkout-be-rg", local.parent_project)
  location = var.location

  tags = module.tag_config.tags
}

# Availability: Checkout functions & pagopa-proxy
resource "azurerm_monitor_scheduled_query_rules_alert" "checkout_availability" {
  count = var.checkout_enabled && var.env_short == "p" ? 1 : 0

  name                = format("%s-availability-alert", format("%s-fn-checkout", local.parent_project))
  resource_group_name = azurerm_resource_group.checkout_be_rg[0].name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id]
    email_subject          = "Checkout Availability - pagopa-proxy"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
  description    = "Checkout Availability less than 99%"
  enabled        = true
  query = (<<-QUERY
AzureDiagnostics
| where url_s startswith 'https://api.platform.pagopa.it/checkout/auth/payments/v2/payment-requests/'
| summarize
    Total=count(),
    Success=countif(responseCode_d < 500 or responseCode_d == 502 or responseCode_d == 504)
    by Time = bin(TimeGenerated, 15m)
| extend Availability=((Success * 1.0) / Total) * 100
| where toint(Availability) < 90
  QUERY
  )
  severity    = 1
  frequency   = 30
  time_window = 30
  trigger {
    operator  = "GreaterThan"
    threshold = 2
  }
}
