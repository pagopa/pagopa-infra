resource "azurerm_resource_group" "rg_ecommerce_alerts" {
  count    = var.env_short == "p" ? 1 : 0
  name     = "${local.project}-alerts-rg"
  location = var.location
  tags     = module.tag_config.tags
}

data "azurerm_key_vault_secret" "monitor_ecommerce_opsgenie_webhook_key" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "ecommerce-opsgenie-webhook-token"
  key_vault_id = module.key_vault.id
}

resource "azurerm_monitor_action_group" "ecommerce_opsgenie" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "EcomOpsgenie"
  resource_group_name = azurerm_resource_group.rg_ecommerce_alerts[0].name
  short_name          = "EcomOpsgenie"

  webhook_receiver {
    name                    = "EcommerceOpsgenieWebhook"
    service_uri             = "https://api.opsgenie.com/v1/json/azure?apiKey=${data.azurerm_key_vault_secret.monitor_ecommerce_opsgenie_webhook_key[0].value}"
    use_common_alert_schema = true
  }

  tags = module.tag_config.tags
}

data "azurerm_key_vault_secret" "monitor_service_management_ecommerce_opsgenie_webhook_key" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "service-management-opsgenie-webhook-token"
  key_vault_id = module.key_vault.id
}

resource "azurerm_monitor_action_group" "service_management_opsgenie" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "EcomServiceManagementOpsgenie"
  resource_group_name = azurerm_resource_group.rg_ecommerce_alerts[0].name
  short_name          = "EcomSMOpsgen"

  webhook_receiver {
    name                    = "EcommerceServiceManagementOpsgenieWebhook"
    service_uri             = "https://api.opsgenie.com/v1/json/azure?apiKey=${data.azurerm_key_vault_secret.monitor_service_management_ecommerce_opsgenie_webhook_key[0].value}"
    use_common_alert_schema = true
  }

  tags = module.tag_config.tags
}

