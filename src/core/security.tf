resource "azurerm_resource_group" "sec_rg" {
  name     = format("%s-sec-rg", local.project)
  location = var.location

  tags = var.tags
}

module "key_vault" {
  source              = "git::https://github.com/pagopa/azurerm.git//key_vault?ref=v1.0.90"
  name                = format("%s-kv", local.project)
  location            = azurerm_resource_group.sec_rg.location
  resource_group_name = azurerm_resource_group.sec_rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  tags = var.tags
}

# ## api management policy ##
resource "azurerm_key_vault_access_policy" "api_management_policy" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.enabled_features.apim_migrated ? data.azurerm_api_management.apim_migrated[0].identity[0].principal_id : module.apim[0].principal_id

  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}

## user assined identity: (application gateway) ##
resource "azurerm_key_vault_access_policy" "app_gateway_policy" {
  key_vault_id            = module.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = azurerm_user_assigned_identity.appgateway.principal_id
  key_permissions         = ["Get", "List"]
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List", "Purge"]
  storage_permissions     = []
}

# Azure AD
data "azuread_group" "adgroup_admin" {
  display_name = format("%s-adgroup-admin", local.project)
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "ad_group_policy" {
  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_admin.object_id

  key_permissions     = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions  = ["Get", "List", "Set", "Delete", ]
  storage_permissions = []
  certificate_permissions = [
    "Get", "List", "Update", "Create", "Import",
    "Delete", "Restore", "Purge", "Recover"
  ]
}

data "azuread_group" "adgroup_developers" {
  display_name = format("%s-adgroup-developers", local.project)
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "adgroup_developers_policy" {
  count = var.env_short != "p" ? 1 : 0

  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_developers.object_id

  key_permissions     = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions  = ["Get", "List", "Set", "Delete", ]
  storage_permissions = []
  certificate_permissions = [
    "Get", "List", "Update", "Create", "Import",
    "Delete", "Restore", "Purge", "Recover"
  ]
}

data "azuread_group" "adgroup_externals" {
  display_name = format("%s-adgroup-externals", local.project)
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "adgroup_externals_policy" {
  count = var.env_short == "d" ? 1 : 0

  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_externals.object_id

  key_permissions     = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions  = ["Get", "List", "Set", "Delete", ]
  storage_permissions = []
  certificate_permissions = [
    "Get", "List", "Update", "Create", "Import",
    "Delete", "Restore", "Purge", "Recover"
  ]
}

data "azuread_group" "adgroup_security" {
  display_name = format("%s-adgroup-security", local.project)
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "adgroup_security_policy" {
  count = var.env_short == "d" ? 1 : 0

  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_security.object_id

  key_permissions     = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions  = ["Get", "List", "Set", "Delete", ]
  storage_permissions = []
  certificate_permissions = [
    "Get", "List", "Update", "Create", "Import",
    "Delete", "Restore", "Purge", "Recover"
  ]
}

resource "azurerm_user_assigned_identity" "appgateway" {
  resource_group_name = azurerm_resource_group.sec_rg.name
  location            = azurerm_resource_group.sec_rg.location
  name                = format("%s-appgateway-identity", local.project)

  tags = var.tags
}

data "azurerm_key_vault_certificate" "app_gw_platform" {
  name         = var.app_gateway_api_certificate_name
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_certificate" "app_gw_platform_upload" {
  name         = var.app_gateway_upload_certificate_name
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_certificate" "app_gw_platform_prf" {
  count = (var.dns_zone_prefix_prf == "") ? 0 : 1

  name         = var.app_gateway_prf_certificate_name
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_certificate" "portal_platform" {
  name         = var.app_gateway_portal_certificate_name
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_certificate" "management_platform" {
  name         = var.app_gateway_management_certificate_name
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
data "azurerm_key_vault_certificate" "kibana" {
  name         = var.app_gateway_kibana_certificate_name
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "apim_publisher_email" {
  name         = "apim-publisher-email"
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

data "azurerm_key_vault_secret" "fn_checkout_key" {
  name         = "fn-checkout-key"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "fn_buyerbanks_key" {
  name         = "fn-buyerbanks-key"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "google_recaptcha_secret" {
  name         = "google-recaptcha-secret"
  key_vault_id = module.key_vault.id
}

## azure cdn frontdoor ##
## remember to do this: https://docs.microsoft.com/it-it/azure/frontdoor/standard-premium/how-to-configure-https-custom-domain#register-azure-front-door
# data "azuread_service_principal" "azure_cdn_frontdoor" {
#   application_id = "205478c0-bd83-4e1b-a9d6-db63a3e1e1c8"
# }

resource "azurerm_key_vault_access_policy" "azure_cdn_frontdoor_policy" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.azuread_service_principal_azure_cdn_frontdoor_id

  secret_permissions = [
    "Get",
  ]

  certificate_permissions = [
    "Get",
  ]
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

data "azurerm_key_vault_secret" "db_nodo_usr" {
  name         = "db-nodo-usr"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "db_nodo_pwd" {
  name         = "db-nodo-pwd"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "apiconfig-client-secret" {
  name         = "apiconfig-client-secret"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "gpd_payments_apiconfig_subkey" {
  name         = "gpd-payments-apiconfig-subkey"
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

data "azurerm_key_vault_secret" "monitor_pm_opsgenie_webhook_key" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "pm-opsgenie-webhook-token"
  key_vault_id = module.key_vault.id
}


# DEPRECATED use opsgenie-webhook-token
data "azurerm_key_vault_secret" "monitor_new_conn_srv_webhook_key" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "new-conn-srv-opsgenie-webhook-token"
  key_vault_id = module.key_vault.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "newconn_opsgenie_webhook_token" {
  name         = "new-conn-srv-opsgenie-webhook-token"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "team_core_opsgenie_webhook_token" {
  name         = "opsgenie-webhook-token"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}
#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
# GITHUB_TOKEN_READ_PACKAGES_BOT
resource "azurerm_key_vault_secret" "github_token_read_packages_bot" {
  name         = "github-token-read-packages-bot"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}
