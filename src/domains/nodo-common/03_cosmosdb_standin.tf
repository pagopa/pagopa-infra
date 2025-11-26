module "cosmosdb_account_standin" {
  source              = "./.terraform/modules/__v3__/cosmosdb_account"
  domain              = var.domain
  name                = "${local.project}-standin-cosmos-account"
  location            = var.location
  resource_group_name = azurerm_resource_group.standin_rg.name

  offer_type       = var.standin_cosmos_nosql_db_params.offer_type
  kind             = var.standin_cosmos_nosql_db_params.kind
  capabilities     = var.standin_cosmos_nosql_db_params.capabilities
  enable_free_tier = var.standin_cosmos_nosql_db_params.enable_free_tier

  subnet_id                     = module.cosmosdb_standin_snet.id
  public_network_access_enabled = var.standin_cosmos_nosql_db_params.public_network_access_enabled
  # private endpoint
  private_service_connection_sql_name = "${local.project}-standin-cosmos-nosql-endpoint"
  private_endpoint_enabled            = var.standin_cosmos_nosql_db_params.private_endpoint_enabled
  private_endpoint_sql_name           = "${local.project}-standin-cosmos-nosql-endpoint"
  private_dns_zone_sql_ids            = [data.azurerm_private_dns_zone.cosmos_nosql.id]
  is_virtual_network_filter_enabled   = var.standin_cosmos_nosql_db_params.is_virtual_network_filter_enabled
  ip_range                            = ""

  allowed_virtual_network_subnet_ids = var.standin_cosmos_nosql_db_params.public_network_access_enabled ? [] : [data.azurerm_subnet.aks_subnet.id]

  enable_automatic_failover = true

  consistency_policy               = var.standin_cosmos_nosql_db_params.consistency_policy
  main_geo_location_location       = var.location
  main_geo_location_zone_redundant = var.standin_cosmos_nosql_db_params.main_geo_location_zone_redundant
  additional_geo_locations         = var.standin_cosmos_nosql_db_params.additional_geo_locations

  backup_continuous_enabled = var.standin_cosmos_nosql_db_params.backup_continuous_enabled

  tags = module.tag_config.tags
}

# cosmosdb database for standin
module "cosmosdb_account_standin_db" {
  source              = "./.terraform/modules/__v3__/cosmosdb_sql_database"
  name                = "standin"
  resource_group_name = azurerm_resource_group.standin_rg.name
  account_name        = module.cosmosdb_account_standin.name
}

### containers
locals {
  standin_containers = [
    {
      name               = "node_data",
      partition_key_path = "/PartitionKey",
      default_ttl        = var.standin_cosmos_nosql_db_params.events_ttl
      autoscale_settings = {
        max_throughput = var.standin_cosmos_nosql_db_params.max_throughput
      }
      }, {
      name               = "station_data",
      partition_key_path = "/PartitionKey",
      default_ttl        = var.standin_cosmos_nosql_db_params.events_ttl
      autoscale_settings = {
        max_throughput = var.standin_cosmos_nosql_db_params.max_throughput
      }
      }, {
      name               = "events",
      partition_key_path = "/PartitionKey",
      default_ttl        = var.standin_cosmos_nosql_db_params.events_ttl
      autoscale_settings = {
        max_throughput = var.standin_cosmos_nosql_db_params.max_throughput
      }
      }, {
      name               = "stand_in_stations",
      partition_key_path = "/PartitionKey",
      default_ttl        = var.standin_cosmos_nosql_db_params.events_ttl
      autoscale_settings = {
        max_throughput = var.cosmos_nosql_db_params.max_throughput
      }
    }
  ]
}

# cosmosdb container for stand-in datastore
module "cosmosdb_account_standin_containers" {
  source   = "./.terraform/modules/__v3__/cosmosdb_sql_container"
  for_each = { for c in local.standin_containers : c.name => c }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.standin_rg.name
  account_name        = module.cosmosdb_account_standin.name
  database_name       = module.cosmosdb_account_standin_db.name
  partition_key_path  = each.value.partition_key_path
  throughput          = lookup(each.value, "throughput", null)
  default_ttl         = lookup(each.value, "default_ttl", null)

  autoscale_settings = contains(var.standin_cosmos_nosql_db_params.capabilities, "EnableServerless") ? null : lookup(each.value, "autoscale_settings", null)
}

resource "azurerm_key_vault_secret" "cosmos_standin_connection_string_readonly" {
  depends_on   = [module.cosmosdb_account_standin]
  name         = "cosmos-standin-connection-string-readonly"
  value        = module.cosmosdb_account_standin.connection_strings[2]
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}
