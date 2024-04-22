prefix         = "pagopa"
env_short      = "d"
env            = "dev"
domain         = "pay-wallet"
location       = "italynorth"
location_short = "itn"
instance       = "dev"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/pay-wallet-common"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"

ingress_load_balancer_ip = "10.3.2.250"

external_domain          = "pagopa.it"
dns_zone_prefix          = "dev.payment-wallet"
dns_zone_internal_prefix = "internal.dev.platform"