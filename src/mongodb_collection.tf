# Database(s)

# ##########################
# #       Payments DB      #
# ##########################

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
