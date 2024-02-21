data "azurerm_resource_group" "data" {
  name = "${local.product}-data-rg"
}


data "azurerm_subnet" "eventhub_snet" {
  resource_group_name  = data.azurerm_resource_group.rg_vnet_integration.name
  name                 = "pagopa-u-eventhub-snet"
  virtual_network_name = "pagopa-u-vnet-integration"
}
