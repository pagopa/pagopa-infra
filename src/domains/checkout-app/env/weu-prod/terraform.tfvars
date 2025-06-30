prefix          = "pagopa"
env_short       = "p"
env             = "prod"
domain          = "checkout"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "prod"


### External resources

monitor_resource_group_name = "pagopa-p-monitor-rg"

external_domain      = "pagopa.it"
dns_zone_prefix      = "platform"
apim_dns_zone_prefix = "platform"
dns_zone_checkout    = "checkout"

### pagopa-proxy app service

cidr_subnet_pagopa_proxy    = ["10.1.132.0/24"]
cidr_subnet_pagopa_proxy_ha = ["10.1.194.0/27"]

pagopa_proxy_plan_sku             = "P1v3"
pagopa_proxy_zone_balance_enabled = true
pagopa_proxy_ha_enabled           = false


# Networking

cidr_subnet_checkout_be = ["10.1.133.0/24"]

# APIM

apim_logger_resource_id = "/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/loggers/pagopa-p-apim-logger"

# Checkout

checkout_enabled = true

# ecommerce ingress hostname
ecommerce_ingress_hostname = "weuprod.ecommerce.internal.platform.pagopa.it"
checkout_ingress_hostname  = "weuprod.checkout.internal.platform.pagopa.it"

function_app_storage_account_info = {
  account_kind                      = "StorageV2"
  account_tier                      = "Standard"
  account_replication_type          = "GZRS"
  access_tier                       = "Hot"
  advanced_threat_protection_enable = true
}

checkout_cdn_storage_replication_type      = "GZRS"
checkout_ip_restriction_default_action     = "Deny"
pagopa_proxy_ip_restriction_default_action = "Deny"

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "2.0.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.3.4@sha256:c3d45736706c981493b6216451fc65e99a69d5d64409ccb1c4ca93fef57c921d"
}
