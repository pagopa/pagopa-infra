prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "gps"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "dev"


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
  chart_version = "2.0.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.3.4@sha256:c3d45736706c981493b6216451fc65e99a69d5d64409ccb1c4ca93fef57c921d"
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

# WISP-dismantling-cfg
create_wisp_converter = true

### debezium zookeeper_yaml
zookeeper_replicas       = "1"
zookeeper_request_memory = "512Mi"
zookeeper_request_cpu    = "0.5"
zookeeper_limits_memory  = "512Mi"
zookeeper_limits_cpu     = "0.5"
zookeeper_jvm_xms        = "512m"
zookeeper_jvm_xmx        = "512m"
zookeeper_storage_size   = "100Gi"

### debezium kafka_connect_yaml
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
