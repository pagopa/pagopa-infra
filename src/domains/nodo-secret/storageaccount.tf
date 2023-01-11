module "nodocerts_sa" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v2.0.28"

  name                       = replace("${local.product}-${var.domain}-nodocerts-sa", "-", "") # nodocerts<dev|uat|prod>
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = "LRS"
  access_tier                = "Hot"
  versioning_name            = "versioning"
  enable_versioning          = false
  resource_group_name        = azurerm_resource_group.sec_rg.name
  location                   = var.location
  advanced_threat_protection = false
  allow_blob_public_access   = false

  blob_properties_delete_retention_policy_days = 30

  tags = var.tags
}

# resource + upload CACERTS
resource "azurerm_storage_share" "certs" {
  name                 = var.az_nodo_sa_share_name_cert
  storage_account_name = module.nodocerts_sa.name
  quota                = 50
}


resource "azurerm_storage_share_file" "upload_certs" {
  for_each         = var.upload_certificates
  name             = each.key
  source           = each.value
  storage_share_id = azurerm_storage_share.certs.id
}

# resource + upload FIRMATORE
resource "azurerm_storage_share" "firmatore" {
  name                 = var.az_nodo_sa_share_name_firmatore
  storage_account_name = module.nodocerts_sa.name
  quota                = 50
}

#resource "azurerm_storage_share_file" "upload_firmatore" {
#  for_each         = var.upload_firmatore
#  name             = each.key
#  source           = each.value
#  storage_share_id = azurerm_storage_share.firmatore.id
#}




