prefix         = "pagopa"
env_short      = "p"
env            = "prod"
domain         = "printit"
location       = "italynorth"
location_short = "itn"
instance       = "prod"


### 🚩Features flags

is_feature_enabled = {
  cosmosdb_notice      = true
  storage_institutions = true
  storage_notice       = true
  storage_templates    = true
  eventhub             = true
}

### CIRDs

cidr_printit_cosmosdb_italy   = ["10.3.12.0/27"]
cidr_printit_storage_italy    = ["10.3.12.32/27"]
cidr_printit_redis_italy      = ["10.3.12.64/27"]
cidr_printit_postgresql_italy = ["10.3.12.96/27"]
cidr_printit_pdf_engine_italy = ["10.3.12.128/27"]
cidr_printit_eventhub_italy   = ["10.3.12.160/27"]

### External resources

monitor_italy_resource_group_name                 = "pagopa-p-itn-core-monitor-rg"
log_analytics_italy_workspace_name                = "pagopa-p-itn-core-law"
log_analytics_italy_workspace_resource_group_name = "pagopa-p-itn-core-monitor-rg"

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

### Aks

ingress_load_balancer_ip = "10.3.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"

# Cosmos MongoDB Notices Params
cosmos_mongo_db_notices_params = {
  kind         = "MongoDB"
  capabilities = ["EnableMongo"]
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  server_version                   = "4.0"
  main_geo_location_zone_redundant = true
  enable_free_tier                 = false

  additional_geo_locations = [{
    location          = "germanywestcentral"
    failover_priority = 1
    zone_redundant    = false
  }]
  private_endpoint_enabled          = true
  public_network_access_enabled     = false
  is_virtual_network_filter_enabled = false

  backup_continuous_enabled = true

  enable_serverless  = false
  enable_autoscaling = true
  max_throughput     = 2000
  throughput         = 1000

  container_default_ttl = 259200 # 3 days
}

notices_storage_account = {
  account_kind                        = "StorageV2"
  account_tier                        = "Standard"
  account_replication_type            = "ZRS"
  blob_versioning_enabled             = true
  advanced_threat_protection          = false
  public_network_access_enabled       = false
  blob_delete_retention_days          = 30
  enable_low_availability_alert       = true
  blob_tier_to_cool_after_last_access = 100
  #   blob_tier_to_archive_after_days_since_last_access_time_greater_than = 3650
  blob_delete_after_last_access = 200
}

templates_storage_account = {
  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  account_replication_type      = "ZRS"
  blob_versioning_enabled       = true
  advanced_threat_protection    = false
  public_network_access_enabled = false
  blob_delete_retention_days    = 30
  enable_low_availability_alert = true
}

institutions_storage_account = {
  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  account_replication_type      = "ZRS"
  blob_versioning_enabled       = true
  advanced_threat_protection    = false
  public_network_access_enabled = false
  blob_delete_retention_days    = 30
  enable_low_availability_alert = true
}

#
# EventHub
#
ehns_sku_name = "Standard"

# to avoid https://docs.microsoft.com/it-it/azure/event-hubs/event-hubs-messaging-exceptions#error-code-50002
ehns_auto_inflate_enabled     = true
ehns_maximum_throughput_units = 5
ehns_capacity                 = 5
ehns_alerts_enabled           = true
ehns_zone_redundant           = true

ehns_public_network_access       = false
ehns_private_endpoint_is_present = true

ehns_metric_alerts = {
  no_trx = {
    aggregation = "Total"
    metric_name = "IncomingMessages"
    description = "No transactions received from acquirer in the last 24h"
    operator    = "LessThanOrEqual"
    threshold   = 1000
    frequency   = "PT1H"
    window_size = "P1D"
    dimension = [
      {
        name     = "EntityName"
        operator = "Include"
        values   = ["rtd-trx"]
      }
    ],
  },
  active_connections = {
    aggregation = "Average"
    metric_name = "ActiveConnections"
    description = null
    operator    = "LessThanOrEqual"
    threshold   = 0
    frequency   = "PT5M"
    window_size = "PT15M"
    dimension   = [],
  },
  error_trx = {
    aggregation = "Total"
    metric_name = "IncomingMessages"
    description = "Transactions rejected from one acquirer file received. trx write on eventhub. check immediately"
    operator    = "GreaterThan"
    threshold   = 0
    frequency   = "PT5M"
    window_size = "PT30M"
    dimension = [
      {
        name     = "EntityName"
        operator = "Include"
        values = [
          "nodo-dei-pagamenti-log",
          "nodo-dei-pagamenti-re"
        ]
      }
    ],
  },
}

