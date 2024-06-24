prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "gps"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "dev"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/gps"
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

# function_app docker
reporting_batch_image    = "pagopa/pagopa-gpd-reporting-batch"
reporting_service_image  = "pagopagpdreportingservice"
reporting_analysis_image = "pagopagpdreportinganalysis"

# gpd-reporting-functions
gpd_paa_id_intermediario = "15376371009"
gpd_paa_stazione_int     = "15376371009_01"

reporting_batch_function_always_on    = true
reporting_service_function_always_on  = true
reporting_analysis_function_always_on = true

cidr_subnet_reporting_functions = ["10.1.177.0/24"]
cidr_subnet_gpd                 = ["10.1.138.0/24"]

reporting_function = false
reporting_functions_app_sku = {
  kind     = "Linux"
  sku_tier = "Basic"
  sku_size = "B1"
}

cname_record_name = "config"

# gpd database config for gpd-app-service
pgbouncer_enabled = false

# enable wisp dismantling
enable_wisp_converter = true
