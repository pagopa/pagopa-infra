resource "azurerm_resource_group" "bizevents_rg" {
  name     = "${local.project}-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "bizevents_datastore_cosmosdb_snet" {
  source               = "./.terraform/modules/__v3__/subnet"
  name                 = "${local.project}-datastore-cosmosdb-snet"
  address_prefixes     = var.cidr_subnet_bizevents_datastore_cosmosdb
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_name

  private_endpoint_network_policies_enabled = false

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]
}

module "bizevents_datastore_cosmosdb_account" {
  source              = "./.terraform/modules/__v3__/cosmosdb_account"
  name                = "${local.project}-ds-cosmos-account"
  location            = var.location
  domain              = var.domain
  resource_group_name = azurerm_resource_group.bizevents_rg.name
  offer_type          = var.bizevents_datastore_cosmos_db_params.offer_type
  kind                = var.bizevents_datastore_cosmos_db_params.kind

  public_network_access_enabled    = var.bizevents_datastore_cosmos_db_params.public_network_access_enabled
  main_geo_location_zone_redundant = var.bizevents_datastore_cosmos_db_params.main_geo_location_zone_redundant

  enable_free_tier          = var.bizevents_datastore_cosmos_db_params.enable_free_tier
  enable_automatic_failover = true

  capabilities       = var.bizevents_datastore_cosmos_db_params.capabilities
  consistency_policy = var.bizevents_datastore_cosmos_db_params.consistency_policy

  main_geo_location_location = var.location
  additional_geo_locations   = var.bizevents_datastore_cosmos_db_params.additional_geo_locations
  backup_continuous_enabled  = var.bizevents_datastore_cosmos_db_params.backup_continuous_enabled

  is_virtual_network_filter_enabled = var.bizevents_datastore_cosmos_db_params.is_virtual_network_filter_enabled

  ip_range = var.bizevents_datastore_cosmos_db_params.ip_range_filter

  # add data.azurerm_subnet.<my_service>.id
  # allowed_virtual_network_subnet_ids = var.bizevents_datastore_cosmos_db_params.public_network_access_enabled ? var.env_short == "d" ? [] : [data.azurerm_subnet.aks_subnet.id] : [data.azurerm_subnet.aks_subnet.id]
  allowed_virtual_network_subnet_ids = []

  # private endpoint
  private_endpoint_sql_name           = "${local.project}-ds-cosmos-sql-endpoint" # forced after update module vers
  private_service_connection_sql_name = "${local.project}-ds-cosmos-sql-endpoint" # forced after update module vers
  private_endpoint_enabled            = var.bizevents_datastore_cosmos_db_params.private_endpoint_enabled
  subnet_id                           = module.bizevents_datastore_cosmosdb_snet.id
  private_dns_zone_sql_ids            = [data.azurerm_private_dns_zone.cosmos.id]

  tags = module.tag_config.tags
}

module "bizevents_datastore_cosmosdb_account_dev" {
  count = var.env_short == "d" ? 1 : 0 # used for ADF biz test developer

  source              = "./.terraform/modules/__v3__/cosmosdb_account"
  name                = "${local.project}-ds-cosmos-account-dev"
  location            = var.location
  domain              = var.domain
  resource_group_name = azurerm_resource_group.bizevents_rg.name
  offer_type          = var.bizevents_datastore_cosmos_db_params.offer_type
  kind                = var.bizevents_datastore_cosmos_db_params.kind

  public_network_access_enabled    = var.bizevents_datastore_cosmos_db_params.public_network_access_enabled
  main_geo_location_zone_redundant = var.bizevents_datastore_cosmos_db_params.main_geo_location_zone_redundant

  enable_free_tier          = var.bizevents_datastore_cosmos_db_params.enable_free_tier
  enable_automatic_failover = true

  capabilities       = []
  consistency_policy = var.bizevents_datastore_cosmos_db_params.consistency_policy

  main_geo_location_location = var.location
  additional_geo_locations   = var.bizevents_datastore_cosmos_db_params.additional_geo_locations
  backup_continuous_enabled  = var.bizevents_datastore_cosmos_db_params.backup_continuous_enabled

  is_virtual_network_filter_enabled = var.bizevents_datastore_cosmos_db_params.is_virtual_network_filter_enabled

  ip_range = var.bizevents_datastore_cosmos_db_params.ip_range_filter

