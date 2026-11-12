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
checkout_enabled               = true
checkout_apim_frontend_enabled = false

# ecommerce ingress hostname
ecommerce_ingress_hostname = "weudev.ecommerce.internal.dev.platform.pagopa.it"
checkout_ingress_hostname  = "weudev.checkout.internal.dev.platform.pagopa.it"
