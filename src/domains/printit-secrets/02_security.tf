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
  count = var.env_short != "p" ? 1 : 0

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

## ad group policy ##
resource "azurerm_key_vault_access_policy" "adgroup_externals_policy" {
  count = var.env_short != "p" ? 1 : 0

  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_externals.object_id

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

data "azuread_service_principal" "pipe_principal" {
  count        = var.enable_iac_pipeline ? 1 : 0
  display_name = format("pagopaspa-pagoPA-projects-%s", data.azurerm_subscription.current.subscription_id)
}

resource "azurerm_key_vault_access_policy" "azdevops_pipe_policy" {
  count        = var.enable_iac_pipeline ? 1 : 0
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azuread_service_principal.pipe_principal[0].object_id

  secret_permissions      = ["Get", "List", "Set", ]
  certificate_permissions = ["SetIssuers", "DeleteIssuers", "Purge", "List", "Get"]
  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt"]

  storage_permissions = []
}

################
##   Secrets  ##
################

# create json letsencrypt inside kv
# requierd: Docker
module "letsencrypt_printit" {
  source = "git::https://github.com/pagopa/azurerm.git//letsencrypt_credential?ref=v3.8.1"

  prefix            = var.prefix
  env               = var.env_short
  key_vault_name    = "${local.product}-${var.domain}-kv"
  subscription_name = local.subscription_name
}

data "azurerm_cosmosdb_mongo_database" "notices_cosmos_account" {
  name                = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-notices_mongo_db"
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-rg"
}

data "azurerm_storage_account" "notices_storage_sa" {
  name                = "pagopa-${var.env_short}${var.location_short}${var.domain}fnsa"
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-st-rg"
}

data "azurerm_storage_account" "templates_storage_sa" {
  name                = "pagopa-${var.env_short}${var.location_short}${var.domain}fnsa"
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-st-rg"
}

data "azurerm_storage_account" "institutions_storage_sa" {
  name                = "pagopa-${var.env_short}${var.location_short}${var.domain}fnsa"
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-st-rg"
}

data "azurerm_application_insights" "application_insights" {
  name                = "pagopa-${var.env_short}-appinsights"
  resource_group_name = var.monitor_resource_group_name
}

resource "azurerm_key_vault_secret" "cosmos_receipt_connection_string" {
  name         = "cosmos-receipt-connection-string"
  value        = "AccountEndpoint=https://pagopa-${var.env_short}-${var.location_short}-${var.domain}-ds-cosmos-account.documents.azure.com:443/;AccountKey=${data.azurerm_cosmosdb_account.pdf_receipts_cosmos_account.primary_key};"
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}
