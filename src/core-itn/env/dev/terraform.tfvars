prefix             = "pagopa"
env_short          = "d"
env                = "dev"
domain             = "core"
location           = "italynorth"
location_short     = "itn"
location_ita       = "italynorth"
location_short_ita = "itn"
instance           = "dev"

tags = {
  CreatedBy   = "Terraform"
  Environment = "DEV"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### Feature Flag
is_feature_enabled = {
  vnet_ita                  = true,
  container_app_tools_cae   = true,
  node_forwarder_ha_enabled = true,
  vpn                       = true,
  dns_forwarder_lb          = true
  postgres_private_dns      = true
}

### Network Italy
cidr_vnet_italy = ["10.3.0.0/16"]

cidr_aks_system       = ["10.3.1.0/24"] #see aks-leonardo
cidr_aks_user         = ["10.3.2.0/24"] #see aks-leonardo
cidr_cosmosdb_italy   = ["10.3.3.0/24"]
cidr_eventhubs_italy  = ["10.3.4.0/24"]
cidr_storage_italy    = ["10.3.5.0/24"]
cird_redis_italy      = ["10.3.6.0/24"]
cird_postgresql_italy = ["10.3.7.0/24"]

cidr_cosmosdb_wallet_italy         = ["10.3.8.0/24"]  #placeholder
cird_redis_wallet_italy            = ["10.3.9.0/24"]  #placeholder
cidr_storage_wallet_italy          = ["10.3.10.0/24"] #placeholder
cidr_subnet_pdf_engine_app_service = ["10.3.11.0/24"] #placeholder


#
# Dns
#
external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"

### External resources

monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"

#
# Eventhub
#
ehns_auto_inflate_enabled        = false
ehns_maximum_throughput_units    = 1
ehns_capacity                    = 1
ehns_zone_redundant              = false
ehns_public_network_access       = true
ehns_private_endpoint_is_present = false
ehns_sku_name                    = "Standard"
ehns_metric_alerts_create        = false

ehns_metric_alerts = {
  no_trx = {
    aggregation = "Total"
    metric_name = "IncomingMessages"
    description = "No messagge received in the last 24h"
    operator    = "LessThanOrEqual"
    threshold   = 1000
    frequency   = "PT1H"
    window_size = "P1D"
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
    description = "rejected received. trx write on eventhub. check immediately"
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
container_registry_sku                     = "Basic"
container_registry_zone_redundancy_enabled = false



eventhubs_03 = [
  {
    name              = "pagopa-printit-evh"
    partitions        = 1
    message_retention = 1
    consumers = [
      "pagopa-d-itn-printit-notice-evt-rx",
      "pagopa-d-itn-printit-notice-complete-evt-t",
      "pagopa-d-itn-printit-notice-error-evt-tx"
    ]
    keys = [
      {
        name   = "pagopa-d-itn-printit-notice-evt-rx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pagopa-d-itn-printit-notice-complete-evt-t"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "pagopa-d-itn-printit-notice-error-evt-tx"
        listen = true
        send   = false
        manage = false
      },
    ]
  },
]
