resource "azurerm_resource_group" "mongodb_rg" {
  name     = format("%s-cosmosdb-mongodb-rg", local.project)
  location = var.location

  tags = var.tags
}

locals {
  base_capabilities = [
    "EnableMongo"
  ]
  cosmosdb_mongodb_enable_serverless = contains(var.cosmosdb_mongodb_extra_capabilities, "EnableServerless")
}

module "cosmosdb_mongodb_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.15.1"
  name                 = format("%s-cosmosb-mongodb-snet", local.project)
  address_prefixes     = var.cidr_subnet_cosmosdb_mongodb
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet.name

  enforce_private_link_endpoint_network_policies = true
  service_endpoints                              = ["Microsoft.Web"]
}


# cosmos mongodb account
# https://docs.microsoft.com/en-us/azure/cosmos-db/mongodb/mongodb-introduction
module "cosmosdb_account_mongodb" {
  source = "git::https://github.com/pagopa/azurerm.git//cosmosdb_account?ref=v2.15.1"

  name                 = format("%s-cosmosdb-mongodb-account", local.project)
  location             = azurerm_resource_group.mongodb_rg.location
  resource_group_name  = azurerm_resource_group.mongodb_rg.name
  offer_type           = var.cosmosdb_mongodb_offer_type
  kind                 = "MongoDB"
  capabilities         = concat(["EnableMongo"], var.cosmosdb_mongodb_extra_capabilities)
  mongo_server_version = "4.0"

  public_network_access_enabled     = var.env_short == "p" ? false : var.cosmosdb_mongodb_public_network_access_enabled
  private_endpoint_enabled          = var.cosmosdb_mongodb_private_endpoint_enabled
  subnet_id                         = module.cosmosdb_mongodb_snet.id
  private_dns_zone_ids              = var.cosmosdb_mongodb_private_endpoint_enabled ? [azurerm_private_dns_zone.privatelink_mongo_cosmos_azure_com.id] : []
  is_virtual_network_filter_enabled = true

  consistency_policy = var.cosmosdb_mongodb_consistency_policy

  main_geo_location_location       = azurerm_resource_group.mongodb_rg.location
  main_geo_location_zone_redundant = var.cosmosdb_mongodb_main_geo_location_zone_redundant

  additional_geo_locations = var.cosmosdb_mongodb_additional_geo_locations

  backup_continuous_enabled = true


  ip_range = ""

  allowed_virtual_network_subnet_ids = []

  tags = var.tags
}

# database(s)

# 1) payments db
resource "azurerm_cosmosdb_mongo_database" "pagopa_payments_cosmosdb_mongodb_db" {
  name                = "paymentsdb"
  resource_group_name = azurerm_resource_group.mongodb_rg.name
  account_name        = module.cosmosdb_account_mongodb.name

  throughput = var.cosmosdb_mongodb_enable_autoscaling || local.cosmosdb_mongodb_enable_serverless ? null : var.cosmosdb_mongodb_throughput

  dynamic "autoscale_settings" {
    for_each = var.cosmosdb_mongodb_enable_autoscaling && !local.cosmosdb_mongodb_enable_serverless ? [""] : []
    content {
      max_throughput = var.cosmosdb_mongodb_max_throughput
    }
  }
}

# database-lock
resource "azurerm_management_lock" "pagopa_cosmosdb_mongodb_db" {
  name       = "mongodb-paymentsdb-lock"
  scope      = azurerm_cosmosdb_mongo_database.pagopa_payments_cosmosdb_mongodb_db.id
  lock_level = "CanNotDelete"
  notes      = "This items can't be deleted in this subscription!"
}

# N) "other-one" db
# ...
# ...


#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "cosmosdb_account_mongodb_connection_strings" {
  name         = "mongodb-connection-string"
  value        = module.cosmosdb_account_mongodb.connection_strings[0]
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

# Collections

# 1) payments collection
module "mongdb_collection_payments" {
  source = "git::https://github.com/pagopa/azurerm.git//cosmosdb_mongodb_collection?ref=v2.15.1"

  name                = format("%scoll", "payments")
  resource_group_name = azurerm_resource_group.mongodb_rg.name

  cosmosdb_mongo_account_name  = module.cosmosdb_account_mongodb.name
  cosmosdb_mongo_database_name = azurerm_cosmosdb_mongo_database.pagopa_payments_cosmosdb_mongodb_db.name

  # https://www.mongodb.com/docs/manual/core/sharding-shard-key/

  # mongodb-indexing https://docs.microsoft.com/en-us/azure/cosmos-db/mongodb/mongodb-indexing
  indexes = [{
    keys   = ["_id"]
    unique = true
    },
    {
      keys   = ["uuid", "version"]
      unique = true
    },
    {
      keys   = ["idPA", "noticeNumber"]
      unique = true
    },
    {
      keys   = ["idPsp"]
      unique = false
    },
    {
      keys   = ["idPA"]
      unique = false
    }
  ]

  lock_enable = true
}
