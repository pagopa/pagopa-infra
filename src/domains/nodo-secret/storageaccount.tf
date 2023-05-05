module "nodocerts_sa" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v6.4.1"

  name                       = replace("${local.product}-${var.domain}-nodocerts-sa", "-", "") # nodocerts<dev|uat|prod>
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = "LRS"
  access_tier                = "Hot"
  blob_versioning_enabled    = false

  resource_group_name        = azurerm_resource_group.sec_rg.name
  location                   = var.location
  advanced_threat_protection = false
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true
  blob_delete_retention_days      = 30

  tags = var.tags
}
resource "azurerm_storage_share" "firmatore" {
  name                 = var.az_nodo_sa_share_name_firmatore
  storage_account_name = module.nodocerts_sa.name
  quota                = 50
}
resource "azurerm_storage_share_file" "upload_firmatore" {
  for_each         = var.upload_firmatore
  name             = each.key
  source           = each.value
  storage_share_id = azurerm_storage_share.firmatore.id
}