# Availability: ecommerce for checkout
data "azurerm_api_management" "apim" {
  name                = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

resource "azurerm_monitor_scheduled_query_rules_alert" "ecommerce_for_checkout_availability" {
  count = var.env_short == "p" ? 1 : 0

  name                = "ecommerce-for-checkout-availability-alert"
  resource_group_name = azurerm_resource_group.rg_ecommerce_alerts[0].name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.ecommerce_opsgenie[0].id, azurerm_monitor_action_group.service_management_opsgenie[0].id]
    email_subject          = "[eCommerce] Availability Alert"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
  description    = "eCommerce Availability less than or equal 99%"
  enabled        = true
  query = (<<-QUERY
let thresholdTrafficMin = 150;
let thresholdTrafficLinear = 400;
let lowTrafficAvailability = 96;
let highTrafficAvailability = 99;
let thresholdDelta = thresholdTrafficLinear - thresholdTrafficMin;
let availabilityDelta = highTrafficAvailability - lowTrafficAvailability;
AzureDiagnostics
| where url_s startswith 'https://api.platform.pagopa.it/ecommerce/checkout/'
| summarize
    Total=count(),
    Success=countif(responseCode_d < 500 or (operationId_s in ("getPaymentRequestInfo", "getPaymentRequestInfoV3") and responseCode_d in (502, 504)))
    by Time = bin(TimeGenerated, 15m)
| extend trafficUp = Total-thresholdTrafficMin
| extend deltaRatio = todouble(todouble(trafficUp)/todouble(thresholdDelta))
| extend expectedAvailability = iff(Total >= thresholdTrafficLinear, toreal(highTrafficAvailability), iff(Total <= thresholdTrafficMin, toreal(lowTrafficAvailability), (deltaRatio*(availabilityDelta))+lowTrafficAvailability))
| extend Availability=((Success * 1.0) / Total) * 100
| where Availability < expectedAvailability
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
resource "azurerm_monitor_scheduled_query_rules_alert" "ecommerce_transactions_service_auth_request_ko" {
  count = var.env_short == "p" ? 1 : 0

  name                = "ecommerce-transactions-service-auth-request-ko"
  resource_group_name = azurerm_resource_group.rg_ecommerce_alerts[0].name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.ecommerce_opsgenie[0].id, azurerm_monitor_action_group.service_management_opsgenie[0].id]
    email_subject          = "[eCommerce] Transactions service PATCH auth request KO"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
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
resource "azurerm_monitor_scheduled_query_rules_alert" "ecommerce_transactions_service_user_receipts_ko" {
  count = var.env_short == "p" ? 1 : 0

  name                = "ecommerce-transactions-service-user-receipts-ko"
  resource_group_name = azurerm_resource_group.rg_ecommerce_alerts[0].name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.ecommerce_opsgenie[0].id, azurerm_monitor_action_group.service_management_opsgenie[0].id]
    email_subject          = "[eCommerce] Transactions service POST user receipts (sendPaymentResultV2) KO"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
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

# eCommerce Payment method handler monitoring: KO or slow payment methods api call (GMP getAllPaymentMethods)
resource "azurerm_monitor_scheduled_query_rules_alert" "ecommerce_payment_methods_alert" {
  count = var.env_short == "p" ? 1 : 0

  name                = "ecommerce-payment-methods-alert"
  resource_group_name = azurerm_resource_group.rg_ecommerce_alerts[0].name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.ecommerce_opsgenie[0].id, azurerm_monitor_action_group.service_management_opsgenie[0].id]
    email_subject          = "[eCommerce] POST get all payment-methods KO/slow api detected"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
  description    = "eCommerce Payment methods handler service POST get all payment methods KO/slow api detected, more than 10 KO or above 250 ms as response time in 30 minutes time window"
  enabled        = true
  query = (<<-QUERY
AzureDiagnostics
| where url_s == "https://api.platform.pagopa.it/ecommerce/checkout/v2/payment-methods"
| where method_s == "POST"
| where responseCode_d != 200 or DurationMs > 250
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


# eCommerce NPG monitoring: KO or slow payment methods start session api call (order/build retrieve card form fields)
resource "azurerm_monitor_scheduled_query_rules_alert" "ecommerce_payment_methods_start_session_alert" {
  count = var.env_short == "p" ? 1 : 0

  name                = "ecommerce-payment-methods-start-session-alert"
  resource_group_name = azurerm_resource_group.rg_ecommerce_alerts[0].name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[eCommerce] NPG order/build KO/slow api detected"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
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
resource "azurerm_monitor_scheduled_query_rules_alert" "ecommerce_authorization_outcome_notification_alert" {
  count = var.env_short == "p" ? 1 : 0

  name                = "ecommerce-authorization-outcome-notification-alert"
  resource_group_name = azurerm_resource_group.rg_ecommerce_alerts[0].name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[eCommerce] NPG POST notification KO api detected"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
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

# eCommerce for app IO V2 availability
resource "azurerm_monitor_scheduled_query_rules_alert" "ecommerce_for_app_io_v2_availability_alert" {
  count = var.env_short == "p" ? 1 : 0

  name                = "ecommerce-for-app-io-v2-availability-alert"
  resource_group_name = azurerm_resource_group.rg_ecommerce_alerts[0].name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[eCommerce] api for app IO V2 availability less that 99%"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
  description    = "eCommerce api for app IO V2 availability less than 99% in the last 30 minutes detected"
  enabled        = true
  query = (<<-QUERY
let thresholdTrafficMin = 200;
let thresholdTrafficLinear = 500;
let lowTrafficAvailability = 94;
let highTrafficAvailability = 98;
let thresholdDelta = thresholdTrafficLinear - thresholdTrafficMin;
let availabilityDelta = highTrafficAvailability - lowTrafficAvailability;
AzureDiagnostics
| where url_s startswith 'https://api.platform.pagopa.it/ecommerce/io/v2'
| summarize
    Total=count(),
    Success=countif(responseCode_d < 500 and DurationMs < 10000)
    by Time = bin(TimeGenerated, 15m)
| extend trafficUp = Total-thresholdTrafficMin
| extend deltaRatio = todouble(todouble(trafficUp)/todouble(thresholdDelta))
| extend expectedAvailability = iff(Total >= thresholdTrafficLinear, toreal(highTrafficAvailability), iff(Total <= thresholdTrafficMin, toreal(lowTrafficAvailability), (deltaRatio*(availabilityDelta))+lowTrafficAvailability))
| extend Availability=((Success * 1.0) / Total) * 100
| where Availability < expectedAvailability
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

# eCommerce user stats last payment method put availability
resource "azurerm_monitor_scheduled_query_rules_alert" "ecommerce_user_stats_last_payment_method_put_availability_alert" {
  count = var.env_short == "p" ? 1 : 0

  name                = "ecommerce-user-stats-last-payment-method-put-availability-alert"
  resource_group_name = azurerm_resource_group.rg_ecommerce_alerts[0].name
  location            = var.location

  action {
    action_group  = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject = "[eCommerce] User stats service - PUT lastPaymentMethodUsed availability less that 99%"
    custom_webhook_payload = jsonencode({
      //alert properties https://docs.opsgenie.com/docs/alert-api
      "message"  = "[eCommerce] User stats service - PUT lastPaymentMethodUsed availability less that 99%"
      "alias"    = "ecommerce-user-stats-last-payment-method-put-availability-alert"
      "tags"     = "availability"
      "entity"   = "eCommerce"
      "priority" = "P3"
    })
  }
  data_source_id = data.azurerm_api_management.apim.id
  description    = "eCommerce User stats service PUT lastPaymentMethodUsed availability less that 99%"
  enabled        = true
  query = (<<-QUERY
AzureDiagnostics
| where url_s startswith 'https://api.platform.pagopa.it/ecommerce/user-stats-service/v1/user/lastPaymentMethodUsed'
| where method_s == "PUT"
| summarize
    Total=count(),
    Success=countif(responseCode_d < 400 and DurationMs < 250)
    by Time = bin(TimeGenerated, 15m)
| extend Availability=((Success * 1.0) / Total) * 100
| where toint(Availability) < 99
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

resource "azurerm_monitor_scheduled_query_rules_alert" "ecommerce_notifications_service_availability" {
  count = var.env_short == "p" ? 1 : 0

  name                = "ecommerce-notifications-service-availability-alert"
  resource_group_name = azurerm_resource_group.rg_ecommerce_alerts[0].name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.ecommerce_opsgenie[0].id, azurerm_monitor_action_group.service_management_opsgenie[0].id]
    email_subject          = "[eCommerce] Notifications service Availability Alert"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
  description    = "eCommerce notifications service Availability less than or equal 99%"
  enabled        = true
  query = (<<-QUERY
let thresholdTrafficMin = 100;
let thresholdTrafficLinear = 500;
let lowTrafficAvailability = 97;
let highTrafficAvailability = 99;
let thresholdDelta = thresholdTrafficLinear - thresholdTrafficMin;
let availabilityDelta = highTrafficAvailability - lowTrafficAvailability;
AzureDiagnostics
| where url_s == 'https://api.platform.pagopa.it/ecommerce/notifications-service/v1/emails'
| summarize
    Total=count(),
    Success=countif(responseCode_d < 500)
    by Time = bin(TimeGenerated, 15m)
| extend trafficUp = Total-thresholdTrafficMin
| extend deltaRatio = todouble(todouble(trafficUp)/todouble(thresholdDelta))
| extend expectedAvailability = iff(Total >= thresholdTrafficLinear, toreal(highTrafficAvailability), iff(Total <= thresholdTrafficMin, toreal(lowTrafficAvailability), (deltaRatio*(availabilityDelta))+lowTrafficAvailability))
| extend Availability=((Success * 1.0) / Total) * 100
| where Availability < expectedAvailability
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



resource "azurerm_monitor_scheduled_query_rules_alert" "ecommerce_payment_requests_service_availability" {
  count = var.env_short == "p" ? 1 : 0

  name                = "ecommerce-payment-requests-service-availability-alert"
  resource_group_name = azurerm_resource_group.rg_ecommerce_alerts[0].name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.ecommerce_opsgenie[0].id, azurerm_monitor_action_group.service_management_opsgenie[0].id]
    email_subject          = "[eCommerce] Payment requests service availability less than 99% in the last 30 minutes"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
  description    = "Payment requests service availability less than or equal 99% in the last 30 minutes"
  enabled        = true
  #TO DO: tuning alert thresholds based 503 status code
  query = (<<-QUERY
AzureDiagnostics
| where url_s startswith "https://api.platform.pagopa.it/ecommerce/payment-requests-service/v1/payment-requests" and method_s == "GET"
| summarize
    Total=count(),
    Success=countif(responseCode_d < 500 or responseCode_d == 502 or responseCode_d == 504 or responseCode_d == 503)
    by Time = bin(TimeGenerated, 15m)
| extend availability=(toreal(Success) / Total) * 100
| where availability < 99
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

resource "azurerm_monitor_scheduled_query_rules_alert" "ecommerce_webview_v1_availability_alert" {
  count = var.env_short == "p" ? 1 : 0

  name                = "ecommerce-webview-v1-availability-alert"
  resource_group_name = azurerm_resource_group.rg_ecommerce_alerts[0].name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[eCommerce] webview api v1 availability alert"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
  description    = "eCommerce webview api's Availability less than or equal 99%"
  enabled        = true
  query = (<<-QUERY
let thresholdTrafficMin = 100;
let thresholdTrafficLinear = 500;
let lowTrafficAvailability = 97;
let highTrafficAvailability = 99;
let thresholdDelta = thresholdTrafficLinear - thresholdTrafficMin;
let availabilityDelta = highTrafficAvailability - lowTrafficAvailability;
AzureDiagnostics
| where url_s startswith 'https://api.platform.pagopa.it/ecommerce/webview/v1'
| summarize
    Total=count(),
    Success=countif(responseCode_d < 500)
    by Time = bin(TimeGenerated, 15m)
| extend trafficUp = Total-thresholdTrafficMin
| extend deltaRatio = todouble(todouble(trafficUp)/todouble(thresholdDelta))
| extend expectedAvailability = iff(Total >= thresholdTrafficLinear, toreal(highTrafficAvailability), iff(Total <= thresholdTrafficMin, toreal(lowTrafficAvailability), (deltaRatio*(availabilityDelta))+lowTrafficAvailability))
| extend Availability=((Success * 1.0) / Total) * 100
| where Availability < expectedAvailability
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

resource "azurerm_monitor_scheduled_query_rules_alert" "ecommerce_io_payment_with_not_onboarded_card_outcome_availability" {
  count = var.env_short == "p" ? 1 : 0

  name                = "ecommerce-io-payment-with-not-onboarded-card-outcome-availability"
  resource_group_name = azurerm_resource_group.rg_ecommerce_alerts[0].name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[eCommerce] IO payment flow - payment with not onboarded card outcome availability alert"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
  description    = "eCommerce for IO - payment with not onboarded card  - card data insertion webview result outcome success rate less than 90%"
  enabled        = true
  query = (<<-QUERY
AzureDiagnostics
| where ResourceType == "APPLICATIONGATEWAYS"
    and OperationName == "ApplicationGatewayAccess"
    and (requestUri_s startswith "/ecommerce/io-outcomes/v1/payments/cards/outcomes")
    and (requestQuery_s contains "outcome")
| extend outcome = tostring(parse_urlquery(requestQuery_s)["Query Parameters"]["outcome"])
| summarize
    Total=count(),
    Success=countif(outcome == "0")
    by Time = bin(TimeGenerated, 15m)
| extend Availability=((Success * 1.0) / Total) * 100
| where Availability < 90
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

resource "azurerm_monitor_scheduled_query_rules_alert" "ecommerce_io_payment_with_contextual_onboarding_outcome_availability" {
  count = var.env_short == "p" ? 1 : 0

  name                = "ecommerce-io-payment-with-contextual-onboarding-outcome-availability"
  resource_group_name = azurerm_resource_group.rg_ecommerce_alerts[0].name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[eCommerce] IO payment flow - payment with contextual onboarding outcome availability alert"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
  description    = "eCommerce for IO - payment with contextual onboarding - wallet creation webview result outcome success rate less than 90%"
  enabled        = true
  query = (<<-QUERY
AzureDiagnostics
| where ResourceType == "APPLICATIONGATEWAYS"
    and OperationName == "ApplicationGatewayAccess"
    and (requestUri_s startswith "/payment-wallet-outcomes/v1/wallets/contextual-onboard/outcomes")
    and (requestQuery_s contains "outcome")
| extend outcome = tostring(parse_urlquery(requestQuery_s)["Query Parameters"]["outcome"])
| summarize
    Total=count(),
    Success=countif(outcome == "0")
    by Time = bin(TimeGenerated, 15m)
| extend Availability=((Success * 1.0) / Total) * 100
| where Availability < 90
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