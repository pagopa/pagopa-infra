locals {
  taxonomy_label = "txnm"
}

resource "azurerm_resource_group" "taxonomy_rg" {
  name     = "${local.project}-${local.taxonomy_label}-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "taxonomy_sa" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v8.53.0"

  name                            = replace("${local.project}-${local.taxonomy_label}-sa", "-", "")
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


  blob_change_feed_enabled             = var.taxonomy_storage_account.backup_enabled
  blob_change_feed_retention_in_days   = var.taxonomy_storage_account.backup_enabled ? var.taxonomy_storage_account.backup_retention + 1 : null
  blob_container_delete_retention_days = var.taxonomy_storage_account.backup_retention
  blob_storage_policy = {
    enable_immutability_policy = false
    blob_restore_policy_days   = var.taxonomy_storage_account.backup_retention
  }
  network_rules = var.taxonomy_network_rules

  tags = module.tag_config.tags
}

resource "azurerm_private_endpoint" "taxonomy_blob_private_endpoint" {
  count = var.env_short == "d" ? 0 : 1

  name                = "${local.project}-${local.taxonomy_label}-blob-sa-private-endpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.taxonomy_rg.name
  subnet_id           = module.taxonomy_storage_snet[0].id

  private_dns_zone_group {
    name                 = "${local.project}-${local.taxonomy_label}-blob-sa-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_azure_com.id]
  }

  private_service_connection {
    name                           = "${local.project}-${local.taxonomy_label}-blob-sa-private-service-connection"
    private_connection_resource_id = module.taxonomy_sa.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  tags = module.tag_config.tags

  depends_on = [
    module.taxonomy_sa
  ]
}

## taxonomy input file
resource "azurerm_storage_container" "taxonomy_input_blob_file" {
  name                  = "input"
  storage_account_name  = module.taxonomy_sa.name
  container_access_type = "private"
}

## taxonomy output file
resource "azurerm_storage_container" "taxonomy_output_blob_file" {
  name                  = "output"
  storage_account_name  = module.taxonomy_sa.name
  container_access_type = "private"
}
