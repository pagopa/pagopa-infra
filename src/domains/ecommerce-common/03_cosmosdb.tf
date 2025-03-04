resource "azurerm_resource_group" "cosmosdb_ecommerce_rg" {
  name     = "${local.project}-cosmosdb-rg"
  location = var.location

  tags = var.tags
}

module "cosmosdb_ecommerce_snet" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.42.3"

  name                 = "${local.project}-cosmosb-snet"
  address_prefixes     = var.cidr_subnet_cosmosdb_ecommerce
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_name

  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
  ]
}

module "cosmosdb_account_mongodb" {

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_account?ref=v8.42.3"


  name                = "${local.project}-cosmos-account"
  location            = var.location
  domain              = var.domain
  resource_group_name = azurerm_resource_group.cosmosdb_ecommerce_rg.name

  offer_type   = var.cosmos_mongo_db_params.offer_type
  kind         = var.cosmos_mongo_db_params.kind
  capabilities = var.cosmos_mongo_db_params.capabilities
  #version commented out since using 6.0 version here raise the following error
  # `expected mongo_server_version to be one of [3.2 3.6 4.0 4.2], got 6.0``
  # Leaving mongo_server_version parameter here causes plan diff for each plan
  # so it was simply commented out so that actual version is ignored
  #mongo_server_version = var.cosmos_mongo_db_params.server_version
  enable_free_tier = var.cosmos_mongo_db_params.enable_free_tier

  public_network_access_enabled      = var.cosmos_mongo_db_params.public_network_access_enabled
  private_endpoint_enabled           = var.cosmos_mongo_db_params.private_endpoint_enabled
  subnet_id                          = module.cosmosdb_ecommerce_snet.id
  private_dns_zone_mongo_ids         = [data.azurerm_private_dns_zone.cosmos.id]
  is_virtual_network_filter_enabled  = var.cosmos_mongo_db_params.is_virtual_network_filter_enabled
  allowed_virtual_network_subnet_ids = var.cosmos_mongo_db_params.public_network_access_enabled ? [] : [data.azurerm_subnet.aks_subnet.id]

  consistency_policy               = var.cosmos_mongo_db_params.consistency_policy
  main_geo_location_location       = azurerm_resource_group.cosmosdb_ecommerce_rg.location
  main_geo_location_zone_redundant = var.cosmos_mongo_db_params.main_geo_location_zone_redundant
  additional_geo_locations         = var.cosmos_mongo_db_params.additional_geo_locations

  backup_continuous_enabled                    = var.cosmos_mongo_db_params.backup_continuous_enabled
  enable_provisioned_throughput_exceeded_alert = var.cosmos_mongo_db_params.enable_provisioned_throughput_exceeded_alert

  tags = var.tags
}

resource "azurerm_cosmosdb_mongo_database" "ecommerce" {

  name                = "ecommerce"
  resource_group_name = azurerm_resource_group.cosmosdb_ecommerce_rg.name
  account_name        = module.cosmosdb_account_mongodb.name

  throughput = var.cosmos_mongo_db_ecommerce_params.enable_autoscaling || var.cosmos_mongo_db_ecommerce_params.enable_serverless ? null : var.cosmos_mongo_db_ecommerce_params.throughput

  dynamic "autoscale_settings" {
    for_each = var.cosmos_mongo_db_ecommerce_params.enable_autoscaling && !var.cosmos_mongo_db_ecommerce_params.enable_serverless ? [""] : []
    content {
      max_throughput = var.cosmos_mongo_db_ecommerce_params.max_throughput
    }
  }

}

resource "azurerm_cosmosdb_mongo_database" "ecommerce_history" {

  name                = "ecommerce-history"
  resource_group_name = azurerm_resource_group.cosmosdb_ecommerce_rg.name
  account_name        = module.cosmosdb_account_mongodb.name

  throughput = var.cosmos_mongo_db_ecommerce_history_params.enable_autoscaling || var.cosmos_mongo_db_ecommerce_history_params.enable_serverless ? null : var.cosmos_mongo_db_ecommerce_history_params.throughput

  dynamic "autoscale_settings" {
    for_each = var.cosmos_mongo_db_ecommerce_history_params.enable_autoscaling && !var.cosmos_mongo_db_ecommerce_history_params.enable_serverless ? [""] : []
    content {
      max_throughput = var.cosmos_mongo_db_ecommerce_history_params.max_throughput
    }
  }

}

