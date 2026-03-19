module "domain_key_vault_secrets_query" {
  source = "./.terraform/modules/__v4__/key_vault_secrets_query"

  key_vault_name = module.key_vault.name
  resource_group = module.key_vault.resource_group_name

  secrets = [
    "alert-error-notification-email"
  ]
}



data "azurerm_key_vault_secret" "apim_publisher_email" {
  name         = "apim-publisher-email"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_certificate" "app_gw_platform" {
  name         = var.integration_app_gateway_api_certificate_name
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_certificate" "portal_platform" {
  name         = var.integration_app_gateway_portal_certificate_name
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_certificate" "management_platform" {
  name         = var.integration_app_gateway_management_certificate_name
  key_vault_id = module.key_vault.id
}


data "azurerm_key_vault_secret" "fn_checkout_key" {
  name         = "fn-checkout-key"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "google_recaptcha_secret" {
  name         = "google-recaptcha-secret"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "fn_buyerbanks_key" {
  name         = "fn-buyerbanks-key"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "pm_gtw_hostname" {
  name         = "pm-gtw-hostname"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "pm_onprem_hostname" {
  name         = "pm-onprem-hostname"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "pm_host" {
  name         = "pm-host"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "pm_host_prf" {
  name         = "pm-host-prf"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_certificate" "app_gw_platform_prf" {
  count        = (var.dns_zone_prefix_prf == "") ? 0 : 1
  name         = var.integration_app_gateway_prf_certificate_name
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_certificate" "wisp2" {
  name         = var.app_gateway_wisp2_certificate_name
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_certificate" "wisp2govit" {
  count = (var.app_gateway_wisp2govit_certificate_name == "") ? 0 : 1

  name         = var.app_gateway_wisp2govit_certificate_name
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_certificate" "wfespgovit" {
  count        = (var.app_gateway_wfespgovit_certificate_name == "") ? 0 : 1
  name         = var.app_gateway_wfespgovit_certificate_name
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_certificate" "app_gw_platform_upload" {
  name         = var.app_gateway_upload_certificate_name
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "certificate_crt_node_forwarder" {
  name         = "certificate-crt-node-forwarder"
  key_vault_id = module.key_vault.id
}
data "azurerm_key_vault_secret" "certificate_key_node_forwarder" {
  name         = "certificate-key-node-forwarder"
  key_vault_id = module.key_vault.id
}


data "azurerm_key_vault_secret" "monitor_notification_email" {
  name         = "monitor-notification-email"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "monitor_notification_slack_email" {
  name         = "monitor-notification-slack-email"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "monitor_mo_notification_email" {
  name         = "monitor-mo-notification-email"
  key_vault_id = module.key_vault.id
}

# DEPRECATED use opsgenie-webhook-token
data "azurerm_key_vault_secret" "monitor_new_conn_srv_webhook_key" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "new-conn-srv-opsgenie-webhook-token"
  key_vault_id = module.key_vault.id
}


#
# Alerts
#
data "azurerm_key_vault_secret" "alert_error_notification_email" {
  name         = "alert-error-notification-email"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "alert_error_notification_slack" {
  name         = "alert-error-notification-slack"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "alert_cert_pipeline_status_notification_slack" {
  name         = "alert-cert-pipeline-status-notification-slack"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "monitor_pm_opsgenie_webhook_key" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "pm-opsgenie-webhook-token"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "sec_workspace_id" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "sec-workspace-id"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "sec_storage_id" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "sec-storage-id"
  key_vault_id = module.key_vault.id
}

# INFRA OpsGenie PagoPA_Azure_infra webhook key
data "azurerm_key_vault_secret" "opsgenie_infra_webhook_key" {
  count = var.env_short == "p" ? 1 : 0
  name  = "opsgenie-infra-webhook-token"

  key_vault_id = module.key_vault.id
}

# pagoPA - Service Management and Operation - Reperibilità_SMO → https://pagopa.atlassian.net/wiki/x/TgA9XQ
data "azurerm_key_vault_secret" "opsgenie_smo_webhook_key" {
  count = var.env_short == "p" ? 1 : 0
  name  = "opsgenie-smo-webhook-token"

  key_vault_id = module.key_vault.id
}
