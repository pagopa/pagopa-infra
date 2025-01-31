module "cosmosdb_account_mongodb" {
  source              = "./.terraform/modules/__v3__/cosmosdb_account"
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
  private_dns_zone_mongo_ids         = [data.azurerm_private_dns_zone.cosmos.id]
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

# Collections
locals {
  collections = [
    {
      name = "fdr_flow"
      indexes = [
        {
          keys   = ["_id"] # document UID
          unique = true
        },
        {
          keys   = ["sender.psp_id", "name", "revision"] # flow_revision_idx
          unique = true
        },
        {
          keys   = ["sender.psp_id", "receiver.organization_id", "published"] # published_flow_by_psp_idx
          unique = false
        },
        {
          keys   = ["receiver.organization_id", "sender.psp_id", "published"] # published_flow_by_organization_idx
          unique = false
        }
      ]
      shard_key   = null,
      ttl_seconds = var.cosmos_mongo_db_fdr_params.fdr_flow_container_ttl
    },
    {
      name = "fdr_payment"
      indexes = [
        {
          keys   = ["_id"] # document UID
          unique = true
        },
        {
          keys   = ["ref_fdr.id", "index"] # payment_by_fdr_idx
          unique = true
        },
        #{
        #  keys   = ["ref_fdr.sender_psp_id", "iuv", "created"] # payment_by_iuv_idx
        #  unique = false
        #}
      ]
      shard_key   = null,
      ttl_seconds = var.cosmos_mongo_db_fdr_params.fdr_payment_container_ttl
    },
  ]
}

module "cosmosdb_fdr_collections" {
  source = "./.terraform/modules/__v3__/cosmosdb_mongodb_collection"

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
