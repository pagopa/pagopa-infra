resource "azurerm_resource_group" "cosmosdb_pay_wallet_rg" {
  name     = format("${local.project}-cosmosdb-rg", )
  location = var.location

  tags = module.tag_config.tags
}

module "cosmosdb_account_mongodb" {
  count = var.is_feature_enabled.cosmos ? 1 : 0

  source = "./.terraform/modules/__v4__/cosmosdb_account"

  name                = "${local.project}-cosmos-account"
  location            = var.location
  resource_group_name = azurerm_resource_group.cosmosdb_pay_wallet_rg.name
  domain              = var.domain

  offer_type   = var.cosmos_mongo_db_params.offer_type
  kind         = var.cosmos_mongo_db_params.kind
  capabilities = var.cosmos_mongo_db_params.capabilities
  #mongo_server_version = var.cosmos_mongo_db_params.server_version
  enable_free_tier = var.cosmos_mongo_db_params.enable_free_tier

  public_network_access_enabled      = var.cosmos_mongo_db_params.public_network_access_enabled
  private_endpoint_enabled           = var.cosmos_mongo_db_params.private_endpoint_enabled
  subnet_id                          = module.cosmosdb_pay_wallet_snet.id
  private_dns_zone_mongo_ids         = [data.azurerm_private_dns_zone.cosmos.id]
  is_virtual_network_filter_enabled  = var.cosmos_mongo_db_params.is_virtual_network_filter_enabled
  allowed_virtual_network_subnet_ids = var.env_short == "d" ? [] : [azurerm_subnet.pay_wallet_user_aks_subnet.id, data.azurerm_subnet.vpn_subnet.id]

  consistency_policy               = var.cosmos_mongo_db_params.consistency_policy
  main_geo_location_location       = azurerm_resource_group.cosmosdb_pay_wallet_rg.location
  main_geo_location_zone_redundant = var.cosmos_mongo_db_params.main_geo_location_zone_redundant
  additional_geo_locations         = var.cosmos_mongo_db_params.additional_geo_locations

  backup_continuous_enabled = var.cosmos_mongo_db_params.backup_continuous_enabled
  ip_range                  = var.cosmos_mongo_db_params.ip_range_filter

  enable_provisioned_throughput_exceeded_alert = var.cosmos_mongo_db_params.enable_provisioned_throughput_exceeded_alert

  tags = module.tag_config.tags
}

resource "azurerm_cosmosdb_mongo_database" "pay_wallet" {
  count = var.is_feature_enabled.cosmos ? 1 : 0

  name                = "payment-wallet"
  resource_group_name = azurerm_resource_group.cosmosdb_pay_wallet_rg.name
  account_name        = module.cosmosdb_account_mongodb[0].name

  throughput = var.cosmos_mongo_db_pay_wallet_params.enable_autoscaling || var.cosmos_mongo_db_pay_wallet_params.enable_serverless ? null : var.cosmos_mongo_db_pay_wallet_params.throughput

  dynamic "autoscale_settings" {
    for_each = var.cosmos_mongo_db_pay_wallet_params.enable_autoscaling && !var.cosmos_mongo_db_pay_wallet_params.enable_serverless ? [""] : []
    content {
      max_throughput = var.cosmos_mongo_db_pay_wallet_params.max_throughput
    }
  }

}

# Collections
locals {
  collections = [
    {
      name                = "applications"
      default_ttl_seconds = null
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
      name                = "wallets-migration-pm",
      default_ttl_seconds = null
      indexes = [
        {
          keys   = ["_id"] # wallet id pm
          unique = true
        },
        {
          keys   = ["contractId"],
          unique = true
        }
      ],
      shard_key = null
    },
    {
      name                = "payment-wallets"
      default_ttl_seconds = null
      indexes = [{
        keys   = ["_id"]
        unique = true
        },
        {
          keys   = ["userId"]
          unique = false
        },
        {
          keys   = ["contractId"],
          unique = false
        },
        {
          keys   = ["status"],
          unique = false
        },
        {
          keys   = ["creationDate"],
          unique = false
        },
        {
          keys   = ["updateDate"],
          unique = false
        }
      ]
      shard_key = "userId"
    },
    { # collection with new and detailed logging events
      name                = "payment-wallets-log-events"
      default_ttl_seconds = "7776000" #90 days
      indexes = [{
        keys   = ["_id"]
        unique = true
        },
        {
          keys   = ["walletId", "timestamp"]
          unique = true
        }
      ]
      shard_key = "walletId"
    },
  ]
}

module "cosmosdb_pay_wallet_collections" {

  source   = "./.terraform/modules/__v4__/cosmosdb_mongodb_collection"
  for_each = var.is_feature_enabled.cosmos ? { for index, coll in local.collections : coll.name => coll } : {}

  name                = each.value.name
  resource_group_name = azurerm_resource_group.cosmosdb_pay_wallet_rg.name

  cosmosdb_mongo_account_name  = module.cosmosdb_account_mongodb[0].name
  cosmosdb_mongo_database_name = azurerm_cosmosdb_mongo_database.pay_wallet[0].name

  indexes             = each.value.indexes
  shard_key           = each.value.shard_key
  default_ttl_seconds = each.value.default_ttl_seconds
  lock_enable         = var.env_short != "p" ? false : true
}

# -----------------------------------------------
# Alerts
# -----------------------------------------------

resource "azurerm_monitor_metric_alert" "cosmos_db_normalized_ru_exceeded" {
  count = var.is_feature_enabled.cosmos && var.env_short == "p" ? 1 : 0


  name                = "[${var.domain != null ? "${var.domain} | " : ""}${module.cosmosdb_account_mongodb[0].name}] Normalized RU Exceeded"
  resource_group_name = azurerm_resource_group.cosmosdb_pay_wallet_rg.name
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
      values   = [azurerm_resource_group.cosmosdb_pay_wallet_rg.location]
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

  action {
    action_group_id = azurerm_monitor_action_group.payment_wallet_opsgenie[0].id
  }

  tags = module.tag_config.tags
}
