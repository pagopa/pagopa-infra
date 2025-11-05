
module "bizevents_datastore_fn_sa" {
  source = "./.terraform/modules/__v3__/storage_account"

  name                       = replace(format("%s-fn-sa", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = var.storage_account_replication_type
  access_tier                = "Hot"
  blob_versioning_enabled    = false
  resource_group_name        = azurerm_resource_group.bizevents_rg.name
  location                   = var.location
  advanced_threat_protection = var.bizevents_datastore_fn_sa_advanced_threat_protection

  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true

  blob_delete_retention_days = var.bizevents_datastore_fn_sa_delete_retention_days
  tags                       = module.tag_config.tags
}


module "bizevents_datastore_fn_sa_bizview" {
  source = "./.terraform/modules/__v3__/storage_account"

  name                       = replace(format("%s-v-fn-sa", local.project), "-", "") # -v- aka biz view storate for azure-webjobs-eventhub
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = var.storage_account_replication_type
  access_tier                = "Hot"
  blob_versioning_enabled    = false
  resource_group_name        = azurerm_resource_group.bizevents_rg.name
  location                   = var.location
  advanced_threat_protection = var.bizevents_datastore_fn_sa_advanced_threat_protection

  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true

  blob_delete_retention_days = var.bizevents_datastore_fn_sa_delete_retention_days
  tags                       = module.tag_config.tags
}
