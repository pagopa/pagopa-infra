resource "azurerm_resource_group" "st_observability_rg" {
  name     = "${local.project_itn}-st-rg"
  location = var.location_itn
  tags     = module.tag_config.tags
}

module "observability_st_snet" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.7.0"

  name                 = "${local.project_itn}-observability-st-net"
  address_prefixes     = var.cidr_subnet_observability_storage
  resource_group_name  = local.vnet_italy_resource_group_name
  virtual_network_name = local.vnet_italy_name

  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Storage",
  ]
}

resource "azurerm_private_endpoint" "observability_storage_private_endpoint" {
  count = var.env_short != "d" ? 1 : 0

  name                = "${local.project_itn}-storage-private-endpoint"
  location            = var.location_itn
  resource_group_name = azurerm_resource_group.st_observability_rg.name
  subnet_id           = module.observability_st_snet.id

  private_dns_zone_group {
    name                 = "${local.project_itn}-storage-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.storage.id]
  }

  private_service_connection {
    name                           = "${local.project_itn}-storage-private-service-connection"
    private_connection_resource_id = module.observability_sa.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  tags = module.tag_config.tags
}



module "observability_sa" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v7.18.0"

  name                       = replace(format("%s-sa", local.project_itn), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = var.observability_storage_account_replication_type
  access_tier                = "Hot"
  blob_versioning_enabled    = var.enable_sa_backup
  resource_group_name        = azurerm_resource_group.st_observability_rg.name
  location                   = var.location_itn
  advanced_threat_protection = var.observability_sa_advanced_threat_protection

  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true

  blob_delete_retention_days = var.observability_sa_delete_retention_days
  tags                       = module.tag_config.tags

  blob_last_access_time_enabled = true


  blob_change_feed_enabled             = var.enable_sa_backup
  blob_change_feed_retention_in_days   = var.enable_sa_backup ? var.observability_sa_backup_retention_days + 1 : null
  blob_container_delete_retention_days = var.observability_sa_backup_retention_days
  blob_storage_policy = {
    enable_immutability_policy = false
    blob_restore_policy_days   = var.observability_sa_backup_retention_days
  }

}


## blob container attachments
resource "azurerm_storage_container" "blob-observability-st" {
  name                  = "${local.project_itn}-az-blob-observability-container"
  storage_account_name  = module.observability_sa.name
  container_access_type = "private"
}

# resource "azurerm_storage_management_policy" "st_blob_observability_management_policy" {
#   storage_account_id = module.observability_sa.id

#   rule {
#     name    = "tier-to-cool-policy"
#     enabled = true
#     filters {
#       prefix_match = [format("%s/", azurerm_storage_container.blob-observability-st.name)]
#       blob_types   = ["blockBlob"]
#     }

#     # https://docs.microsoft.com/en-us/azure/storage/blobs/access-tiers-overview
#     actions {
#       # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy#delete_after_days_since_modification_greater_than
#       base_blob {
#         tier_to_cool_after_days_since_last_access_time_greater_than    = var.observability_sa_tier_to_cool_after_last_access
#         tier_to_archive_after_days_since_last_access_time_greater_than = var.observability_tier_to_archive_after_days_since_last_access_time_greater_than
#         delete_after_days_since_last_access_time_greater_than          = var.observability_sa_delete_after_last_access
#         auto_tier_to_hot_from_cool_enabled                             = true
#       }
#     }
#   }

# }
