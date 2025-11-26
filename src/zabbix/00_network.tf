data "azurerm_resource_group" "rg_vnet_core" {
  name = local.vnet_core_resource_group_name
}

data "azurerm_virtual_network" "vnet_core" {
  name                = local.vnet_core_name
  resource_group_name = local.vnet_core_resource_group_name
}

# data "azurerm_private_dns_zone" "privatelink_postgres_database_azure_com" {
#   name                = local.dns_zone_private_name_postgres
#   resource_group_name = data.azurerm_resource_group.rg_db.name
# }
