prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "mock"
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
lb_aks                                      = "10.70.66.200" # use http protocol + /nodo-<sit|uat|prod> + for SOAP services add /webservices/input

mock_ec_enabled                    = true
mock_ec_secondary_enabled          = true
mock_payment_gateway_enabled       = true
mock_psp_service_enabled           = true
mock_psp_secondary_service_enabled = true

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
mock_enabled = true

dns_zone_prefix = "dev.platform"
