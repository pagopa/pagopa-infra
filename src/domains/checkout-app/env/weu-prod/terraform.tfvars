prefix          = "pagopa"
env_short       = "p"
env             = "prod"
domain          = "checkout"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/checkout-app"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name = "pagopa-p-monitor-rg"

external_domain = "pagopa.it"
dns_zone_prefix = "platform"

### pagopa-proxy app service

cidr_subnet_pagopa_proxy = ["10.1.132.0/24"]

pagopa_proxy_tier = "PremiumV3"
pagopa_proxy_size = "P1v3"

# Checkout

checkout_enabled = true
