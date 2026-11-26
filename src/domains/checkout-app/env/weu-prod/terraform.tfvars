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

# Networking
checkout_enabled               = true
checkout_apim_frontend_enabled = false

# ecommerce ingress hostname
ecommerce_ingress_hostname            = "weuprod.ecommerce.internal.platform.pagopa.it"
checkout_ingress_hostname             = "weuprod.checkout.internal.platform.pagopa.it"
checkout_cdn_storage_replication_type = "GZRS"
