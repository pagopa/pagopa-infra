# storage

module "poc_reporting_enrollment_sa" {
  count = var.env_short == "d" ? 1 : 0

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v6.6.1"

  name                            = replace(format("%s-penrol-sa", local.project), "-", "")
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.poc_versioning
  resource_group_name             = azurerm_resource_group.shared_rg.name
  location                        = var.location
  advanced_threat_protection      = var.poc_advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.reporting_storage_public_access_enabled

  blob_delete_retention_days = var.poc_delete_retention_days

  tags = var.tags
}


## table receipts storage
resource "azurerm_storage_table" "poc_reporting_enrollment_table" {
  count                = var.env_short == "d" ? 1 : 0
  name                 = "organizations"
  storage_account_name = module.poc_reporting_enrollment_sa[0].name
}
