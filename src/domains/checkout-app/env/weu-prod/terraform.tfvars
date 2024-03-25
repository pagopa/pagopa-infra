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

external_domain      = "pagopa.it"
dns_zone_prefix      = "platform"
apim_dns_zone_prefix = "platform"
dns_zone_checkout    = "checkout"

### pagopa-proxy app service

cidr_subnet_pagopa_proxy = ["10.1.132.0/24"]

pagopa_proxy_plan_sku = "P1v3"

# Networking

cidr_subnet_checkout_be = ["10.1.133.0/24"]

# APIM

apim_logger_resource_id = "/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/loggers/pagopa-p-apim-logger"

# Checkout

checkout_enabled = true

# Checkout functions

checkout_function_kind                   = "Linux"
checkout_function_sku_tier               = "PremiumV3"
checkout_function_sku_size               = "P1v3"
checkout_function_always_on              = true
checkout_function_autoscale_minimum      = 1
checkout_function_autoscale_maximum      = 3
checkout_function_autoscale_default      = 1
checkout_function_zone_balancing_enabled = false

# ecommerce ingress hostname
ecommerce_ingress_hostname = "weuprod.ecommerce.internal.platform.pagopa.it"


function_app_storage_account_info = {
  account_kind                      = "StorageV2"
  account_tier                      = "Standard"
  account_replication_type          = "GZRS"
  access_tier                       = "Hot"
  advanced_threat_protection_enable = true
}

checkout_cdn_storage_replication_type = "GZRS"
