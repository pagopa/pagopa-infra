module "cosmosdb_account_wispconv" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_account?ref=v6.7.0"
  domain              = var.domain
  name                = "${local.project}-wispconv-cosmos-account"
  location            = var.location
  resource_group_name = azurerm_resource_group.wispconv_rg.name

  offer_type       = var.wispconv_cosmos_nosql_db_params.offer_type
  kind             = var.wispconv_cosmos_nosql_db_params.kind
  capabilities     = var.wispconv_cosmos_nosql_db_params.capabilities
  enable_free_tier = var.wispconv_cosmos_nosql_db_params.enable_free_tier

  subnet_id                     = module.cosmosdb_wispconv_snet.id
  public_network_access_enabled = var.wispconv_cosmos_nosql_db_params.public_network_access_enabled
  # private endpoint
  private_endpoint_enabled          = var.wispconv_cosmos_nosql_db_params.private_endpoint_enabled
  private_endpoint_name             = "${local.project}-wispconv-cosmos-nosql-endpoint"
  private_dns_zone_ids              = [data.azurerm_private_dns_zone.cosmos_nosql.id]
  is_virtual_network_filter_enabled = var.wispconv_cosmos_nosql_db_params.is_virtual_network_filter_enabled
  ip_range                          = ""

  allowed_virtual_network_subnet_ids = var.wispconv_cosmos_nosql_db_params.public_network_access_enabled ? [] : [data.azurerm_subnet.aks_subnet.id]

  enable_automatic_failover = true

  consistency_policy               = var.wispconv_cosmos_nosql_db_params.consistency_policy
  main_geo_location_location       = var.location
  main_geo_location_zone_redundant = var.wispconv_cosmos_nosql_db_params.main_geo_location_zone_redundant
  additional_geo_locations         = var.wispconv_cosmos_nosql_db_params.additional_geo_locations

  backup_continuous_enabled = var.wispconv_cosmos_nosql_db_params.backup_continuous_enabled

  tags = var.tags
}

# cosmosdb database for wispconv
module "cosmosdb_account_wispconv_db" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_database?ref=v6.7.0"
  name                = "wispconverter"
  resource_group_name = azurerm_resource_group.wispconv_rg.name
  account_name        = module.cosmosdb_account_wispconv.name
}

### containers
locals {
  wispconv_containers = [
    {
      name               = "data",
      partition_key_path = "/PartitionKey",
      default_ttl        = var.wispconv_cosmos_nosql_db_params.events_ttl
      autoscale_settings = {
        max_throughput = var.wispconv_cosmos_nosql_db_params.max_throughput
      }
    }
  ]
}

# cosmosdb container for stand-in datastore
module "cosmosdb_account_wispconv_containers" {
  source   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container?ref=v6.7.0"
  for_each = { for c in local.wispconv_containers : c.name => c }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.wispconv_rg.name
  account_name        = module.cosmosdb_account_wispconv.name
  database_name       = module.cosmosdb_account_wispconv_db.name
  partition_key_path  = each.value.partition_key_path
  throughput          = lookup(each.value, "throughput", null)
  default_ttl         = lookup(each.value, "default_ttl", null)

  autoscale_settings = contains(var.wispconv_cosmos_nosql_db_params.capabilities, "EnableServerless") ? null : lookup(each.value, "autoscale_settings", null)
}

