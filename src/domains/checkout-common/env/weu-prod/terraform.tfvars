prefix         = "pagopa"
env_short      = "p"
env            = "prod"
domain         = "checkout"
location       = "westeurope"
location_short = "weu"


### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

# DNS

external_domain          = "pagopa.it"
dns_zone_prefix          = "platform"
dns_zone_checkout        = "checkout"
dns_zone_internal_prefix = "internal.platform"

# Networking

cidr_subnet_pagopa_proxy_redis = ["10.1.131.0/24"]
ingress_load_balancer_ip       = "10.1.100.250"

# pagopa-proxy Redis

pagopa_proxy_redis_capacity = 0
pagopa_proxy_redis_sku_name = "Standard"
pagopa_proxy_redis_family   = "C"

redis_private_endpoint_enabled = true
redis_zones                    = [1, 2, 3]


# Checkout Redis parameters: Premium
redis_checkout_params = {
  capacity   = 1
  sku_name   = "Premium"
  family     = "P"
  version    = 6
  ha_enabled = true
  zones      = [1, 2, 3],
}

# Checkout Redis parameters: Standard
redis_checkout_params_std = {
  capacity   = 1
  sku_name   = "Standard"
  family     = "C"
  version    = 6
  ha_enabled = true
  zones      = [],
}
cidr_subnet_redis_checkout = ["10.1.167.0/24"]
