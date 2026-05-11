prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "selfcare"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "dev"


### External resources

monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"
apim_dns_zone_prefix     = "dev.platform"

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
selfcare_fe_enabled  = true
robots_indexed_paths = []

#this is the id of the user cstar pagopa
backoffice_external_for_rtp_sub_key_user = "63860f8ac257810fc0ed012c"
