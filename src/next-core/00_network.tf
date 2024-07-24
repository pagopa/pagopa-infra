data "azurerm_virtual_network" "vnet_core" {
  name                = local.vnet_core_name
  resource_group_name = local.vnet_core_resource_group_name
}

data "azurerm_resource_group" "rg_vnet_core" {
  name = local.vnet_core_resource_group_name
}

data "azurerm_virtual_network" "vnet_integration" {
  name                = local.vnet_integration_name
  resource_group_name = local.vnet_integration_resource_group_name
}

data "azurerm_resource_group" "rg_vnet_integration" {
  name = local.vnet_integration_resource_group_name
}

data "azurerm_subnet" "private_endpoint_snet" {
  name                 = "${local.product}-common-private-endpoint-snet"
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = data.azurerm_virtual_network.vnet_core.name
}

data "azurerm_private_dns_zone" "privatelink_blob_core_windows_net" {
  name = "privatelink.blob.core.windows.net"
}


data "azurerm_route_table" "rt_sia" {
  name                = "${local.product}-sia-rt"
  resource_group_name = local.vnet_core_resource_group_name
}

data "azurerm_public_ip" "natgateway_public_ip" {
  count               = var.nat_gateway_public_ips
  name                = "${local.product}-natgw-pip-0${count.index + 1}"
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}
