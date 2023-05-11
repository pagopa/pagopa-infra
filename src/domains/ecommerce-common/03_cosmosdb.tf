resource "azurerm_resource_group" "cosmosdb_ecommerce_rg" {
  name     = "${local.project}-cosmosdb-rg"
  location = var.location

  tags = var.tags
}

module "cosmosdb_ecommerce_snet" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.7.0"

  name                 = "${local.project}-cosmosb-snet"
  address_prefixes     = var.cidr_subnet_cosmosdb_ecommerce
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_name

  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
  ]
}

module "cosmosdb_account_mongodb" {

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_account?ref=v6.7.0"


  name                = "${local.project}-cosmos-account"
  location            = var.location
  domain              = var.domain
  resource_group_name = azurerm_resource_group.cosmosdb_ecommerce_rg.name

  offer_type           = var.cosmos_mongo_db_params.offer_type
  kind                 = var.cosmos_mongo_db_params.kind
  capabilities         = var.cosmos_mongo_db_params.capabilities
  mongo_server_version = var.cosmos_mongo_db_params.server_version
  enable_free_tier     = var.cosmos_mongo_db_params.enable_free_tier

  public_network_access_enabled      = var.cosmos_mongo_db_params.public_network_access_enabled
  private_endpoint_enabled           = var.cosmos_mongo_db_params.private_endpoint_enabled
  subnet_id                          = module.cosmosdb_ecommerce_snet.id
  private_dns_zone_ids               = [data.azurerm_private_dns_zone.cosmos.id]
  is_virtual_network_filter_enabled  = var.cosmos_mongo_db_params.is_virtual_network_filter_enabled
  allowed_virtual_network_subnet_ids = var.cosmos_mongo_db_params.public_network_access_enabled ? [] : [data.azurerm_subnet.aks_subnet.id]

  consistency_policy               = var.cosmos_mongo_db_params.consistency_policy
  main_geo_location_location       = azurerm_resource_group.cosmosdb_ecommerce_rg.location
  main_geo_location_zone_redundant = var.cosmos_mongo_db_params.main_geo_location_zone_redundant
  additional_geo_locations         = var.cosmos_mongo_db_params.additional_geo_locations

  backup_continuous_enabled = var.cosmos_mongo_db_params.backup_continuous_enabled

  tags = var.tags
}

resource "azurerm_cosmosdb_mongo_database" "ecommerce" {

  name                = "ecommerce"
  resource_group_name = azurerm_resource_group.cosmosdb_ecommerce_rg.name
  account_name        = module.cosmosdb_account_mongodb.name

  throughput = var.cosmos_mongo_db_ecommerce_params.enable_autoscaling || var.cosmos_mongo_db_ecommerce_params.enable_serverless ? null : var.cosmos_mongo_db_ecommerce_params.throughput

  dynamic "autoscale_settings" {
    for_each = var.cosmos_mongo_db_ecommerce_params.enable_autoscaling && !var.cosmos_mongo_db_ecommerce_params.enable_serverless ? [""] : []
    content {
      max_throughput = var.cosmos_mongo_db_ecommerce_params.max_throughput
    }
  }

}

# Collections
locals {
  collections = [
    {
      name = "payment-methods"
      indexes = [{
        keys   = ["_id"]
        unique = true
        }
      ]
      shard_key = null
    },
    {
      name = "eventstore"
      indexes = [{
        keys   = ["_id"]
        unique = true
        },
        {
          keys   = ["transactionId", "creationDate"]
          unique = false
        }
      ]
      shard_key = "transactionId"
    },
    {
      name = "view"
      indexes = [{
        keys   = ["_id"]
        unique = true
        },
        {
          keys   = ["creationDate", "status", "clientId"]
          unique = false
        }
      ]
      shard_key = null
    },
  ]
}

module "cosmosdb_ecommerce_collections" {

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_mongodb_collection?ref=v6.7.0"


  for_each = {
    for index, coll in local.collections :
    coll.name => coll
  }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.cosmosdb_ecommerce_rg.name

  cosmosdb_mongo_account_name  = module.cosmosdb_account_mongodb.name
  cosmosdb_mongo_database_name = azurerm_cosmosdb_mongo_database.ecommerce.name

  indexes     = each.value.indexes
  shard_key   = each.value.shard_key
  lock_enable = var.env_short == "p" ? true : false
}
