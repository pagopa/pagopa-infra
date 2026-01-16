resource "azurerm_resource_group" "printit_rg" {
  name     = "${local.project}-pdf-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "notices_sa" {
  source = "./.terraform/modules/__v4__/storage_account"
  count  = var.is_feature_enabled.storage_notice ? 1 : 0

  name                            = replace("${local.project_short}-notices", "-", "")
  account_kind                    = var.notices_storage_account.account_kind
  account_tier                    = var.notices_storage_account.account_tier
  account_replication_type        = var.notices_storage_account.account_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.notices_storage_account.blob_versioning_enabled
  resource_group_name             = azurerm_resource_group.printit_rg.name
  location                        = var.location
  advanced_threat_protection      = var.notices_storage_account.advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.notices_storage_account.public_network_access_enabled
  enable_low_availability_alert   = var.notices_storage_account.enable_low_availability_alert

  blob_delete_retention_days = var.notices_storage_account.blob_delete_retention_days

  blob_change_feed_enabled             = var.notices_storage_account.backup_enabled
  blob_change_feed_retention_in_days   = var.notices_storage_account.backup_enabled ? var.notices_storage_account.backup_retention + 1 : null
  blob_container_delete_retention_days = var.notices_storage_account.backup_retention
  blob_last_access_time_enabled        = true
  blob_storage_policy = {
    enable_immutability_policy = false
    blob_restore_policy_days   = var.notices_storage_account.backup_retention
  }

  tags = module.tag_config.tags
}

resource "azurerm_private_endpoint" "notices_blob_private_endpoint" {
  count = var.is_feature_enabled.cosmosdb_notice && var.env_short != "d" ? 1 : 0

  name                = "${local.project}-blob-private-endpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.printit_rg.name
  subnet_id           = azurerm_subnet.cidr_storage_italy.id

  private_dns_zone_group {
    name                 = "${local.project}-blob-sa-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_azure_com.id]
  }

  private_service_connection {
    name                           = "${local.project}-blob-sa-private-service-connection"
    private_connection_resource_id = module.notices_sa[0].id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  tags = module.tag_config.tags

  depends_on = [
    module.notices_sa
  ]
}


## share xml file
resource "azurerm_storage_container" "notices_blob_file" {
  count = var.is_feature_enabled.storage_notice ? 1 : 0

  name                  = "notices"
  storage_account_name  = module.notices_sa[0].name
  container_access_type = "private"
}

resource "azurerm_storage_management_policy" "st_blob_receipts_management_policy" {
  count = var.is_feature_enabled.storage_notice ? 1 : 0

  storage_account_id = module.notices_sa[0].id

  rule {
    name    = "tier-to-cool-policy"
    enabled = true
    filters {
      prefix_match = [
        "${azurerm_storage_container.notices_blob_file[0].name}/"
      ]
      blob_types = ["blockBlob"]
    }

    # https://docs.microsoft.com/en-us/azure/storage/blobs/access-tiers-overview
    actions {
      # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy#delete_after_days_since_modification_greater_than
      base_blob {
        tier_to_cool_after_days_since_last_access_time_greater_than = var.notices_storage_account.blob_tier_to_cool_after_last_access
        # TODO it does not supported yet
        #         tier_to_archive_after_days_since_last_access_time_greater_than = var.notices_storage_account.blob_tier_to_archive_after_days_since_last_access_time_greater_than
        delete_after_days_since_last_access_time_greater_than = var.notices_storage_account.blob_delete_after_last_access
        auto_tier_to_hot_from_cool_enabled                    = true
      }
    }
  }

}

resource "azurerm_user_assigned_identity" "identity_blob_storage_pdf" {
  resource_group_name = data.azurerm_resource_group.identity_rg.name
  location            = data.azurerm_resource_group.identity_rg.location
  name                = "${local.project}-service"

  tags = module.tag_config.tags
}

resource "azurerm_role_assignment" "role_blob_storage_pdf" {
  principal_id = azurerm_user_assigned_identity.identity_blob_storage_pdf.principal_id
  scope        = module.notices_sa[0].id

  role_definition_name = "Storage Blob Data Contributor"
}

resource "azurerm_key_vault_secret" "blob_storage_pdf_client_id" {
  name         = "blob-storage-pdf-client-id"
  value        = azurerm_user_assigned_identity.identity_blob_storage_pdf.client_id
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}
