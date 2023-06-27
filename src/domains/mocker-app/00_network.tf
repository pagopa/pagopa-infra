data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_subnet" "apim_snet" {
  name                 = local.pagopa_apim_snet
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.pagopa_vnet_integration
}
