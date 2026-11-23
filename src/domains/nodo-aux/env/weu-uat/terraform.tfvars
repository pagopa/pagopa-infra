prefix          = "pagopa"
env_short       = "u"
env             = "uat"
domain          = "nodo"
location        = "westeurope"
location_short  = "weu"
instance        = "uat"
#
#
# ### External resources
#
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"

nodo_observability_enabled = true

ingress_haproxy_load_balancer_ip = "10.1.100.252"

dns_zone_internal_prefix = "internal.dev.platform"