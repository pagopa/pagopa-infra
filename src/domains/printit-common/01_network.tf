resource "azurerm_private_dns_a_record" "ingress" {
  name                = local.ingress_hostname
  zone_name           = data.azurerm_private_dns_zone.internal.name
  resource_group_name = local.internal_dns_zone_resource_group_name
  ttl                 = 3600
  records             = [var.ingress_load_balancer_ip]
}

###

resource "azurerm_subnet" "cosmosdb_italy_snet" {
  name                              = "${local.project}-cosmosdb-snet"
  resource_group_name               = data.azurerm_resource_group.rg_vnet_italy.name
  virtual_network_name              = data.azurerm_virtual_network.vnet_italy.name
  address_prefixes                  = var.cidr_printit_cosmosdb_italy
  private_endpoint_network_policies = "Enabled"

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
  ]
}

resource "azurerm_subnet" "cidr_storage_italy" {
  name                              = "${local.project}-storage-snet"
  resource_group_name               = data.azurerm_resource_group.rg_vnet_italy.name
  virtual_network_name              = data.azurerm_virtual_network.vnet_italy.name
  address_prefixes                  = var.cidr_printit_storage_italy
  private_endpoint_network_policies = "Enabled"

}

resource "azurerm_subnet" "cidr_redis_italy" {
  name                              = "${local.project}-redis-snet"
  resource_group_name               = data.azurerm_resource_group.rg_vnet_italy.name
  virtual_network_name              = data.azurerm_virtual_network.vnet_italy.name
  address_prefixes                  = var.cidr_printit_redis_italy
  private_endpoint_network_policies = "Enabled"
}

resource "azurerm_subnet" "pdf_engine_italy_snet" {
  name = "${local.project}-pdf-engine-snet"

  resource_group_name               = data.azurerm_resource_group.rg_vnet_italy.name
  virtual_network_name              = data.azurerm_virtual_network.vnet_italy.name
  address_prefixes                  = var.cidr_printit_pdf_engine_italy
  private_endpoint_network_policies = "Enabled"

  delegation {
    name = "delegation"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet" "eventhub_italy" {
  name                              = "${local.project}-eventhub-snet"
  resource_group_name               = data.azurerm_resource_group.rg_vnet_italy.name
  virtual_network_name              = data.azurerm_virtual_network.vnet_italy.name
  address_prefixes                  = var.cidr_printit_eventhub_italy
  private_endpoint_network_policies = "Enabled"

}
