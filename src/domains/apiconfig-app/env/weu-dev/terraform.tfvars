prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "apiconfig"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "dev"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPa"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/apiconfig"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

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
  image_tag     = "v1.3.4"
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
