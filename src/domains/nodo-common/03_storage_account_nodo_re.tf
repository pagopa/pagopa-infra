data "azurerm_resource_group" "nodo_re_to_datastore_rg" {
  count = var.enable_nodo_re || var.env_short != "d" ? 1 : 0


  name = format("%s-re-to-datastore-rg", local.project)
}

module "nodo_re_storage_account" {
  count  = var.enable_nodo_re ? 1 : 0
  source = "./.terraform/modules/__v3__/storage_account"

  name                            = replace(format("%s-re-2-data-st", local.project), "-", "")
  account_kind                    = var.nodo_re_storage_account.account_kind
  account_tier                    = var.nodo_re_storage_account.account_tier
  account_replication_type        = var.nodo_re_storage_account.account_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.nodo_re_storage_account.blob_versioning_enabled
  resource_group_name             = data.azurerm_resource_group.nodo_re_to_datastore_rg[0].name
  location                        = var.location
  advanced_threat_protection      = var.nodo_re_storage_account.advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.nodo_re_storage_account.public_network_access_enabled

  blob_delete_retention_days = var.nodo_re_storage_account.blob_delete_retention_days

  blob_change_feed_enabled             = var.nodo_re_storage_account.backup_enabled
  blob_change_feed_retention_in_days   = var.nodo_re_storage_account.backup_enabled ? var.nodo_re_storage_account.backup_retention : null
  blob_container_delete_retention_days = var.nodo_re_storage_account.backup_retention
  blob_storage_policy = {
    enable_immutability_policy = false
    blob_restore_policy_days   = var.nodo_re_storage_account.backup_retention
  }

  tags = module.tag_config.tags
}

resource "azurerm_private_endpoint" "nodo_re_private_endpoint" {
  count = var.env_short == "d" ? 0 : var.enable_nodo_re ? 1 : 0

  name                = "${local.project}-re-private-endpoint"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.nodo_re_to_datastore_rg[0].name
  subnet_id           = data.azurerm_subnet.private_endpoint_snet.id

  private_dns_zone_group {
    name                 = "${local.project}-re-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_table_azure_com.id]
  }

  private_service_connection {
    name                           = "${local.project}-re-private-service-connection"
    private_connection_resource_id = var.enable_nodo_re ? module.nodo_re_storage_account[0].id : "https://private/connection/fake/path"
    is_manual_connection           = false
    subresource_names              = ["table"]
  }

  tags = module.tag_config.tags

  depends_on = [
    module.nodo_re_storage_account
  ]
}

# table#1 nodo-re
resource "azurerm_storage_table" "nodo_re_table" {
  count                = var.enable_nodo_re ? 1 : 0
  name                 = "events"
  storage_account_name = module.nodo_re_storage_account[0].name
}
