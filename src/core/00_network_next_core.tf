data "azurerm_virtual_network" "vnet_ita" {
  name                = local.vnet_ita_name
  resource_group_name = local.vnet_ita_resource_group_name
}

data "azurerm_resource_group" "rg_vnet_ita" {
  name = local.vnet_ita_resource_group_name
}
