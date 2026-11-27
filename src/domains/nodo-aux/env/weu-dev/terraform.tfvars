prefix         = "pagopa"
env_short      = "d"
env            = "dev"
domain         = "nodo"
location       = "westeurope"
location_short = "weu"
instance       = "dev"

#
# ### External resources
#
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"

nodo_observability_enabled = true

ingress_haproxy_load_balancer_ip = "10.1.100.252"

dns_zone_internal_prefix = "internal.dev.platform"