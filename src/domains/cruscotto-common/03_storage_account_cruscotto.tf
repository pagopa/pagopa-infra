resource "azurerm_resource_group" "cruscotto_rg" {
  name     = "${local.project}-sa-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "cruscotto_sa" {
  source = "./.terraform/modules/__v4__/storage_account"

  name                            = "pagopa${var.env_short}itn${var.domain}sa"
  account_kind                    = var.cruscotto_storage_account.account_kind
  account_tier                    = var.cruscotto_storage_account.account_tier
  account_replication_type        = var.cruscotto_storage_account.account_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.cruscotto_storage_account.blob_versioning_enabled
  resource_group_name             = azurerm_resource_group.cruscotto_rg.name
  location                        = var.location
  advanced_threat_protection      = var.cruscotto_storage_account.advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.cruscotto_storage_account.public_network_access_enabled

  blob_delete_retention_days = var.cruscotto_storage_account.blob_delete_retention_days

  network_rules = var.env_short != "d" ? {
    default_action             = "Deny"
    ip_rules                   = []
    virtual_network_subnet_ids = [module.cruscotto_storage_snet[0].id]
    bypass                     = ["AzureServices"]
  } : null

  tags = module.tag_config.tags
}

# Private Endpoints
resource "azurerm_private_endpoint" "cruscotto_blob_private_endpoint" {
  count = var.env_short == "d" ? 0 : 1

  name                = format("%s-blob-private-endpoint", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.cruscotto_rg.name
  subnet_id           = module.cruscotto_storage_snet[0].id

  private_dns_zone_group {
    name                 = "${local.project}-blob-sa-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_azure_com.id]
  }

  private_service_connection {
    name                           = "${local.project}-blob-sa-private-service-connection"
    private_connection_resource_id = module.cruscotto_sa.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  tags = module.tag_config.tags

  depends_on = [
    module.cruscotto_sa
  ]
}

# https://github.com/hashicorp/terraform-provider-azurerm/issues/5820
resource "azurerm_private_endpoint" "cruscotto_queue_private_endpoint" {
  count = var.env_short == "d" ? 0 : 1

  name                = format("%s-queue-private-endpoint", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.cruscotto_rg.name
  subnet_id           = module.cruscotto_storage_snet[0].id

  private_dns_zone_group {
    name                 = "${local.project}-queue-sa-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_queue_azure_com.id]
  }

  private_service_connection {
    name                           = "${local.project}-queue-sa-private-service-connection"
    private_connection_resource_id = module.cruscotto_sa.id
    is_manual_connection           = false
    subresource_names              = ["queue"]
  }

  tags = module.tag_config.tags

  depends_on = [
    module.cruscotto_sa
  ]
}

# https://github.com/hashicorp/terraform-provider-azurerm/issues/5820
resource "azurerm_private_endpoint" "cruscotto_table_private_endpoint" {
  count = var.env_short == "d" ? 0 : 1

  name                = format("%s-table-private-endpoint", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.cruscotto_rg.name
  subnet_id           = module.cruscotto_storage_snet[0].id

  private_dns_zone_group {
    name                 = "${local.project}-table-sa-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_table_azure_com.id]
  }

  private_service_connection {
    name                           = "${local.project}-table-sa-private-service-connection"
    private_connection_resource_id = module.cruscotto_sa.id
    is_manual_connection           = false
    subresource_names              = ["table"]
  }

  tags = module.tag_config.tags

  depends_on = [
    module.cruscotto_sa
  ]
}

## Blob containers
resource "azurerm_storage_container" "cruscotto_report_blob" {
  name               = "report"
  storage_account_id = module.cruscotto_sa.id
}

## Blob lifecycle policy
# https://azure.microsoft.com/it-it/blog/azure-blob-storage-lifecycle-management-now-generally-available/
resource "azurerm_storage_management_policy" "cruscotto_storage_management_policy" {
  storage_account_id = module.cruscotto_sa.id

  rule {
    name    = "deleteafterdays"
    enabled = true
    filters {
      prefix_match = ["${azurerm_storage_container.cruscotto_report_blob.name}/"]
      blob_types   = ["blockBlob"]
    }

    # https://docs.microsoft.com/en-us/azure/storage/blobs/access-tiers-overview
    actions {
      # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy#delete_after_days_since_modification_greater_than
      base_blob {
        delete_after_days_since_modification_greater_than = var.cruscotto_blobs_retention_days
      }
      snapshot {
        delete_after_days_since_creation_greater_than = 30
      }
    }
  }

  depends_on = [
    module.cruscotto_sa
  ]
}

