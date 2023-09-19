module "poc_quarkus_cosmosdb_snet" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.7.0"
  name                 = "${local.project}-quarkus-cosmosdb-snet"
  address_prefixes     = var.cidr_subnet_poc_quarkus_cosmosdb
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_name

  private_endpoint_network_policies_enabled = false

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
  ]
}

module "poc_quarkus_cosmosdb_account" {
  source   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_account?ref=v6.4.1"
  
  name     = "${local.project}-quarkus-cosmos-account"
  location = var.location
  domain   = "shared"
  resource_group_name = azurerm_resource_group.shared_rg.name
  
  offer_type           = var.poc_quarkus_db_account_params.offer_type
  kind                 = var.poc_quarkus_db_account_params.kind
  capabilities       = var.poc_quarkus_db_account_params.capabilities
  enable_free_tier     = var.poc_quarkus_db_account_params.enable_free_tier
  mongo_server_version = var.poc_quarkus_db_account_params.server_version


  public_network_access_enabled    = var.poc_quarkus_db_account_params.public_network_access_enabled
  private_endpoint_enabled         = var.poc_quarkus_db_account_params.private_endpoint_enabled
  main_geo_location_zone_redundant = var.poc_quarkus_db_account_params.main_geo_location_zone_redundant

  enable_automatic_failover = true

  consistency_policy = var.poc_quarkus_db_account_params.consistency_policy

  main_geo_location_location = var.location
  additional_geo_locations   = var.poc_quarkus_db_account_params.additional_geo_locations
  backup_continuous_enabled  = var.poc_quarkus_db_account_params.backup_continuous_enabled

  is_virtual_network_filter_enabled            = var.poc_quarkus_db_account_params.is_virtual_network_filter_enabled
  enable_provisioned_throughput_exceeded_alert = var.poc_quarkus_db_account_params.enable_provisioned_throughput_exceeded_alert


  ip_range  = ""
  subnet_id = module.poc_quarkus_cosmosdb_snet.id

  # add data.azurerm_subnet.<my_service>.id
  # allowed_virtual_network_subnet_ids = var.poc_quarkus_db_account_params.public_network_access_enabled ? var.env_short == "d" ? [] : [data.azurerm_subnet.aks_subnet.id] : [data.azurerm_subnet.aks_subnet.id]
  # allowed_virtual_network_subnet_ids = var.poc_quarkus_db_account_params.public_network_access_enabled ? [] : [data.azurerm_subnet.aks_subnet.id]
  allowed_virtual_network_subnet_ids = []

  tags = var.tags
}

resource "azurerm_cosmosdb_mongo_database" "poc_quarkus" {

  name                = "poc_quarkus"
  resource_group_name = azurerm_resource_group.shared_rg.name
  account_name        = module.poc_quarkus_cosmosdb_account.name

  throughput = var.poc_quarkus_db_params.enable_autoscaling || var.poc_quarkus_db_params.enable_serverless ? null : var.poc_quarkus_db_params.throughput

  dynamic "autoscale_settings" {
    for_each = var.poc_quarkus_db_params.enable_autoscaling && !var.poc_quarkus_db_params.enable_serverless ? [""] : []
    content {
      max_throughput = var.poc_quarkus_db_params.max_throughput
    }
  }

}

# Collections
locals {
  collections = [
    {
      name = "organizations"
      indexes = [{
        keys   = ["_id"]
        unique = true
        }
      ]
      shard_key = "organizationFiscalCode"
    }
  ]
}

module "cosmosdb_quarkus_collections" {

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_mongodb_collection?ref=v6.7.0"


  for_each = {
    for index, coll in local.collections :
    coll.name => coll
  }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.shared_rg.name

  cosmosdb_mongo_account_name  = module.poc_quarkus_cosmosdb_account.name
  cosmosdb_mongo_database_name = azurerm_cosmosdb_mongo_database.poc_quarkus.name

  indexes     = each.value.indexes
  shard_key   = each.value.shard_key
  lock_enable = var.env_short == "d" ? false : true
}
