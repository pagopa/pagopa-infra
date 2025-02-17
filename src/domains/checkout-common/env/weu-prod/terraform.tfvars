prefix         = "pagopa"
env_short      = "p"
env            = "prod"
domain         = "checkout"
location       = "westeurope"
location_short = "weu"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/checkout-common"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

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
