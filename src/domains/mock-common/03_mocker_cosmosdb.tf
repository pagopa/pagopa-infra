locals {
  cosmosdb_mongodb_enable_serverless = contains(var.cosmosdb_mongodb_extra_capabilities, "EnableServerless")
}

# resource group
resource "azurerm_resource_group" "mock_rg" {
  name     = "${local.product}-mock-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "mocker_cosmosdb_snet" {
  source               = "./.terraform/modules/__v3__/subnet"
  name                 = "${local.project}-cosmosdb-snet"
  address_prefixes     = var.cidr_subnet_mocker_cosmosdb
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_name

  private_endpoint_network_policies_enabled = false

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]
}

module "mocker_cosmosdb_account" {
  source   = "./.terraform/modules/__v3__/cosmosdb_account"
  name     = "${local.project}-cosmos-account"
  location = var.location
  domain   = var.domain

  resource_group_name  = azurerm_resource_group.mock_rg.name
  offer_type           = var.mocker_cosmosdb_params.offer_type
  kind                 = var.mocker_cosmosdb_params.kind
  capabilities         = var.mocker_cosmosdb_params.capabilities
  mongo_server_version = var.mocker_cosmosdb_params.server_version

  main_geo_location_zone_redundant = var.mocker_cosmosdb_params.main_geo_location_zone_redundant

  enable_free_tier = var.mocker_cosmosdb_params.enable_free_tier

  public_network_access_enabled = var.mocker_cosmosdb_params.public_network_access_enabled

  consistency_policy = var.mocker_cosmosdb_params.consistency_policy

  main_geo_location_location = var.location
  additional_geo_locations   = var.mocker_cosmosdb_params.additional_geo_locations
  backup_continuous_enabled  = var.mocker_cosmosdb_params.backup_continuous_enabled

  is_virtual_network_filter_enabled = var.mocker_cosmosdb_params.is_virtual_network_filter_enabled

  ip_range = ""

  # add data.azurerm_subnet.<my_service>.id
  allowed_virtual_network_subnet_ids = var.mocker_cosmosdb_params.public_network_access_enabled ? [] : [data.azurerm_subnet.aks_subnet.id]


  private_endpoint_enabled   = var.mocker_cosmosdb_params.private_endpoint_enabled
  subnet_id                  = module.mocker_cosmosdb_snet.id
  private_dns_zone_mongo_ids = [data.azurerm_private_dns_zone.cosmos.id]

  tags = module.tag_config.tags
}

resource "azurerm_cosmosdb_mongo_database" "mocker" {
  name                = "mocker"
  resource_group_name = azurerm_resource_group.mock_rg.name
  account_name        = module.mocker_cosmosdb_account.name

  throughput = var.cosmosdb_mongodb_enable_autoscaling || local.cosmosdb_mongodb_enable_serverless ? null : var.cosmosdb_mongodb_throughput

  dynamic "autoscale_settings" {
    for_each = var.cosmosdb_mongodb_enable_autoscaling && !local.cosmosdb_mongodb_enable_serverless ? [
      ""
    ] : []
    content {
      max_throughput = var.cosmosdb_mongodb_max_throughput
    }
  }
}
