prefix             = "pagopa"
env_short          = "p"
env                = "prod"
domain             = "core"
location           = "italynorth"
location_short     = "itn"
location_ita       = "italynorth"
location_short_ita = "itn"


### Feature Flag
is_feature_enabled = {
  container_app_tools_cae = true,
}

#
# CIRDs
#
cidr_vnet_italy = ["10.3.0.0/16"]

cidr_aks_system      = ["10.3.1.0/24"] #see aks-leonardo
cidr_aks_user        = ["10.3.2.0/24"] #see aks-leonardo
cidr_eventhubs_italy = ["10.3.4.0/24"]


cidr_cosmosdb_wallet_italy         = ["10.3.8.0/24"]  #placeholder
cird_redis_wallet_italy            = ["10.3.9.0/24"]  #placeholder
cidr_storage_wallet_italy          = ["10.3.10.0/24"] #placeholder
cidr_subnet_pdf_engine_app_service = ["10.3.11.0/27"] #placeholder
cidr_common_private_endpoint_snet  = ["10.3.144.0/23"]

cird_printit_domain = ["10.3.12.0/24"] #placeholder for domain printit


cidr_subnet_tools_cae = ["10.3.252.0/23"]

#
# Dns
#
platform_dns_zone_prefix = "platform"
dns_zone_internal_prefix = "internal.platform"
external_domain          = "pagopa.it"
dns_default_ttl_sec      = 3600

### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

#
# Container registry ACR
#
container_registry_sku                     = "Premium"
container_registry_zone_redundancy_enabled = true

#
# Monitoring
#
law_sku                    = "PerGB2018"
law_retention_in_days      = 30
law_daily_quota_gb         = 10
law_internet_query_enabled = true

### DDOS
# networking
vnet_ita_ddos_protection_plan = {
  id     = "/subscriptions/0da48c97-355f-4050-a520-f11a18b8be90/resourceGroups/sec-p-ddos/providers/Microsoft.Network/ddosProtectionPlans/sec-p-ddos-protection"
  enable = true
}
