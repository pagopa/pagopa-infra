prefix          = "pagopa"
env_short       = "u"
env             = "uat"
domain          = "apiconfig"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "uat"


### External resources

monitor_resource_group_name                 = "pagopa-u-monitor-rg"
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"

external_domain                    = "pagopa.it"
dns_zone_internal_prefix           = "internal.uat.platform"
apim_dns_zone_prefix               = "uat.platform"
private_dns_zone_db_nodo_pagamenti = "u.db-nodo-pagamenti.com"
cidr_subnet_api_config             = ["10.230.9.128/29"]

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
api_config_fe_enabled = true
cname_record_name     = "config"
