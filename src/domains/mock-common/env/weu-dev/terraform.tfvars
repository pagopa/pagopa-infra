prefix         = "pagopa"
env_short      = "d"
env            = "dev"
domain         = "mock"
location       = "westeurope"
location_short = "weu"
instance       = "dev"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/src/domains/mock-common"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources
monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"
application_insights_name                   = "pagopa-d-appinsights"

ingress_load_balancer_ip = "10.1.100.250"

cidr_subnet_mock_ec              = ["10.1.137.0/29"]
cidr_subnet_mock_payment_gateway = ["10.1.137.8/29"]
cidr_subnet_dbms                 = ["10.1.180.0/24"]
cidr_subnet_pgflex_dbms          = ["10.1.181.0/24"]

external_domain          = "pagopa.it"
dns_zone_prefix          = "dev.platform"
dns_zone_internal_prefix = "internal.dev.platform"

mock_ec_enabled                    = true
mock_ec_secondary_enabled          = true
mock_payment_gateway_enabled       = true
mock_psp_service_enabled           = true
mock_psp_secondary_service_enabled = true

postgresql_network_rules = {
  ip_rules = [
    "0.0.0.0/0"
  ]
  # dblink
  allow_access_to_azure_services = false
}

# Postgres Flexible
pgres_flex_params = {
  private_endpoint_enabled = false
  sku_name                 = "B_Standard_B1ms"
  db_version               = "13"
  # Possible values are 32768, 65536, 131072, 262144, 524288, 1048576,
  # 2097152, 4194304, 8388608, 16777216, and 33554432.
  storage_mb                   = 32768
  zone                         = 1
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  create_mode                  = "Default"
  high_availability_enabled    = false
  standby_availability_zone    = 2
  pgbouncer_enabled            = true
}

enable_iac_pipeline = false
