
data "azurerm_resource_group" "rg_vnet" {
  name = "${local.project}-vnet-rg"
}


data "azurerm_virtual_network" "vnet" {
  name                = "${local.project}-vnet"
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}

data "azurerm_virtual_network" "vnet_integration" {
  name                = "${local.project}-vnet-integration"
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}


data "azurerm_subnet" "eventhub_snet" {
  name                 = format("%s-eventhub-snet", local.project)
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = data.azurerm_virtual_network.vnet_integration.name
}

