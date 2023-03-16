module "afm_storage" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v2.18.10"

  name                       = replace(format("%s-sa", local.project), "-", "")
  account_kind               = var.afm_storage_params.kind
  account_tier               = var.afm_storage_params.tier
  account_replication_type   = var.afm_storage_params.account_replication_type
  access_tier                = "Hot"
  versioning_name            = "versioning"
  enable_versioning          = true
  resource_group_name        = azurerm_resource_group.afm_rg.name
  location                   = var.location
  advanced_threat_protection = var.afm_storage_params.advanced_threat_protection
  allow_blob_public_access   = false

  blob_properties_delete_retention_policy_days = var.afm_storage_params.retention_days

  tags = var.tags
}

resource "azurerm_storage_table" "issuer_range_table" {
  name                 = format("%sissuerrangetable", module.afm_storage.name)
  storage_account_name = module.afm_storage.name
}
