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

external_domain      = "pagopa.it"
dns_zone_prefix      = "dev.platform"
apim_dns_zone_prefix = "dev.platform"
dns_zone_checkout    = "dev.checkout"

# Networking

cidr_subnet_checkout_be = ["10.1.133.0/24"]

# APIM

apim_logger_resource_id = "/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/loggers/pagopa-d-apim-logger"

#### pagopa-proxy

cidr_subnet_pagopa_proxy = ["10.1.132.0/24"]

pagopa_proxy_plan_sku = "S1"

# Checkout

checkout_enabled = true

# Checkout functions

checkout_function_kind                   = "Linux"
checkout_function_sku_tier               = "Standard"
checkout_function_sku_size               = "S1"
checkout_function_autoscale_minimum      = 1
checkout_function_autoscale_maximum      = 3
checkout_function_autoscale_default      = 1
checkout_function_zone_balancing_enabled = false

# ecommerce ingress hostname
ecommerce_ingress_hostname = "weudev.ecommerce.internal.dev.platform.pagopa.it"
