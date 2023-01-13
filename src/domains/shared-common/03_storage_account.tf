# storage
module "poc_reporting_enrollment_sa" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v4.0.0"

  name                       = replace(format("%s-penrol-sa", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = "LRS"
  access_tier                = "Hot"
  versioning_name            = "versioning"
  enable_versioning          = var.poc_versioning
  resource_group_name        = azurerm_resource_group.shared_rg.name
  location                   = var.location
  advanced_threat_protection = var.poc_advanced_threat_protection
  allow_blob_public_access   = false

  blob_properties_delete_retention_policy_days = var.poc_delete_retention_days

  tags = var.tags
}


## table receipts storage
resource "azurerm_storage_table" "poc_reporting_enrollment_table" {
  name                 = format("%sorganizations", module.poc_reporting_enrollment_sa.name)
  storage_account_name = module.poc_reporting_enrollment_sa.name
}
