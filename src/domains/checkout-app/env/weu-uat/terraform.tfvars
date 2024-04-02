prefix          = "pagopa"
env_short       = "u"
env             = "uat"
domain          = "checkout"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/checkout-app"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name = "pagopa-u-monitor-rg"

external_domain      = "pagopa.it"
dns_zone_prefix      = "uat.platform"
apim_dns_zone_prefix = "uat.platform"
dns_zone_checkout    = "uat.checkout"

# Networking

cidr_subnet_checkout_be = ["10.1.133.0/24"]

# APIM

apim_logger_resource_id = "/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/loggers/pagopa-u-apim-logger"

#### pagopa-proxy

cidr_subnet_pagopa_proxy    = ["10.1.132.0/24"]
cidr_subnet_pagopa_proxy_ha = ["10.1.194.0/28"]

pagopa_proxy_plan_sku             = "S1"
pagopa_proxy_zone_balance_enabled = false
pagopa_proxy_ha_enabled           = false
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
ecommerce_ingress_hostname = "weuuat.ecommerce.internal.uat.platform.pagopa.it"
