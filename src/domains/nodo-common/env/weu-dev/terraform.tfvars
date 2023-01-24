prefix         = "pagopa"
env_short      = "d"
env            = "dev"
domain         = "nodo"
location       = "westeurope"
location_short = "weu"
instance       = "dev"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/nodo-common"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"

### Aks

ingress_load_balancer_ip = "10.1.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"

## CIDR nodo per database pgsql
cidr_subnet_flex_dbms = ["10.1.160.0/24"]

## CIDR storage subnet
cidr_subnet_storage_account = ["10.1.137.16/29"]

pgres_flex_params = {

  enabled    = true
  sku_name   = "B_Standard_B1ms"
  db_version = "13"
  # Possible values are 32768, 65536, 131072, 262144, 524288, 1048576,
  # 2097152, 4194304, 8388608, 16777216, and 33554432.
  storage_mb                   = 32768
  zone                         = 1
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  create_mode                  = "Default"

}

pgres_flex_private_endpoint_enabled    = false
pgres_flex_ha_enabled                  = false
pgres_flex_pgbouncher_enabled          = false
pgres_flex_diagnostic_settings_enabled = false


sftp_account_replication_type = "LRS"
sftp_enable_private_endpoint  = false
sftp_disable_network_rules    = true
