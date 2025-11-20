resource "azurerm_resource_group" "receipts_rg" {
  name     = "${local.project}-rg"
  location = var.location

  tags = module.tag_config.tags
}


locals {

  action_groups_default = [
    {
      action_group_id    = data.azurerm_monitor_action_group.email.id
      webhook_properties = null
    },
    {
      action_group_id    = data.azurerm_monitor_action_group.slack.id
      webhook_properties = null
    }
  ]

  action_groups = var.env_short == "p" ? concat(local.action_groups_default, [{
    action_group_id    = data.azurerm_monitor_action_group.opsgenie[0].id
    webhook_properties = null
  }]) : local.action_groups_default
}





module "receipts_datastore_cosmosdb_snet" {
  source               = "./.terraform/modules/__v3__/subnet"
  name                 = "${local.project}-datastore-cosmosdb-snet"
  address_prefixes     = var.cidr_subnet_receipts_datastore_cosmosdb
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_name

  private_endpoint_network_policies_enabled = false

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]
}

module "receipts_datastore_cosmosdb_account" {
  source              = "./.terraform/modules/__v3__/cosmosdb_account"
  name                = "${local.project}-ds-cosmos-account"
  location            = var.location
  domain              = var.domain
  resource_group_name = azurerm_resource_group.receipts_rg.name
  offer_type          = var.receipts_datastore_cosmos_db_params.offer_type
  kind                = var.receipts_datastore_cosmos_db_params.kind

  public_network_access_enabled    = var.receipts_datastore_cosmos_db_params.public_network_access_enabled
  main_geo_location_zone_redundant = var.receipts_datastore_cosmos_db_params.main_geo_location_zone_redundant

  enable_free_tier          = var.receipts_datastore_cosmos_db_params.enable_free_tier
  enable_automatic_failover = true

  capabilities       = var.receipts_datastore_cosmos_db_params.capabilities
  consistency_policy = var.receipts_datastore_cosmos_db_params.consistency_policy

  main_geo_location_location = var.location
  additional_geo_locations   = var.receipts_datastore_cosmos_db_params.additional_geo_locations
  backup_continuous_enabled  = var.receipts_datastore_cosmos_db_params.backup_continuous_enabled

  is_virtual_network_filter_enabled = var.receipts_datastore_cosmos_db_params.is_virtual_network_filter_enabled

  ip_range = ""

  enable_provisioned_throughput_exceeded_alert = var.env_short == "p" ? true : false

  action = local.action_groups

  # add data.azurerm_subnet.<my_service>.id
  # allowed_virtual_network_subnet_ids = var.receipts_datastore_cosmos_db_params.public_network_access_enabled ? var.env_short == "d" ? [] : [data.azurerm_subnet.aks_subnet.id] : [data.azurerm_subnet.aks_subnet.id]
  allowed_virtual_network_subnet_ids = []

  # private endpoint
  private_endpoint_sql_name           = "${local.project}-ds-cosmos-sql-endpoint" # forced after update module vers
  private_service_connection_sql_name = "${local.project}-ds-cosmos-sql-endpoint" # forced after update module vers
  private_endpoint_enabled            = var.receipts_datastore_cosmos_db_params.private_endpoint_enabled
  subnet_id                           = module.receipts_datastore_cosmosdb_snet.id
  private_dns_zone_sql_ids            = [data.azurerm_private_dns_zone.cosmos.id]


  tags = module.tag_config.tags
}

# cosmosdb database for receipts
module "receipts_datastore_cosmosdb_database" {
  source              = "./.terraform/modules/__v3__/cosmosdb_sql_database"
  name                = "db"
  resource_group_name = azurerm_resource_group.receipts_rg.name
  account_name        = module.receipts_datastore_cosmosdb_account.name
}

