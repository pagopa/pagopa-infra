prefix             = "pagopa"
env_short          = "u"
env                = "uat"
domain             = "core"
location           = "italynorth"
location_short     = "itn"
location_ita       = "italynorth"
location_short_ita = "itn"
instance           = "uat"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### Feature Flag
is_feature_enabled = {
  vnet_ita                  = false,
  container_app_tools_cae   = true,
  node_forwarder_ha_enabled = false,
  vpn                       = false,
  dns_forwarder_lb          = true,
  postgres_private_dns      = true
}

#
# CIRDs
#
cidr_vnet_italy = ["10.3.0.0/16"]

cidr_aks_system       = ["10.3.1.0/24"] #see aks-leonardo
cidr_aks_user         = ["10.3.2.0/24"] #see aks-leonardo
cidr_cosmosdb_italy   = ["10.3.3.0/24"]
cidr_eventhubs_italy  = ["10.3.4.0/24"]
cidr_storage_italy    = ["10.3.5.0/24"]
cird_redis_italy      = ["10.3.6.0/24"]
cird_postgresql_italy = ["10.3.7.0/24"]

cidr_cosmosdb_wallet_italy   = ["10.3.8.0/24"] #placeholder
cird_redis_wallet_italy      = ["10.3.9.0/24"] #placeholder
cidr_storage_wallet_italy    = ["10.3.10.0/24"] #placeholder

#
# Dns
#
external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.uat.platform"
dns_zone_prefix          = "uat.platform"
dns_zone_prefix_prf      = "prf.platform"

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
