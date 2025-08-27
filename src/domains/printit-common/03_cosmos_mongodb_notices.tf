resource "azurerm_resource_group" "db_rg" {
  name     = "${local.project}-db-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "cosmosdb_account_mongodb" {
  source = "./.terraform/modules/__v3__//cosmosdb_account"
  count  = var.is_feature_enabled.cosmosdb_notice ? 1 : 0

  domain              = var.domain
  name                = "${local.project}-cosmos-account"
  location            = var.location
  resource_group_name = azurerm_resource_group.db_rg.name

  offer_type           = var.cosmos_mongo_db_notices_params.offer_type
  kind                 = var.cosmos_mongo_db_notices_params.kind
  capabilities         = var.cosmos_mongo_db_notices_params.capabilities
  mongo_server_version = var.cosmos_mongo_db_notices_params.server_version
  enable_free_tier     = var.cosmos_mongo_db_notices_params.enable_free_tier

  public_network_access_enabled     = var.cosmos_mongo_db_notices_params.public_network_access_enabled
  private_endpoint_enabled          = var.cosmos_mongo_db_notices_params.private_endpoint_enabled
  subnet_id                         = azurerm_subnet.cosmosdb_italy_snet.id
  private_dns_zone_mongo_ids        = [data.azurerm_private_dns_zone.cosmos.id]
  is_virtual_network_filter_enabled = var.cosmos_mongo_db_notices_params.is_virtual_network_filter_enabled

  consistency_policy               = var.cosmos_mongo_db_notices_params.consistency_policy
  main_geo_location_location       = var.location
  main_geo_location_zone_redundant = var.cosmos_mongo_db_notices_params.main_geo_location_zone_redundant
  additional_geo_locations         = var.cosmos_mongo_db_notices_params.additional_geo_locations

  backup_continuous_enabled = var.cosmos_mongo_db_notices_params.backup_continuous_enabled

  tags = module.tag_config.tags
}

resource "azurerm_cosmosdb_mongo_database" "notices_mongo_db" {
  count = var.is_feature_enabled.cosmosdb_notice ? 1 : 0

  name                = "noticesMongoDb"
  resource_group_name = azurerm_resource_group.db_rg.name
  account_name        = module.cosmosdb_account_mongodb[0].name


  dynamic "autoscale_settings" {
    for_each = var.cosmos_mongo_db_notices_params.enable_autoscaling && !var.cosmos_mongo_db_notices_params.enable_serverless ? [""] : []
    content {
      max_throughput = var.cosmos_mongo_db_notices_params.max_throughput
    }
  }

}

# Collections
locals {
  collections = [
    {
      name = "payment_notice_generation_request"
      indexes = [{
        keys   = ["_id"] # folderId
        unique = true
        },
        {
          keys   = ["userId"] # userId
          unique = false
        }
      ]
      shard_key = null
    },
    {
      name = "payment_notice_generation_request_error"
      indexes = [{
        keys   = ["_id"] # folderId + notice_item_id
        unique = true
        },
        {
          keys   = ["folderId"] # folderId
          unique = false
        }
      ]
      shard_key = null
    }
  ]
}

module "cosmosdb_notices_collections" {
  source = "./.terraform/modules/__v3__//cosmosdb_mongodb_collection"

  for_each = var.is_feature_enabled.cosmosdb_notice ? { for index, coll in local.collections : coll.name => coll } : {}

  name                = each.value.name
  resource_group_name = azurerm_resource_group.db_rg.name

  cosmosdb_mongo_account_name  = module.cosmosdb_account_mongodb[0].name
  cosmosdb_mongo_database_name = azurerm_cosmosdb_mongo_database.notices_mongo_db[0].name

  indexes   = each.value.indexes
  shard_key = each.value.shard_key

  default_ttl_seconds = var.cosmos_mongo_db_notices_params.container_default_ttl

  lock_enable = var.env_short == "p" ? true : false
}
