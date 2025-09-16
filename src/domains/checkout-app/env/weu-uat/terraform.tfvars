prefix          = "pagopa"
env_short       = "u"
env             = "uat"
domain          = "checkout"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "uat"


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

# Checkout

checkout_enabled = true

# ecommerce ingress hostname
ecommerce_ingress_hostname             = "weuuat.ecommerce.internal.uat.platform.pagopa.it"
checkout_ingress_hostname              = "weuuat.checkout.internal.uat.platform.pagopa.it"
checkout_ip_restriction_default_action = "Allow"

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "2.0.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.3.4@sha256:c3d45736706c981493b6216451fc65e99a69d5d64409ccb1c4ca93fef57c921d"
}

checkout_feature_flag_map = <<EOF
{ 
   "enableAuthIpWhiteList": "*", 
   "enablePspPickerPageIpWhiteList": "*"
}
EOF