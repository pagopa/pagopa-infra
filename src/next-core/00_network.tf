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


data "azurerm_private_dns_zone" "eventhub" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = local.msg_resource_group_name
}


data "azurerm_route_table" "rt_sia" {
  name                = "${local.product}-sia-rt"
  resource_group_name = local.vnet_core_resource_group_name
}

data "azurerm_subnet" "node_forwarder_snet" {
  name                 = "${local.product}-node-forwarder-snet"
  resource_group_name  = local.vnet_core_resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_core.name
}


data "azurerm_private_dns_zone" "postgres" {
  count               = var.env_short != "d" ? 1 : 0
  name                = "private.postgres.database.azure.com"
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}

data "azurerm_nat_gateway" "nat_gw" {
  name                = "${local.product}-natgw"
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}
