prefix         = "pagopa"
env_short      = "u"
env            = "uat"
domain         = "aca"
location       = "westeurope"
location_short = "weu"
instance       = "uat"


### External resources

monitor_resource_group_name = "pagopa-u-monitor-rg"
ingress_load_balancer_ip    = "10.1.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.uat.platform"


enable_iac_pipeline = true
