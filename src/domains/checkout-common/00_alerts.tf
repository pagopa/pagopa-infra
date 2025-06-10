resource "azurerm_resource_group" "rg_checkout_alerts" {
  count    = var.env_short == "p" ? 1 : 0
  name     = "${local.project}-alerts-rg"
  location = var.location
  tags     = module.tag_config.tags
}

#Checkout auth service internal (without external dependencies) api availability alert
resource "azurerm_monitor_scheduled_query_rules_alert" "checkout_auth_service_v1_internal_api_availability_alert" {
  count = var.env_short == "p" ? 1 : 0

  name                = "checkout-auth-service-v1-internal-api-availability-alert"
  resource_group_name = azurerm_resource_group.rg_checkout_alerts[0].name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.checkout_opsgenie[0].id]
    email_subject          = "[Checkout] Auth service internal API availability alert"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
  description    = "Checkout-auth-service internal API availability less than or equal 99% in the last 30 minutes"
  enabled        = true
  query = (<<-QUERY
AzureDiagnostics
| where url_s startswith 'https://api.platform.pagopa.it/checkout/auth-service/v1'
  and operationId_s != "authenticateWithAuthToken" //exclude POST auth/token api
| summarize
    Total=count(),
    Success=countif(responseCode_d < 500 and DurationMs < 250)
    by Time = bin(TimeGenerated, 15m)
| extend Availability=((Success * 1.0) / Total) * 100
| where Availability < 99
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

#Checkout auth service external (with external dependencies) api availability alert
resource "azurerm_monitor_scheduled_query_rules_alert" "checkout_auth_service_v1_external_api_availability_alert" {
  count = var.env_short == "p" ? 1 : 0

  name                = "checkout-auth-service-v1-external-api-availability-alert"
  resource_group_name = azurerm_resource_group.rg_checkout_alerts[0].name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.checkout_opsgenie[0].id]
    email_subject          = "[Checkout] Auth service external API availability alert"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
  description    = "Checkout-auth-service external API availability less than or equal 95% in the last 30 minutes"
  enabled        = true
  query = (<<-QUERY
AzureDiagnostics
| where url_s startswith 'https://api.platform.pagopa.it/checkout/auth-service/v1'
  and operationId_s == "authenticateWithAuthToken" //include only POST auth/token api
| summarize
    Total=count(),
    Success=countif(responseCode_d < 500 and DurationMs < 500)
    by Time = bin(TimeGenerated, 15m)
| extend Availability=((Success * 1.0) / Total) * 100
| where Availability < 95
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

#Checkout auth service unauthorized percentage alert
resource "azurerm_monitor_scheduled_query_rules_alert" "checkout_auth_service_v1_unauthorized_percentage_alert" {
  count = var.env_short == "p" ? 1 : 0

  name                = "checkout-auth-service-v1-unauthorized-percentage-alert"
  resource_group_name = azurerm_resource_group.rg_checkout_alerts[0].name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.checkout_opsgenie[0].id]
    email_subject          = "[Checkout] Auth service unauthorized api call percentage alert"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
  description    = "Checkout-auth-service unauthorized api call percentage greater than 10% of all api calls in the last 30 minutes"
  enabled        = true
  query = (<<-QUERY
AzureDiagnostics
| where url_s startswith 'https://api.platform.pagopa.it/checkout/auth-service/v1'
| summarize
  Total = count() ,
  UnautorizedCount= countif(responseCode_d == 401)
  by Time = bin(TimeGenerated, 15m)
| extend UnauthorizedPercentage = (UnautorizedCount * 1.0 / Total) * 100
| where UnauthorizedPercentage > 10
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

