resource "azurerm_resource_group" "sec_rg" {
  name     = format("%s-sec-rg", local.project)
  location = var.location

  tags = var.tags
}

# Create Key Vault
module "key_vault" {
  source              = "git::https://github.com/pagopa/azurerm.git//key_vault?ref=v1.0.7"
  name                = format("%s-kv", local.project)
  location            = azurerm_resource_group.sec_rg.location
  resource_group_name = azurerm_resource_group.sec_rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  tags = var.tags
}

#
# POLICIES
#

data "azuread_group" "adgroup_admin" {
  display_name = format("%s-adgroup-admin", local.project)
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "adgroup_admin_policy" {
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

data "azuread_group" "adgroup_contributors" {
  display_name = format("%s-adgroup-contributors", local.project)
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "adgroup_contributors_policy" {
  count        = (var.env_short == "d" || var.env_short == "u") ? 1 : 0
  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_contributors.object_id

  key_permissions     = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions  = ["Get", "List", "Set", "Delete", ]
  storage_permissions = []
  certificate_permissions = [
    "Get", "List", "Update", "Create", "Import",
    "Delete", "Restore", "Purge", "Recover"
  ]
}

# fixme
# data "azurerm_key_vault_secret" "apim_publisher_email" {
#   name         = "apim-publisher-email"
#   key_vault_id = module.key_vault.id
# }

# fixme
# data "azurerm_key_vault_certificate" "app_gw_io_cstar" {
#   count        = var.app_gateway_api_io_certificate_name != null ? 1 : 0
#   name         = var.app_gateway_api_io_certificate_name
#   key_vault_id = module.key_vault.id
# }

# data "azurerm_key_vault_certificate" "app_gw_cstar" {
#   name         = var.app_gateway_api_certificate_name
#   key_vault_id = module.key_vault.id
# }

# data "azurerm_key_vault_certificate" "portal_cstar" {
#   name         = var.app_gateway_portal_certificate_name
#   key_vault_id = module.key_vault.id
# }

# data "azurerm_key_vault_certificate" "management_cstar" {
#   name         = var.app_gateway_management_certificate_name
#   key_vault_id = module.key_vault.id
# }
