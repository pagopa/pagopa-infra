#
# ITALY
#
data "azurerm_resource_group" "vnet_ita_rg" {
  name = local.vnet_ita_resource_group_name
}

data "azurerm_virtual_network" "vnet_ita" {
  name                = local.vnet_ita_name
  resource_group_name = data.azurerm_resource_group.vnet_ita_rg.name
}

#
# CORE
#
data "azurerm_resource_group" "vnet_core_rg" {
  name = local.vnet_core_resource_group_name
}

data "azurerm_virtual_network" "vnet_core" {
  name                = local.vnet_core_name
  resource_group_name = data.azurerm_resource_group.vnet_core_rg.name
}

#
# Pip
#
data "azurerm_public_ip" "pip_aks_outboud" {
  name                = local.public_ip_aks_leonardo_outbound_name
  resource_group_name = data.azurerm_resource_group.vnet_ita_rg.name
}