# Collections
locals {
  collections = [
    {
      name = "payment-methods"
      indexes = [{
        keys   = ["_id"]
        unique = true
        }
      ]
      shard_key           = null,
      default_ttl_seconds = null
    },
    {
      name = "eventstore"
      indexes = [{
        keys   = ["_id"]
        unique = true
        },
        {
          keys   = ["transactionId", "creationDate"]
          unique = false
        }
      ]
      shard_key           = "transactionId",
      default_ttl_seconds = null
    },
    {
      name = "transactions-view"
      indexes = [{
        keys   = ["_id"]
        unique = true
        },
        {
          keys   = ["creationDate", "status", "clientId"]
          unique = false
        },
        {
          keys   = ["paymentNotices.rptId"]
          unique = false
        },
        {
          keys   = ["paymentNotices.paymentToken"]
          unique = false
        },
        {
          keys   = ["email.data"]
          unique = false
        }
      ]
      shard_key           = "_id",
      default_ttl_seconds = null
    },
    {
      name = "dead-letter-events"
      indexes = [{
        keys   = ["_id"]
        unique = true
        },
        {
          keys   = ["insertionDate", "queueName"]
          unique = false
        },
        {
          keys   = ["insertionDate"]
          unique = false
        },
        {
          keys   = ["transactionInfo.eCommerceStatus"]
          unique = false
        },
        {
          keys   = ["transactionInfo.details.operationResult"]
          unique = false
        }
      ]
      shard_key           = "_id",
      default_ttl_seconds = null
    },
    {
      name = "user-stats"
      indexes = [{
        keys   = ["_id"]
        unique = true
        }
      ]
      shard_key           = "_id",
      default_ttl_seconds = "31536000" #1 year
    },
  ]
}

module "cosmosdb_ecommerce_collections" {

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_mongodb_collection?ref=v8.42.3"


  for_each = {
    for index, coll in local.collections :
    coll.name => coll
  }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.cosmosdb_ecommerce_rg.name

  cosmosdb_mongo_account_name  = module.cosmosdb_account_mongodb.name
  cosmosdb_mongo_database_name = azurerm_cosmosdb_mongo_database.ecommerce.name

  indexes             = each.value.indexes
  shard_key           = each.value.shard_key
  default_ttl_seconds = each.value.default_ttl_seconds
  lock_enable         = var.env_short == "d" ? false : true
}

# Collections ecommerce history
locals {
  ecommerce_history_collections = [
    {
      name = "pm-transactions-view"
      indexes = [{
        keys   = ["_id"]
        unique = true
        },
        {
          keys   = ["userInfo.notificationEmail"]
          unique = false
        },
        {
          keys   = ["userInfo.userFiscalCode"]
          unique = false
        },
        {
          keys   = ["transactionInfo.creationDate"]
          unique = false
        }
      ]
      shard_key           = "_id",
      default_ttl_seconds = null
    },
  ]
}

module "cosmosdb_ecommerce_history_collections" {

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_mongodb_collection?ref=v8.42.3"


  for_each = {
    for index, coll in local.ecommerce_history_collections :
    coll.name => coll
  }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.cosmosdb_ecommerce_rg.name

  cosmosdb_mongo_account_name  = module.cosmosdb_account_mongodb.name
  cosmosdb_mongo_database_name = azurerm_cosmosdb_mongo_database.ecommerce_history.name

  indexes             = each.value.indexes
  shard_key           = each.value.shard_key
  default_ttl_seconds = each.value.default_ttl_seconds
  lock_enable         = var.env_short == "d" ? false : true
}

# -----------------------------------------------
# Alerts
# -----------------------------------------------

resource "azurerm_monitor_metric_alert" "cosmos_db_normalized_ru_exceeded" {
  count = var.env_short == "p" ? 1 : 0

  name                = "[${var.domain != null ? "${var.domain} | " : ""}${module.cosmosdb_account_mongodb.name}] Normalized RU Exceeded"
  resource_group_name = azurerm_resource_group.cosmosdb_ecommerce_rg.name
  scopes              = [module.cosmosdb_account_mongodb.id]
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
      values   = [azurerm_resource_group.cosmosdb_ecommerce_rg.location]
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
    action_group_id = azurerm_monitor_action_group.ecommerce_opsgenie[0].id
  }

  tags = var.tags
}
