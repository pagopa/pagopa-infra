resource "azurerm_resource_group" "fdr_history_rg" {
  name     = "${local.project}-history-rg"
  location = var.location

  tags = var.tags
}

module "fdr_history_sa" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v7.18.0"

  name                            = replace("${local.project}-history-sa", "-", "")
  account_kind                    = var.fdr_history_storage_account.account_kind
  account_tier                    = var.fdr_history_storage_account.account_tier
  account_replication_type        = var.fdr_history_storage_account.account_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.fdr_history_storage_account.blob_versioning_enabled
  resource_group_name             = azurerm_resource_group.fdr_history_rg.name
  location                        = var.location
  advanced_threat_protection      = var.fdr_history_storage_account.advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.fdr_history_storage_account.public_network_access_enabled
  enable_low_availability_alert   = var.fdr_history_storage_account.enable_low_availability_alert

  blob_delete_retention_days = var.fdr_history_storage_account.blob_delete_retention_days

  blob_change_feed_enabled             = var.fdr_history_storage_account.backup_enabled
  blob_change_feed_retention_in_days   = var.fdr_history_storage_account.backup_enabled ? var.fdr_history_storage_account.backup_retention : null
  blob_container_delete_retention_days = var.fdr_history_storage_account.backup_retention
  blob_storage_policy = {
    enable_immutability_policy = false
    blob_restore_policy_days   = var.fdr_history_storage_account.backup_retention
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "fdr_history_blob_private_endpoint" {
  count = var.env_short == "d" ? 0 : 1

  name                = format("%s-history-blob-private-endpoint", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.fdr_history_rg.name
  subnet_id           = module.fdr_storage_snet[0].id

  private_dns_zone_group {
    name                 = "${local.project}-history-blob-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_azure_com.id]
  }

  private_service_connection {
    name                           = "${local.project}-history-blob-private-service-connection"
    private_connection_resource_id = module.fdr_history_sa.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  tags = var.tags

  depends_on = [
    module.fdr_history_sa
  ]
}

resource "azurerm_private_endpoint" "fdr_history_table_private_endpoint" {
  count = var.env_short == "d" ? 0 : 1

  name                = format("%s-history-table-private-endpoint", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.fdr_history_rg.name
  subnet_id           = module.fdr_storage_snet[0].id

  private_dns_zone_group {
    name                 = "${local.project}-history-table-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_table_azure_com.id]
  }

  private_service_connection {
    name                           = "${local.project}-history-table-private-service-connection"
    private_connection_resource_id = module.fdr_history_sa.id
    is_manual_connection           = false
    subresource_names              = ["table"]
  }

  tags = var.tags

  depends_on = [
    module.fdr_history_sa
  ]
}

## fdr json file
resource "azurerm_storage_container" "fdr_json_blob_file" {
  name                  = "fdrjson"
  storage_account_name  = module.fdr_history_sa.name
  container_access_type = "private"
}

# table#1 fdr-history
resource "azurerm_storage_table" "fdr_publish_history_table" {
  name                 = "fdrpublish"
  storage_account_name = module.fdr_history_sa.name
}
resource "azurerm_storage_table" "fdr_payment_publish_history_table" {
  name                 = "fdrpaymentpublish"
  storage_account_name = module.fdr_history_sa.name
}

