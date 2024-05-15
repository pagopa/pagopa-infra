resource "azurerm_subnet" "cosmosdb_italy_snet" {
  name                 = "${local.project}-cosmosdb-snet"
  resource_group_name  = data.azurerm_resource_group.rg_vnet_italy.name
  virtual_network_name = data.azurerm_virtual_network.vnet_italy.name
  address_prefixes     = var.cidr_printit_cosmosdb_italy

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
  ]
}

resource "azurerm_subnet" "cidr_storage_italy" {
  name                 = "${local.project}-storage-snet"
  resource_group_name  = data.azurerm_resource_group.rg_vnet_italy.name
  virtual_network_name = data.azurerm_virtual_network.vnet_italy.name
  address_prefixes     = var.cidr_printit_storage_italy
}

resource "azurerm_subnet" "cidr_redis_italy" {
  name                 = "${local.project}-redis-snet"
  resource_group_name  = data.azurerm_resource_group.rg_vnet_italy.name
  virtual_network_name = data.azurerm_virtual_network.vnet_italy.name
  address_prefixes     = var.cidr_printit_redis_italy
}

resource "azurerm_subnet" "cidr_postgres_italy" {
  name                 = "${local.project}-postgresql-snet"
  resource_group_name  = data.azurerm_resource_group.rg_vnet_italy.name
  virtual_network_name = data.azurerm_virtual_network.vnet_italy.name
  address_prefixes     = var.cidr_printit_postgresql_italy
}


resource "azurerm_subnet" "pdf_engine_italy_snet" {
  name                 = "${local.project}-pdf-engine-snet"
  resource_group_name  = data.azurerm_resource_group.rg_vnet_italy.name
  virtual_network_name = data.azurerm_virtual_network.vnet_italy.name
  address_prefixes     = var.cidr_printit_pdf_engine_italy

  delegation {
    name = "delegation"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
