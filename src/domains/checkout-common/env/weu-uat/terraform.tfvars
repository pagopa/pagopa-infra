prefix         = "pagopa"
env_short      = "u"
env            = "uat"
domain         = "checkout"
location       = "westeurope"
location_short = "weu"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/checkout-common"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "pagopa-u-monitor-rg"
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"

# DNS

external_domain   = "pagopa.it"
dns_zone_prefix   = "uat.platform"
dns_zone_checkout = "uat.checkout"

# Networking

cidr_subnet_pagopa_proxy_redis = ["10.1.131.0/24"]

# pagopa-proxy Redis

pagopa_proxy_redis_capacity = 0
pagopa_proxy_redis_sku_name = "Basic"
pagopa_proxy_redis_family   = "C"

redis_private_endpoint_enabled = true
redis_zones                    = []

