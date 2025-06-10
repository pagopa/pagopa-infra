prefix          = "pagopa"
env_short       = "u"
env             = "uat"
domain          = "crusc8"
location        = "italynorth"
location_short  = "itn"
location_string = "Italy North"

location_weu        = "westeurope"
location_short_weu  = "weu"
location_string_weu = "West Europe"

instance = "uat"


### External resources

monitor_italy_resource_group_name                 = "pagopa-u-itn-core-monitor-rg"
log_analytics_italy_workspace_name                = "pagopa-u-itn-core-law"
log_analytics_italy_workspace_resource_group_name = "pagopa-u-itn-core-monitor-rg"

monitor_resource_group_name                 = "pagopa-u-monitor-rg"
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.uat.platform"
dns_zone_prefix          = "crusc8.itn"
apim_dns_zone_prefix     = "uat.platform"
### Aks

ingress_load_balancer_ip = "10.3.2.250"
