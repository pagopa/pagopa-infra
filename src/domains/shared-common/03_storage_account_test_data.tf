locals {
  test_label = "tst-dt"
}

resource "azurerm_resource_group" "test_data_rg" {
  count    = var.env_short == "p" ? 0 : 1
  name     = "${local.project}-${local.test_label}-rg"
  location = var.location

  tags = var.tags
}

module "test_data_sa" {
  count  = var.env_short == "p" ? 0 : 1
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v6.17.0"

  name                            = replace("${local.project}-${local.test_label}-sa", "-", "")
  account_kind                    = var.test_data_storage_account.account_kind
  account_tier                    = var.test_data_storage_account.account_tier
  account_replication_type        = var.test_data_storage_account.account_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.test_data_storage_account.blob_versioning_enabled
  resource_group_name             = azurerm_resource_group.test_data_rg[0].name
  location                        = var.location
  advanced_threat_protection      = var.test_data_storage_account.advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.test_data_storage_account.public_network_access_enabled
  enable_low_availability_alert   = var.test_data_storage_account.enable_low_availability_alert

  blob_delete_retention_days = var.test_data_storage_account.blob_delete_retention_days

  tags = var.tags
}

#resource "azurerm_private_endpoint" "taxonomy_blob_private_endpoint" {
#  count = var.env_short == "u" ? 1 : 0
#
#  name                = "${local.project}-${local.test_label}-blob-sa-private-endpoint"
#  location            = var.location
#  resource_group_name = azurerm_resource_group.test_data_rg.name
#  subnet_id           = module.taxonomy_storage_snet[0].id
#
#  private_dns_zone_group {
#    name                 = "${local.project}-${local.test_label}-blob-sa-private-dns-zone-group"
#    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_azure_com.id]
#  }
#
#  private_service_connection {
#    name                           = "${local.project}-${local.test_label}-blob-sa-private-service-connection"
#    private_connection_resource_id = module.test_data_sa.id
#    is_manual_connection           = false
#    subresource_names              = ["blob"]
#  }
#
#  tags = var.tags
#
#  depends_on = [
#    module.test_data_sa
#  ]
#}

### taxonomy input file
#resource "azurerm_storage_container" "taxonomy_input_blob_file" {
#  name                  = "input"
#  storage_account_name  = module.test_data_sa.name
#  container_access_type = "private"
#}
#
### taxonomy output file
#resource "azurerm_storage_container" "taxonomy_output_blob_file" {
#  name                  = "output"
#  storage_account_name  = module.test_data_sa.name
#  container_access_type = "private"
#}
