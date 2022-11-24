resource "azurerm_resource_group" "bizevents_rg" {
  name     = format("%s-rg", local.project)
  location = var.location

  tags = var.tags
}

module "bizevents_datastore_cosmosdb_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.90"
  name                 = format("%s-datastore-cosmosdb-snet", local.project)
  address_prefixes     = var.cidr_subnet_bizevents_datastore_cosmosdb
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_name

  enforce_private_link_endpoint_network_policies = true

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]
}

module "bizevents_datastore_cosmosdb_account" {
  source   = "git::https://github.com/pagopa/azurerm.git//cosmosdb_account?ref=v2.1.18"
  name     = format("%s-ds-cosmos-account", local.project)
  location = var.location

  resource_group_name = azurerm_resource_group.bizevents_rg.name
  offer_type          = var.bizevents_datastore_cosmos_db_params.offer_type
  kind                = var.bizevents_datastore_cosmos_db_params.kind

  public_network_access_enabled    = var.bizevents_datastore_cosmos_db_params.public_network_access_enabled
  main_geo_location_zone_redundant = var.bizevents_datastore_cosmos_db_params.main_geo_location_zone_redundant

  enable_free_tier          = var.bizevents_datastore_cosmos_db_params.enable_free_tier
  enable_automatic_failover = true

  capabilities       = var.bizevents_datastore_cosmos_db_params.capabilities
  consistency_policy = var.bizevents_datastore_cosmos_db_params.consistency_policy

  main_geo_location_location = var.location
  additional_geo_locations   = var.bizevents_datastore_cosmos_db_params.additional_geo_locations
  backup_continuous_enabled  = var.bizevents_datastore_cosmos_db_params.backup_continuous_enabled

  is_virtual_network_filter_enabled = var.bizevents_datastore_cosmos_db_params.is_virtual_network_filter_enabled

  ip_range = ""

  # add data.azurerm_subnet.<my_service>.id
  allowed_virtual_network_subnet_ids = var.bizevents_datastore_cosmos_db_params.public_network_access_enabled ? [] : [data.azurerm_subnet.aks_subnet.id]

  # private endpoint
  private_endpoint_name    = format("%s-ds-cosmos-sql-endpoint", local.project)
  private_endpoint_enabled = var.bizevents_datastore_cosmos_db_params.private_endpoint_enabled
  subnet_id                = module.bizevents_datastore_cosmosdb_snet.id
  private_dns_zone_ids     = [data.azurerm_private_dns_zone.cosmos.id]

  tags = var.tags
}

# cosmosdb database for marketplace
module "bizevents_datastore_cosmosdb_database" {
  source              = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_database?ref=v2.1.15"
  name                = "db"
  resource_group_name = azurerm_resource_group.bizevents_rg.name
  account_name        = module.bizevents_datastore_cosmosdb_account.name
}

### Containers
locals {
  bizevents_datastore_cosmosdb_containers = [
    {
      name               = "biz-events",
      partition_key_path = "/id",
      default_ttl        = var.bizevents_datastore_cosmos_db_params.container_default_ttl
    },
  ]
}

# cosmosdb container for biz events datastore
module "bizevents_datastore_cosmosdb_containers" {
  source   = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_container?ref=v3.2.5"
  for_each = { for c in local.bizevents_datastore_cosmosdb_containers : c.name => c }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.bizevents_rg.name
  account_name        = module.bizevents_datastore_cosmosdb_account.name
  database_name       = module.bizevents_datastore_cosmosdb_database.name
  partition_key_path  = each.value.partition_key_path
  throughput          = lookup(each.value, "throughput", null)
  default_ttl         = lookup(each.value, "default_ttl", null)

  autoscale_settings = contains(var.bizevents_datastore_cosmos_db_params.capabilities, "EnableServerless") ? null : lookup(each.value, "autoscale_settings", null)
}
