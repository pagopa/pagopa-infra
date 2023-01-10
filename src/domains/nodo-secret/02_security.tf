resource "azurerm_resource_group" "sec_rg" {
  name     = "${local.product}-${var.domain}-sec-rg"
  location = var.location

  tags = var.tags
}

module "key_vault" {
  source = "git::https://github.com/pagopa/azurerm.git//key_vault?ref=v2.13.1"

  name                       = "${local.product}-${var.domain}-kv"
  location                   = azurerm_resource_group.sec_rg.location
  resource_group_name        = azurerm_resource_group.sec_rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 90

  tags = var.tags
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "ad_group_policy" {
  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_admin.object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt"]
  secret_permissions      = ["Get", "List", "Set", "Delete", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Purge", "Recover", ]
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "adgroup_developers_policy" {
  count = var.env_short == "d" ? 1 : 0

  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_developers.object_id

  key_permissions     = ["Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt"]
  secret_permissions  = ["Get", "List", "Set", "Delete", ]
  storage_permissions = []
  certificate_permissions = [
    "Get", "List", "Update", "Create", "Import",
    "Delete", "Restore", "Purge", "Recover"
  ]
}

# azure devops policy
data "azuread_service_principal" "iac_principal" {
  count        = var.enable_iac_pipeline ? 1 : 0
  display_name = format("pagopaspa-pagoPA-iac-%s", data.azurerm_subscription.current.subscription_id)
}

resource "azurerm_key_vault_access_policy" "azdevops_iac_policy" {
  count        = var.enable_iac_pipeline ? 1 : 0
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azuread_service_principal.iac_principal[0].object_id

  secret_permissions      = ["Get", "List", "Set", ]
  certificate_permissions = ["SetIssuers", "DeleteIssuers", "Purge", "List", "Get"]
  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt"]

  storage_permissions = []
}

###########################
# Porting from init-tf-nodo
###########################

## Create App for use keyvault with access read only
resource "azuread_application" "app_kv" {
  display_name = var.az_nodo_app_kv_ro_policy_name
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_application_password" "app_kv_pwd" {
  application_object_id = azuread_application.app_kv.object_id
}

resource "azuread_service_principal" "sp_kv" {
  application_id               = azuread_application.app_kv.application_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}

## Associate App and sp to key vault
resource "azurerm_key_vault_access_policy" "read_policy" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azuread_service_principal.sp_kv.object_id

  key_permissions         = var.kv-key-permissions-read
  certificate_permissions = var.kv-certificate-permissions-read
  secret_permissions      = var.kv-secret-permissions-read
  storage_permissions     = var.kv-storage-permissions-read
}


## Upload client id and client secret for access to key vault, used from pipeline for create secret on aks 
## (Attention pipeline not use this service principal but another custom or personal account if enabled)
resource "azurerm_key_vault_secret" "client_id" {
  key_vault_id = module.key_vault.id
  name         = "sp-kv-client-id"
  value        = azuread_application.app_kv.application_id

  # depends_on = [azurerm_key_vault_access_policy.owner_policy]
}

resource "azurerm_key_vault_secret" "client_secret" {
  key_vault_id = module.key_vault.id
  name         = "sp-kv-client-secret"
  value        = azuread_application_password.app_kv_pwd.value

  # depends_on = [azurerm_key_vault_access_policy.owner_policy]
}

## Upload storage name id and storage key for access to storage account, used from pipeline for create secret on aks 

resource "azurerm_key_vault_secret" "dev_sa_name" {
  key_vault_id = module.key_vault.id
  name         = "az-storage-account-name"
  value        = module.nodocerts_sa.name

  # depends_on = [azurerm_key_vault_access_policy.owner_policy]
}

resource "azurerm_key_vault_secret" "dev_sa_key" {
  key_vault_id = module.key_vault.id
  name         = "az-storage-account-key"
  value        = module.nodocerts_sa.primary_access_key

  # depends_on = [azurerm_key_vault_access_policy.owner_policy]
}
