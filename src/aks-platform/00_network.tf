#
# Core
#
data "azurerm_resource_group" "vnet_core_rg" {
  name = local.vnet_core_resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group_name
}

#
# Vnet Integration
#
data "azurerm_resource_group" "vnet_integration_rg" {
  name = local.vnet_integration_resource_group_name
}

data "azurerm_virtual_network" "vnet_integration" {
  name                = local.vnet_integration_name
  resource_group_name = data.azurerm_resource_group.vnet_integration_rg.name
}
