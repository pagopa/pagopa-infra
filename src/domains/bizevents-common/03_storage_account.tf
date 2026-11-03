module "bizevents_sa" {
  source = "./.terraform/modules/__v4__/storage_account"

  name                       = replace(format("%s-sa", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = var.storage_account_replication_type
  access_tier                = "Hot"
  blob_versioning_enabled    = false
  resource_group_name        = azurerm_resource_group.bizevents_rg.name
  location                   = var.location
  advanced_threat_protection = var.bizevents_sa_advanced_threat_protection

  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true

  blob_delete_retention_days = var.bizevents_sa_delete_retention_days
  tags                       = module.tag_config.tags
}

module "storage_account" {
  source = "./.terraform/modules/__v4__/IDH/storage_account"

  name = replace(format("%s-sa", local.project), "-", "")

  product_name        = var.prefix
  env                 = var.env
  idh_resource_tier   = "basic_public"
  domain              = var.domain
  location            = var.location
  resource_group_name = azurerm_resource_group.bizevents_rg.name
  tags                = module.tag_config.tags
}

resource "azurerm_storage_container" "send_dead_letter_events" {
  name                 = "send-dead-letter-events"
  storage_account_id = module.bizevents_sa.id
}

