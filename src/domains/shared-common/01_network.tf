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

data "azurerm_private_dns_zone" "cosmos_table" {
  name                = local.cosmos_table_dns_zone_name
  resource_group_name = local.cosmos_table_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "storage" {
  name                = local.storage_queue_dns_zone_name
  resource_group_name = local.storage_dns_zone_resource_group_name
}

module "taxonomy_storage_snet" {
  count  = var.env_short == "d" ? 0 : 1
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.53.0"

  name                 = "${local.project}-${local.taxonomy_label}-storage-snet"
  address_prefixes     = var.cidr_subnet_taxonomy_storage_account
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_name

  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Storage",
  ]
}

data "azurerm_private_dns_zone" "privatelink_blob_azure_com" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = local.vnet_resource_group_name
}
