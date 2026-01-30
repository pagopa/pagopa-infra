module "cosmosdb_account_mongodb_fdr_re" {
  source              = "./.terraform/modules/__v4__/cosmosdb_account"
  domain              = var.domain
  name                = "${local.project}-re-cosmos-account"
  location            = var.location
  resource_group_name = azurerm_resource_group.db_rg.name

  offer_type           = var.cosmos_mongo_db_fdr_re_params.offer_type
  kind                 = var.cosmos_mongo_db_fdr_re_params.kind
  capabilities         = var.cosmos_mongo_db_fdr_re_params.capabilities
  mongo_server_version = var.cosmos_mongo_db_fdr_re_params.server_version
  enable_free_tier     = var.cosmos_mongo_db_fdr_re_params.enable_free_tier

  public_network_access_enabled      = var.cosmos_mongo_db_fdr_re_params.public_network_access_enabled
  private_endpoint_enabled           = var.cosmos_mongo_db_fdr_re_params.private_endpoint_enabled
  subnet_id                          = module.cosmosdb_fdr_snet.id
  private_dns_zone_mongo_ids         = [data.azurerm_private_dns_zone.cosmos.id]
  is_virtual_network_filter_enabled  = var.cosmos_mongo_db_fdr_re_params.is_virtual_network_filter_enabled
  allowed_virtual_network_subnet_ids = var.cosmos_mongo_db_fdr_re_params.public_network_access_enabled ? [] : [data.azurerm_subnet.aks_subnet.id]

  consistency_policy               = var.cosmos_mongo_db_fdr_re_params.consistency_policy
  main_geo_location_location       = var.location
  main_geo_location_zone_redundant = var.cosmos_mongo_db_fdr_re_params.main_geo_location_zone_redundant
  additional_geo_locations         = var.cosmos_mongo_db_fdr_re_params.additional_geo_locations

  backup_continuous_enabled = var.cosmos_mongo_db_fdr_re_params.backup_continuous_enabled
  burst_capacity_enabled =  var.cosmos_mongo_db_fdr_re_params.burst_capacity_enabled
  ip_range = var.cosmos_mongo_db_fdr_re_params.ip_range
  tags = module.tag_config.tags
}

resource "azurerm_cosmosdb_mongo_database" "fdr_re" {

  name                = "fdr-re"
  resource_group_name = azurerm_resource_group.db_rg.name
  account_name        = module.cosmosdb_account_mongodb_fdr_re.name

  throughput = var.cosmos_mongo_db_fdr_re_params.enable_autoscaling || var.cosmos_mongo_db_fdr_re_params.enable_serverless ? null : var.cosmos_mongo_db_fdr_re_params.throughput

  dynamic "autoscale_settings" {
    for_each = var.cosmos_mongo_db_fdr_re_params.enable_autoscaling && !var.cosmos_mongo_db_fdr_re_params.enable_serverless ? [""] : []
    content {
      max_throughput = var.cosmos_mongo_db_fdr_re_params.max_throughput
    }
  }
}

# Collections
locals {
  fdr_re_collections = [
    {
      name = "events"
      indexes = [
        {
          keys   = ["_id"]
          unique = true
        },
        {
          keys   = ["PartitionKey"]
          unique = false
        },
        {
          keys   = ["fdr"]
          unique = false
        },
        {
          keys   = ["pspId"]
          unique = false
        },
        {
          keys   = ["organizationId"]
          unique = false
        },
        {
          keys   = ["fdrAction"]
          unique = false
        },
      ]
      shard_key = "created"
    },
    ### fdr1-metadata, reference collection for Blobs URI ###
    {
      name = "fdr1-metadata"
      indexes = [
        {
          keys   = ["_id"]
          unique = true
        },
        {
          keys   = ["PartitionKey"]
          unique = false
        }
      ]
      shard_key = "pspCreditorInstitution"
    }
  ]
}

module "cosmosdb_fdr_re_collections" {
  source = "./.terraform/modules/__v4__/cosmosdb_mongodb_collection"

  for_each = {
    for index, coll in local.fdr_re_collections :
    coll.name => coll
  }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.db_rg.name

  cosmosdb_mongo_account_name  = module.cosmosdb_account_mongodb_fdr_re.name
  cosmosdb_mongo_database_name = azurerm_cosmosdb_mongo_database.fdr_re.name

  indexes   = each.value.indexes
  shard_key = each.value.shard_key

  default_ttl_seconds = var.cosmos_mongo_db_fdr_re_params.container_default_ttl

  lock_enable = var.env_short == "p" ? true : false
}
