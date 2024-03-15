module "wispconv_storage_account" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v7.60.0"

  name                            = replace(format("%s-wispconv-st", local.project), "-", "")
  account_kind                    = var.wispconv_storage_account.account_kind
  account_tier                    = var.wispconv_storage_account.account_tier
  account_replication_type        = var.wispconv_storage_account.account_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.wispconv_storage_account.blob_versioning_enabled
  resource_group_name             = azurerm_resource_group.wispconv_rg.name
  location                        = var.location
  advanced_threat_protection      = var.wispconv_storage_account.advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.wispconv_storage_account.public_network_access_enabled

  blob_delete_retention_days = var.wispconv_storage_account.blob_delete_retention_days

  blob_change_feed_enabled             = var.wispconv_storage_account.backup_enabled
  blob_change_feed_retention_in_days   = var.wispconv_storage_account.backup_enabled ? var.wispconv_storage_account.backup_retention_days + 1 : null
  blob_container_delete_retention_days = var.wispconv_storage_account.backup_retention_days
  blob_storage_policy = {
    enable_immutability_policy = false
    blob_restore_policy_days   = var.wispconv_storage_account.backup_retention_days
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "wispconv_private_endpoint_container" {
  count = var.env_short == "d" ? 0 : 1

  name                = "${local.project}-wispconv-private-endpoint-container"
  location            = var.location
  resource_group_name = azurerm_resource_group.wispconv_rg.name
  subnet_id           = data.azurerm_subnet.private_endpoint_snet.id

  private_dns_zone_group {
    name                 = "${local.project}-wispconv-private-dns-zone-group-container"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_table_azure_com.id]
  }

  private_service_connection {
    name                           = "${local.project}-wispconv-private-service-connection-container"
    private_connection_resource_id = module.wispconv_storage_account.id
    is_manual_connection           = false
    subresource_names              = ["container"]
  }

  tags = var.tags

  depends_on = [
    module.wispconv_storage_account
  ]
}

# table wispconverter
resource "azurerm_storage_table" "wispconv_table" {
  name                 = "events"
  storage_account_name = module.nodo_verifyko_storage_account.name
}

# blob wispconverter
resource "azurerm_storage_container" "wispconv_container" {
  name                 = "payloads"
  storage_account_name = module.wispconv_storage_account.name
  depends_on = [
    module.wispconv_storage_account
  ]
}
