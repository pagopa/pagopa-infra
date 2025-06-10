prefix                 = "pagopa"
env_short              = "p"
env                    = "prod"
domain                 = "apiconfig"
location               = "westeurope"
location_short         = "weu"
location_string        = "West Europe"
instance               = "prod"
gh_runner_job_location = "italynorth"

### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

external_domain                    = "pagopa.it"
dns_zone_internal_prefix           = "internal.platform"
apim_dns_zone_prefix               = "platform"
private_dns_zone_db_nodo_pagamenti = "p.db-nodo-pagamenti.com"
cidr_subnet_api_config             = ["10.230.10.128/29"]

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "2.8.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.3.4@sha256:c3d45736706c981493b6216451fc65e99a69d5d64409ccb1c4ca93fef57c921d"
}


# https://pagopa.atlassian.net/wiki/spaces/ACN/pages/525764770/API+Config+Ambienti+DB#On-Premise
# db_service_name = "NDPSPCP_PP_NODO4_CFG"
db_service_name = "NDPSPCP_NODO4_CFG"
db_port         = 1521

# API Config
xsd_ica         = "https://raw.githubusercontent.com/pagopa/pagopa-api/master/general/InformativaContoAccredito_1_2_1.xsd"
api_config_tier = "PremiumV3"
sku_name        = "P1v3"

# API Config FE
api_config_fe_enabled                = true
cname_record_name                    = "config"
cdn_storage_account_replication_type = "GZRS"

pod_disruption_budgets = {
  "apiconfig-selfcare-integration" = {
    minAvailable = 1
    matchLabels = {
      "app.kubernetes.io/instance" = "apiconfig-selfcare-integration"
    }
  },
  "pagopaapiconfig-oracle" = {
    minAvailable = 1
    matchLabels = {
      "app.kubernetes.io/instance" = "pagopaapiconfig"
    }
  },
  "status-app" = {
    minAvailable = 1
    matchLabels = {
      "app.kubernetes.io/instance" = "status-app"
    }
  },
}


# cache-oracle
# NOT USED FUTURE NEEDS

# cache-oracleprod
# NOT USED FUTURE NEEDS

# cache-postgresql
# NOT USED FUTURE NEEDS

# pagopaapiconfig-postgresql
# NOT USED FUTURE NEEDS
