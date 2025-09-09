data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_virtual_network" "vnet_replica" {
  count               = var.geo_replica_enabled ? 1 : 0
  name                = local.vnet_replica_name
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_virtual_network" "vnet_italy" {
  name                = local.vnet_replica_name
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

data "azurerm_private_dns_zone" "postgres" {
  count               = var.env_short != "d" ? 1 : 0
  name                = "private.postgres.database.azure.com"
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}

data "azurerm_resource_group" "rg_vnet" {
  name = local.vnet_resource_group_name
}

data "azurerm_private_dns_zone" "cosmos" {
  name                = local.cosmos_dns_zone_name
  resource_group_name = local.cosmos_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "privatelink_blob_azure_com" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_private_dns_zone" "privatelink_table_azure_com" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_private_dns_zone" "privatelink_queue_azure_com" {
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = local.vnet_resource_group_name
}

module "fdr_storage_snet" {
  count  = var.env_short == "d" ? 0 : 1
  source = "./.terraform/modules/__v3__/subnet"

  name                 = "${local.project}-storage-snet"
  address_prefixes     = var.cidr_subnet_storage_account
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_name

  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Storage",
  ]
}

module "cosmosdb_fdr_snet" {
  source               = "./.terraform/modules/__v3__/subnet"
  name                 = "${local.project}-cosmosb-snet"
  address_prefixes     = var.cidr_subnet_cosmosdb_fdr
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_name

  private_link_service_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
  ]
}
