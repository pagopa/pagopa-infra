data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_subnet" "apim_vnet" {
  name                 = local.apim_vnet_snet
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_integration_name
}

data "azurerm_dns_zone" "public" {
  name = join(".", [var.apim_dns_zone_prefix, var.external_domain])
}
