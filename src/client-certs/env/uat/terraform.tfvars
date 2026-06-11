prefix         = "pagopa"
env_short      = "u"
env            = "uat"
domain         = "core"
location_short = "weu"

#
# CIRDs
#
# main vnet
# integration vnet
# https://www.davidc.net/sites/default/subnets/subnets.html?network=10.230.7.0&mask=24&division=7.31

#
# Dns
#
### External resources
#
# apim v2
#



# to avoid https://docs.microsoft.com/it-it/azure/event-hubs/event-hubs-messaging-exceptions#error-code-50002

# public app gateway
# app_gateway
#app_gateway_wfespgovit_certificate_name = "wfesp-test-pagopa-gov-it-stable" # Rimosso in quando non usato
#app_gateway_sku_name                    = "WAF_v2"
#app_gateway_sku_tier                    = "WAF_v2"
#app_gateway_waf_enabled                 = true
# monitoring
