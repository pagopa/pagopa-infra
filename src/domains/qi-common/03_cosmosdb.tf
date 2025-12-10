resource "azurerm_resource_group" "cosmosdb_qi_rg" {
  name     = "${local.project}-cosmosdb-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "cosmosdb_account_mongodb" {

  source = "./.terraform/modules/__v3__/cosmosdb_account"

  name                = "${local.project}-cosmos-account"
  location            = var.location
  resource_group_name = azurerm_resource_group.cosmosdb_qi_rg.name
  domain              = var.domain

  offer_type   = var.cosmos_mongo_db_params.offer_type
  kind         = var.cosmos_mongo_db_params.kind
  capabilities = var.cosmos_mongo_db_params.capabilities
  # mongo_server_version = var.cosmos_mongo_db_params.server_version
  enable_free_tier = var.cosmos_mongo_db_params.enable_free_tier

  public_network_access_enabled      = var.cosmos_mongo_db_params.public_network_access_enabled
  private_endpoint_enabled           = var.cosmos_mongo_db_params.private_endpoint_enabled
  subnet_id                          = module.cosmosdb_qi_snet.id
  private_dns_zone_mongo_ids         = [data.azurerm_private_dns_zone.cosmos.id]
  is_virtual_network_filter_enabled  = var.cosmos_mongo_db_params.is_virtual_network_filter_enabled
  allowed_virtual_network_subnet_ids = var.cosmos_mongo_db_params.public_network_access_enabled ? [] : [data.azurerm_subnet.aks_subnet.id]

  consistency_policy               = var.cosmos_mongo_db_params.consistency_policy
  main_geo_location_location       = azurerm_resource_group.cosmosdb_qi_rg.location
  main_geo_location_zone_redundant = var.cosmos_mongo_db_params.main_geo_location_zone_redundant
  additional_geo_locations         = var.cosmos_mongo_db_params.additional_geo_locations

  backup_continuous_enabled                    = var.cosmos_mongo_db_params.backup_continuous_enabled
  enable_provisioned_throughput_exceeded_alert = var.cosmos_mongo_db_params.enable_provisioned_throughput_exceeded_alert

  tags = module.tag_config.tags
}

resource "azurerm_cosmosdb_mongo_database" "accounting_reconciliation" {

  name                = "accounting-reconciliation"
  resource_group_name = azurerm_resource_group.cosmosdb_qi_rg.name
  account_name        = module.cosmosdb_account_mongodb.name

  throughput = var.cosmos_mongo_db_accounting_reconciliation_params.enable_autoscaling || var.cosmos_mongo_db_accounting_reconciliation_params.enable_serverless ? null : var.cosmos_mongo_db_accounting_reconciliation_params.throughput

  dynamic "autoscale_settings" {
    for_each = var.cosmos_mongo_db_accounting_reconciliation_params.enable_autoscaling && !var.cosmos_mongo_db_accounting_reconciliation_params.enable_serverless ? [""] : []
    content {
      max_throughput = var.cosmos_mongo_db_accounting_reconciliation_params.max_throughput
    }
  }

}

# Collections
locals {
  accounting_reconciliation_collections = [
    {
      name = "accounting-zip"
      indexes = [
        {
          keys   = ["_id"]
          unique = true
        }
      ]
      shard_key           = "_id",
      default_ttl_seconds = null
    },
    {
      name = "accounting-xml"
      indexes = [
        {
          keys   = ["_id"]
          unique = true
        }
      ]
      shard_key           = "_id",
      default_ttl_seconds = null
    }
  ]
}

module "cosmosdb_accounting_reconciliation_collections" {

  source   = "./.terraform/modules/__v3__/cosmosdb_mongodb_collection"
  for_each = { for index, coll in local.accounting_reconciliation_collections : coll.name => coll }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.cosmosdb_qi_rg.name

  cosmosdb_mongo_account_name  = module.cosmosdb_account_mongodb.name
  cosmosdb_mongo_database_name = azurerm_cosmosdb_mongo_database.accounting_reconciliation.name

  indexes             = each.value.indexes
  shard_key           = each.value.shard_key
  default_ttl_seconds = each.value.default_ttl_seconds
  lock_enable         = var.env_short != "p" ? false : true
}
