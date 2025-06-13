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
tls_cert_check_helm = {
  chart_version = "2.8.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.3.4@sha256:c3d45736706c981493b6216451fc65e99a69d5d64409ccb1c4ca93fef57c921d"
}


# API Config BE
apiconfig_logging_level = "DEBUG"

# Configuration
cidr_subnet_api_config = ["10.230.8.128/29"]
db_service_name        = "NDPSPCT_PP_NODO4_CFG"
db_port                = 1522

# API Config FE
api_config_fe_enabled = true
cname_record_name     = "config"
