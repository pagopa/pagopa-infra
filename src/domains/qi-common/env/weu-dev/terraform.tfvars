prefix             = "pagopa"
env_short          = "d"
env                = "dev"
domain             = "qi"
location           = "westeurope"
location_short     = "weu"
instance           = "dev"
location_alt       = "italynorth"
location_short_alt = "itn"


tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/qi-common"
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

enable_iac_pipeline = true

qi_storage_params = {
  enabled                       = true
  tier                          = "Standard"
  kind                          = "StorageV2"
  account_replication_type      = "LRS",
  advanced_threat_protection    = true,
  retention_days                = 7,
  public_network_access_enabled = true,
  access_tier                   = "Hot"
}

# SMO configuration 
cidr_subnet_pg_flex_smo_dbms = ["10.1.193.0/24"]

pgres_flex_smo_params = {
  private_endpoint_enabled = false
  sku_name                 = "GP_Standard_D4ds_v4"
  db_version               = "13"
  # Possible values are 32768, 65536, 131072, 262144, 524288, 1048576,
  # 2097152, 4194304, 8388608, 16777216, and 33554432.
  storage_mb                      = 32768
  zone                            = 1
  backup_retention_days           = 7
  geo_redundant_backup_enabled    = false
  create_mode                     = "Default"
  high_availability_enabled       = false
  standby_availability_zone       = 2
  pgbouncer_enabled               = true
  alerts_enabled                  = false
  max_connections                 = 1000
  enable_private_dns_registration = false
}
