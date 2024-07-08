data "azurerm_api_management" "apim" {
  name                = "${local.product}-apim"
  resource_group_name = "${local.product}-api-rg"
}

resource "azurerm_resource_group" "rg_payment_wallet_alerts" {
  count    = var.env_short == "p" ? 1 : 0
  name     = "${local.project}-alerts-rg"
  location = var.location
  tags     = var.tags
}

data "azurerm_key_vault_secret" "monitor_payment_wallet_opsgenie_webhook_key" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "payment-wallet-opsgenie-webhook-token"
  key_vault_id = module.key_vault.id
}

resource "azurerm_monitor_action_group" "payment_wallet_opsgenie" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "PayWalletOpsgenie"
  resource_group_name = azurerm_resource_group.rg_payment_wallet_alerts[0].name
  short_name          = "PayWalletOps"

  webhook_receiver {
    name                    = "PayWalletOpsgenieWebhook"
    service_uri             = "https://api.opsgenie.com/v1/json/azure?apiKey=${data.azurerm_key_vault_secret.monitor_payment_wallet_opsgenie_webhook_key[0].value}"
    use_common_alert_schema = true
  }

  tags = var.tags
}

#Availability API payment wallet for IO app V1
resource "azurerm_monitor_scheduled_query_rules_alert" "payment_wallet_for_io_availability_v1" {
  count = var.env_short == "p" ? 1 : 0

  name                = "payment-wallet-for-io-availability-alert-v1"
  resource_group_name = azurerm_resource_group.rg_payment_wallet_alerts[0].name
  location            = var.location

  action {
    #action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.ecommerce_opsgenie[0].id]
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[payment-wallet-for-IO V1] Availability Alert"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
  description    = "Payment Wallet for IO - Availability less than 99% in the last 30 minutes"
  enabled        = true
  query = (<<-QUERY
AzureDiagnostics
| where url_s startswith 'https://api.platform.pagopa.it/io-payment-wallet/v1'
| summarize
    Total=count(),
    Success=countif(responseCode_d < 500)
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


#Availability API payment wallet for webview V1
resource "azurerm_monitor_scheduled_query_rules_alert" "payment_wallet_for_webview_availability_v1" {
  count = var.env_short == "p" ? 1 : 0

  name                = "payment-wallet-for-webview-availability-alert-v1"
  resource_group_name = azurerm_resource_group.rg_payment_wallet_alerts[0].name
  location            = var.location

  action {
    #action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.ecommerce_opsgenie[0].id]
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[payment-wallet-for-webview V1] Availability Alert"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
  description    = "Payment Wallet for Webview - Availability less than 99% in the last 30 minutes"
  enabled        = true
  query = (<<-QUERY
AzureDiagnostics
| where url_s startswith 'https://api.platform.pagopa.it/webview-payment-wallet/v1'
| summarize
    Total=count(),
    Success=countif(responseCode_d < 500)
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





#Availability API payment wallet for eCommerce V1
resource "azurerm_monitor_scheduled_query_rules_alert" "payment_wallet_for_ecommerce_availability_v1" {
  count = var.env_short == "p" ? 1 : 0

  name                = "payment-wallet-for-ecommerce-availability-alert-v1"
  resource_group_name = azurerm_resource_group.rg_payment_wallet_alerts[0].name
  location            = var.location

  action {
    #action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.ecommerce_opsgenie[0].id]
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[payment-wallet-for-ecommerce V1] Availability Alert"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
  description    = "Payment Wallet for eCommerce V1 - Availability less than 99% in the last 30 minutes"
  enabled        = true
  query = (<<-QUERY
AzureDiagnostics
| where url_s startswith 'https://api.platform.pagopa.it/payment-wallet-for-ecommerce/v1'
| summarize
    Total=count(),
    Success=countif(responseCode_d < 500)
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

#Availability API NPG wallet notification V1
resource "azurerm_monitor_scheduled_query_rules_alert" "payment_wallet_npg_notifications_availability_v1" {
  count = var.env_short == "p" ? 1 : 0

  name                = "payment-wallet-npg-notifications-availability-alert-v1"
  resource_group_name = azurerm_resource_group.rg_payment_wallet_alerts[0].name
  location            = var.location

  action {
    #action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.ecommerce_opsgenie[0].id]
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[payment-wallet-npg-notifications V1] Availability Alert"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
  description    = "Payment Wallet NPG Notifications - Availability less than 99% in the last 30 minutes"
  enabled        = true
  query = (<<-QUERY
AzureDiagnostics
| where url_s startswith 'https://api.platform.pagopa.it/payment-wallet-notifications/v1'
| summarize
    Total=count(),
    Success=countif(responseCode_d < 500)
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

#Availability API wallet outcomes V1
resource "azurerm_monitor_scheduled_query_rules_alert" "payment_wallet_outcomes_availability_v1" {
  count = var.env_short == "p" ? 1 : 0

  name                = "payment-wallet-outcomes-availability-alert-v1"
  resource_group_name = azurerm_resource_group.rg_payment_wallet_alerts[0].name
  location            = var.location

  action {
    #action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.ecommerce_opsgenie[0].id]
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[payment-wallet-outcomes V1] Availability Alert"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_api_management.apim.id
  description    = "Payment Wallet redirection outcomes - Availability less than 99% in the last 30 minutes"
  enabled        = true
  query = (<<-QUERY
AzureDiagnostics
| where url_s startswith 'https://api.platform.pagopa.it/payment-wallet-outcomes/v1'
| summarize
    Total=count(),
    Success=countif(responseCode_d < 500)
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