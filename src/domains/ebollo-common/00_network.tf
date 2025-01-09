data "azurerm_virtual_network" "vnet_italy" {
  name                = local.vnet_italy_name
  resource_group_name = local.vnet_italy_resource_group_name
}

data "azurerm_resource_group" "rg_vnet_italy" {
  name = local.vnet_italy_resource_group_name
}

#
# Subnets
#
data "azurerm_subnet" "aks_subnet" {
  name                 = local.aks_subnet_name
  virtual_network_name = local.vnet_italy_name
  resource_group_name  = local.vnet_italy_resource_group_name
}

#
# Private DNS Zones
#
data "azurerm_private_dns_zone" "internal" {
  name                = local.internal_dns_zone_name
  resource_group_name = local.internal_dns_zone_resource_group_name
}

data "azurerm_resource_group" "rg_event_private_dns_zone" {
  name = local.msg_resource_group_name
}
