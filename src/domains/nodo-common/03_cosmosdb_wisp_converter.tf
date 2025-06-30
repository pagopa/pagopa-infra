module "cosmosdb_account_wispconv" {
  count = var.create_wisp_converter ? 1 : 0

  source              = "./.terraform/modules/__v3__/cosmosdb_account"
  domain              = var.domain
  name                = "${local.project}-wispconv-cosmos-account"
  location            = var.location
  resource_group_name = azurerm_resource_group.wisp_converter_rg[0].name

  offer_type                    = var.wisp_converter_cosmos_nosql_db_params.offer_type
  kind                          = var.wisp_converter_cosmos_nosql_db_params.kind
  capabilities                  = var.wisp_converter_cosmos_nosql_db_params.capabilities
  enable_free_tier              = var.wisp_converter_cosmos_nosql_db_params.enable_free_tier
  burst_capacity_enabled        = var.wisp_converter_cosmos_nosql_db_params.burst_capacity_enabled
  subnet_id                     = module.cosmosdb_wisp_converter_snet[0].id
  public_network_access_enabled = var.wisp_converter_cosmos_nosql_db_params.public_network_access_enabled
  # private endpoint
  private_service_connection_sql_name = "${local.project}-wispconv-cosmos-nosql-endpoint"
  private_endpoint_enabled            = var.wisp_converter_cosmos_nosql_db_params.private_endpoint_enabled
  private_endpoint_sql_name           = "${local.project}-wispconv-cosmos-nosql-endpoint"
  private_dns_zone_sql_ids            = [data.azurerm_private_dns_zone.cosmos_nosql.id]
  is_virtual_network_filter_enabled   = var.wisp_converter_cosmos_nosql_db_params.is_virtual_network_filter_enabled
  ip_range                            = ""

  allowed_virtual_network_subnet_ids = var.wisp_converter_cosmos_nosql_db_params.public_network_access_enabled ? [] : [data.azurerm_subnet.aks_subnet.id]

  enable_automatic_failover = true

  consistency_policy               = var.wisp_converter_cosmos_nosql_db_params.consistency_policy
  main_geo_location_location       = var.location
  main_geo_location_zone_redundant = var.wisp_converter_cosmos_nosql_db_params.main_geo_location_zone_redundant
  additional_geo_locations         = var.wisp_converter_cosmos_nosql_db_params.additional_geo_locations

  backup_continuous_enabled = var.wisp_converter_cosmos_nosql_db_params.backup_continuous_enabled

  tags = module.tag_config.tags

  depends_on = [
    azurerm_resource_group.wisp_converter_rg,
    module.cosmosdb_wisp_converter_snet
  ]
}

# cosmosdb database for wispconv
module "cosmosdb_account_wispconv_db" {
  count               = var.create_wisp_converter ? 1 : 0
  source              = "./.terraform/modules/__v3__/cosmosdb_sql_database"
  name                = "wispconverter"
  resource_group_name = azurerm_resource_group.wisp_converter_rg[0].name
  account_name        = module.cosmosdb_account_wispconv[0].name
}

