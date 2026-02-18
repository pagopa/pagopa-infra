resource "azurerm_resource_group" "nodo_cfg_sync_rg" {
  name     = "${local.project}-cfg-sync-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "nodo_cfg_sync_re_storage_account" {
  source = "./.terraform/modules/__v4__/storage_account"

  name                            = replace(format("%s-cfg-syn-re-st", local.project), "-", "")
  account_kind                    = var.nodo_cfg_sync_storage_account.account_kind
  account_tier                    = var.nodo_cfg_sync_storage_account.account_tier
  account_replication_type        = var.nodo_cfg_sync_storage_account.account_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.nodo_cfg_sync_storage_account.blob_versioning_enabled
  resource_group_name             = azurerm_resource_group.nodo_cfg_sync_rg.name
  location                        = var.location
  advanced_threat_protection      = var.nodo_cfg_sync_storage_account.advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.nodo_cfg_sync_storage_account.public_network_access_enabled

  blob_delete_retention_days = var.nodo_cfg_sync_storage_account.blob_delete_retention_days

  blob_change_feed_enabled             = var.nodo_cfg_sync_storage_account.backup_enabled
  blob_change_feed_retention_in_days   = var.nodo_cfg_sync_storage_account.backup_enabled ? var.nodo_cfg_sync_storage_account.backup_retention_days + 1 : null
  blob_container_delete_retention_days = var.nodo_cfg_sync_storage_account.backup_retention_days
  blob_storage_policy = {
    enable_immutability_policy = false
    blob_restore_policy_days   = var.nodo_cfg_sync_storage_account.backup_retention_days
  }

  tags = module.tag_config.tags
}

resource "azurerm_private_endpoint" "nodo_cfg_sync_re_private_endpoint_container" {
  count = var.env_short == "d" ? 0 : 1

  name                = "${local.project}-cfg-sync-re-private-endpoint-container"
  location            = var.location
  resource_group_name = azurerm_resource_group.nodo_cfg_sync_rg.name
  subnet_id           = data.azurerm_subnet.private_endpoint_snet.id

  private_dns_zone_group {
    name                 = "${local.project}-cfg-sync-re-private-dns-zone-group-container"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_azure_com.id]
  }

  private_service_connection {
    name                           = "${local.project}-cfg-sync-re-private-service-connection-container"
    private_connection_resource_id = module.nodo_cfg_sync_re_storage_account.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  tags = module.tag_config.tags

  depends_on = [
    module.nodo_cfg_sync_re_storage_account
  ]
}

# table nodo-cfg-sync
resource "azurerm_storage_container" "nodo_cfg_sync_re_cache_container" {
  name                 = "cacheevents"
  storage_account_name = module.nodo_cfg_sync_re_storage_account.name

  depends_on = [
    module.nodo_cfg_sync_re_storage_account
  ]
}

resource "azurerm_storage_container" "nodo_cfg_sync_re_stand_in_container" {
  name                 = "standinevents"
  storage_account_name = module.nodo_cfg_sync_re_storage_account.name

  depends_on = [
    module.nodo_cfg_sync_re_storage_account
  ]
}
