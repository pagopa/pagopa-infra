resource "azurerm_resource_group" "fdr_rg" {
  name     = "${local.project}-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "fdr_re_sa" {
  source = "./.terraform/modules/__v4__/storage_account"

  name                            = replace("${local.project}-re-sa", "-", "")
  account_kind                    = var.fdr_re_storage_account.account_kind
  account_tier                    = var.fdr_re_storage_account.account_tier
  account_replication_type        = var.fdr_re_storage_account.account_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.fdr_re_storage_account.blob_versioning_enabled
  resource_group_name             = azurerm_resource_group.fdr_rg.name
  location                        = var.location
  advanced_threat_protection      = false # using Storage Defender
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.fdr_re_storage_account.public_network_access_enabled
  enable_low_availability_alert   = var.fdr_re_storage_account.enable_low_availability_alert

  blob_delete_retention_days = var.fdr_re_storage_account.blob_delete_retention_days

  blob_change_feed_enabled             = var.fdr_re_storage_account.backup_enabled
  blob_change_feed_retention_in_days   = var.fdr_re_storage_account.backup_enabled ? var.fdr_re_storage_account.backup_retention + 1 : null
  blob_container_delete_retention_days = var.fdr_re_storage_account.backup_retention
  blob_storage_policy = {
    enable_immutability_policy = false
    blob_restore_policy_days   = var.fdr_re_storage_account.backup_retention
  }

  tags = module.tag_config.tags
}

module "fdr_conversion_sa" {
  source = "./.terraform/modules/__v4__/storage_account"

  name                            = replace("${local.project}-sa", "-", "")
  account_kind                    = var.fdr_storage_account.account_kind
  account_tier                    = var.fdr_storage_account.account_tier
  account_replication_type        = var.fdr_storage_account.account_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.fdr_storage_account.blob_versioning_enabled
  resource_group_name             = azurerm_resource_group.fdr_rg.name
  location                        = var.location
  advanced_threat_protection      = var.fdr_storage_account.advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.fdr_storage_account.public_network_access_enabled
  enable_low_availability_alert   = var.fdr_storage_account.enable_low_availability_alert

  blob_delete_retention_days = var.fdr_storage_account.blob_delete_retention_days

  blob_change_feed_enabled             = var.fdr_storage_account.backup_enabled
  blob_change_feed_retention_in_days   = var.fdr_storage_account.backup_enabled ? var.fdr_storage_account.backup_retention + 1 : null
  blob_container_delete_retention_days = var.fdr_storage_account.backup_retention
  blob_storage_policy = {
    enable_immutability_policy = false
    blob_restore_policy_days   = var.fdr_storage_account.backup_retention
  }

  tags = module.tag_config.tags
}

