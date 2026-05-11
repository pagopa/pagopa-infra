data "azurerm_subnet" "vpn_subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = "${local.product}-vnet-rg"
  virtual_network_name = "${local.product}-vnet"
}

data "azurerm_private_dns_zone" "private_endpoint_dns_zone" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = "${local.product}-vnet-rg"
}

data "azurerm_subnet" "private_endpoint_snet" {
  name                 = "${local.product}-common-private-endpoint-snet"
  resource_group_name  = "${local.product}-vnet-rg"
  virtual_network_name = "${local.product}-vnet"
}