data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_private_dns_zone" "internal" {
  name                = local.internal_dns_zone_name
  resource_group_name = local.internal_dns_zone_resource_group_name
}

resource "azurerm_private_dns_a_record" "ingress" {
  name                = local.ingress_hostname
  zone_name           = data.azurerm_private_dns_zone.internal.name
  resource_group_name = local.internal_dns_zone_resource_group_name
  ttl                 = 3600
  records             = [var.ingress_load_balancer_ip]
}

data "azurerm_subnet" "aks_subnet" {
  name                 = local.aks_subnet_name
  virtual_network_name = local.vnet_name
  resource_group_name  = local.vnet_resource_group_name
}

data "azurerm_private_dns_zone" "cosmos" {
  name                = local.cosmos_dns_zone_name
  resource_group_name = local.cosmos_dns_zone_resource_group_name
}

data "azurerm_subnet" "apiconfig_subnet" {
  # pagopa-u-<...>
  name                 = format("%s-%s-api-config-snet", var.prefix, var.env_short)
  virtual_network_name = format("%s-%s-vnet-integration", var.prefix, var.env_short)
  resource_group_name  = format("%s-%s-vnet-rg", var.prefix, var.env_short)
}

data "azurerm_resource_group" "rg_vnet" {
  name = local.vnet_resource_group_name
}


