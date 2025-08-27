locals {
  test_label = "tst-dt"
}

resource "azurerm_resource_group" "test_data_rg" {
  count    = var.env_short == "p" ? 0 : 1
  name     = "${local.project}-${local.test_label}-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "test_data_sa" {
  count  = var.env_short == "p" ? 0 : 1
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v8.53.0"

  name                            = replace("${local.project}-${local.test_label}-sa", "-", "")
  account_kind                    = var.test_data_storage_account.account_kind
  account_tier                    = var.test_data_storage_account.account_tier
  account_replication_type        = var.test_data_storage_account.account_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.test_data_storage_account.blob_versioning_enabled
  resource_group_name             = azurerm_resource_group.test_data_rg[0].name
  location                        = var.location
  advanced_threat_protection      = var.test_data_storage_account.advanced_threat_protection
  allow_nested_items_to_be_public = true
  public_network_access_enabled   = var.test_data_storage_account.public_network_access_enabled
  enable_low_availability_alert   = var.test_data_storage_account.enable_low_availability_alert

  blob_delete_retention_days = var.test_data_storage_account.blob_delete_retention_days

  tags = module.tag_config.tags
}
