prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "checkout"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/checkout-app"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name = "pagopa-d-monitor-rg"

external_domain = "pagopa.it"
dns_zone_prefix = "dev.platform"

#### pagopa-proxy

cidr_subnet_pagopa_proxy = ["10.1.132.0/24"]

pagopa_proxy_tier = "Standard"
pagopa_proxy_size = "S1"

# Checkout

checkout_enabled = true
