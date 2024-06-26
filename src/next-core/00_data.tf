data "azurerm_resource_group" "data" {
  name = "${local.product}-data-rg"
}


data "azurerm_subnet" "eventhub_snet" {
  resource_group_name  = data.azurerm_resource_group.rg_vnet_integration.name
  virtual_network_name = data.azurerm_virtual_network.vnet_integration.name
  name                 = "${local.product}-eventhub-snet"
}
data "azurerm_resource_group" "rg_vnet" {
  name = format("%s-vnet-rg", local.product)
}

data "azurerm_resource_group" "sec_rg" {
  name = format("%s-sec-rg", local.product)
}

data "azurerm_resource_group" "rg_api" {
  name = format("%s-api-rg", local.product)
}
