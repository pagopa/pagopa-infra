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

resource "azurerm_private_dns_zone_virtual_network_link" "aks_private_dns_link_tools_vnet" {
  for_each = local.aks_private_clusters

  name                  = "aks-${each.key}-private-dns-link-tools-vnet"
  resource_group_name   = each.value.node_resource_group
  private_dns_zone_name = data.azurerm_private_dns_zone.aks_private_dns_zone[each.key].name
  virtual_network_id    = data.azurerm_virtual_network.network_tools_vnet.id
  registration_enabled  = false

  tags = module.tag_config.tags
}
