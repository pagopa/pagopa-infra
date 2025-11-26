#
# Core
#
data "azurerm_resource_group" "vnet_core_rg" {
  name = local.vnet_resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_private_dns_zone" "storage_account_private_dns_zone" {
  name = "privatelink.blob.core.windows.net"
}

data "azurerm_subnet" "private_endpoint_subnet" {
  name                 = "${local.product}-common-private-endpoint-snet"
  resource_group_name  = data.azurerm_resource_group.vnet_core_rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}
