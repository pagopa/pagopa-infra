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
gpd_paa_stazione_int     = "15376371009_06"

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

# APIM
apim_logger_resource_id = "/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/loggers/pagopa-u-apim-logger"

# gpd database config for gpd-app-service
pgbouncer_enabled = true

# WISP-dismantling-cfg
create_wisp_converter = true

### debezium zookeeper_yaml
zookeeper_replicas       = 3
zookeeper_request_memory = "512Mi"
zookeeper_request_cpu    = 0.5
zookeeper_limits_memory  = "1024Mi"
zookeeper_limits_cpu     = 1
zookeeper_jvm_xms        = "512m"
zookeeper_jvm_xmx        = "1024m"
zookeeper_storage_size   = "100Gi"

### debezium kafka_connect_yaml
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
