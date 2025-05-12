prefix    = "pagopa"
env_short = "d"
env       = "dev"
domain    = "crusc8"

location        = "italynorth"
location_short  = "itn"
location_string = "Italy North"

location_weu        = "westeurope"
location_short_weu  = "weu"
location_string_weu = "West Europe"

instance = "dev"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/crusc8-app"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
  domain      = "crusc8"
}

### External resources

monitor_italy_resource_group_name                 = "pagopa-d-itn-core-monitor-rg"
log_analytics_italy_workspace_name                = "pagopa-d-itn-core-law"
log_analytics_italy_workspace_resource_group_name = "pagopa-d-itn-core-monitor-rg"

monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"
dns_zone_prefix          = "crusc8.itn"
apim_dns_zone_prefix     = "dev.platform"
### Aks

ingress_load_balancer_ip = "10.3.2.250"
