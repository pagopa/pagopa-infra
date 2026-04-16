prefix         = "pagopa"
env_short      = "p"
env            = "prod"
domain         = "aca"
location       = "westeurope"
location_short = "weu"
instance       = "prod"


### External resources

monitor_resource_group_name = "pagopa-p-monitor-rg"
ingress_load_balancer_ip    = "10.1.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"


enable_iac_pipeline = true
