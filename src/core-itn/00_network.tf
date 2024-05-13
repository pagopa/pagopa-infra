#
# VNET
#
### CORE
data "azurerm_virtual_network" "vnet_core" {
  name                = local.vnet_core_name
  resource_group_name = local.vnet_core_resource_group_name
}

data "azurerm_resource_group" "rg_vnet_core" {
  name = local.vnet_core_resource_group_name
}

### INTEGRATION
data "azurerm_virtual_network" "vnet_integration" {
  name                = local.vnet_integration_name
  resource_group_name = local.vnet_integration_resource_group_name
}

data "azurerm_resource_group" "rg_vnet_integration" {
  name = local.vnet_integration_resource_group_name
}

#
# Eventhub
#
data "azurerm_private_dns_zone" "eventhub" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = local.msg_resource_group_name
}

data "azurerm_resource_group" "rg_event_private_dns_zone" {
  name = local.msg_resource_group_name
}

