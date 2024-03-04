data "azurerm_virtual_network" "vnet_ita" {
  name                = local.vnet_itn_name
  resource_group_name = local.vnet_itn_resource_group_name
}

data "azurerm_resource_group" "rg_vnet_ita" {
  name = local.vnet_itn_resource_group_name
}
