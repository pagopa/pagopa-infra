data "azurerm_api_management" "apim" {
  name                = "${local.product}-apim"
  resource_group_name = "${local.product}-api-rg"
}

data "azurerm_subnet" "apim_subnet" {
  name                 = "${local.product}-apim-snet"
  resource_group_name  = local.vnet_integration_resource_group_name
  virtual_network_name = local.vnet_integration_name
}
