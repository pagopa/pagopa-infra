prefix         = "pagopa"
env_short      = "d"
env            = "dev"
domain         = "mocker"
location       = "westeurope"
location_short = "weu"
instance       = "dev"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/mocker"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources
monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"
application_insights_name                   = "pagopa-d-appinsights"


ingress_load_balancer_ip = "10.1.100.250"
external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"

cidr_subnet_dbms = ["10.1.180.0/24"]

postgresql_network_rules = {
  ip_rules = [
    "0.0.0.0/0"
  ]
  # dblink
  allow_access_to_azure_services = false
}

enable_iac_pipeline = false
