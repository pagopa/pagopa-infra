prefix         = "pagopa"
env_short      = "p"
env            = "prod"
domain         = "crusc8"
location       = "italynorth"
location_short = "itn"
instance       = "prod"


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

## CIDR cruscotto per database pgsql
cidr_subnet_flex_dbms = ["10.3.7.0/27"]

pgres_flex_params = {
  idh_resource = "pgflex4" # https://github.com/pagopa/terraform-azurerm-v4/blob/44df8cdf0615a2d1c39efd05996edc4bf28e0dec/IDH/postgres_flexible_server/LIBRARY.md
  sku_name     = "GP_Standard_D4ds_v5"
  db_version   = "16"
  # Possible values are 32768, 65536, 131072, 262144, 524288, 1048576,
  # 2097152, 4194304, 8388608, 16777216, and 33554432.
  storage_mb                             = 1048576 # 1Tib
  zone                                   = 1
  backup_retention_days                  = 7
  geo_redundant_backup_enabled           = false
  create_mode                            = "Default"
  pgres_flex_private_endpoint_enabled    = true
  pgres_flex_ha_enabled                  = false
  pgres_flex_pgbouncer_enabled           = false
  standby_availability_zone              = 2
  pgres_flex_diagnostic_settings_enabled = false
  alerts_enabled                         = false
  max_connections                        = 1700
  pgbouncer_min_pool_size                = 1
  max_worker_process                     = 32
  wal_level                              = "logical"
  shared_preoload_libraries              = "pg_failover_slots"
  public_network_access_enabled          = false
}

pgres_flex_db_names = [
  "cruscotto",
  "cruscotto-replica"
]

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

# Storage Account Crusc8  Report 
crusc8_sa_report = {
  idh_resource_tier = "backup30"
}
