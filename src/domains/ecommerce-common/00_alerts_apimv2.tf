


# Availability: ecommerce for checkout
data "azurerm_api_management" "apim_v2" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "${local.product}-weu-core-apim-v2"
  resource_group_name = local.pagopa_apim_rg
}

resource "azurerm_monitor_scheduled_query_rules_alert" "ecommerce_for_checkout_availability-v2" {
  count = var.env_short == "p" ? 1 : 0

  name                = "ecommerce-for-checkout-availability-alert-v2"
  resource_group_name = azurerm_resource_group.rg_ecommerce_alerts[0].name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.ecommerce_opsgenie[0].id]
    email_subject          = "[eCommerce] Availability Alert"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim_v2[0].id
  description    = "eCommerce Availability less than or equal 99%"
  enabled        = true
  query = (<<-QUERY
AzureDiagnostics
| where url_s startswith 'https://api.platform.pagopa.it/ecommerce/checkout/'
| summarize
    Total=count(),
    Success=countif(responseCode_d < 500 or url_s startswith "https://api.platform.pagopa.it/ecommerce/checkout/v1/payment-requests" and ( responseCode_d == 502 or responseCode_d == 504))
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



# eCommerce transaction service: KO for PATCH auth requests
resource "azurerm_monitor_scheduled_query_rules_alert" "ecommerce_transactions_service_auth_request_ko-v2" {
  count = var.env_short == "p" ? 1 : 0

  name                = "ecommerce-transactions-service-auth-request-ko-v2"
  resource_group_name = azurerm_resource_group.rg_ecommerce_alerts[0].name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.ecommerce_opsgenie[0].id]
    email_subject          = "[eCommerce] Transactions service PATCH auth request KO"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim_v2[0].id
  description    = "eCommerce Transactions service PATCH auth request KO detected, more than 10 KO in 30 minute time window"
  enabled        = true
  query = (<<-QUERY
AzureDiagnostics
| where url_s startswith "https://api.platform.pagopa.it/ecommerce/transaction-auth-requests-service/v1/transactions/"
| where method_s == "PATCH"
| where responseCode_d >= 500
| project TimeGenerated, responseCode_d
  QUERY
  )
  severity    = 1
  frequency   = 30
  time_window = 30
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 10
  }
}

# eCommerce transaction service: KO for POST user-receipts (sendPaymentResultV2)
resource "azurerm_monitor_scheduled_query_rules_alert" "ecommerce_transactions_service_user_receipts_ko-v2" {
  count = var.env_short == "p" ? 1 : 0

  name                = "ecommerce-transactions-service-user-receipts-ko-v2"
  resource_group_name = azurerm_resource_group.rg_ecommerce_alerts[0].name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.ecommerce_opsgenie[0].id]
    email_subject          = "[eCommerce] Transactions service POST user receipts (sendPaymentResultV2) KO"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim_v2[0].id
  description    = "eCommerce Transactions service POST user receipts KO detected, more than 10 KO in 30 minutes time window"
  enabled        = true
  query = (<<-QUERY
AzureDiagnostics
| where url_s endswith "?clientId=ecomm" and (url_s startswith "https://api.platform.pagopa.it/payment-manager/pm-per-nodo/v2/transactions/" or url_s startswith "https://api.platform.pagopa.it/receipt-ndp/v1/transactions/")
| where method_s == "POST"
| where set_has_element(dynamic([400, 404, 408, 422]), responseCode_d)
| project TimeGenerated, responseCode_d
  QUERY
  )
  severity    = 1
  frequency   = 30
  time_window = 30
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 60 // NDP for each requests does 5 retries with a 2 minutes interval after a 10 minutes delay
  }
}


# eCommerce NPG monitoring: KO or slow payment methods start session api call (order/build retrieve card form fields)
resource "azurerm_monitor_scheduled_query_rules_alert" "ecommerce_payment_methods_start_session_alert-v2" {
  count = var.env_short == "p" ? 1 : 0

  name                = "ecommerce-payment-methods-start-session-alert-v2"
  resource_group_name = azurerm_resource_group.rg_ecommerce_alerts[0].name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[eCommerce] NPG order/build KO/slow api detected"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim_v2[0].id
  description    = "eCommerce Payment methods service POST session KO/slow api detected, more than 10 KO or above 2 seconds as response time in 30 minutes time window"
  enabled        = true
  query = (<<-QUERY
AzureDiagnostics
| where url_s matches regex "https://api.platform.pagopa.it/ecommerce/checkout/v1/payment-methods/.*/sessions"
| where method_s == "POST"
| where responseCode_d != 200 or DurationMs > 2000
| project TimeGenerated, responseCode_d, DurationMs
  QUERY
  )
  severity    = 1
  frequency   = 30
  time_window = 30
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 10
  }
}

# eCommerce NPG monitoring: KO on POST notification (callback api to receive authorization outcome)
resource "azurerm_monitor_scheduled_query_rules_alert" "ecommerce_authorization_outcome_notification_alert-v2" {
  count = var.env_short == "p" ? 1 : 0

  name                = "ecommerce-authorization-outcome-notification-alert-v2"
  resource_group_name = azurerm_resource_group.rg_ecommerce_alerts[0].name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[eCommerce] NPG POST notification KO api detected"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim_v2[0].id
  description    = "eCommerce POST notification KO detected, more than 10 KO in 30 minutes time window"
  enabled        = true
  query = (<<-QUERY
AzureDiagnostics
| where url_s matches regex "https://api.platform.pagopa.it/ecommerce/npg/notifications/v1/sessions/.*/outcomes"
| where method_s == "POST"
| where responseCode_d != 200
| project TimeGenerated, responseCode_d
  QUERY
  )
  severity    = 1
  frequency   = 30
  time_window = 30
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 10
  }
}
