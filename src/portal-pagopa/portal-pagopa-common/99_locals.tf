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
    NEXT_PUBLIC_APP_URL                 = var.next_public_app_url
    AUTH_URL                            = var.next_public_app_url
    AWS_REGION                          = var.aws_region
    EMAIL_FALLBACK_PROVIDER             = var.email_fallback_provider
    EMAIL_FROM                          = var.email_from
    EMAIL_PROVIDER                      = var.email_provider
    EMAIL_PUBLIC_APP_URL                = var.email_public_app_url
    GITHUB_ISSUES_OWNER                 = var.github_issues_owner
    GITHUB_ISSUES_REPO                  = var.github_issues_repo
    ONEMAIL_BASE_URL                    = var.onemail_base_url
    ONEMAIL_ENV                         = var.onemail_env
    ONEMAIL_FROM_EMAIL                  = var.onemail_from_email
    ONEMAIL_TENANT_NAME                 = var.onemail_tenant_name
    PLAYWRIGHT_TEST                     = tostring(var.playwright_test)
    TIMETRACK_EMAIL_DISABLE_SEND        = tostring(var.timetrack_email_disable_send)
    TIMETRACK_EMAIL_FORCE_TO            = var.timetrack_email_force_to
    TIMETRACK_ONEMAIL_FROM_EMAIL        = var.timetrack_onemail_from_email
    TRAINING_EMAIL_DISABLE_SEND         = tostring(var.training_email_disable_send)
    TRAINING_EMAIL_FORCE_TO             = var.training_email_force_to
    TRAINING_ONEMAIL_FROM_EMAIL         = var.training_onemail_from_email
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = tostring(var.websites_enable_app_service_storage)
    WEBSITES_PORT                       = tostring(var.websites_port)
  }

  app_settings = merge(local.app_settings_secret_refs, local.database_url_secret_ref, local.app_settings_plain)
}
