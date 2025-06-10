resource "azurerm_resource_group" "sec_rg" {
  name     = format("%s-sec-rg", local.product)
  location = var.location

  tags = module.tag_config.tags
}

module "key_vault" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault?ref=v8.22.0"
  name                = format("%s-kv", local.product)
  location            = azurerm_resource_group.sec_rg.location
  resource_group_name = azurerm_resource_group.sec_rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  tags = module.tag_config.tags
}

# ## api management policy ##
resource "azurerm_key_vault_access_policy" "api_management_policy" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.apim[0].principal_id

  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}

## user assined identity: (application gateway) ##
resource "azurerm_key_vault_access_policy" "app_gateway_public_policy" {
  key_vault_id            = module.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = azurerm_user_assigned_identity.appgateway_public.principal_id
  key_permissions         = ["Get", "List"]
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List", "Purge"]
  storage_permissions     = []
}


## ad group policy ##
resource "azurerm_key_vault_access_policy" "ad_group_policy" {
  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_admin.object_id

  key_permissions     = ["Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt", "Backup", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"]
  secret_permissions  = ["Get", "List", "Set", "Delete", "Restore", "Recover"]
  storage_permissions = []
  certificate_permissions = [
    "Get", "List", "Update", "Create", "Import",
    "Delete", "Restore", "Purge", "Recover"
  ]
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

resource "azurerm_user_assigned_identity" "appgateway_public" {
  resource_group_name = azurerm_resource_group.sec_rg.name
  location            = azurerm_resource_group.sec_rg.location
  name                = format("%s-appgateway-identity", local.product)

  tags = module.tag_config.tags
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
