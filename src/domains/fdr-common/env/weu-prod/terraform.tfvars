prefix         = "pagopa"
env_short      = "p"
env            = "prod"
domain         = "fdr"
location       = "westeurope"
location_short = "weu"
instance       = "prod"


### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"
application_insights_name                   = "pagopa-p-appinsights"

### Aks

ingress_load_balancer_ip = "10.1.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"

## CIDR fdr per database pgsql
cidr_subnet_flex_dbms = ["10.1.162.0/24"]

enable_iac_pipeline = true

pgres_flex_params = {

  sku_name   = "GP_Standard_D4ds_v4"
  db_version = "15"
  # Possible values are 32768, 65536, 131072, 262144, 524288, 1048576,
  # 2097152, 4194304, 8388608, 16777216, and 33554432.
  storage_mb                             = 1048576 # 1Tib
  zone                                   = 2
  standby_zone                           = 1
  backup_retention_days                  = 30
  geo_redundant_backup_enabled           = true
  create_mode                            = "Default"
  pgres_flex_private_endpoint_enabled    = true
  pgres_flex_ha_enabled                  = true
  pgres_flex_pgbouncer_enabled           = true
  standby_availability_zone              = 2
  pgres_flex_diagnostic_settings_enabled = false
  alerts_enabled                         = true
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
  capabilities = ["EnableMongo"] # Serverless accounts do not support multiple regions
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300 # must be greater then 300 (5min) when more then one geo_location is used
    max_staleness_prefix    = 100000
  }
  server_version                   = "4.0"
  main_geo_location_zone_redundant = true
  enable_free_tier                 = false

  additional_geo_locations = [{
    location          = "northeurope"
    failover_priority = 1
    zone_redundant    = false
  }]

  private_endpoint_enabled          = true
  public_network_access_enabled     = false
  is_virtual_network_filter_enabled = true

  backup_continuous_enabled = true

  container_default_ttl = 10368000 # 120 days

  enable_serverless  = false
  enable_autoscaling = true
  max_throughput     = 20000
  throughput         = 1000
}

# Storage Account
cidr_subnet_storage_account = ["10.1.179.0/24"]

fdr_storage_account = {
  account_kind                       = "StorageV2"
  account_tier                       = "Standard"
  account_replication_type           = "GZRS"
  blob_versioning_enabled            = true
  advanced_threat_protection         = true
  advanced_threat_protection_enabled = false
  public_network_access_enabled      = false
  blob_delete_retention_days         = 90
  enable_low_availability_alert      = true
  backup_enabled                     = false
  backup_retention                   = 0
}

fdr_re_storage_account = {
  account_kind                                                 = "StorageV2"
  account_tier                                                 = "Standard"
  account_replication_type                                     = "ZRS"
  blob_versioning_enabled                                      = false
  public_network_access_enabled                                = false
  blob_delete_retention_days                                   = 7
  enable_low_availability_alert                                = true
  backup_enabled                                               = false
  backup_retention                                             = 0
  storage_defender_enabled                                     = true
  storage_defender_override_subscription_settings_enabled      = false
  storage_defender_sensitive_data_discovery_enabled            = false
  storage_defender_malware_scanning_on_upload_enabled          = false
  storage_defender_malware_scanning_on_upload_cap_gb_per_month = -1
  blob_file_retention_days                                     = 180 # 6 months
}

fdr_flow_storage_account = {
  account_kind                       = "StorageV2"
  account_tier                       = "Standard"
  account_replication_type           = "GZRS"
  blob_versioning_enabled            = false
  advanced_threat_protection         = true
  advanced_threat_protection_enabled = false
  public_network_access_enabled      = false
  blob_delete_retention_days         = 90
  enable_low_availability_alert      = true
}

#
# replica settings
#
geo_replica_enabled                                = true
location_replica                                   = "northeurope"
location_replica_short                             = "neu"
geo_replica_cidr_subnet_postgresql                 = ["10.2.162.0/24"]
postgresql_sku_name                                = "GP_Gen5_2"
postgres_dns_registration_enabled                  = false
postgres_dns_registration_virtual_endpoint_enabled = true




reporting_fdr_storage_account = {
  advanced_threat_protection         = false
  advanced_threat_protection_enabled = false
  blob_versioning_enabled            = false
  blob_delete_retention_days         = 30
  account_replication_type           = "GZRS"
}
