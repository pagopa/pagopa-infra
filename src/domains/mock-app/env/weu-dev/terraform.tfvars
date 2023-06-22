prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "mock"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "dev"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/src/domains/mock-app"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

## APIM
apim_logger_resource_id = "/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/loggers/pagopa-d-apim-logger"

### External resources
monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"
external_domain                             = "pagopa.it"
dns_zone_internal_prefix                    = "internal.dev.platform"
apim_dns_zone_prefix                        = "dev.platform"

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "1.21.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.2.2@sha256:22f4b53177cc8891bf10cbd0deb39f60e1cd12877021c3048a01e7738f63e0f9"
}
