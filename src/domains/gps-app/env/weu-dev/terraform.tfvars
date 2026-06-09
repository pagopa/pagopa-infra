prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "gps"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "dev"


## APIM
monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"
external_domain                             = "pagopa.it"
dns_zone_internal_prefix                    = "internal.dev.platform"
apim_dns_zone_prefix                        = "dev.platform"

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
reporting_analysis_function_always_on = true

cidr_subnet_reporting_functions = ["10.1.177.0/24"]
reporting_function              = false
reporting_functions_app_sku = {
  kind     = "Linux"
  sku_tier = "Basic"
  sku_size = "B1"
}

cname_record_name = "config"

# gpd database config for gpd-app-service
create_wisp_converter = true

### debezium zookeeper_yaml
replicas           = 1
request_cpu        = 0.5
limits_cpu         = 2
request_memory     = "512Mi"
limits_memory      = "1024Mi"
postgres_db_name   = "apd"
tasks_max          = "1"
container_registry = "pagopadcommonacr.azurecr.io"
max_threads        = 1
gpd_cdc_enabled    = true
