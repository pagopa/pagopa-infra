module "institutions_sa" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v8.9.1"
  count  = var.is_feature_enabled.storage_institutions ? 1 : 0

  name                                       = replace("${var.domain}-institutions", "-", "")
  account_kind                               = var.institutions_storage_account.account_kind
  account_tier                               = var.institutions_storage_account.account_tier
  account_replication_type                   = var.institutions_storage_account.account_replication_type
  access_tier                                = "Hot"
  blob_versioning_enabled                    = var.institutions_storage_account.blob_versioning_enabled
  resource_group_name                        = azurerm_resource_group.printit_rg.name
  location                                   = var.location
  advanced_threat_protection                 = var.institutions_storage_account.advanced_threat_protection
  allow_nested_items_to_be_public            = false
  public_network_access_enabled              = var.institutions_storage_account.public_network_access_enabled
  enable_low_availability_alert              = var.institutions_storage_account.enable_low_availability_alert

  blob_delete_retention_days = var.institutions_storage_account.blob_delete_retention_days

  blob_change_feed_enabled             = var.institutions_storage_account.backup_enabled
  blob_change_feed_retention_in_days   = var.institutions_storage_account.backup_enabled ? var.institutions_storage_account.backup_retention + 1 : null
  blob_container_delete_retention_days = var.institutions_storage_account.backup_retention
  blob_storage_policy = {
    enable_immutability_policy = false
    blob_restore_policy_days   = var.institutions_storage_account.backup_retention
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "institutions_blob_private_endpoint" {
  count = var.is_feature_enabled.storage_institutions && var.env_short != "d" ? 1 : 0

  name                = "${local.project}-institution-blob-private-endpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.printit_rg.name
  subnet_id           = azurerm_subnet.cidr_storage_italy.id

  private_dns_zone_group {
    name                 = "${local.project}-institutions-blob-sa-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_azure_com.id]
  }

  private_service_connection {
    name                           = "${local.project}-institution-blob-sa-private-service-connection"
    private_connection_resource_id = module.institutions_sa[0].id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  tags = var.tags

  depends_on = [
    module.institutions_sa
  ]
}

resource "azurerm_storage_container" "institutions_blob_file" {
  count = var.is_feature_enabled.storage_institutions ? 1 : 0

  name                  = "institutionsdatablob"
  storage_account_name  = module.institutions_sa[0].name
  container_access_type = "private"
}
