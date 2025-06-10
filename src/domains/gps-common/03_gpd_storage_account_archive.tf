# ##################
# ## GPD ARCHIVE ##
# ##################

# # storage
# module "gpd_archive_sa" {
#   source = "./.terraform/modules/__v3__/storage_account"

#   name                            = replace(format("%s-%s-gpd-archive-sa", local.product, var.location_short), "-", "")
#   account_kind                    = "StorageV2"
#   account_tier                    = "Standard"
#   account_replication_type        = var.gpd_archive_replication_type
#   access_tier                     = "Cool"
#   resource_group_name             = azurerm_resource_group.gps_rg.name
#   location                        = var.location
#   advanced_threat_protection      = var.gpd_archive_advanced_threat_protection
#   allow_nested_items_to_be_public = false
#   public_network_access_enabled   = true
#   enable_low_availability_alert   = false

#   // blob section not used & not cfg

#   tags = module.tag_config.tags
# }


# ## table debt position archive storage
# resource "azurerm_storage_table" "gpd_archive_pd_table" {
#   name                 = "paymentpositiontable"
#   storage_account_name = module.gpd_archive_sa.name
# }

# ## table payments options archive storage
# resource "azurerm_storage_table" "gpd_archive_po_table" {
#   name                 = "paymentoptiontable"
#   storage_account_name = module.gpd_archive_sa.name
# }
