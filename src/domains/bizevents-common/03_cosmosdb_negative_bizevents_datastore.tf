module "negative_bizevents_datastore_cosmosdb_account" {
  source              = "./.terraform/modules/__v3__/cosmosdb_account"
  name                = "${local.project}-neg-ds-cosmos-account"
  location            = var.location
  domain              = var.domain
  resource_group_name = azurerm_resource_group.bizevents_rg.name
  offer_type          = var.negative_bizevents_datastore_cosmos_db_params.offer_type
  kind                = var.negative_bizevents_datastore_cosmos_db_params.kind

  public_network_access_enabled    = var.negative_bizevents_datastore_cosmos_db_params.public_network_access_enabled
  main_geo_location_zone_redundant = var.negative_bizevents_datastore_cosmos_db_params.main_geo_location_zone_redundant

  enable_free_tier          = var.negative_bizevents_datastore_cosmos_db_params.enable_free_tier
  enable_automatic_failover = true

  capabilities       = var.negative_bizevents_datastore_cosmos_db_params.capabilities
  consistency_policy = var.negative_bizevents_datastore_cosmos_db_params.consistency_policy

  main_geo_location_location = var.location
  additional_geo_locations   = var.negative_bizevents_datastore_cosmos_db_params.additional_geo_locations
  backup_continuous_enabled  = var.negative_bizevents_datastore_cosmos_db_params.backup_continuous_enabled

  is_virtual_network_filter_enabled = var.negative_bizevents_datastore_cosmos_db_params.is_virtual_network_filter_enabled

  ip_range = ""

  # add data.azurerm_subnet.<my_service>.id
  # allowed_virtual_network_subnet_ids = var.bizevents_datastore_cosmos_db_params.public_network_access_enabled ? var.env_short == "d" ? [] : [data.azurerm_subnet.aks_subnet.id] : [data.azurerm_subnet.aks_subnet.id]
  allowed_virtual_network_subnet_ids = []

  # private endpoint
  private_endpoint_sql_name           = "${local.project}-negative-ds-cosmos-sql-endpoint" # forced after update module vers
  private_service_connection_sql_name = "${local.project}-negative-ds-cosmos-sql-endpoint" # forced after update module vers
  private_endpoint_enabled            = var.negative_bizevents_datastore_cosmos_db_params.private_endpoint_enabled
  subnet_id                           = module.bizevents_datastore_cosmosdb_snet.id
  private_dns_zone_sql_ids            = [data.azurerm_private_dns_zone.cosmos.id]

  tags = module.tag_config.tags
}

# cosmosdb database for negative biz-events
module "negative_bizevents_datastore_cosmosdb_database" {
  source              = "./.terraform/modules/__v3__/cosmosdb_sql_database"
  name                = "db"
  resource_group_name = azurerm_resource_group.bizevents_rg.name
  account_name        = module.negative_bizevents_datastore_cosmosdb_account.name
}

### Containers
locals {
  negative_bizevents_datastore_cosmosdb_containers = [
    {
      name               = "negative-biz-events",
      partition_key_path = "/id",
      default_ttl        = var.negative_bizevents_datastore_cosmos_db_params.container_default_ttl
      autoscale_settings = { max_throughput = var.negative_bizevents_datastore_cosmos_db_params.max_throughput }
    },
  ]
}

# cosmosdb container for negative biz events datastore
module "negative_bizevents_datastore_cosmosdb_containers" {
  source   = "./.terraform/modules/__v3__/cosmosdb_sql_container"
  for_each = { for c in local.negative_bizevents_datastore_cosmosdb_containers : c.name => c }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.bizevents_rg.name
  account_name        = module.negative_bizevents_datastore_cosmosdb_account.name
  database_name       = module.negative_bizevents_datastore_cosmosdb_database.name
  partition_key_path  = each.value.partition_key_path
  throughput          = lookup(each.value, "throughput", null)
  default_ttl         = lookup(each.value, "default_ttl", null)

  autoscale_settings = contains(var.negative_bizevents_datastore_cosmos_db_params.capabilities, "EnableServerless") ? null : lookup(each.value, "autoscale_settings", null)
}
