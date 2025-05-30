# resource "azurerm_resource_group" "api_config_common_rg" {
#   name     = format("%s-api-config-common-rg", local.product)
#   location = var.location

#   tags = module.tag_config.tags
# }

data "azurerm_resource_group" "api_config_rg" {
  name = "${local.product}-api-config-rg"
}

data "azurerm_storage_account" "api_config_ica_sa" {
  name                = replace(format("%s-sa", local.project), "-", "")
  resource_group_name = data.azurerm_resource_group.api_config_rg.name
}

module "api_config_ica_sa" {
  source = "./.terraform/modules/__v3__/storage_account"

  name                            = replace(format("%s-sa", local.project), "-", "")
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  account_replication_type        = var.api_config_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.api_config_enable_versioning
  resource_group_name             = data.azurerm_resource_group.api_config_rg.name
  location                        = var.location
  advanced_threat_protection      = var.api_config_reporting_advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true
  enable_low_availability_alert   = false


  blob_change_feed_enabled             = var.enable_apiconfig_sa_backup
  blob_change_feed_retention_in_days   = var.enable_apiconfig_sa_backup ? var.api_config_reporting_backup_retention_days + 1 : null
  blob_container_delete_retention_days = var.api_config_reporting_backup_retention_days
  blob_storage_policy = {
    enable_immutability_policy = false
    blob_restore_policy_days   = var.api_config_reporting_backup_retention_days
  }
  blob_delete_retention_days = var.api_config_reporting_delete_retention_days
  tags                       = module.tag_config.tags
}


resource "azurerm_storage_table" "ica_table" {
  name                 = format("%sicatable", module.api_config_ica_sa.name)
  storage_account_name = module.api_config_ica_sa.name
}
