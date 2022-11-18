
module "bizevents_datastore_fn_sa" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v2.0.28"

  name                       = replace(format("%s-fn-sa", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = "LRS"
  access_tier                = "Hot"
  versioning_name            = "versioning"
  enable_versioning          = var.bizevents_datastore_fn_sa_enable_versioning
  resource_group_name        = azurerm_resource_group.bizevents_rg.name
  location                   = var.location
  advanced_threat_protection = var.bizevents_datastore_fn_sa_advanced_threat_protection
  allow_blob_public_access   = false

  blob_properties_delete_retention_policy_days = var.bizevents_datastore_fn_sa_delete_retention_days

  tags = var.tags
}
