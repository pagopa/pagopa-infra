prefix         = "pagopa"
env_short      = "u"
env            = "uat"
domain         = "checkout"
location       = "westeurope"
location_short = "weu"


### External resources

monitor_resource_group_name                 = "pagopa-u-monitor-rg"
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"

# DNS

external_domain          = "pagopa.it"
dns_zone_prefix          = "uat.platform"
dns_zone_checkout        = "uat.checkout"
dns_zone_internal_prefix = "internal.uat.platform"

# Networking

cidr_subnet_pagopa_proxy_redis = ["10.1.131.0/24"]
ingress_load_balancer_ip       = "10.1.100.250"

# pagopa-proxy Redis

pagopa_proxy_redis_capacity = 0
pagopa_proxy_redis_sku_name = "Basic"
pagopa_proxy_redis_family   = "C"

redis_private_endpoint_enabled = true
redis_zones                    = []

# Checkout Redis
redis_checkout_params = {
  capacity   = 0
  sku_name   = "Basic"
  family     = "C"
  version    = 6
  ha_enabled = false
  zones      = []
}
cidr_subnet_redis_checkout = ["10.1.167.0/24"]
