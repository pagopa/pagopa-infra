prefix         = "pagopa"
env_short      = "d"
env            = "dev"
domain         = "printcenter"
location       = "italynorth"
location_short = "itn"
instance       = "dev"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/printcenter-common"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"

### Aks

ingress_load_balancer_ip = "10.1.100.250"

## DNS

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"
dns_zone_prefix          = "printcenter"
dns_zone_platform        = "dev.platform"
