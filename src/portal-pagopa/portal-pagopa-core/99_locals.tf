locals {
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product = "${var.prefix}-${var.env_short}"
  domain  = var.domain

  spoke_data_vnet_name                = "${local.product}-${var.location_short}-spoke-data-vnet"
  spoke_data_vnet_resource_group_name = "${local.product}-${var.location_short}-network-hub-spoke-rg"

  log_analytics_workspace_name                = "${local.product}-${var.location_short}-core-law"
  log_analytics_workspace_resource_group_name = "${local.product}-${var.location_short}-core-monitor-rg"

  monitor_action_group_email_name = "PagoPA"
  monitor_action_group_slack_name = "SlackPagoPA"
  key_vault_name                  = "${local.product}-${var.location_short}-${var.domain}-kv"
  key_vault_resource_group_name   = "${local.product}-${var.location_short}-${var.domain}-sec-rg"

  acr_name                = replace("${local.product}commonacr", "-", "")
  acr_resource_group_name = "${local.product}-container-registry-rg"

  app_settings_secret_refs = {
    for setting_name, secret_name in var.app_secret_names :
    setting_name => "@Microsoft.KeyVault(SecretUri=${data.azurerm_key_vault_secret.portal_app[setting_name].versionless_id})"
  }

  database_url_secret_ref = {
    DATABASE_URL = "@Microsoft.KeyVault(SecretUri=${azurerm_key_vault_secret.portal_database_url.versionless_id})"
  }

  app_settings_plain = {
    NEXT_PUBLIC_APP_URL = var.next_public_app_url
    EMAIL_FROM          = var.email_from
    PLAYWRIGHT_TEST     = tostring(var.playwright_test)
    WEBSITES_PORT       = tostring(var.websites_port)
  }

  app_settings = merge(local.app_settings_secret_refs, local.database_url_secret_ref, local.app_settings_plain)
}

