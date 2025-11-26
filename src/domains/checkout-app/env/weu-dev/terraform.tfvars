prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "checkout"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "dev"


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

# Checkout

checkout_enabled = true

# ecommerce ingress hostname
ecommerce_ingress_hostname             = "weudev.ecommerce.internal.dev.platform.pagopa.it"
checkout_ingress_hostname              = "weudev.checkout.internal.dev.platform.pagopa.it"
checkout_ip_restriction_default_action = "Allow"

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "2.0.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.3.4@sha256:c3d45736706c981493b6216451fc65e99a69d5d64409ccb1c4ca93fef57c921d"
}
