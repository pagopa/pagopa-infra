resource "azurerm_resource_group" "nodo_verifyko_to_datastore_rg" {
  name     = "${local.project}-verifyko-to-datastore-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "cosmosdb_account_nodo_verifyko" {
  source              = "./.terraform/modules/__v3__/cosmosdb_account"
  domain              = var.domain
  name                = "${local.project}-verifyko-cosmos-account"
  location            = var.location
  resource_group_name = azurerm_resource_group.nodo_verifyko_to_datastore_rg.name

  offer_type       = var.verifyko_cosmos_nosql_db_params.offer_type
  kind             = var.verifyko_cosmos_nosql_db_params.kind
  capabilities     = var.verifyko_cosmos_nosql_db_params.capabilities
  enable_free_tier = var.verifyko_cosmos_nosql_db_params.enable_free_tier

  subnet_id                     = module.cosmosdb_nodo_verifyko_snet.id
  public_network_access_enabled = var.verifyko_cosmos_nosql_db_params.public_network_access_enabled
  # private endpoint
  private_service_connection_sql_name = "${local.project}-verifyko-cosmos-nosql-endpoint"
  private_endpoint_enabled            = var.verifyko_cosmos_nosql_db_params.private_endpoint_enabled
  private_endpoint_sql_name           = "${local.project}-verifyko-cosmos-nosql-endpoint"
  private_dns_zone_sql_ids            = [data.azurerm_private_dns_zone.cosmos_nosql.id]
  is_virtual_network_filter_enabled   = var.verifyko_cosmos_nosql_db_params.is_virtual_network_filter_enabled
  ip_range                            = ""

  allowed_virtual_network_subnet_ids = var.verifyko_cosmos_nosql_db_params.public_network_access_enabled ? [] : [module.cosmosdb_nodo_verifyko_snet.id]

  enable_automatic_failover = true

  consistency_policy               = var.verifyko_cosmos_nosql_db_params.consistency_policy
  main_geo_location_location       = var.location
  main_geo_location_zone_redundant = var.verifyko_cosmos_nosql_db_params.main_geo_location_zone_redundant
  additional_geo_locations         = var.verifyko_cosmos_nosql_db_params.additional_geo_locations

  backup_continuous_enabled = var.verifyko_cosmos_nosql_db_params.backup_continuous_enabled

  tags = module.tag_config.tags
}

# cosmosdb database for nodo_verify_ko
module "cosmosdb_account_nodo_verifyko_db" {
  source              = "./.terraform/modules/__v3__/cosmosdb_sql_database"
  name                = "nodo_verifyko"
  resource_group_name = azurerm_resource_group.nodo_verifyko_to_datastore_rg.name
  account_name        = module.cosmosdb_account_nodo_verifyko.name
}

### containers
locals {
  nodo_verify_ko_containers = [
    {
      name               = "events",
      partition_key_path = "/PartitionKey",
      default_ttl        = var.verifyko_cosmos_nosql_db_params.events_ttl
      autoscale_settings = {
        max_throughput = var.cosmos_nosql_db_params.max_throughput
      }
    },
  ]
}

# cosmosdb container for nodo re datastore
module "cosmosdb_account_nodo_verifyko_containers" {
  source   = "./.terraform/modules/__v3__/cosmosdb_sql_container"
  for_each = { for c in local.nodo_verify_ko_containers : c.name => c }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.nodo_verifyko_to_datastore_rg.name
  account_name        = module.cosmosdb_account_nodo_verifyko.name
  database_name       = module.cosmosdb_account_nodo_verifyko_db.name
  partition_key_path  = each.value.partition_key_path
  throughput          = lookup(each.value, "throughput", null)
  default_ttl         = lookup(each.value, "default_ttl", null)

  autoscale_settings = contains(var.verifyko_cosmos_nosql_db_params.capabilities, "EnableServerless") ? null : lookup(each.value, "autoscale_settings", null)
}

