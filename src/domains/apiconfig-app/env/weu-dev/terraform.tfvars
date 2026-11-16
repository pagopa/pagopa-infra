prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "apiconfig"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "dev"


### External resources

monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"

external_domain                    = "pagopa.it"
dns_zone_internal_prefix           = "internal.dev.platform"
apim_dns_zone_prefix               = "dev.platform"
private_dns_zone_db_nodo_pagamenti = "d.db-nodo-pagamenti.com"
# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases


# API Config BE
cidr_subnet_api_config = ["10.230.8.128/29"]
api_config_fe_enabled  = true
cname_record_name      = "config"
