prefix                                      = "pagopa"
env_short                                   = "p"
env                                         = "prod"
domain                                      = "selfcare"
location                                    = "westeurope"
location_short                              = "weu"
location_string                             = "West Europe"
instance                                    = "prod"
monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"
apim_dns_zone_prefix     = "platform"

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
selfcare_fe_enabled               = true
robots_indexed_paths              = []
selfcare_storage_replication_type = "GZRS"

pod_disruption_budgets = {
  "pagopaselfcaremsbackofficebackend" = {
    minAvailable = 1
    matchLabels = {
      "app.kubernetes.io/instance" = "pagopaselfcaremsbackofficebackend"
    }
  },
}

#this is the id of the user cstar api-gateway
backoffice_external_for_rtp_sub_key_user = "cstar-pagopa-it"
