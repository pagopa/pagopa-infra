resource "azurerm_resource_group" "nodo_storico_rg" {
  count    = var.env_short == "d" ? 0 : 1
  name     = format("%s-storico-rg", local.project)
  location = var.location

  tags = module.tag_config.tags
}

module "nodo_storico_storage_account" {
  source = "./.terraform/modules/__v3__/storage_account"
  count  = var.env_short == "d" ? 0 : 1

  enable_low_availability_alert = false

  name                            = replace(format("%s-storico-st", local.project), "-", "")
  account_kind                    = var.nodo_storico_storage_account.account_kind
  account_tier                    = var.nodo_storico_storage_account.account_tier
  account_replication_type        = var.nodo_storico_storage_account.account_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.nodo_storico_storage_account.blob_versioning_enabled
  resource_group_name             = azurerm_resource_group.nodo_storico_rg[0].name
  location                        = var.location
  advanced_threat_protection      = var.nodo_storico_storage_account.advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.nodo_storico_storage_account.public_network_access_enabled

  blob_delete_retention_days           = var.nodo_storico_storage_account.blob_delete_retention_days
  blob_change_feed_enabled             = var.nodo_storico_storage_account.backup_enabled
  blob_change_feed_retention_in_days   = var.nodo_storico_storage_account.backup_enabled ? var.nodo_storico_storage_account.backup_retention + 1 : null
  blob_container_delete_retention_days = var.nodo_storico_storage_account.backup_retention
  blob_storage_policy = {
    enable_immutability_policy = false
    blob_restore_policy_days   = var.nodo_storico_storage_account.backup_retention
  }

  network_rules = {
    default_action             = "Deny"
    bypass                     = ["AzureServices"]
    ip_rules                   = var.nodo_storico_allowed_ips
    virtual_network_subnet_ids = [data.azurerm_subnet.private_endpoint_snet.id]
  }

  tags = module.tag_config.tags
}

resource "azurerm_private_endpoint" "nodo_storico_private_endpoint" {
  count = var.env_short == "d" ? 0 : 1

  name                = format("%s-storico-private-endpoint", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.nodo_storico_rg[0].name
  subnet_id           = data.azurerm_subnet.private_endpoint_snet.id

  private_dns_zone_group {
    name                 = "${local.project}-backupstorage-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_azure_com.id]
  }

  private_service_connection {
    name                           = "${local.project}-backupstorage-private-service-connection"
    private_connection_resource_id = module.nodo_storico_storage_account[0].id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  tags = module.tag_config.tags

  depends_on = [
    module.nodo_storico_storage_account
  ]
}

# blob container#1 nodo-storico
resource "azurerm_storage_container" "storico_container" {
  count                 = var.env_short == "d" ? 0 : 1
  name                  = "storico"
  storage_account_name  = module.nodo_storico_storage_account[0].name
  container_access_type = "private"
}
