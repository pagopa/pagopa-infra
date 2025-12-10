resource "azurerm_resource_group" "bopagopa_rg" {
  name     = "${local.project}-rg"
  location = var.location

  tags = module.tag_config.tags
}

locals {
  cosmosdb_mongodb_enable_serverless = contains(var.cosmosdb_mongodb_extra_capabilities, "EnableServerless")
}

module "bopagopa_cosmosdb_mongodb_snet" {
  source               = "./.terraform/modules/__v3__/subnet"
  name                 = "${local.project}-datastore-cosmosdb-snet"
  address_prefixes     = var.cidr_subnet_cosmosdb_mongodb
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_name

  private_endpoint_network_policies_enabled = false

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]
}


module "bopagopa_cosmosdb_mongo_account" {
  source   = "./.terraform/modules/__v3__/cosmosdb_account"
  name     = "${local.project}-cosmos-account"
  location = var.location
  domain   = var.domain

  resource_group_name  = azurerm_resource_group.bopagopa_rg.name
  offer_type           = var.bopagopa_datastore_cosmos_db_params.offer_type
  kind                 = var.bopagopa_datastore_cosmos_db_params.kind
  capabilities         = var.bopagopa_datastore_cosmos_db_params.capabilities
  mongo_server_version = var.bopagopa_datastore_cosmos_db_params.server_version

  main_geo_location_zone_redundant = var.bopagopa_datastore_cosmos_db_params.main_geo_location_zone_redundant

  enable_free_tier       = var.bopagopa_datastore_cosmos_db_params.enable_free_tier
  burst_capacity_enabled = var.env_short == "p"

  public_network_access_enabled = var.bopagopa_datastore_cosmos_db_params.public_network_access_enabled

  consistency_policy = var.bopagopa_datastore_cosmos_db_params.consistency_policy

  main_geo_location_location = var.location
  additional_geo_locations   = var.bopagopa_datastore_cosmos_db_params.additional_geo_locations
  backup_continuous_enabled  = var.bopagopa_datastore_cosmos_db_params.backup_continuous_enabled

  is_virtual_network_filter_enabled = var.bopagopa_datastore_cosmos_db_params.is_virtual_network_filter_enabled

  ip_range = ""

  # add data.azurerm_subnet.<my_service>.id
  allowed_virtual_network_subnet_ids = var.bopagopa_datastore_cosmos_db_params.public_network_access_enabled ? [] : [data.azurerm_subnet.aks_subnet.id]


  private_endpoint_enabled              = var.bopagopa_datastore_cosmos_db_params.private_endpoint_enabled
  subnet_id                             = module.bopagopa_cosmosdb_mongodb_snet.id
  private_dns_zone_mongo_ids            = [data.azurerm_private_dns_zone.cosmos.id]
  private_endpoint_mongo_name           = "${local.project}-cosmos-account-private-endpoint" # forced after update module vers
  private_service_connection_mongo_name = "${local.project}-cosmos-account-private-endpoint" # forced after update module vers


  tags = module.tag_config.tags
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

  # lifecycle {
  #   ignore_changes = [
  #     autoscale_settings
  #   ]
  # }
}

resource "azurerm_management_lock" "mongodb_pagopa_backoffice" {
  name       = "mongodb-pagopa-backoffice-lock"
  scope      = azurerm_cosmosdb_mongo_database.pagopa_backoffice.id
  lock_level = "CanNotDelete"
  notes      = "This items can't be deleted in this subscription!"
}

# Collections
module "mongdb_collection_products" {
  source = "./.terraform/modules/__v3__/cosmosdb_mongodb_collection"

  name                = "wrappers"
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

module "mongdb_collection_brokeribans" {
  source = "./.terraform/modules/__v3__/cosmosdb_mongodb_collection"

  name                = "brokerIbans"
  resource_group_name = azurerm_resource_group.bopagopa_rg.name

  cosmosdb_mongo_account_name  = module.bopagopa_cosmosdb_mongo_account.name
  cosmosdb_mongo_database_name = azurerm_cosmosdb_mongo_database.pagopa_backoffice.name

  indexes = [{
    keys   = ["_id"]
    unique = true
    },
    {
      keys   = ["brokerCode"]
      unique = true
    }
  ]

  lock_enable = true
}

module "mongdb_collection_brokerinstitutions" {
  source = "./.terraform/modules/__v3__/cosmosdb_mongodb_collection"

  name                = "brokerInstitutions"
  resource_group_name = azurerm_resource_group.bopagopa_rg.name

  cosmosdb_mongo_account_name  = module.bopagopa_cosmosdb_mongo_account.name
  cosmosdb_mongo_database_name = azurerm_cosmosdb_mongo_database.pagopa_backoffice.name


  indexes = [{
    keys   = ["_id"]
    unique = true
    },
    {
      keys   = ["brokerCode"]
      unique = true
    }
  ]

  lock_enable = true
}

module "mongdb_collection_maintenance" {
  source = "./.terraform/modules/__v3__/cosmosdb_mongodb_collection"

  name                = "maintenance"
  resource_group_name = azurerm_resource_group.bopagopa_rg.name

  cosmosdb_mongo_account_name  = module.bopagopa_cosmosdb_mongo_account.name
  cosmosdb_mongo_database_name = azurerm_cosmosdb_mongo_database.pagopa_backoffice.name


  indexes = [{
    keys   = ["_id"]
    unique = true
    }
  ]

  lock_enable = true
}

module "mongdb_collection_iban_deletion_requests" {
  source = "./.terraform/modules/__v3__/cosmosdb_mongodb_collection"

  name                = "ibanDeletionRequests"
  resource_group_name = azurerm_resource_group.bopagopa_rg.name

  cosmosdb_mongo_account_name  = module.bopagopa_cosmosdb_mongo_account.name
  cosmosdb_mongo_database_name = azurerm_cosmosdb_mongo_database.pagopa_backoffice.name

  shard_key = "_id"

  indexes = [
    {
      keys   = ["_id"]
      unique = true
    },
    {
      keys   = ["creditorInstitutionCode", "status"]
      unique = false
    },
    {
      keys   = ["status", "scheduledExecutionDate"]
      unique = false
    },
    {
      keys   = ["creditorInstitutionCode", "status", "ibanValue"]
      unique = false
    },
  ]

  lock_enable =  var.env_short != "d"
}
