resource "azurerm_resource_group" "fdr_re_rg" {
  name     = "${local.project}-re-rg"
  location = var.location

  tags = var.tags
}

module "fdr_re_sa" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v6.17.0"

  name                            = replace("${local.project}-re-sa", "-", "")
  account_kind                    = var.fdr_re_storage_account.account_kind
  account_tier                    = var.fdr_re_storage_account.account_tier
  account_replication_type        = var.fdr_re_storage_account.account_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.fdr_re_storage_account.blob_versioning_enabled
  resource_group_name             = azurerm_resource_group.fdr_re_rg.name
  location                        = var.location
  advanced_threat_protection      = var.fdr_re_storage_account.advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.fdr_re_storage_account.public_network_access_enabled
  enable_low_availability_alert   = var.fdr_re_storage_account.enable_low_availability_alert

  blob_delete_retention_days = var.fdr_re_storage_account.blob_delete_retention_days

  tags = var.tags
}

## share xml file
resource "azurerm_storage_container" "payload_blob_file" {
  name                  = "${module.fdr_conversion_sa.name}repayload"
  storage_account_name  = module.fdr_re_sa.name
  container_access_type = "private"
}

