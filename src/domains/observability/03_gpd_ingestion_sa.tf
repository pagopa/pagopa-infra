# gpd_rg
resource "azurerm_resource_group" "gpd_ingestion_rg" {
  name     = "${local.project_itn}-gpd-rg"
  location = var.location_itn

  tags = module.tag_config.tags
}

module "gpd_ingestion_sa" {
  source = "./.terraform/modules/__v4__/storage_account"

  name                            = replace(format("%s-gpd-ingest-sa", local.product), "-", "")
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  account_replication_type        = var.gpd_ingestion_storage_account.account_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.gpd_ingestion_storage_account.blob_versioning_enabled
  resource_group_name             = azurerm_resource_group.gpd_ingestion_rg.name
  location                        = var.location_itn
  advanced_threat_protection      = var.gpd_ingestion_storage_account.advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.gpd_ingestion_storage_account.public_network_access_enabled
  enable_low_availability_alert   = false

  blob_delete_retention_days = var.gpd_ingestion_storage_account.blob_delete_retention_days

  blob_change_feed_enabled             = var.gpd_ingestion_storage_account.backup_enabled
  blob_change_feed_retention_in_days   = var.gpd_ingestion_storage_account.backup_enabled ? var.gpd_ingestion_storage_account.backup_retention + 1 : null
  blob_container_delete_retention_days = var.gpd_ingestion_storage_account.backup_retention
  blob_storage_policy = {
    enable_immutability_policy = false
    blob_restore_policy_days   = var.gpd_ingestion_storage_account.backup_retention
  }

  tags = module.tag_config.tags
}
