# ##################
# ## GPD PAYMENTS ##
# ##################

# storage
module "payments_receipt_sa" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v6.4.1"

  name                            = replace(format("%s-payments-sa", local.project), "-", "")
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.gpd_payments_versioning
  resource_group_name             = azurerm_resource_group.gps_rg.name
  location                        = var.location
  advanced_threat_protection      = var.gpd_payments_advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true
  enable_low_availability_alert   = false

  blob_delete_retention_days = var.gpd_payments_delete_retention_days

  tags = var.tags
}


## table receipts storage
resource "azurerm_storage_table" "payments_receipts_table" {
  name                 = format("%sreceiptstable", module.payments_receipt_sa.name)
  storage_account_name = module.payments_receipt_sa.name
}
