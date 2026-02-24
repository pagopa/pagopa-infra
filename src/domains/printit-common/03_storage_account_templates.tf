module "templates_sa" {
  source = "./.terraform/modules/__v4__/storage_account"
  count  = var.is_feature_enabled.storage_templates ? 1 : 0

  name                       = replace("${local.project_short}-templates", "-", "")
  account_kind               = var.templates_storage_account.account_kind
  account_tier               = var.templates_storage_account.account_tier
  account_replication_type   = var.templates_storage_account.account_replication_type
  access_tier                = "Hot"
  blob_versioning_enabled    = var.templates_storage_account.blob_versioning_enabled
  resource_group_name        = azurerm_resource_group.printit_rg.name
  location                   = var.location
  advanced_threat_protection = var.templates_storage_account.advanced_threat_protection

  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.templates_storage_account.public_network_access_enabled
  enable_low_availability_alert   = var.templates_storage_account.enable_low_availability_alert

  private_endpoint_enabled   = var.is_feature_enabled.storage_templates && var.env_short != "d"
  private_dns_zone_blob_ids  = [data.azurerm_private_dns_zone.privatelink_blob_azure_com.id]
  private_dns_zone_table_ids = [data.azurerm_private_dns_zone.privatelink_table_azure_com.id]
  subnet_id                  = var.env_short != "d" ? module.storage_spoke_printit_snet[0].id : null


  blob_delete_retention_days = var.templates_storage_account.blob_delete_retention_days

  blob_change_feed_enabled             = var.templates_storage_account.backup_enabled
  blob_change_feed_retention_in_days   = var.templates_storage_account.backup_enabled ? var.templates_storage_account.backup_retention + 1 : null
  blob_container_delete_retention_days = var.templates_storage_account.backup_retention
  blob_storage_policy = {
    enable_immutability_policy = false
    blob_restore_policy_days   = var.templates_storage_account.backup_retention
  }

  tags = module.tag_config.tags
}

resource "azurerm_storage_container" "template_blob_file" {
  count                 = var.is_feature_enabled.storage_templates ? 1 : 0
  name                  = "noticetemplateblob"
  storage_account_name  = module.templates_sa[0].name
  container_access_type = "private"
}

resource "azurerm_storage_table" "template_data_table" {
  count                = var.is_feature_enabled.storage_templates ? 1 : 0
  name                 = "noticetemplatedatatable"
  storage_account_name = module.templates_sa[0].name
}

