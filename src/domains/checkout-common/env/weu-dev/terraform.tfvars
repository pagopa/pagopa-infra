prefix         = "pagopa"
env_short      = "d"
env            = "dev"
domain         = "checkout"
location       = "westeurope"
location_short = "weu"


### External resources

monitor_resource_group_name = "pagopa-d-monitor-rg"
external_domain             = "pagopa.it"
dns_zone_internal_prefix    = "internal.dev.platform"

# Networking

ingress_load_balancer_ip = "10.1.100.250"


# IAC Policy
enable_iac_pipeline = true


# Checkout Redis
redis_checkout_params_std = {
  capacity   = 0
  sku_name   = "Basic"
  family     = "C"
  version    = 6
  ha_enabled = false
  zones      = []
}
cidr_subnet_redis_checkout = ["10.1.167.0/24"]
