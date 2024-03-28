module "templates_sa" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v7.18.0"

  name                            = replace("${local.project}-templates-sa", "-", "")
  account_kind                    = var.templates_storage_account.account_kind
  account_tier                    = var.templates_storage_account.account_tier
  account_replication_type        = var.templates_storage_account.account_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.templates_storage_account.blob_versioning_enabled
  resource_group_name             = azurerm_resource_group.printit_rg.name
  location                        = var.location
  advanced_threat_protection      = var.templates_storage_account.advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.templates_storage_account.public_network_access_enabled
  enable_low_availability_alert   = var.templates_storage_account.enable_low_availability_alert

  blob_delete_retention_days = var.templates_storage_account.blob_delete_retention_days

  blob_change_feed_enabled             = var.templates_storage_account.backup_enabled
  blob_change_feed_retention_in_days   = var.templates_storage_account.backup_enabled ? var.templates_storage_account.backup_retention + 1 : null
  blob_container_delete_retention_days = var.templates_storage_account.backup_retention
  blob_storage_policy = {
    enable_immutability_policy = false
    blob_restore_policy_days   = var.templates_storage_account.backup_retention
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "templates_blob_private_endpoint" {
  count = var.env_short == "d" ? 0 : 1

  name                = format("%s-template-blob-private-endpoint", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.printit_rg.name
  subnet_id           = module.printit_storage_snet[0].id

  private_dns_zone_group {
    name                 = "${local.project}-template-blob-sa-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_azure_com.id]
  }

  private_service_connection {
    name                           = "${local.project}-template-blob-sa-private-service-connection"
    private_connection_resource_id = module.templates_sa.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  tags = var.tags

  depends_on = [
    module.templates_sa
  ]
}

# https://github.com/hashicorp/terraform-provider-azurerm/issues/5820
resource "azurerm_private_endpoint" "notices_table_private_endpoint" {
  count = var.env_short == "d" ? 0 : 1

  name                = format("%s-table-private-endpoint", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.printit_rg.name
  subnet_id           = module.printit_storage_snet[0].id

  private_dns_zone_group {
    name                 = "${local.project}-table-sa-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_table_azure_com.id]
  }

  private_service_connection {
    name                           = "${local.project}-table-sa-private-service-connection"
    private_connection_resource_id = module.templates_sa.id
    is_manual_connection           = false
    subresource_names              = ["table"]
  }

  tags = var.tags

  depends_on = [
    module.templates_sa
  ]
}

resource "azurerm_storage_container" "template_blob_file" {
  name                  = "notice_template_blob"
  storage_account_name  = module.templates_sa.name
  container_access_type = "private"
}

resource "azurerm_storage_table" "template_data_table" {
  name                 = "notice_template_data_table"
  storage_account_name = module.templates_sa.name
}

