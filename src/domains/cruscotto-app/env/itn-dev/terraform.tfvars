prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "crusc8"
location_string = "Italy North"

location_weu       = "westeurope"
location_short_weu = "weu"
instance           = "dev"


### External resources

monitor_italy_resource_group_name                 = "pagopa-d-itn-core-monitor-rg"
log_analytics_italy_workspace_name                = "pagopa-d-itn-core-law"
log_analytics_italy_workspace_resource_group_name = "pagopa-d-itn-core-monitor-rg"

monitor_resource_group_name = "pagopa-d-monitor-rg"
external_domain             = "pagopa.it"
dns_zone_internal_prefix    = "internal.dev.platform"
dns_zone_prefix             = "crusc8.itn"
apim_dns_zone_prefix        = "dev.platform"
### Aks

ingress_load_balancer_ip = "10.3.2.250"
