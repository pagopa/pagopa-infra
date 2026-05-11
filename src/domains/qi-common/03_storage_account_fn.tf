resource "azurerm_resource_group" "qi_rg" {
  name     = "${local.project}-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "qi_fn_sa" {
  source = "./.terraform/modules/__v4__/storage_account"

  name                       = replace(format("%s-fn-sa", local.project), "-", "")
  account_kind               = var.qi_storage_params.kind
  account_tier               = var.qi_storage_params.tier
  account_replication_type   = var.qi_storage_params.account_replication_type
  access_tier                = var.qi_storage_params.access_tier
  blob_versioning_enabled    = false
  resource_group_name        = azurerm_resource_group.qi_rg.name
  location                   = var.location
  advanced_threat_protection = var.qi_storage_params.advanced_threat_protection

  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true

  blob_delete_retention_days = var.qi_storage_params.retention_days
  tags                       = module.tag_config.tags
}
