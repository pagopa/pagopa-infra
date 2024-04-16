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

## ad group policy ##
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

# data "azurerm_eventhub_authorization_rule" "notices_evt_authorization_rule" {
#   name                = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-notice-evt-rx"
#   resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-msg-rg"
#   eventhub_name       = "${var.prefix}-printit-evh"
#   namespace_name      = "${var.prefix}-${var.env_short}-weu-core-evh-ns04"
# }

# data "azurerm_eventhub_authorization_rule" "notices_complete_evt_authorization_rule" {
#   name                = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-notice-complete-evt-tx"
#   resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-msg-rg"
#   eventhub_name       = "${var.prefix}-printit-evh"
#   namespace_name      = "${var.prefix}-${var.env_short}-weu-core-evh-ns04"
# }

# data "azurerm_eventhub_authorization_rule" "notices_error_evt_authorization_rule" {
#   name                = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-notice-error-evt-tx"
#   resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-msg-rg"
#   eventhub_name       = "${var.prefix}-printit-evh"
#   namespace_name      = "${var.prefix}-${var.env_short}-weu-core-evh-ns04"
# }

data "azurerm_cosmosdb_account" "notices_cosmos_account" {
  name                = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-cosmos-account"
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-db-rg"
}

data "azurerm_storage_account" "notices_storage_sa" {
  name                = replace("${var.domain}-notices", "-", "")
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-rg"
}

data "azurerm_storage_account" "templates_storage_sa" {
  name                = replace("${var.domain}-templates", "-", "")
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-rg"
}

data "azurerm_storage_account" "institutions_storage_sa" {
  name                = replace("${var.domain}-institutions", "-", "")
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-rg"
}

data "azurerm_application_insights" "application_insights" {
  name                = "pagopa-${var.env_short}-appinsights"
  resource_group_name = var.monitor_resource_group_name
}

resource "azurerm_key_vault_secret" "notices_mongo_connection_string" {
  name         = "notices-mongo-connection-string"
  value        = "AccountEndpoint=https://pagopa-${var.env_short}-${var.location_short}-${var.domain}-ds-cosmos-account.documents.azure.com:443/;AccountKey=${data.azurerm_cosmosdb_account.notices_cosmos_account.primary_key};"
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "notices_mongo_primary_key" {
  name         = "notices-mongo-primary-key"
  value        = data.azurerm_cosmosdb_account.notices_cosmos_account.primary_key
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "notices_storage_account_connection_string" {
  name         = "notices-storage-account-connection-string"
  value        = data.azurerm_storage_account.notices_storage_sa.primary_connection_string
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}
#
resource "azurerm_key_vault_secret" "notices_storage_account_pkey" {
  name         = "notices-storage-account-pkey"
  value        = data.azurerm_storage_account.notices_storage_sa.primary_access_key
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "templates_storage_account_connection_string" {
  name         = "templates-storage-account-connection-string"
  value        = data.azurerm_storage_account.templates_storage_sa.primary_connection_string
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "templates_storage_account_pkey" {
  name         = "templates-storage-account-pkey"
  value        = data.azurerm_storage_account.templates_storage_sa.primary_access_key
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "institutions_storage_account_connection_string" {
  name         = "institutions-storage-account-connection-string"
  value        = data.azurerm_storage_account.institutions_storage_sa.primary_connection_string
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "institutions_storage_account_pkey" {
  name         = "institutions-storage-account-pkey"
  value        = data.azurerm_storage_account.institutions_storage_sa.primary_access_key
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}

# resource "azurerm_key_vault_secret" "ehub_notice_connection_string" {
#   name         = format("ehub-%s-notice-connection-string", var.env_short)
#   value        = data.azurerm_eventhub_authorization_rule.notices_evt_authorization_rule.primary_connection_string
#   content_type = "text/plain"
#   key_vault_id = module.key_vault.id
# }
#
# resource "azurerm_key_vault_secret" "ehub_notice_complete_connection_string" {
#   name         = format("ehub-%s-notice-complete-connection-string", var.env_short)
#   value        = data.azurerm_eventhub_authorization_rule.notices_complete_evt_authorization_rule.primary_connection_string
#   content_type = "text/plain"
#   key_vault_id = module.key_vault.id
# }
#
# resource "azurerm_key_vault_secret" "ehub_notice_error_connection_string" {
#   name         = format("ehub-%s-notice-error-connection-string", var.env_short)
#   value        = data.azurerm_eventhub_authorization_rule.notices_error_evt_authorization_rule.primary_connection_string
#   content_type = "text/plain"
#
#   key_vault_id = module.key_vault.id
# }
