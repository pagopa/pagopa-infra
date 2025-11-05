prefix                           = "pagopa"
env_short                        = "p"
env                              = "prod"
domain                           = "qi"
location                         = "westeurope"
location_short                   = "weu"
location_itn                     = "italynorth"
location_short_itn               = "itn"
instance                         = "prod"
ehns_private_endpoint_is_present = true


### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

### Aks

ingress_load_balancer_ip = "10.1.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"

enable_iac_pipeline = true

qi_storage_params = {
  enabled                       = true
  tier                          = "Standard"
  kind                          = "StorageV2"
  account_replication_type      = "GZRS",
  advanced_threat_protection    = true,
  retention_days                = 7,
  public_network_access_enabled = true,
  access_tier                   = "Hot"
}

### EVH
cidr_subnet_qi_evh = ["10.3.3.0/27"]

ehns_auto_inflate_enabled     = true
ehns_maximum_throughput_units = 5
ehns_capacity                 = 5
ehns_alerts_enabled           = true
ehns_zone_redundant           = true

ehns_public_network_access = true
ehns_sku_name              = "Standard"

# evh to add to namespace
eventhubs_bdi = [
  {
    name              = "bdi-kpi-ingestion-dl"
    partitions        = 4
    message_retention = 7
    consumers         = ["bdi-kpi-ingestion-dl-evt-rx", "bdi-kpi-ingestion-dl-evt-rx-pdnd"]
    keys = [
      {
        name   = "bdi-kpi-ingestion-dl-evt-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "bdi-kpi-ingestion-dl-evt-rx"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "bdi-kpi-ingestion-dl-evt-rx-pdnd"
        listen = true
        send   = false
        manage = false
      }
    ]
  }
]

# alert evh
ehns_metric_alerts_qi = {
  # no_trx = {
  #   aggregation = "Total"
  #   metric_name = "IncomingMessages"
  #   description = "No transactions received from acquirer in the last 24h"
  #   operator    = "LessThanOrEqual"
  #   threshold   = 1000
  #   frequency   = "PT1H"
  #   window_size = "P1D"
  #   dimension = [
  #     {
  #       name     = "EntityName"
  #       operator = "Include"
  #       values   = ["bdi-kpi-ingestion-dl"]
  #     }
  #   ],
  # },
  # active_connections = {
  #   aggregation = "Average"
  #   metric_name = "ActiveConnections"
  #   description = null
  #   operator    = "LessThanOrEqual"
  #   threshold   = 0
  #   frequency   = "PT5M"
  #   window_size = "PT15M"
  #   dimension   = [],
  # },
  # error_trx = {
  #   aggregation = "Total"
  #   metric_name = "IncomingMessages"
  #   description = "Transactions rejected from one acquirer file received. trx write on eventhub. check immediately"
  #   operator    = "GreaterThan"
  #   threshold   = 0
  #   frequency   = "PT5M"
  #   window_size = "PT30M"
  #   dimension = [
  #     {
  #       name     = "EntityName"
  #       operator = "Include"
  #       values = ["bdi-kpi-ingestion-dl"]
  #     }
  #   ],
  # },
  # no_wallet_ingestion_alert_qi = {
  #   aggregation = "Total"
  #   metric_name = "IncomingMessages"
  #   description = "Payment wallet onboarding written events less than 1000 detected in the last 24h"
  #   operator    = "LessThanOrEqual"
  #   threshold   = 1000
  #   frequency   = "PT1H"
  #   window_size = "P1D"
  #   dimension = [
  #     {
  #       name     = "EntityName"
  #       operator = "Include"
  #       values = ["bdi-kpi-ingestion-dl"]
  #     }
  #   ],
  # },
}
