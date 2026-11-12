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
checkout_enabled               = true
checkout_apim_frontend_enabled = false

# ecommerce ingress hostname
ecommerce_ingress_hostname = "weuuat.ecommerce.internal.uat.platform.pagopa.it"
checkout_ingress_hostname  = "weuuat.checkout.internal.uat.platform.pagopa.it"
