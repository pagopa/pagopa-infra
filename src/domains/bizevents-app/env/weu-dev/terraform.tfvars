prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "bizevents"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "dev"


### External resources

monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"
apim_dns_zone_prefix     = "dev.platform"

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "2.0.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.3.4@sha256:c3d45736706c981493b6216451fc65e99a69d5d64409ccb1c4ca93fef57c921d"
}

pdv_api_base_path = "https://api.uat.tokenizer.pdv.pagopa.it/tokenizer/v1"
