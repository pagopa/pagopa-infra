module "nodocerts_sa" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v7.18.0"

  name                     = replace("${local.product}-${var.domain}-nodocerts-sa", "-", "") # nodocerts<dev|uat|prod>
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = var.certs_storage_account_replication_type
  access_tier              = "Hot"
  blob_versioning_enabled  = var.nodo_cert_storage_account.blob_versioning_enabled

  resource_group_name             = azurerm_resource_group.sec_rg.name
  location                        = var.location
  advanced_threat_protection      = var.nodo_cert_storage_account.advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true


  blob_change_feed_enabled             = var.nodo_cert_storage_account.backup_enabled
  blob_change_feed_retention_in_days   = var.nodo_cert_storage_account.backup_enabled ? var.nodo_cert_storage_account.backup_retention + 1 : null
  blob_container_delete_retention_days = var.nodo_cert_storage_account.backup_retention
  blob_storage_policy = {
    enable_immutability_policy = false
    blob_restore_policy_days   = var.nodo_cert_storage_account.backup_retention
  }
  blob_delete_retention_days = var.nodo_cert_storage_account.blob_delete_retention_days

  tags = module.tag_config.tags
}
resource "azurerm_storage_share" "firmatore" {
  name                 = var.az_nodo_sa_share_name_firmatore
  storage_account_name = module.nodocerts_sa.name
  quota                = 50
}

# :warning: The following resource is deprecated and should not be used in new deployments.\
# ⚠️⚠️⚠️
# DEPRACATED: upload manually ✋ via Az portal or Az CLI
# ⚠️⚠️⚠️

resource "azurerm_storage_share_file" "upload_firmatore" {
  for_each         = var.upload_firmatore
  name             = each.key
  source           = each.value
  storage_share_id = azurerm_storage_share.firmatore.id
}


