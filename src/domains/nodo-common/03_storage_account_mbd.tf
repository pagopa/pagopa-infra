resource "azurerm_resource_group" "mbd_rg" {
  name     = "${local.project}-mbd-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "mbd_storage_account" {
  source = "./.terraform/modules/__v3__/storage_account"

  name                            = replace(format("%s-mbd-st", local.project), "-", "")
  account_kind                    = var.mbd_storage_account.account_kind
  account_tier                    = var.mbd_storage_account.account_tier
  account_replication_type        = var.mbd_storage_account.account_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.mbd_storage_account.blob_versioning_enabled
  resource_group_name             = azurerm_resource_group.mbd_rg.name
  location                        = var.location
  advanced_threat_protection      = var.mbd_storage_account.advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.mbd_storage_account.public_network_access_enabled
  use_legacy_defender_version     = var.mbd_storage_account.use_legacy_defender_version

  blob_delete_retention_days = var.mbd_storage_account.blob_delete_retention_days

  blob_change_feed_enabled             = var.mbd_storage_account.backup_enabled
  blob_change_feed_retention_in_days   = var.mbd_storage_account.backup_enabled ? var.mbd_storage_account.backup_retention_days + 1 : null
  blob_container_delete_retention_days = var.mbd_storage_account.backup_retention_days
  blob_storage_policy = {
    enable_immutability_policy = false
    blob_restore_policy_days   = var.mbd_storage_account.backup_retention_days
  }

  tags = module.tag_config.tags

  depends_on = [
    azurerm_resource_group.mbd_rg
  ]
}

resource "azurerm_storage_share" "firmatore_mbd" {
  name                 = "firmatore"
  storage_account_name = module.mbd_storage_account.name
  quota                = 50
}

