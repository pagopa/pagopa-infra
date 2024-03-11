resource "azurerm_resource_group" "cosmosdb_wallet_rg" {
  count    = var.env_short != "p" ? 1 : 0
  name     = format("%s-cosmosdb-rg", local.project)
  location = var.location

  tags = var.tags
}

module "cosmosdb_wallet_snet" {
  count                = var.env_short != "p" ? 1 : 0
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.3.0"
  name                 = "${local.project}-cosmosb-snet"
  address_prefixes     = var.cidr_subnet_cosmosdb_wallet
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_name

  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
  ]
}

module "cosmosdb_account_mongodb" {
  count = var.env_short != "p" ? 1 : 0

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_account?ref=v6.3.0"

  name                = "${local.project}-cosmos-account"
  location            = var.location
  resource_group_name = azurerm_resource_group.cosmosdb_wallet_rg[0].name
  domain              = var.domain

  offer_type           = var.cosmos_mongo_db_params.offer_type
  kind                 = var.cosmos_mongo_db_params.kind
  capabilities         = var.cosmos_mongo_db_params.capabilities
  mongo_server_version = var.cosmos_mongo_db_params.server_version
  enable_free_tier     = var.cosmos_mongo_db_params.enable_free_tier

  public_network_access_enabled      = var.cosmos_mongo_db_params.public_network_access_enabled
  private_endpoint_enabled           = var.cosmos_mongo_db_params.private_endpoint_enabled
  subnet_id                          = module.cosmosdb_wallet_snet[0].id
  private_dns_zone_ids               = [data.azurerm_private_dns_zone.cosmos.id]
  is_virtual_network_filter_enabled  = var.cosmos_mongo_db_params.is_virtual_network_filter_enabled
  allowed_virtual_network_subnet_ids = var.cosmos_mongo_db_params.public_network_access_enabled ? [] : [data.azurerm_subnet.aks_subnet.id]

  consistency_policy               = var.cosmos_mongo_db_params.consistency_policy
  main_geo_location_location       = azurerm_resource_group.cosmosdb_wallet_rg[0].location
  main_geo_location_zone_redundant = var.cosmos_mongo_db_params.main_geo_location_zone_redundant
  additional_geo_locations         = var.cosmos_mongo_db_params.additional_geo_locations

  backup_continuous_enabled = var.cosmos_mongo_db_params.backup_continuous_enabled

  tags = var.tags
}

resource "azurerm_cosmosdb_mongo_database" "wallet" {
  count = var.env_short != "p" ? 1 : 0

  name                = "wallet"
  resource_group_name = azurerm_resource_group.cosmosdb_wallet_rg[0].name
  account_name        = module.cosmosdb_account_mongodb[0].name

  throughput = var.cosmos_mongo_db_wallet_params.enable_autoscaling || var.cosmos_mongo_db_wallet_params.enable_serverless ? null : var.cosmos_mongo_db_wallet_params.throughput

  dynamic "autoscale_settings" {
    for_each = var.cosmos_mongo_db_wallet_params.enable_autoscaling && !var.cosmos_mongo_db_wallet_params.enable_serverless ? [""] : []
    content {
      max_throughput = var.cosmos_mongo_db_wallet_params.max_throughput
    }
  }

}

# Collections
locals {
  collections = [
    {
      name = "services"
      indexes = [{
        keys   = ["_id"]
        unique = true
        },
        {
          keys   = ["name"]
          unique = true
        }
      ]
      shard_key = null
    },
    {
      name = "wallets"
      indexes = [{
        keys   = ["_id"]
        unique = true
        },
        {
          keys   = ["userId"]
          unique = false
        }
      ]
      shard_key = "_id"
    },
    {
      name = "wallet-log-events"
      indexes = [{
        keys   = ["_id"]
        unique = true
        },
        {
          keys   = ["walletId", "timestamp", "eventType"]
          unique = true
        }
      ]
      shard_key = null
    },
    {
      name = "wallets-migration-pm",
      indexes = [
        {
          keys   = ["_id"]
          unique = true
        },
        {
          keys = ["contractId"],
          unique = true
        }
      ],
      shard_key = null
    }
  ]
}

module "cosmosdb_wallet_collections" {

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_mongodb_collection?ref=v6.7.0"


  for_each = {
    for index, coll in local.collections :
    coll.name => coll
  }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.cosmosdb_wallet_rg[0].name

  cosmosdb_mongo_account_name  = module.cosmosdb_account_mongodb[0].name
  cosmosdb_mongo_database_name = azurerm_cosmosdb_mongo_database.wallet[0].name

  indexes     = each.value.indexes
  shard_key   = each.value.shard_key
  lock_enable = var.env_short != "p" ? false : true
}

# -----------------------------------------------
# Alerts
# -----------------------------------------------

resource "azurerm_monitor_metric_alert" "cosmos_db_normalized_ru_exceeded" {
  count = var.env_short == "p" ? 1 : 0

  name                = "[${var.domain != null ? "${var.domain} | " : ""}${module.cosmosdb_account_mongodb[0].name}] Normalized RU Exceeded"
  resource_group_name = azurerm_resource_group.cosmosdb_wallet_rg[0].name
  scopes              = [module.cosmosdb_account_mongodb[0].id]
  description         = "A collection Normalized RU/s exceed provisioned throughput, and it's raising latency. Please, consider to increase RU."
  severity            = 0
  window_size         = "PT5M"
  frequency           = "PT5M"
  auto_mitigate       = false


  # Metric info
  # https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/metrics-supported#microsoftdocumentdbdatabaseaccounts
  criteria {
    metric_namespace       = "Microsoft.DocumentDB/databaseAccounts"
    metric_name            = "NormalizedRUConsumption"
    aggregation            = "Maximum"
    operator               = "GreaterThan"
    threshold              = "80"
    skip_metric_validation = false


    dimension {
      name     = "Region"
      operator = "Include"
      values   = [azurerm_resource_group.cosmosdb_wallet_rg[0].location]
    }

    dimension {
      name     = "CollectionName"
      operator = "Include"
      values   = ["*"]
    }

  }

  action {
    action_group_id = data.azurerm_monitor_action_group.email.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack.id
  }

  tags = var.tags
}
