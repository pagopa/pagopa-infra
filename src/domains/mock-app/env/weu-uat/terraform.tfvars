prefix          = "pagopa"
env_short       = "u"
env             = "uat"
domain          = "mock"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "uat"


## APIM
monitor_resource_group_name                 = "pagopa-u-monitor-rg"
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"
external_domain                             = "pagopa.it"
dns_zone_internal_prefix                    = "internal.uat.platform"
lb_aks                                      = "10.70.74.200" # use http protocol + /nodo-<sit|uat|prod> + for SOAP services add /webservices/input


mock_ec_enabled                    = true
mock_ec_secondary_enabled          = true
mock_payment_gateway_enabled       = true
mock_psp_secondary_service_enabled = true

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
mock_enabled    = false
dns_zone_prefix = "uat.platform"