  # add data.azurerm_subnet.<my_service>.id
  # allowed_virtual_network_subnet_ids = var.bizevents_datastore_cosmos_db_params.public_network_access_enabled ? var.env_short == "d" ? [] : [data.azurerm_subnet.aks_subnet.id] : [data.azurerm_subnet.aks_subnet.id]
  allowed_virtual_network_subnet_ids = []

  # private endpoint
  private_endpoint_sql_name           = "${local.project}-ds-cosmos-sql-endpoint" # forced after update module vers
  private_service_connection_sql_name = "${local.project}-ds-cosmos-sql-endpoint" # forced after update module vers
  private_endpoint_enabled            = var.bizevents_datastore_cosmos_db_params.private_endpoint_enabled
  subnet_id                           = module.bizevents_datastore_cosmosdb_snet.id
  private_dns_zone_sql_ids            = [data.azurerm_private_dns_zone.cosmos.id]

  tags = module.tag_config.tags
}

# cosmosdb database for biz-events
module "bizevents_datastore_cosmosdb_database" {
  source              = "./.terraform/modules/__v3__/cosmosdb_sql_database"
  name                = "db"
  resource_group_name = azurerm_resource_group.bizevents_rg.name
  account_name        = module.bizevents_datastore_cosmosdb_account.name
}
module "bizevents_datastore_cosmosdb_database_dev" {
  count = var.env_short == "d" ? 1 : 0 # used for ADF biz test developer

  source              = "./.terraform/modules/__v3__/cosmosdb_sql_database"
  name                = "db"
  resource_group_name = azurerm_resource_group.bizevents_rg.name
  account_name        = module.bizevents_datastore_cosmosdb_account_dev[0].name
}

### Containers
locals {
  bizevents_datastore_cosmosdb_containers = [
    {
      name               = "biz-events",
      partition_key_path = "/id",
      default_ttl        = var.bizevents_datastore_cosmos_db_params.container_default_ttl
      # autoscale_settings = { max_throughput = sum(toset([var.bizevents_datastore_cosmos_db_params.max_throughput, var.env_short == "p" ? 2000 : 0])) }
      autoscale_settings = { max_throughput = var.bizevents_datastore_cosmos_db_params.max_throughput_view_alt }
    },
    {
      name               = "biz-events-view-general",
      partition_key_path = "/transactionId",
      default_ttl        = var.bizevents_datastore_cosmos_db_params.container_default_ttl
      autoscale_settings = { max_throughput = var.bizevents_datastore_cosmos_db_params.max_throughput_view_alt }
    },
    {
      name               = "biz-events-view-cart",
      partition_key_path = "/transactionId",
      default_ttl        = var.bizevents_datastore_cosmos_db_params.container_default_ttl
      autoscale_settings = { max_throughput = var.bizevents_datastore_cosmos_db_params.max_throughput_view_alt }
    },
    {
      name               = "biz-events-view-user",
      partition_key_path = "/taxCode",
      default_ttl        = var.bizevents_datastore_cosmos_db_params.container_default_ttl
      autoscale_settings = { max_throughput = var.bizevents_datastore_cosmos_db_params.max_throughput_view_alt }
    }
  ]

  bizevents_datastore_cosmosdb_containers_dev = var.env_short == "d" ? [
    {
      name               = "biz-events-view-general",
      partition_key_path = "/transactionId",
      default_ttl        = var.bizevents_datastore_cosmos_db_params.container_default_ttl
      autoscale_settings = { max_throughput = 1000 }
    },
    {
      name               = "biz-events-view-cart",
      partition_key_path = "/transactionId",
      default_ttl        = var.bizevents_datastore_cosmos_db_params.container_default_ttl
      autoscale_settings = { max_throughput = 1000 }
    },
    {
      name               = "biz-events-view-user",
      partition_key_path = "/taxCode",
      default_ttl        = var.bizevents_datastore_cosmos_db_params.container_default_ttl
      autoscale_settings = { max_throughput = 1000 }
  }] : []
}