### Containers
locals {
  receipts_datastore_cosmosdb_containers = [
    # {
    #   name               = "fake",
    #   partition_key_path = "/fakeid",
    #   default_ttl        = var.receipts_datastore_cosmos_db_params.container_default_ttl
    #   autoscale_settings = { max_throughput = (var.env_short != "p" ? 6000 : 20000) }
    # },
    {
      name                       = "receipts",
      partition_key_path         = "/id",
      default_ttl                = var.receipts_datastore_cosmos_db_params.container_default_ttl
      autoscale_settings         = { max_throughput = var.receipts_datastore_cosmos_db_params.max_throughput },
      conflict_resolution_policy = { mode = "LastWriterWins", path = "/_ts", procedure = null }
    },
    {
      name                       = "cart-for-receipts",
      partition_key_path         = "/eventId",
      default_ttl                = var.receipts_datastore_cosmos_db_params.container_default_ttl
      autoscale_settings         = { max_throughput = var.receipts_datastore_cosmos_db_params.max_throughput_alt },
      conflict_resolution_policy = { mode = "LastWriterWins", path = "/_ts", procedure = null }
    },
    {
      name                       = "receipts-message-errors",
      partition_key_path         = "/id",
      default_ttl                = var.receipts_datastore_cosmos_db_params.container_default_ttl
      autoscale_settings         = { max_throughput = var.receipts_datastore_cosmos_db_params.max_throughput_alt },
      conflict_resolution_policy = { mode = "LastWriterWins", path = "/_ts", procedure = null }
    },
    {
      name                       = "cart-receipts-message-errors",
      partition_key_path         = "/id",
      default_ttl                = var.receipts_datastore_cosmos_db_params.container_default_ttl
      autoscale_settings         = { max_throughput = var.receipts_datastore_cosmos_db_params.max_throughput_alt },
      conflict_resolution_policy = { mode = "LastWriterWins", path = "/_ts", procedure = null }
    },
    {
      name                       = "receipts-io-messages",
      partition_key_path         = "/messageId",
      default_ttl                = var.receipts_datastore_cosmos_db_params.container_default_ttl
      autoscale_settings         = { max_throughput = var.receipts_datastore_cosmos_db_params.max_throughput_alt },
      conflict_resolution_policy = { mode = "LastWriterWins", path = "/_ts", procedure = null }
    },
    {
      name                       = "receipts-io-messages-evt",
      partition_key_path         = "/eventId",
      default_ttl                = var.receipts_datastore_cosmos_db_params.container_default_ttl
      autoscale_settings         = { max_throughput = var.receipts_datastore_cosmos_db_params.max_throughput_alt },
      conflict_resolution_policy = { mode = "LastWriterWins", path = "/_ts", procedure = null }
    },
    {
      name                       = "cart-receipts-io-messages",
      partition_key_path         = "/cartId",
      default_ttl                = var.receipts_datastore_cosmos_db_params.container_default_ttl
      autoscale_settings         = { max_throughput = var.receipts_datastore_cosmos_db_params.max_throughput_alt },
      conflict_resolution_policy = { mode = "LastWriterWins", path = "/_ts", procedure = null }
    },
  ]
}

# cosmosdb container for receipts datastore
module "receipts_datastore_cosmosdb_containers" {
  # source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container?ref=PRDP-276-feat-add-conflict-resolution-policy-and-stored-procedure"
  source = "./.terraform/modules/__v3__/cosmosdb_sql_container"

  for_each = { for c in local.receipts_datastore_cosmosdb_containers : c.name => c }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.receipts_rg.name
  account_name        = module.receipts_datastore_cosmosdb_account.name
  database_name       = module.receipts_datastore_cosmosdb_database.name
  partition_key_path  = each.value.partition_key_path
  throughput          = lookup(each.value, "throughput", null)
  default_ttl         = lookup(each.value, "default_ttl", null)

  # conflict_resolution_policy = each.value.conflict_resolution_policy == null ? null : each.value.conflict_resolution_policy
  autoscale_settings = contains(var.receipts_datastore_cosmos_db_params.capabilities, "EnableServerless") ? null : lookup(each.value, "autoscale_settings", null)
}

resource "azurerm_monitor_metric_alert" "cosmos_db_normalized_ru_exceeded" {
  count = var.env_short == "p" ? 1 : 0

  name                = "[${var.domain != null ? "${var.domain} | " : ""}${module.receipts_datastore_cosmosdb_account.name}] Normalized RU Exceeded"
  resource_group_name = azurerm_resource_group.receipts_rg.name
  scopes              = [module.receipts_datastore_cosmosdb_account.id]
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
      values   = [azurerm_resource_group.receipts_rg.location]
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
    action_group_id = data.azurerm_monitor_action_group.opsgenie[0].id
  }

  tags = module.tag_config.tags
}


resource "azurerm_monitor_metric_alert" "cosmos_db_provisioned_throughput_exceeded_ProvisionedThroughput" { # https://github.com/pagopa/terraform-azurerm-v3/blob/58f14dc120e10bd3515bcc34e0685e74d1d11047/cosmosdb_account/main.tf#L205
  count = var.env_short == "p" ? 1 : 0

  name                = "[${var.domain != null ? "${var.domain} | " : ""}${module.receipts_datastore_cosmosdb_account.name}] Provisioned Throughput Exceeded - ProvisionedThroughput"
  resource_group_name = azurerm_resource_group.receipts_rg.name
  scopes              = [module.receipts_datastore_cosmosdb_account.id]
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
    threshold              = 0 // var.receipts_datastore_cosmos_db_params.max_throughput
    skip_metric_validation = false


    dimension {
      name     = "Region"
      operator = "Include"
      values   = [var.location]
    }
    dimension {
      name     = "StatusCode"
      operator = "Include"
      values   = ["429"]
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
    action_group_id = data.azurerm_monitor_action_group.opsgenie[0].id
  }


  tags = module.tag_config.tags
}
