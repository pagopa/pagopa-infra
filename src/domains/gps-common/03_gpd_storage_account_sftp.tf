module "gpd_sa_sftp" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v7.18.0"

  name                = replace("${local.project}-gpd-sa-sftp", "-", "")
  resource_group_name = azurerm_resource_group.gpd_rg.name
  location            = azurerm_resource_group.gpd_rg.location

  public_network_access_enabled = var.gpd_sftp_sa_public_network_access_enabled
  is_sftp_enabled               = true
  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  account_replication_type      = var.gpd_sftp_sa_replication_type
  access_tier                   = var.gpd_sftp_sa_access_tier

  is_hns_enabled             = true
  advanced_threat_protection = true
  # should be false when sftp is enabled, ref:https://learn.microsoft.com/en-us/azure/storage/blobs/secure-file-transfer-protocol-known-issues
  blob_versioning_enabled       = false
  blob_last_access_time_enabled = true

  network_rules = {
    default_action             = var.gpd_sftp_disable_network_rules ? "Allow" : "Deny"
    bypass                     = ["AzureServices"]
    ip_rules                   = var.gpd_sftp_ip_rules
    virtual_network_subnet_ids = var.gpd_sftp_disable_network_rules ? [] : [data.azurerm_subnet.aks_snet.id]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "gpd_blob" {
  count = var.gpd_sftp_enable_private_endpoint ? 1 : 0

  name                = "${module.gpd_sa_sftp.name}-blob-endpoint"
  resource_group_name = azurerm_resource_group.gpd_rg.name
  location            = azurerm_resource_group.gpd_rg.location
  subnet_id           = module.storage_account_snet.id

  private_dns_zone_group {
    name                 = "${local.project}-storage-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.storage[0].id]
  }

  private_service_connection {
    name                           = "${local.project}-storage-private-service-connection"
    private_connection_resource_id = module.gpd_sa_sftp.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  depends_on = [
    module.gpd_sa_sftp
  ]

  tags = var.tags
}

resource "azurerm_storage_management_policy" "gpd_sa_lifecycle_policy" {
  storage_account_id = module.gpd_sa_sftp.id

  rule {
    name    = "GPD upload blob sa policy"
    enabled = true
    filters {
      prefix_match = ["input", "output"]
      blob_types   = ["blockBlob"]
    }
    actions {
      base_blob {
        tier_to_archive_after_days_since_modification_greater_than = var.gpd_sftp_sa_tier_to_archive
        tier_to_cool_after_days_since_modification_greater_than    = var.gpd_sftp_sa_tier_to_cool
        delete_after_days_since_modification_greater_than          = var.gpd_sftp_sa_delete
      }
    }
  }
}