# cosmosdb container for biz events datastore
module "bizevents_datastore_cosmosdb_containers" {
  source   = "./.terraform/modules/__v3__/cosmosdb_sql_container"
  for_each = { for c in local.bizevents_datastore_cosmosdb_containers : c.name => c }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.bizevents_rg.name
  account_name        = module.bizevents_datastore_cosmosdb_account.name
  database_name       = module.bizevents_datastore_cosmosdb_database.name
  partition_key_path  = each.value.partition_key_path
  throughput          = lookup(each.value, "throughput", null)
  default_ttl         = lookup(each.value, "default_ttl", null)

  autoscale_settings = contains(var.bizevents_datastore_cosmos_db_params.capabilities, "EnableServerless") ? null : lookup(each.value, "autoscale_settings", null)
}

module "bizevents_datastore_cosmosdb_containers_dev" {

  source   = "./.terraform/modules/__v3__/cosmosdb_sql_container"
  for_each = { for c in local.bizevents_datastore_cosmosdb_containers_dev : c.name => c }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.bizevents_rg.name
  account_name        = module.bizevents_datastore_cosmosdb_account_dev[0].name
  database_name       = module.bizevents_datastore_cosmosdb_database_dev[0].name
  partition_key_path  = each.value.partition_key_path
  throughput          = lookup(each.value, "throughput", null)
  default_ttl         = lookup(each.value, "default_ttl", null)

  autoscale_settings = contains(var.bizevents_datastore_cosmos_db_params.capabilities, "EnableServerless") ? null : lookup(each.value, "autoscale_settings", null)
}

resource "azurerm_monitor_metric_alert" "cosmos_biz_db_normalized_ru_exceeded" {
  count = var.env_short == "p" ? 1 : 0

  name                = "[${var.domain != null ? "${var.domain} | " : ""}${module.bizevents_datastore_cosmosdb_account.name}] Normalized RU Exceeded"
  resource_group_name = azurerm_resource_group.bizevents_rg.name
  scopes              = [module.bizevents_datastore_cosmosdb_account.id]
  description         = "A collection Normalized RU/s exceed provisioned throughput, and it's raising latency. Please, consider to increase RU."
  severity            = 0
  window_size         = "PT5M"
  frequency           = "PT5M"
  auto_mitigate       = false
  enabled             = false # TODO diabled TMP


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
      values   = ["West Europe"]
    }

  }

  action {
    action_group_id = data.azurerm_monitor_action_group.email.id
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.slack.id
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.opsgenie[0].id
  }

  tags = module.tag_config.tags
}


# In general, for a production workload, if you see between 1-5% of requests with 429s, 
# and your end-to-end latency is acceptable, this is a healthy sign that the RU/s are being fully utilized. 
# In this case, the normalized RU consumption metric reaching 100% only means that in a given second, 
# at least one partition key range used all its provisioned throughput. 
# This is acceptable because the overall rate of 429s is still low. No further action is required.
resource "azurerm_monitor_metric_alert" "cosmos_biz_db_provisioned_throughput_exceeded" { # https://github.com/pagopa/terraform-azurerm-v3/blob/58f14dc120e10bd3515bcc34e0685e74d1d11047/cosmosdb_account/main.tf#L205
  count = var.env_short == "p" ? 1 : 0

  name                = "[${var.domain != null ? "${var.domain} | " : ""}${module.bizevents_datastore_cosmosdb_account.name}] 429 Throttling Errors Exceeded"
  resource_group_name = azurerm_resource_group.bizevents_rg.name
  scopes              = [module.bizevents_datastore_cosmosdb_account.id]
  description         = "A collection throughput (RU/s) exceed provisioned throughput, and it's raising 429 errors. Please, consider to increase RU. Runbook: not needed."
  severity            = 0
  window_size         = "PT5M"
  frequency           = "PT1M"
  auto_mitigate       = false


  # Metric info
  # https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/metrics-supported#microsoftdocumentdbdatabaseaccounts
  criteria {
    metric_namespace       = "Microsoft.DocumentDB/databaseAccounts"
    metric_name            = "TotalRequestUnits"
    aggregation            = "Total"
    operator               = "GreaterThan"
    threshold              = 100 # https://learn.microsoft.com/en-us/azure/cosmos-db/monitor-normalized-request-units?utm_source=chatgpt.com#what-to-expect-and-do-when-normalized-rus-is-higher
    skip_metric_validation = false

    dimension {
      name     = "StatusCode"
      operator = "Include"
      values   = ["429"]
    }
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.email.id
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.slack.id
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.opsgenie[0].id
  }


  tags = module.tag_config.tags
}