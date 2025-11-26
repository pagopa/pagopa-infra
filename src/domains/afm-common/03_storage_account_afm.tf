module "afm_storage" {
  source = "./.terraform/modules/__v3__/storage_account"

  name                            = replace("${local.project}-sa", "-", "")
  account_kind                    = var.afm_storage_params.kind
  account_tier                    = var.afm_storage_params.tier
  account_replication_type        = var.afm_storage_params.account_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = true
  resource_group_name             = azurerm_resource_group.afm_rg.name
  location                        = var.location
  advanced_threat_protection      = var.afm_storage_params.advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.afm_storage_params.public_network_access_enabled

  blob_delete_retention_days = var.afm_storage_params.retention_days

  blob_change_feed_enabled             = var.afm_storage_params.enable_backup
  blob_change_feed_retention_in_days   = var.afm_storage_params.enable_backup ? var.afm_storage_params.backup_retention_days + 1 : null
  blob_container_delete_retention_days = var.afm_storage_params.backup_retention_days
  blob_storage_policy = {
    enable_immutability_policy = false
    blob_restore_policy_days   = var.afm_storage_params.backup_retention_days
  }

  tags = module.tag_config.tags
}

resource "azurerm_storage_table" "issuer_range_table" {
  name                 = "${module.afm_storage.name}issuerrangetable"
  storage_account_name = module.afm_storage.name
}
