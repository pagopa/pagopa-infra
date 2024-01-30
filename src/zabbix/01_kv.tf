resource "azurerm_resource_group" "sec_rg" {
  count = var.enabled_resource.zabbix_kv_enabled ? 1 : 0

  name     = "${local.product}-${var.domain}-sec-rg"
  location = var.location

  tags = var.tags
}

module "key_vault" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault?ref=v7.35.1"
  count  = var.enabled_resource.zabbix_kv_enabled ? 1 : 0

  name                       = "${local.product}-${var.domain}-kv"
  location                   = azurerm_resource_group.sec_rg[0].location
  resource_group_name        = azurerm_resource_group.sec_rg[0].name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 90

  tags = var.tags
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "ad_group_policy" {
  count = var.enabled_resource.zabbix_kv_enabled ? 1 : 0

  key_vault_id = module.key_vault[0].id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_admin.object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt"]
  secret_permissions      = ["Get", "List", "Set", "Delete", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Purge", "Recover", ]
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "adgroup_developers_policy" {
  count = var.enabled_resource.zabbix_kv_enabled ? 1 : 0

  key_vault_id = module.key_vault[0].id

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
  count = var.enabled_resource.zabbix_kv_enabled ? 1 : 0

  key_vault_id = module.key_vault[0].id

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
