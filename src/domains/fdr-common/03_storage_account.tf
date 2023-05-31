resource "azurerm_resource_group" "fdr_rg" {
  name     = "${local.project}-rg"
  location = var.location

  tags = var.tags
}

# storage
module "fdr_conversion_sa" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v6.4.1"

  name                            = replace(format("%s-sa", local.project), "-", "")
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.fdr_conversion_versioning
  resource_group_name             = azurerm_resource_group.fdr_rg.name
  location                        = var.location
  advanced_threat_protection      = var.fdr_convertion_advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true
  enable_low_availability_alert   = false

  blob_delete_retention_days = var.fdr_convertion_delete_retention_days

  tags = var.tags
}


## share xml file
resource "azurerm_storage_container" "xml_share_file" {
  name                 = format("%sxmlsharefile", module.fdr_conversion_sa.name)
  storage_account_name = module.fdr_conversion_sa.name
  container_access_type = "private"
}

# send id of fdr mongo collection
resource "azurerm_storage_queue" "flow_id_send_queue" {
  name                 = format("%sflowidsendqueue", module.fdr_conversion_sa.name)
  storage_account_name = module.fdr_conversion_sa.name
}