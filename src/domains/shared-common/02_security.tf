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

resource "azurerm_key_vault_secret" "iuv_generator_cosmos_connection_string" {
  name = "iuv-generator-cosmos-primary-connection-string"
  // the array is related to the input box in the following section https://portal.azure.com/#@pagopait.onmicrosoft.com/resource/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-weu-shared-rg/providers/Microsoft.DocumentDB/databaseAccounts/pagopa-d-weu-shared-iuv-gen-cosmos-account/tableKeys
  // the 4th input box is the PRIMARY CONNECTION STRING
  value        = module.iuvgenerator_cosmosdb_account.connection_strings[4]
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "notifications_service_sa_connection_string" {
  name         = "notifications-service-sa-connection-string"
  value        = module.notifications_service_storage.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "notifications_service_ai_instrumentation_key" {
  name         = "notifications-service-ai-instrumentation-key"
  value        = data.azurerm_application_insights.application_insights.instrumentation_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}