resource "azurerm_private_endpoint" "fdr_re_blob_private_endpoint" {
  count = var.env_short == "d" ? 0 : 1

  name                = format("%s-re-blob-private-endpoint", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.fdr_rg.name
  subnet_id           = module.fdr_storage_snet[0].id

  private_dns_zone_group {
    name                 = "${local.project}-re-blob-sa-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_azure_com.id]
  }

  private_service_connection {
    name                           = "${local.project}-re-blob-sa-private-service-connection"
    private_connection_resource_id = module.fdr_re_sa.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  tags = module.tag_config.tags

  depends_on = [
    module.fdr_re_sa
  ]
}


resource "azurerm_private_endpoint" "fdr_blob_private_endpoint" {
  count = var.env_short == "d" ? 0 : 1

  name                = format("%s-blob-private-endpoint", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.fdr_rg.name
  subnet_id           = module.fdr_storage_snet[0].id

  private_dns_zone_group {
    name                 = "${local.project}-blob-sa-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_azure_com.id]
  }

  private_service_connection {
    name                           = "${local.project}-blob-sa-private-service-connection"
    private_connection_resource_id = module.fdr_conversion_sa.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  tags = module.tag_config.tags

  depends_on = [
    module.fdr_conversion_sa
  ]
}

# https://github.com/hashicorp/terraform-provider-azurerm/issues/5820
resource "azurerm_private_endpoint" "fdr_queue_private_endpoint" {
  count = var.env_short == "d" ? 0 : 1

  name                = format("%s-queue-private-endpoint", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.fdr_rg.name
  subnet_id           = module.fdr_storage_snet[0].id

  private_dns_zone_group {
    name                 = "${local.project}-queue-sa-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_queue_azure_com.id]
  }

  private_service_connection {
    name                           = "${local.project}-queue-sa-private-service-connection"
    private_connection_resource_id = module.fdr_conversion_sa.id
    is_manual_connection           = false
    subresource_names              = ["queue"]
  }

  tags = module.tag_config.tags

  depends_on = [
    module.fdr_conversion_sa
  ]
}

# https://github.com/hashicorp/terraform-provider-azurerm/issues/5820
resource "azurerm_private_endpoint" "fdr_table_private_endpoint" {
  count = var.env_short == "d" ? 0 : 1

  name                = format("%s-table-private-endpoint", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.fdr_rg.name
  subnet_id           = module.fdr_storage_snet[0].id

  private_dns_zone_group {
    name                 = "${local.project}-table-sa-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_table_azure_com.id]
  }

  private_service_connection {
    name                           = "${local.project}-table-sa-private-service-connection"
    private_connection_resource_id = module.fdr_conversion_sa.id
    is_manual_connection           = false
    subresource_names              = ["table"]
  }

  tags = module.tag_config.tags

  depends_on = [
    module.fdr_conversion_sa
  ]
}

## fdr 1 flows blob container
resource "azurerm_storage_container" "fdr1_flows_blob_file" {
  name                 = "fdr1-flows"
  storage_account_name = module.fdr_conversion_sa.name
}

## fdr 3 flows blob container
resource "azurerm_storage_container" "fdr3_flows_blob_file" {
  name                 = "fdr3-flows"
  storage_account_name = module.fdr_conversion_sa.name
}

## re payload blob container
resource "azurerm_storage_container" "re_payloads_blob_file" {
  name                 = "re-payload"
  storage_account_name = module.fdr_re_sa.name
}

## re payload blob container
## TODO WARNING: this is the old one, it must be deleted only after data migration
resource "azurerm_storage_container" "re_payload_blob_file" {
  name                 = "re-payload"
  storage_account_name = module.fdr_conversion_sa.name
}

# table#1 conversion error table
resource "azurerm_storage_table" "fdr1_conversion_error_table" {
  name                 = "fdr1conversionerror"
  storage_account_name = module.fdr_conversion_sa.name
}

# Defender for RE storage Account
resource "azurerm_security_center_storage_defender" "fdr_re_storage_defender" {
  count = var.fdr_re_storage_account.storage_defender_enabled ? 1 : 0

  storage_account_id                          = module.fdr_re_sa.id
  override_subscription_settings_enabled      = var.fdr_re_storage_account.storage_defender_override_subscription_settings_enabled
  sensitive_data_discovery_enabled            = var.fdr_re_storage_account.storage_defender_sensitive_data_discovery_enabled
  malware_scanning_on_upload_enabled          = var.fdr_re_storage_account.storage_defender_malware_scanning_on_upload_enabled
  malware_scanning_on_upload_cap_gb_per_month = var.fdr_re_storage_account.storage_defender_malware_scanning_on_upload_cap_gb_per_month

  depends_on = [
    module.fdr_re_sa
  ]
}



# https://medium.com/marcus-tee-anytime/secure-azure-blob-storage-with-azure-api-management-managed-identities-b0b82b53533c

# 1 - add Blob Data Contributor to apim for FDR1's Cached response blob storage
resource "azurerm_role_assignment" "fdrconversionsa_data_contributor_role" {
  scope                = module.fdr_conversion_sa.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_api_management.apim.identity[0].principal_id

  depends_on = [
    module.fdr_conversion_sa
  ]
}

## 🐞https://github.com/hashicorp/terraform-provider-azurerm/pull/15832
## blob lifecycle policy
# https://azure.microsoft.com/it-it/blog/azure-blob-storage-lifecycle-management-now-generally-available/
resource "azurerm_storage_management_policy" "fdr1_re_payload_blob_file_management_policy" {
  storage_account_id = module.fdr_re_sa.id

  rule {
    name    = "deleteafterdays"
    enabled = true
    filters {
      # https://learn.microsoft.com/en-us/answers/questions/139922/in-azure-blob-lifecycle-management-how-do-you-matc
      prefix_match = [azurerm_storage_container.re_payloads_blob_file.name]
      blob_types   = ["blockBlob"]
    }

    # https://docs.microsoft.com/en-us/azure/storage/blobs/access-tiers-overview
    actions {
      # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy#delete_after_days_since_modification_greater_than
      base_blob {
        delete_after_days_since_modification_greater_than = var.fdr_re_storage_account.blob_file_retention_days
      }
      snapshot {
        delete_after_days_since_creation_greater_than = 1
      }
      version {
        delete_after_days_since_creation = var.fdr_re_storage_account.blob_file_retention_days
      }
    }
  }

  depends_on = [
    module.fdr_re_sa
  ]
}
