prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "shared"
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
  chart_version = "1.21.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.2.2@sha256:22f4b53177cc8891bf10cbd0deb39f60e1cd12877021c3048a01e7738f63e0f9"
}

cidr_subnet_authorizer_functions = "10.1.167.0/24"

authorizer_function_always_on = true

authorizer_functions_app_sku = {
  kind     = "Linux"
  sku_tier = "Basic"
  sku_size = "B1"
}

authorizer_functions_autoscale = {
  default = 1
  minimum = 1
  maximum = 3
}


# taxonomy
taxonomy_function_subnet                   = ["10.1.183.0/24"]
taxonomy_function_network_policies_enabled = false
taxonomy_function = {
  always_on                    = true
  kind                         = "Linux"
  sku_size                     = "B1"
  maximum_elastic_worker_count = null
}
taxonomy_function_autoscale = {
  default = 1
  minimum = 1
  maximum = 1
}

# pdf-engine
cidr_subnet_pdf_engine_app_service = ["10.1.187.0/24"]

robots_indexed_paths = []

// wallet session token
io_backend_base_path = "http://{{aks-lb-nexi}}/pmmockservice/pmmockserviceapi"
pdv_api_base_path    = "https://api.uat.tokenizer.pdv.pagopa.it/tokenizer/v1"