### containers
locals {
  wispconv_containers = [
    {
      name               = "data",
      partition_key_path = "/id", # contains brokerEC_sessionId
      default_ttl        = var.wisp_converter_cosmos_nosql_db_params.data_ttl
      autoscale_settings = {
        max_throughput = var.wisp_converter_cosmos_nosql_db_params.data_max_throughput
      }
    },
    {
      name               = "receipt",       # contains all paaInviaRT to send
      partition_key_path = "/partitionKey", # contains 'yyyy-MM-dd'
      default_ttl        = var.wisp_converter_cosmos_nosql_db_params.receipt_ttl
      autoscale_settings = {
        max_throughput = var.wisp_converter_cosmos_nosql_db_params.receipt_max_throughput
      }
    },
    {
      name               = "receipt-dead-letter", # contains all paaInviaRT sent but not accepted by EC and with fault code not in blacklist
      partition_key_path = "/partitionKey",       # contains 'yyyy-MM-dd'
      default_ttl        = var.wisp_converter_cosmos_nosql_db_params.receipt_dead_letter_ttl
      autoscale_settings = {
        max_throughput = var.wisp_converter_cosmos_nosql_db_params.receipt_dead_letter_max_throughput
      }
    },
    {
      name               = "idempotency_key",
      partition_key_path = "/partitionKey", # contains 'yyyy-MM-dd'
      default_ttl        = var.wisp_converter_cosmos_nosql_db_params.idempotency_ttl
      autoscale_settings = {
        max_throughput = var.wisp_converter_cosmos_nosql_db_params.idempotency_max_throughput
      }
    },
    {
      name               = "re",
      partition_key_path = "/partitionKey", # contains 'yyyy-MM-dd'
      default_ttl        = var.wisp_converter_cosmos_nosql_db_params.re_ttl
      autoscale_settings = {
        max_throughput = var.wisp_converter_cosmos_nosql_db_params.re_max_throughput
      }
    },
    {
      name               = "receipts-rt", # contains all generated and sent RT
      partition_key_path = "/id",
      default_ttl        = var.wisp_converter_cosmos_nosql_db_params.rt_ttl
      autoscale_settings = {
        max_throughput = var.wisp_converter_cosmos_nosql_db_params.rt_max_throughput
      }
    },
    {
      name               = "configuration",
      partition_key_path = "/id", # contains 'yyyy-MM-dd'
      default_ttl        = var.wisp_converter_cosmos_nosql_db_params.configuration_ttl
      autoscale_settings = {
        max_throughput = var.wisp_converter_cosmos_nosql_db_params.configuration_max_throughput
      }
    },
    {
      name               = "reports", # contains all extracted reports
      partition_key_path = "/date",   # contains 'yyyy-MM-dd'
      default_ttl        = var.wisp_converter_cosmos_nosql_db_params.report_ttl
      autoscale_settings = {
        max_throughput = var.wisp_converter_cosmos_nosql_db_params.report_max_throughput
      }
    },
    {
      name               = "nav2iuv-mapping",
      partition_key_path = "/partitionKey", # contains Broker EC fiscal code
      default_ttl        = var.wisp_converter_cosmos_nosql_db_params.nav2iuv_mapping_ttl
      autoscale_settings = {
        max_throughput = var.wisp_converter_cosmos_nosql_db_params.nav2iuv_mapping_max_throughput
      }
    },
  ]
}

# cosmosdb container for stand-in datastore
module "cosmosdb_account_wispconv_containers" {
  source   = "./.terraform/modules/__v3__/cosmosdb_sql_container"
  for_each = { for c in local.wispconv_containers : c.name => c if var.create_wisp_converter }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.wisp_converter_rg[0].name
  account_name        = module.cosmosdb_account_wispconv[0].name
  database_name       = module.cosmosdb_account_wispconv_db[0].name
  partition_key_path  = each.value.partition_key_path
  throughput          = lookup(each.value, "throughput", null)
  default_ttl         = lookup(each.value, "default_ttl", null)

  autoscale_settings = contains(var.wisp_converter_cosmos_nosql_db_params.capabilities, "EnableServerless") ? null : lookup(each.value, "autoscale_settings", null)

  depends_on = [
    azurerm_resource_group.wisp_converter_rg,
    module.cosmosdb_account_wispconv,
    module.cosmosdb_account_wispconv_db
  ]
}

resource "azurerm_monitor_metric_alert" "cosmos_wisp_normalized_ru_exceeded" {
  count = (var.env_short == "p" && var.create_wisp_converter) ? 1 : 0

  name                = "[${var.domain != null ? "${var.domain} | " : ""}${module.cosmosdb_account_wispconv[0].name}] Normalized RU Exceeded"
  resource_group_name = azurerm_resource_group.wisp_converter_rg[0].name
  scopes              = [module.cosmosdb_account_wispconv[0].id]
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
      values   = [azurerm_resource_group.wisp_converter_rg[0].location]
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
    action_group_id = azurerm_monitor_action_group.slack.id
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.opsgenie[0].id
  }

  tags = module.tag_config.tags
}


