prefix         = "pagopa"
env_short      = "u"
env            = "uat"
domain         = "printit"
location       = "italynorth"
location_short = "itn"
instance       = "uat"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/printit-common"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "pagopa-u-monitor-rg"
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"

### Aks

ingress_load_balancer_ip = "10.3.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.uat.platform"

# Cosmos MongoDB Notices Params
cosmos_mongo_db_notices_params = {
  enable       = true
  kind         = "MongoDB"
  capabilities = ["EnableMongo"]
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100000
  }
  server_version                   = "4.0"
  main_geo_location_zone_redundant = false
  enable_free_tier                 = false

  additional_geo_locations          = []
  private_endpoint_enabled          = false
  public_network_access_enabled     = true
  is_virtual_network_filter_enabled = false

  backup_continuous_enabled = false

  enable_serverless  = false
  enable_autoscaling = true
  max_throughput     = 2000
  throughput         = 1000

  container_default_ttl = 259200 # 3 days
}

notices_storage_account = {
  account_kind                                                        = "StorageV2"
  account_tier                                                        = "Standard"
  account_replication_type                                            = "LRS"
  blob_versioning_enabled                                             = false
  advanced_threat_protection                                          = false
  public_network_access_enabled                                       = true
  blob_delete_retention_days                                          = 30
  enable_low_availability_alert                                       = false
  blob_tier_to_cool_after_last_access                                 = 100
  blob_tier_to_archive_after_days_since_last_access_time_greater_than = 3650
  blob_delete_after_last_access                                       = 3650
}

templates_storage_account = {
  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  blob_versioning_enabled       = false
  advanced_threat_protection    = false
  public_network_access_enabled = true
  blob_delete_retention_days    = 30
  enable_low_availability_alert = false
}

institutions_storage_account = {
  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  blob_versioning_enabled       = false
  advanced_threat_protection    = false
  public_network_access_enabled = true
  blob_delete_retention_days    = 30
  enable_low_availability_alert = false
}

cidr_subnet_cosmosdb_printit = ["10.3.3.0/24"]
cidr_subnet_storage_account  = ["10.3.4.0/24"]
cidr_subnet_eventhub   = ["10.3.5.64/26"]

enable_iac_pipeline = true


ehns_sku_name = "Standard"
# to avoid https://docs.microsoft.com/it-it/azure/event-hubs/event-hubs-messaging-exceptions#error-code-50002
ehns_auto_inflate_enabled     = true
ehns_maximum_throughput_units = 5
ehns_capacity                 = 5

ehns_alerts_enabled = false

ehns_metric_alerts = {}

eventhubs = [
  {
    name              = "payment-notice-evt"
    partitions        = 32
    message_retention = 7
    consumers         = ["pagopa-notice-evt-rx", "pagopa-notice-complete-evt-rx", "pagopa-notice-error-evt-rx"]
    keys = [
      {
        name   = "pagopa-notice-evt-rx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pagopa-notice-complete-evt-rx"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "pagopa-notice-error-evt-rxv"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
]
