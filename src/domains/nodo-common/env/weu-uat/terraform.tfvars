prefix         = "pagopa"
env_short      = "u"
env            = "uat"
domain         = "nodo"
location       = "westeurope"
location_short = "weu"
instance       = "uat"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/nodo-common"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "pagopa-u-monitor-rg"
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"

### Aks

ingress_load_balancer_ip = "10.1.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.uat.platform"

## CIDR nodo per database pgsql
cidr_subnet_flex_dbms = ["10.1.160.0/24"]

## CIDR storage subnet
cidr_subnet_storage_account = ["10.1.137.16/29"]


pgres_flex_params = {

  enabled    = true
  sku_name   = "GP_Standard_D4ds_v4"
  db_version = "13"
  # Possible values are 32768, 65536, 131072, 262144, 524288, 1048576,
  # 2097152, 4194304, 8388608, 16777216, and 33554432.
  storage_mb                             = 1048576
  zone                                   = 1
  standby_ha_zone                        = 2
  backup_retention_days                  = 7
  geo_redundant_backup_enabled           = false
  create_mode                            = "Default"
  pgres_flex_private_endpoint_enabled    = true
  pgres_flex_ha_enabled                  = false
  pgres_flex_pgbouncer_enabled           = true
  pgres_flex_diagnostic_settings_enabled = false
  max_connections                        = 5000
  enable_private_dns_registration        = true
}

sftp_account_replication_type = "LRS"
sftp_enable_private_endpoint  = true
sftp_ip_rules                 = [] # List of public IP or IP ranges in CIDR Format allowed to access the storage account. Only IPV4 addresses are allowed

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
    threshold        = 4500
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

cosmos_nosql_db_params = {
  enabled      = true
  kind         = "GlobalDocumentDB"
  capabilities = ["EnableServerless"]
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "Strong"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  server_version                    = "4.0"
  main_geo_location_zone_redundant  = false
  enable_free_tier                  = false
  additional_geo_locations          = []
  private_endpoint_enabled          = true
  public_network_access_enabled     = false
  is_virtual_network_filter_enabled = true

  backup_continuous_enabled = false

  events_ttl     = 2629800 # 1 month in second
  max_throughput = 1000
}

verifyko_cosmos_nosql_db_params = {
  enabled      = true
  kind         = "GlobalDocumentDB"
  capabilities = ["EnableServerless"]
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "Strong"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  server_version                    = "4.0"
  main_geo_location_zone_redundant  = false
  enable_free_tier                  = false
  additional_geo_locations          = []
  private_endpoint_enabled          = true
  public_network_access_enabled     = false
  is_virtual_network_filter_enabled = true

  backup_continuous_enabled = false

  events_ttl     = 2629800 # 1 month in second
  max_throughput = 1000
}

standin_cosmos_nosql_db_params = {
  enabled      = true
  kind         = "GlobalDocumentDB"
  capabilities = ["EnableServerless"]
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "Strong"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  server_version                    = "4.0"
  main_geo_location_zone_redundant  = false
  enable_free_tier                  = false
  additional_geo_locations          = []
  private_endpoint_enabled          = true
  public_network_access_enabled     = false
  is_virtual_network_filter_enabled = true

  backup_continuous_enabled = false

  events_ttl     = 2629800 # 1 month in second
  max_throughput = 1000
}

cidr_subnet_cosmosdb_nodo_re       = ["10.1.170.0/24"]
cidr_subnet_cosmosdb_nodo_verifyko = ["10.1.173.0/24"]
cidr_subnet_cosmosdb_standin       = ["10.1.190.0/24"]

nodo_storico_allowed_ips = ["93.63.219.230"]

nodo_re_storage_account = {
  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  blob_versioning_enabled       = false
  advanced_threat_protection    = false
  blob_delete_retention_days    = 0
  public_network_access_enabled = true
  backup_enabled                = false

}

nodo_storico_storage_account = {
  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  blob_versioning_enabled       = false
  advanced_threat_protection    = true
  public_network_access_enabled = true
  backup_enabled                = false
  blob_delete_retention_days    = 0
}

nodo_verifyko_storage_account = {
  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  blob_versioning_enabled       = false
  advanced_threat_protection    = false
  blob_delete_retention_days    = 90
  public_network_access_enabled = true
}
