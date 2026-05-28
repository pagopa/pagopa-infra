prefix          = "pagopa"
env_short       = "p"
env             = "prod"
domain          = "qi"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "prod"

gh_runner_job_location = "italynorth"


### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"
apim_dns_zone_prefix     = "platform"

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
dexp_re_db_linkes_service = {
  enable = true
}
