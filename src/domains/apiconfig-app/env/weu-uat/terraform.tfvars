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
tls_cert_check_helm = {
  chart_version = "2.8.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.3.4@sha256:c3d45736706c981493b6216451fc65e99a69d5d64409ccb1c4ca93fef57c921d"
}
db_service_name = "NDPSPCA_NODO4_CFG"
db_port         = 1524


# API Config
xsd_ica                 = "https://raw.githubusercontent.com/pagopa/pagopa-api/master/general/InformativaContoAccredito_1_2_1.xsd"
apiconfig_logging_level = "DEBUG"

# API Config FE
api_config_fe_enabled = true
cname_record_name     = "config"
