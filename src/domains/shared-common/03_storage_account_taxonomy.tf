resource "azurerm_resource_group" "taxonomy_rg" {
  name     = "${local.project}-rg"
  location = var.location

  tags = var.tags
}

module "taxonomy_sa" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v6.17.0"

  name                            = replace("${local.project}-sa", "-", "")
  account_kind                    = var.taxonomy_storage_account.account_kind
  account_tier                    = var.taxonomy_storage_account.account_tier
  account_replication_type        = var.taxonomy_storage_account.account_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.taxonomy_storage_account.blob_versioning_enabled
  resource_group_name             = azurerm_resource_group.taxonomy_rg.name
  location                        = var.location
  advanced_threat_protection      = var.taxonomy_storage_account.advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.taxonomy_storage_account.public_network_access_enabled
  enable_low_availability_alert   = var.taxonomy_storage_account.enable_low_availability_alert

  blob_delete_retention_days = var.taxonomy_storage_account.blob_delete_retention_days

  tags = var.tags
}

resource "azurerm_private_endpoint" "taxonomy_blob_private_endpoint" {
  count = var.env_short == "d" ? 0 : 1

  name                = format("%s-blob-private-endpoint", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.taxonomy_rg.name
  subnet_id           = module.taxonomy_storage_snet[0].id

  private_dns_zone_group {
    name                 = "${local.project}-blob-sa-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_azure_com.id]
  }

  private_service_connection {
    name                           = "${local.project}-blob-sa-private-service-connection"
    private_connection_resource_id = module.taxonomy_sa.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  tags = var.tags

  depends_on = [
    module.taxonomy_sa
  ]
}

## share xml file
resource "azurerm_storage_container" "taxonomy_blob_file" {
  name                  = "taxonomy"
  storage_account_name  = module.taxonomy_sa.name
  container_access_type = "private"
}
