prefix                                      = "pagopa"
env_short                                   = "p"
env                                         = "prod"
domain                                      = "apiconfig"
location                                    = "westeurope"
location_short                              = "weu"
location_string                             = "West Europe"
instance                                    = "prod"
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


# https://pagopa.atlassian.net/wiki/spaces/ACN/pages/525764770/API+Config+Ambienti+DB#On-Premise
# db_service_name = "NDPSPCP_PP_NODO4_CFG"
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
