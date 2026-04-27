prefix         = "pagopa"
env_short      = "u"
env            = "uat"
domain         = "core"
location       = "italynorth"
location_short = "itn"

### Feature Flag
is_feature_enabled = {
  container_app_tools_cae = true,
}

#
# CIRDs
#
cidr_vnet_italy                   = ["10.3.0.0/16"]
cidr_vnet_italy_cstar_integration = ["10.4.0.0/16"]
cidr_eventhubs_italy              = ["10.3.4.0/24"]
cidr_common_private_endpoint_snet = ["10.3.144.0/23"]
cidr_subnet_tools_cae             = ["10.3.252.0/23"]

#
# Dns
#
platform_dns_zone_prefix = "uat.platform"
external_domain          = "pagopa.it"



# to avoid https://docs.microsoft.com/it-it/azure/event-hubs/event-hubs-messaging-exceptions#error-code-50002
container_registry_sku                     = "Standard"
container_registry_zone_redundancy_enabled = false

#
# Monitoring
#
law_sku                    = "PerGB2018"
law_retention_in_days      = 30
law_daily_quota_gb         = 10
law_internet_query_enabled = true
