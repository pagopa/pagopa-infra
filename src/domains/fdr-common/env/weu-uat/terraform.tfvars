prefix         = "pagopa"
env_short      = "u"
env            = "uat"
domain         = "fdr"
location       = "westeurope"
location_short = "weu"
instance       = "uat"


### External resources

monitor_resource_group_name                 = "pagopa-u-monitor-rg"
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"

### Aks

ingress_load_balancer_ip = "10.1.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.uat.platform"

## CIDR fdr per database pgsql
cidr_subnet_flex_dbms = ["10.1.162.0/24"]

enable_iac_pipeline = true

pgres_flex_params = {

  sku_name   = "GP_Standard_D4ds_v4"
  db_version = "15"
  # Possible values are 32768, 65536, 131072, 262144, 524288, 1048576,
  # 2097152, 4194304, 8388608, 16777216, and 33554432.
  storage_mb                             = 1048576 # 1Tib
  zone                                   = 1
  backup_retention_days                  = 7
  geo_redundant_backup_enabled           = false
  create_mode                            = "Default"
  pgres_flex_private_endpoint_enabled    = true
  pgres_flex_ha_enabled                  = false
  pgres_flex_pgbouncer_enabled           = true
  standby_availability_zone              = 2
  pgres_flex_diagnostic_settings_enabled = false
  alerts_enabled                         = false
  max_connections                        = 5000
  pgbouncer_min_pool_size                = 10
  max_worker_process                     = 32
  wal_level                              = "logical"
  shared_preoload_libraries              = "pg_failover_slots"
  public_network_access_enabled          = false
}

custom_metric_alerts = {

  cpu_percent = {
    frequency        = "PT5M"
    window_size      = "PT30M"
    metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
    aggregation      = "Average"
    metric_name      = "cpu_percent"
    operator         = "GreaterThan"
    threshold        = 80
    severity         = 2
  },
  memory_percent = {
    frequency        = "PT5M"
    window_size      = "PT30M"
    metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
    aggregation      = "Average"
    metric_name      = "memory_percent"
    operator         = "GreaterThan"
    threshold        = 80
    severity         = 2
  },
  storage_percent = {
    frequency        = "PT5M"
    window_size      = "PT30M"
    metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
    aggregation      = "Average"
    metric_name      = "storage_percent"
    operator         = "GreaterThan"
    threshold        = 80
    severity         = 2
  },
  active_connections = {
    frequency        = "PT5M"
    window_size      = "PT30M"
    metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
    aggregation      = "Average"
    metric_name      = "active_connections"
    operator         = "GreaterThan"
    threshold        = 1000
    severity         = 2
  },
  connections_failed = {
    frequency        = "PT5M"
    window_size      = "PT30M"
    metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
    aggregation      = "Total"
    metric_name      = "connections_failed"
    operator         = "GreaterThan"
    threshold        = 50
    severity         = 2
  }
}

### Cosmos
cidr_subnet_cosmosdb_fdr = ["10.1.136.0/24"]

cosmos_mongo_db_fdr_re_params = {
  enabled      = true
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
  private_endpoint_enabled          = true
  public_network_access_enabled     = false
  is_virtual_network_filter_enabled = true

  backup_continuous_enabled = false

  container_default_ttl = 2629800 # 1 month in second

  enable_serverless  = false
  enable_autoscaling = true
  max_throughput     = 10000
  throughput         = 1000
}

# Storage Account

cidr_subnet_storage_account = ["10.1.179.0/24"]

fdr_storage_account = {
  account_kind                       = "StorageV2"
  account_tier                       = "Standard"
  account_replication_type           = "LRS"
  blob_versioning_enabled            = false
  advanced_threat_protection         = true
  advanced_threat_protection_enabled = false
  public_network_access_enabled      = true
  blob_delete_retention_days         = 90
  enable_low_availability_alert      = false
}

reporting_fdr_storage_account = {
  advanced_threat_protection         = true
  advanced_threat_protection_enabled = false
  blob_versioning_enabled            = false
  blob_delete_retention_days         = 30
  account_replication_type           = "LRS"
  public_network_access_enabled      = true
}

fdr_re_storage_account = {
  account_kind                                                 = "StorageV2"
  account_tier                                                 = "Standard"
  account_replication_type                                     = "LRS"
  blob_versioning_enabled                                      = false
  public_network_access_enabled                                = true
  blob_delete_retention_days                                   = 1
  enable_low_availability_alert                                = false
  storage_defender_enabled                                     = true
  storage_defender_override_subscription_settings_enabled      = false
  storage_defender_sensitive_data_discovery_enabled            = false
  storage_defender_malware_scanning_on_upload_enabled          = false
  storage_defender_malware_scanning_on_upload_cap_gb_per_month = -1
  blob_file_retention_days                                     = 14
}


#
# replica settings
#
geo_replica_enabled               = false
postgres_dns_registration_enabled = true
