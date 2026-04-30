prefix         = "pagopa"
env_short      = "p"
env            = "prod"
domain         = "checkout"
location       = "westeurope"
location_short = "weu"


### External resources

monitor_resource_group_name = "pagopa-p-monitor-rg"
external_domain             = "pagopa.it"
dns_zone_internal_prefix    = "internal.platform"

# Networking

ingress_load_balancer_ip = "10.1.100.250"


# Checkout Redis parameters: Premium
redis_checkout_params_std = {
  capacity   = 1
  sku_name   = "Standard"
  family     = "C"
  version    = 6
  ha_enabled = true
  zones      = [],
}
cidr_subnet_redis_checkout = ["10.1.167.0/24"]
