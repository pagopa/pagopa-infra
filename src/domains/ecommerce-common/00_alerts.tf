resource "azurerm_resource_group" "rg_ecommerce_alerts" {
  count    = var.env_short == "p" ? 1 : 0
  name     = "${local.project}-alerts-rg"
  location = var.location
  tags     = var.tags
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

  tags = var.tags
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
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.ecommerce_opsgenie[0].id]
    email_subject          = "[eCommerce] Availability Alert"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
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
| extend Watermark=99
| project Watermark, Availability, Time
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
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.ecommerce_opsgenie[0].id]
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
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.ecommerce_opsgenie[0].id]
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
