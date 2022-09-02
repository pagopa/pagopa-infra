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
  lock_enable                = true

  # Logs
  sec_log_analytics_workspace_id = var.env_short == "p" ? data.terraform_remote_state.core.outputs.sec_workspace_id : null
  sec_storage_id                 = var.env_short == "p" ? data.terraform_remote_state.core.outputs.sec_storage_id : null

  tags = var.tags
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "ad_group_policy" {
  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_admin.object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", ]
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

  key_permissions     = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions  = ["Get", "List", "Set", "Delete", ]
  storage_permissions = []
  certificate_permissions = [
    "Get", "List", "Update", "Create", "Import",
    "Delete", "Restore", "Purge", "Recover"
  ]
}

resource "azurerm_key_vault_secret" "afm_marketplace_cosmos_pkey" {
  name         = format("afm-marketplace-%s-cosmos-pkey", var.env_short)
  value        = module.afm_marketplace_cosmosdb_account.primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "ai_connection_string" {
  name         = format("ai-%s-connection-string", var.env_short)
  value        = data.terraform_remote_state.core.outputs.application_insights_instrumentation_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}
