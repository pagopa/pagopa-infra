#
# Core
#
data "azurerm_resource_group" "vnet_core_rg" {
  name = local.vnet_core_resource_group_name
}

data "azurerm_virtual_network" "vnet_core" {
  name                = local.vnet_core_name
  resource_group_name = data.azurerm_resource_group.vnet_core_rg.name
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

#
# Vnet AKS
#
data "azurerm_resource_group" "vnet_aks_rg" {
  name = var.rg_vnet_aks_name
}

data "azurerm_virtual_network" "vnet_aks" {
  name                = var.vnet_aks_name
  resource_group_name = data.azurerm_resource_group.vnet_aks_rg.name
}

#
# Vnet pair
#
data "azurerm_resource_group" "vnet_pair_rg" {
  name = local.vnet_pair_resource_group_name
}

data "azurerm_virtual_network" "vnet_pair" {
  name                = local.vnet_pair_name
  resource_group_name = data.azurerm_resource_group.vnet_pair_rg.name
}

#
# Pip
#
data "azurerm_public_ip" "pip_aks_outboud" {
  name                = var.public_ip_aksoutbound_name
  resource_group_name = data.azurerm_resource_group.vnet_aks_rg.name
}
