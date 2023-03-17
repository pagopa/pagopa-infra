resource "azurerm_resource_group" "bopagopa_rg" {
  name     = "${local.project}-rg"
  location = var.location

  tags = var.tags
}

locals {
  base_capabilities = [
    "EnableMongo"
  ]
  cosmosdb_mongodb_enable_serverless = contains(var.bopagopa_datastore_cosmos_db_params.cosmosdb_mongodb_extra_capabilities, "EnableServerless")
}

module "bopagopa_cosmosdb_mongodb_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.58"
  name                 = "${local.project}-datastore-cosmosdb-snet"
  address_prefixes     = var.cidr_subnet_cosmosdb_mongodb
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_name

  enforce_private_link_endpoint_network_policies = true

  service_endpoints = ["Microsoft.Web"]
}

module "bopagopa_cosmosdb_mongo_account" {
  source   = "git::https://github.com/pagopa/azurerm.git//cosmosdb?ref=v2.0.19"
  name     = "${local.project}-ds-cosmosdb_mongo_account"
  location = var.location

  resource_group_name = azurerm_resource_group.bopagopa_rg.name
  offer_type          = var.bopagopa_datastore_cosmos_db_params.offer_type
  kind                = var.bopagopa_datastore_cosmos_db_params.kind

  public_network_access_enabled-    = var.bopagopa_datastore_cosmos_db_params.public_network_access_enabled
  main_geo_location_zone_redundant- = var.bopagopa_datastore_cosmos_db_params.main_geo_location_zone_redundant

  capabilities       = var.bopagopa_datastore_cosmos_db_params.capabilities
  consistency_policy = var.bopagopa_datastore_cosmos_db_params.consistency_policy

  main_geo_location_location = var.location
  additional_geo_locations   = var.bopagopa_datastore_cosmos_db_params.additional_geo_locations
  backup_continuous_enabled  = var.bopagopa_datastore_cosmos_db_params.backup_continuous_enabled

  is_virtual_network_filter_enabled = var.bopagopa_datastore_cosmos_db_params.is_virtual_network_filter_enabled

  ip_rangex = ""
  private_endpoint_enabled = var.bopagopa_datastore_cosmos_db_params.private_endpoint_enabled
  subnet_id                = module.bopagopa_cosmosdb_mongodb_snet.id
  private_dns_zone_ids     = [data.azurerm_private_dns_zone.cosmos.id]

  tags = var.tags
}


resource "azurerm_cosmosdb_mongo_database" "pagopa_backoffice" {
  name                = "pagopaBackoffice"
  resource_group_name = azurerm_resource_group.bopagopa_rg.name
  account_name        = module.bopagopa_cosmosdb_mongo_account.name

  throughput = var.cosmosdb_mongodb_enable_autoscaling || local.cosmosdb_mongodb_enable_serverless ? null : var.cosmosdb_mongodb_throughput

  dynamic "autoscale_settings" {
    for_each = var.cosmosdb_mongodb_enable_autoscaling && !local.cosmosdb_mongodb_enable_serverless ? [""] : []
    content {
      max_throughput = var.cosmosdb_mongodb_max_throughput
    }
  }

  lifecycle {
    ignore_changes = [
      autoscale_settings
    ]
  }
}

resource "azurerm_management_lock" "mongodb_pagopa_backoffice" {
  name       = "mongodb-pagopa-backoffice-lock"
  scope      = azurerm_cosmosdb_mongo_database.pagopa_backoffice.id
  lock_level = "CanNotDelete"
  notes      = "This items can't be deleted in this subscription!"
}

# Collections
module "mongdb_collection_products" {
  source = "git::https://github.com/pagopa/azurerm.git//cosmosdb_mongodb_collection?ref=v3.3.0"

  name                = ""
  resource_group_name = azurerm_resource_group.bopagopa_rg.name

  cosmosdb_mongo_account_name  = module.bopagopa_cosmosdb_mongo_account.name
  cosmosdb_mongo_database_name = azurerm_cosmosdb_mongo_database.pagopa_backoffice.name

  indexes = [{
    keys   = ["_id"]
    unique = true
  },
    {
      keys   = ["state"]
      unique = false
    }
  ]

  lock_enable = true
}
