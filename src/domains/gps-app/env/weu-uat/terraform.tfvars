prefix          = "pagopa"
env_short       = "u"
env             = "uat"
domain          = "gps"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "uat"


### External resources
monitor_resource_group_name                 = "pagopa-u-monitor-rg"
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"
external_domain                             = "pagopa.it"
dns_zone_internal_prefix                    = "internal.uat.platform"
apim_dns_zone_prefix                        = "uat.platform"

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

# APIM
create_wisp_converter = true

###debezium zookeeper_yaml
replicas           = 1
request_cpu        = 0.5
limits_cpu         = 2
request_memory     = "512Mi"
limits_memory      = "3072Mi"
postgres_db_name   = "apd"
tasks_max          = "1"
container_registry = "pagopaucommonacr.azurecr.io"
max_threads        = 10
gpd_cdc_enabled    = true
