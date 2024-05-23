module "cosmosdb_account_mongodb" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_account?ref=v6.3.1"
  domain              = null
  name                = "${local.project}-cosmos-account"
  location            = var.location
  resource_group_name = azurerm_resource_group.db_rg.name

  offer_type           = var.cosmos_mongo_db_fdr_params.offer_type
  kind                 = var.cosmos_mongo_db_fdr_params.kind
  capabilities         = var.cosmos_mongo_db_fdr_params.capabilities
  mongo_server_version = var.cosmos_mongo_db_fdr_params.server_version
  enable_free_tier     = var.cosmos_mongo_db_fdr_params.enable_free_tier

  public_network_access_enabled      = var.cosmos_mongo_db_fdr_params.public_network_access_enabled
  private_endpoint_enabled           = var.cosmos_mongo_db_fdr_params.private_endpoint_enabled
  subnet_id                          = module.cosmosdb_fdr_snet.id
  private_dns_zone_ids               = [data.azurerm_private_dns_zone.cosmos.id]
  is_virtual_network_filter_enabled  = var.cosmos_mongo_db_fdr_params.is_virtual_network_filter_enabled
  allowed_virtual_network_subnet_ids = var.cosmos_mongo_db_fdr_params.public_network_access_enabled ? [] : [data.azurerm_subnet.aks_subnet.id]

  consistency_policy               = var.cosmos_mongo_db_fdr_params.consistency_policy
  main_geo_location_location       = var.location
  main_geo_location_zone_redundant = var.cosmos_mongo_db_fdr_params.main_geo_location_zone_redundant
  additional_geo_locations         = var.cosmos_mongo_db_fdr_params.additional_geo_locations

  backup_continuous_enabled = var.cosmos_mongo_db_fdr_params.backup_continuous_enabled

  tags = var.tags
}

resource "azurerm_cosmosdb_mongo_database" "fdr" {
  name                = "fdr"
  resource_group_name = azurerm_resource_group.db_rg.name
  account_name        = module.cosmosdb_account_mongodb.name

  throughput = var.cosmos_mongo_db_fdr_params.enable_autoscaling || var.cosmos_mongo_db_fdr_params.enable_serverless ? null : var.cosmos_mongo_db_fdr_params.throughput

  dynamic "autoscale_settings" {
    for_each = var.cosmos_mongo_db_fdr_params.enable_autoscaling && !var.cosmos_mongo_db_fdr_params.enable_serverless ? [""] : []
    content {
      max_throughput = var.cosmos_mongo_db_fdr_params.max_throughput
    }
  }

}


# fdr_history
# fdr_insert
# fdr_publish

# fdr_payment_history
# fdr_payment_insert
# fdr_payment_publish

# Collections

# https://learn.microsoft.com/en-us/azure/cosmos-db/mongodb/indexing#compound-indexes-mongodb-server-version-36
# Compound indexes are required if your query needs the ability to sort on multiple fields at once.
# For queries with multiple filters that don't need to sort, create multiple single field indexes instead
# of a compound index to save on indexing costs.

locals {
  collections = [
    {
      name = "fdr_history"
      indexes = [{
        keys   = ["_id"] # reporting_flow_name + revision
        unique = true
        }
      ]
      shard_key = null
    },
    {
      name = "fdr_insert"
      indexes = [
        {
          keys   = ["_id"] # reporting_flow_name
          unique = true
        },
        {
          keys   = ["fdr", "revision"] # reporting_flow_name revision TODO verify if necessary
          unique = true
        },
        {
          keys   = ["fdr"]
          unique = false
        },
        {
          keys   = ["sender.psp_id"]
          unique = false
        }
      ]
      shard_key = null
    },
    {
      name = "fdr_publish"
      indexes = [{
        keys   = ["_id"] # reporting_flow_name
        unique = true
        },
        {
          keys   = ["fdr", "revision"] # reporting_flow_name revision
          unique = true
        },
        {
          keys   = ["fdr"]
          unique = false
        },
        {
          keys   = ["sender.psp_id"]
          unique = false
        }
      ]
      shard_key = null
    },
    {
      name = "fdr_payment_history"
      indexes = [{
        keys   = ["_id"] # index + ref_fdr_reporting_flow_name + ref_fdr_id
        unique = true
        }
      ]
      shard_key = null
    },
    {
      name = "fdr_payment_insert"
      indexes = [
        {
          keys   = ["_id"] # index + ref_fdr_reporting_flow_name + ref_fdr_id
          unique = true
        },
        {
          keys   = ["ref_fdr"]
          unique = false
        },
        {
          keys   = ["ref_fdr_sender_psp_id"]
          unique = false
        },
      ]
      shard_key = null
    },
    {
      name = "fdr_payment_publish"
      indexes = [
        {
          keys   = ["_id"] # index + ref_fdr_reporting_flow_name + ref_fdr_id
          unique = true
        },
        {
          keys   = ["ref_fdr"]
          unique = false
        },
        {
          keys   = ["ref_fdr_sender_psp_id"]
          unique = false
        }
      ]
      shard_key = null
    },
  ]
}

module "cosmosdb_fdr_collections" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_mongodb_collection?ref=v6.3.1"

  for_each = {
    for index, coll in local.collections :
    coll.name => coll
  }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.db_rg.name

  cosmosdb_mongo_account_name  = module.cosmosdb_account_mongodb.name
  cosmosdb_mongo_database_name = azurerm_cosmosdb_mongo_database.fdr.name

  indexes   = each.value.indexes
  shard_key = each.value.shard_key

  default_ttl_seconds = var.cosmos_mongo_db_fdr_params.container_default_ttl

  lock_enable = var.env_short == "p" ? true : false
}
