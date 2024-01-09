data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_private_dns_zone" "internal" {
  name                = local.internal_dns_zone_name
  resource_group_name = local.internal_dns_zone_resource_group_name
}

data "azurerm_resource_group" "rg_vnet" {
  name = local.vnet_resource_group_name
}

data "azurerm_virtual_network" "vnet_replica" {
  count               = var.geo_replica_enabled ? 1 : 0
  name                = local.vnet_replica_name
  resource_group_name = local.vnet_resource_group_name
}

resource "azurerm_private_dns_a_record" "ingress" {
  name                = local.ingress_hostname
  zone_name           = data.azurerm_private_dns_zone.internal.name
  resource_group_name = local.internal_dns_zone_resource_group_name
  ttl                 = 3600
  records             = [var.ingress_load_balancer_ip]
}

data "azurerm_private_dns_zone" "storage" {
  count               = var.env_short != "d" ? 1 : 0
  name                = local.storage_dns_zone_name
  resource_group_name = local.storage_dns_zone_resource_group_name
}

# Azure Storage subnet
module "storage_account_snet" {
  source                                        = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.2.1"
  name                                          = "${local.project}-storage-account-snet"
  address_prefixes                              = var.cidr_subnet_gpd_storage_account
  resource_group_name                           = local.vnet_resource_group_name
  virtual_network_name                          = data.azurerm_virtual_network.vnet.name
  service_endpoints                             = ["Microsoft.Storage"]
  private_link_service_network_policies_enabled = var.storage_account_snet_private_link_service_network_policies_enabled
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

data "azurerm_private_dns_zone" "cosmos_table" {
  name                = local.cosmos_table_dns_zone_name
  resource_group_name = local.cosmos_table_dns_zone_resource_group_name
}
