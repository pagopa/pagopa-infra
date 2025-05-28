module "cosmosdb_account_nodo_re" {
  count               = var.enable_nodo_re ? 1 : 0
  source              = "./.terraform/modules/__v3__/cosmosdb_account"
  domain              = var.domain
  name                = "${local.project}-re-cosmos-nosql-account"
  location            = var.location
  resource_group_name = azurerm_resource_group.db_rg.name

  offer_type       = var.cosmos_nosql_db_params.offer_type
  kind             = var.cosmos_nosql_db_params.kind
  capabilities     = var.cosmos_nosql_db_params.capabilities
  enable_free_tier = var.cosmos_nosql_db_params.enable_free_tier

  subnet_id                     = module.cosmosdb_nodo_re_snet[0].id
  public_network_access_enabled = var.cosmos_nosql_db_params.public_network_access_enabled
  # private endpoint
  private_service_connection_sql_name = "${local.project}-re-cosmos-nosql-endpoint"
  private_endpoint_enabled            = var.cosmos_nosql_db_params.private_endpoint_enabled
  private_endpoint_sql_name           = "${local.project}-re-cosmos-nosql-endpoint"
  private_dns_zone_sql_ids            = [data.azurerm_private_dns_zone.cosmos_nosql.id]
  is_virtual_network_filter_enabled   = var.cosmos_nosql_db_params.is_virtual_network_filter_enabled
  allowed_virtual_network_subnet_ids  = var.cosmos_nosql_db_params.public_network_access_enabled ? [] : [data.azurerm_subnet.aks_subnet.id, data.azurerm_subnet.nodo_re_to_datastore_function_snet[0].id]
  ip_range                            = ""

  enable_automatic_failover = true

  consistency_policy               = var.cosmos_nosql_db_params.consistency_policy
  main_geo_location_location       = var.location
  main_geo_location_zone_redundant = var.cosmos_nosql_db_params.main_geo_location_zone_redundant
  additional_geo_locations         = var.cosmos_nosql_db_params.additional_geo_locations

  backup_continuous_enabled = var.cosmos_nosql_db_params.backup_continuous_enabled

  tags = module.tag_config.tags
}

# cosmosdb database for nodo_re
module "cosmosdb_account_nodo_re_db" {
  count               = var.enable_nodo_re ? 1 : 0
  source              = "./.terraform/modules/__v3__/cosmosdb_sql_database"
  name                = "nodo_re"
  resource_group_name = azurerm_resource_group.db_rg.name
  account_name        = var.enable_nodo_re ? module.cosmosdb_account_nodo_re[0].name : "no-account-name"

  depends_on = [
    module.cosmosdb_account_nodo_re
  ]
}

### containers
locals {
  nodo_re_containers = [
    {
      name               = "events",
      partition_key_path = "/PartitionKey",
      default_ttl        = var.cosmos_nosql_db_params.events_ttl
      autoscale_settings = {
        max_throughput = var.cosmos_nosql_db_params.max_throughput
      }
    },
  ]
}

# cosmosdb container for nodo re datastore
module "cosmosdb_account_nodo_re_containers" {
  source = "./.terraform/modules/__v3__/cosmosdb_sql_container"
  for_each = {
    for c in local.nodo_re_containers : c.name => c if var.enable_nodo_re
  }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.db_rg.name
  account_name        = var.enable_nodo_re ? module.cosmosdb_account_nodo_re[0].name : "no-account-name"
  database_name       = var.enable_nodo_re ? module.cosmosdb_account_nodo_re_db[0].name : "no-database-name"
  partition_key_path  = each.value.partition_key_path
  throughput          = lookup(each.value, "throughput", null)
  default_ttl         = lookup(each.value, "default_ttl", null)

  autoscale_settings = contains(var.cosmos_nosql_db_params.capabilities, "EnableServerless") ? null : lookup(each.value, "autoscale_settings", null)

  depends_on = [
    module.cosmosdb_account_nodo_re
  ]
}
