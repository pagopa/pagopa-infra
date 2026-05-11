data "azurerm_subnet" "vpn_snet" {
  name                 = "GatewaySubnet"
  virtual_network_name = local.vnet_name
  resource_group_name  = local.vnet_resource_group_name
}
