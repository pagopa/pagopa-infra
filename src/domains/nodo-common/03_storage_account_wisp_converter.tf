module "wisp_converter_storage_account" {
  count  = var.create_wisp_converter ? 1 : 0
  source = "./.terraform/modules/__v4__/storage_account"

  name                            = replace(format("%s-wisp-conv-st", local.project), "-", "")
  account_kind                    = var.wisp_converter_storage_account.account_kind
  account_tier                    = var.wisp_converter_storage_account.account_tier
  account_replication_type        = var.wisp_converter_storage_account.account_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.wisp_converter_storage_account.blob_versioning_enabled
  resource_group_name             = azurerm_resource_group.wisp_converter_rg[0].name
  location                        = var.location
  advanced_threat_protection      = var.wisp_converter_storage_account.advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.wisp_converter_storage_account.public_network_access_enabled

  blob_delete_retention_days = var.wisp_converter_storage_account.blob_delete_retention_days

  blob_change_feed_enabled             = var.wisp_converter_storage_account.backup_enabled
  blob_change_feed_retention_in_days   = var.wisp_converter_storage_account.backup_enabled ? var.wisp_converter_storage_account.backup_retention_days + 1 : null
  blob_container_delete_retention_days = var.wisp_converter_storage_account.backup_retention_days
  blob_storage_policy = {
    enable_immutability_policy = false
    blob_restore_policy_days   = var.wisp_converter_storage_account.backup_retention_days
  }

  tags = module.tag_config.tags

  depends_on = [
    azurerm_resource_group.wisp_converter_rg
  ]
}

resource "azurerm_private_endpoint" "wispconv_private_endpoint_container" {
  count = var.env_short == "d" ? 0 : var.create_wisp_converter ? 1 : 0

  name                = "${local.project}-wisp-converter-private-endpoint-container"
  location            = var.location
  resource_group_name = azurerm_resource_group.wisp_converter_rg[0].name
  subnet_id           = data.azurerm_subnet.private_endpoint_snet.id

  private_dns_zone_group {
    name                 = "${local.project}-wisp-converter-private-dns-zone-group-container"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_azure_com.id]
  }

  private_service_connection {
    name                           = "${local.project}-wisp-converter-private-service-connection-container"
    private_connection_resource_id = module.wisp_converter_storage_account[0].id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  tags = module.tag_config.tags

  depends_on = [
    azurerm_resource_group.wisp_converter_rg,
    module.wisp_converter_storage_account
  ]
}


# table wispconverter
resource "azurerm_storage_table" "wisp_converter_table" {
  count                = var.create_wisp_converter ? 1 : 0
  name                 = "events"
  storage_account_name = module.wisp_converter_storage_account[0].name

  depends_on = [
    module.wisp_converter_storage_account
  ]
}

resource "azurerm_private_endpoint" "wispconv_private_endpoint_table" {
  count = var.env_short == "d" ? 0 : var.create_wisp_converter ? 1 : 0

  name                = "${local.project}-wisp-converter-private-endpoint-table"
  location            = var.location
  resource_group_name = azurerm_resource_group.wisp_converter_rg[0].name
  subnet_id           = data.azurerm_subnet.private_endpoint_snet.id

  private_dns_zone_group {
    name                 = "${local.project}-wisp-converter-private-dns-zone-group-table"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_table_azure_com.id]
  }

  private_service_connection {
    name                           = "${local.project}-wisp-converter-private-service-connection-table"
    private_connection_resource_id = module.wisp_converter_storage_account[0].id
    is_manual_connection           = false
    subresource_names              = ["table"]
  }

  tags = module.tag_config.tags

  depends_on = [
    azurerm_resource_group.wisp_converter_rg,
    module.wisp_converter_storage_account
  ]
}

# blob wispconverter
resource "azurerm_storage_container" "wisp_converter_container" {
  count                = var.create_wisp_converter ? 1 : 0
  name                 = "payloads"
  storage_account_name = module.wisp_converter_storage_account[0].name

  depends_on = [
    module.wisp_converter_storage_account
  ]
}

resource "azurerm_private_endpoint" "wispconv_private_endpoint_blob" {
  count = var.env_short == "d" ? 0 : var.create_wisp_converter ? 1 : 0

  name                = "${local.project}-wisp-converter-private-endpoint-blob"
  location            = var.location
  resource_group_name = azurerm_resource_group.wisp_converter_rg[0].name
  subnet_id           = data.azurerm_subnet.private_endpoint_snet.id

  private_dns_zone_group {
    name                 = "${local.project}-wisp-converter-private-dns-zone-group-blob"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_azure_com.id]
  }

  private_service_connection {
    name                           = "${local.project}-wisp-converter-private-service-connection-blob"
    private_connection_resource_id = module.wisp_converter_storage_account[0].id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  tags = module.tag_config.tags

  depends_on = [
    azurerm_resource_group.wisp_converter_rg,
    module.wisp_converter_storage_account
  ]
}
