module "gpd_audit_sa" {
  source = "./.terraform/modules/__v4__/storage_account"

  name                            = replace("${local.project}-audit-sa", "-", "")
  account_kind                    = var.audit_storage_account.account_kind
  account_tier                    = var.audit_storage_account.account_tier
  account_replication_type        = var.audit_storage_account.account_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.audit_storage_account.blob_versioning_enabled
  resource_group_name             = azurerm_resource_group.gpd_rg.name
  location                        = var.location
  advanced_threat_protection      = var.audit_storage_account.advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.audit_storage_account.public_network_access_enabled
  enable_low_availability_alert   = var.audit_storage_account.enable_low_availability_alert

  blob_delete_retention_days = var.audit_storage_account.blob_delete_retention_days

  blob_change_feed_enabled             = var.audit_storage_account.backup_enabled
  blob_change_feed_retention_in_days   = var.audit_storage_account.backup_enabled ? var.audit_storage_account.backup_retention + 1 : null
  blob_container_delete_retention_days = var.audit_storage_account.backup_retention
  blob_storage_policy = {
    enable_immutability_policy = false
    blob_restore_policy_days   = var.audit_storage_account.backup_retention
  }

  tags = module.tag_config.tags
}

resource "azurerm_private_endpoint" "gpd_audit_blob_private_endpoint" {
  count = 1

  name                = format("%s-audit-blob-private-endpoint", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.gpd_rg.name
  subnet_id           = module.storage_account_snet.id

  private_dns_zone_group {
    name                 = "${local.project}-audit-blob-sa-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.storage.id]
  }

  private_service_connection {
    name                           = "${local.project}-audit-blob-sa-private-service-connection"
    private_connection_resource_id = module.gpd_audit_sa.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  tags = module.tag_config.tags

  depends_on = [
    module.gpd_audit_sa
  ]
}

## rtp audit blob container
resource "azurerm_storage_container" "rtp_audit_blob_file" {
  name                 = "rtp-audit"
  storage_account_name = module.gpd_audit_sa.name
}
