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
platform_dns_zone_prefix = "uat.platform"
dns_zone_internal_prefix = "internal.uat.platform"
external_domain          = "pagopa.it"
dns_default_ttl_sec      = 3600

### External resources

monitor_resource_group_name                 = "pagopa-u-monitor-rg"
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"

# to avoid https://docs.microsoft.com/it-it/azure/event-hubs/event-hubs-messaging-exceptions#error-code-50002
ehns_auto_inflate_enabled        = true
ehns_maximum_throughput_units    = 5
ehns_capacity                    = 5
ehns_public_network_access       = true
ehns_private_endpoint_is_present = true
ehns_sku_name                    = "Standard"
ehns_metric_alerts_create        = false

ehns_metric_alerts = {
  no_trx = {
    aggregation = "Total"
    metric_name = "IncomingMessages"
    description = "No transactions received from acquirer in the last 24h"
    operator    = "LessThanOrEqual"
    threshold   = 1000
    frequency   = "PT1H"
    window_size = "P1D"
    dimension = [
      {
        name     = "EntityName"
        operator = "Include"
        values   = ["rtd-trx"]
      }
    ],
  },
  active_connections = {
    aggregation = "Average"
    metric_name = "ActiveConnections"
    description = null
    operator    = "LessThanOrEqual"
    threshold   = 0
    frequency   = "PT5M"
    window_size = "PT15M"
    dimension   = [],
  },
  error_trx = {
    aggregation = "Total"
    metric_name = "IncomingMessages"
    description = "Transactions rejected from one acquirer file received. trx write on eventhub. check immediately"
    operator    = "GreaterThan"
    threshold   = 0
    frequency   = "PT5M"
    window_size = "PT30M"
    dimension = [
      {
        name     = "EntityName"
        operator = "Include"
        values = [
          "nodo-dei-pagamenti-log",
          "nodo-dei-pagamenti-re"
        ]
      }
    ],
  },
}

#
# Container registry ACR
#
container_registry_sku                     = "Standard"
container_registry_zone_redundancy_enabled = false

#
# Monitoring
#
law_sku                    = "PerGB2018"
law_retention_in_days      = 30
law_daily_quota_gb         = 10
law_internet_query_enabled = true

ehns_zone_redundant = false
