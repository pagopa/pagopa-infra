resource "azurerm_resource_group" "data" {
  name     = format("%s-data-rg", local.product)
  location = var.location

  tags = module.tag_config.tags
}


# Storage account to store backups: mainly api management
module "backupstorage" {
  count  = var.env_short == "p" ? 1 : 0
  source = "./.terraform/modules/__v4__/storage_account"

  name                            = replace(format("%s-backupstorage", local.product), "-", "")
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  account_replication_type        = var.backup_storage_replication_type
  access_tier                     = "Cool"
  blob_versioning_enabled         = true
  resource_group_name             = azurerm_resource_group.data.name
  location                        = var.location
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true


  tags = module.tag_config.tags
}

resource "azurerm_private_endpoint" "backup_blob_private_endpoint" {
  count = var.env_short == "p" ? 1 : 0

  name                = format("%s-backup-blob-private-endpoint", local.product)
  location            = var.location
  resource_group_name = azurerm_resource_group.data.name
  subnet_id           = module.common_private_endpoint_snet.id

  private_dns_zone_group {
    name                 = "${local.product}-backup-blob-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_core_windows_net.id]
  }

  private_service_connection {
    name                           = "${local.project}-bakcup-blob-private-service-connection"
    private_connection_resource_id = module.backupstorage[0].id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  tags = module.tag_config.tags

  depends_on = [
    module.backupstorage
  ]
}

resource "azurerm_storage_container" "apim_backup" {
  count                 = var.env_short == "p" ? 1 : 0
  name                  = "apim"
  storage_account_name  = module.backupstorage[0].name
  container_access_type = "private"
}

resource "azurerm_storage_management_policy" "backups" {
  count              = var.env_short == "p" ? 1 : 0
  storage_account_id = module.backupstorage[0].id

  rule {
    name    = "deleteafterdays"
    enabled = true
    filters {
      prefix_match = [azurerm_storage_container.apim_backup[0].name]
      blob_types   = ["blockBlob", "appendBlob"]
    }
    actions {
      version {
        delete_after_days_since_creation = 20
      }
    }
  }
}
