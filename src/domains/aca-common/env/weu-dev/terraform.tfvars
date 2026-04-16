prefix         = "pagopa"
env_short      = "d"
env            = "dev"
domain         = "aca"
location       = "westeurope"
location_short = "weu"
instance       = "dev"


### External resources

monitor_resource_group_name = "pagopa-d-monitor-rg"
ingress_load_balancer_ip    = "10.1.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"

enable_iac_pipeline = true
