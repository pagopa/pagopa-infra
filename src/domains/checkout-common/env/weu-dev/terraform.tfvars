prefix         = "pagopa"
env_short      = "d"
env            = "dev"
domain         = "checkout"
location       = "westeurope"
location_short = "weu"


### External resources

monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"

# DNS

external_domain          = "pagopa.it"
dns_zone_prefix          = "dev.platform"
dns_zone_checkout        = "dev.checkout"
dns_zone_internal_prefix = "internal.dev.platform"

# Networking

ingress_load_balancer_ip = "10.1.100.250"


# IAC Policy
enable_iac_pipeline = true


# Checkout Redis
redis_checkout_params = {
  capacity   = 0
  sku_name   = "Basic"
  family     = "C"
  version    = 6
  ha_enabled = false
  zones      = []
}

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
