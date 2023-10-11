resource "azurerm_resource_group" "cosmosdb_dapr" {
  count    = var.is_resource_enabled.mongodb_dapr ? 1 : 0
  name     = "${local.project}-dapr-cosmos-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_cosmosdb_account" "mongodb_dapr" {
  count = var.is_resource_enabled.mongodb_dapr ? 1 : 0

  name                = "${local.project}-dapr-cosmos"
  location            = azurerm_resource_group.cosmosdb_dapr[0].location
  resource_group_name = azurerm_resource_group.cosmosdb_dapr[0].name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  capabilities {
    name = "EnableServerless"
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }
}

resource "azurerm_cosmosdb_sql_database" "db_sql_dapr" {
  count = var.is_resource_enabled.mongodb_dapr ? 1 : 0

  name                = local.cosmosdb_db_name
  resource_group_name = azurerm_resource_group.cosmosdb_dapr[0].name
  account_name        = azurerm_cosmosdb_account.mongodb_dapr[0].name
}

resource "azurerm_cosmosdb_sql_container" "collection_dapr" {
  count = var.is_resource_enabled.mongodb_dapr ? 1 : 0

  name                = local.cosmosdb_collection_name
  resource_group_name = azurerm_resource_group.cosmosdb_dapr[0].name
  account_name        = azurerm_cosmosdb_account.mongodb_dapr[0].name
  database_name       = azurerm_cosmosdb_sql_database.db_sql_dapr[0].name

  partition_key_path = "/id"
}
