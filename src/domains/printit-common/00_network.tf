data "azurerm_virtual_network" "vnet_italy" {
  name                = local.vnet_italy_name
  resource_group_name = local.vnet_italy_resource_group_name
}

data "azurerm_resource_group" "rg_vnet_italy" {
  name = local.vnet_italy_resource_group_name
}

#
# Subnets
#
data "azurerm_subnet" "aks_subnet" {
  name                 = local.aks_subnet_name
  virtual_network_name = local.vnet_italy_name
  resource_group_name  = local.vnet_italy_resource_group_name
}

#
# Private DNS Zones
#
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

data "azurerm_private_dns_zone" "cosmos" {
  name                = local.cosmos_dns_zone_name
  resource_group_name = local.cosmos_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "privatelink_blob_azure_com" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = local.vnet_core_resource_group_name
}

data "azurerm_private_dns_zone" "privatelink_table_azure_com" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = local.vnet_core_resource_group_name
}

data "azurerm_private_dns_zone" "privatelink_queue_azure_com" {
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = local.vnet_core_resource_group_name
}