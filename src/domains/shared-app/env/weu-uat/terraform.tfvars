prefix          = "pagopa"
env_short       = "u"
env             = "uat"
domain          = "shared"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "uat"


### External resources

monitor_resource_group_name                 = "pagopa-u-monitor-rg"
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.uat.platform"
apim_dns_zone_prefix     = "uat.platform"

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
taxonomy_function_subnet                   = ["10.1.183.0/24"]
taxonomy_function_network_policies_enabled = true
taxonomy_function = {
  always_on                    = true
  kind                         = "Linux"
  sku_size                     = "B1"
  maximum_elastic_worker_count = null
}
taxonomy_function_autoscale = {
  default = 1
  minimum = 1
  maximum = 3
}

# pdf-engine
cidr_subnet_pdf_engine_app_service   = ["10.1.187.0/24"]
app_service_pdf_engine_sku_name      = "P1v3"
app_service_pdf_engine_sku_name_java = "P1v3"

robots_indexed_paths = []

// wallet session token
io_backend_base_path = "https://api-app.io.pagopa.it"
pdv_api_base_path    = "https://api.uat.tokenizer.pdv.pagopa.it/tokenizer/v1"
