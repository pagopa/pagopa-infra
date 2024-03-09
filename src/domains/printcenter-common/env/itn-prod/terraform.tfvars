prefix         = "pagopa"
env_short      = "p"
env            = "prod"
domain         = "printcenter"
location       = "italynorth"
location_short = "itn"
instance       = "prod"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/printcenter-common"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

### Aks

ingress_load_balancer_ip = "10.1.100.250"

## DNS

dns_zone_prefix          = "printcenter"
dns_zone_platform        = "platform"
external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"
