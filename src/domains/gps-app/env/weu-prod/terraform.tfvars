prefix          = "pagopa"
env_short       = "p"
env             = "prod"
domain          = "gps"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "prod"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/gps"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"
apim_dns_zone_prefix     = "platform"

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "1.21.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.2.2@sha256:22f4b53177cc8891bf10cbd0deb39f60e1cd12877021c3048a01e7738f63e0f9"
}

# function_app docker
reporting_batch_image    = "pagopagpdreportingbatch"
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

reporting_function = true
reporting_functions_app_sku = {
  kind     = "Linux"
  sku_tier = "PremiumV3"
  sku_size = "P1v3"
}

cname_record_name = "config"

# APIM
apim_logger_resource_id = "/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/loggers/pagopa-p-apim-logger"

# gpd
gpd_plan_kind                = "Linux"
gpd_plan_sku_tier            = "PremiumV3"
gpd_plan_sku_size            = "P1v3"
gpd_always_on                = true
gpd_cron_job_enable          = true
gpd_cron_schedule_valid_to   = "0 */30 * * * *"
gpd_cron_schedule_expired_to = "0 */40 * * * *"
gpd_autoscale_minimum        = 1
gpd_autoscale_maximum        = 3
gpd_autoscale_default        = 1
# gpd database config for gpd-app-service
pgbouncer_enabled = true
