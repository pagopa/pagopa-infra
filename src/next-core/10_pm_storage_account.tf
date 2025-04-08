
module "pm_import_storage_account" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v7.50.0"
  count  = var.is_feature_enabled.pm_import_sa ? 1 : 0

  name                            = replace("${local.product}-pm-import-sa", "-", "")
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  account_replication_type        = "ZRS"
  access_tier                     = "Hot"
  blob_versioning_enabled         = false
  resource_group_name             = azurerm_resource_group.data.name
  location                        = var.location
  advanced_threat_protection      = false
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true


  blob_change_feed_enabled             = false
  blob_change_feed_retention_in_days   = null
  blob_container_delete_retention_days = 30
  blob_delete_retention_days           = 31


  tags = var.tags
}


locals {
  pm_tables = var.is_feature_enabled.pm_import_sa ? [
    "PP_PSP",
    "PP_CANCELLED_PAYMENT",
    "PP_CREDIT_CARD",
    "PP_PAYMENT",
    "PP_PAYMENT_DETAIL",
    "PP_TRANSACTION",
    "PP_USER",
    "PP_WALLET",
    "PP_TRANSACTION_EMAIL"
  ] : []
}

## blob container logo 7
resource "azurerm_storage_container" "table_container" {
  for_each              = toset(local.pm_tables)
  name                  = replace(lower(each.value), "_", "-")
  storage_account_name  = module.pm_import_storage_account[0].name
  container_access_type = "private"
}
