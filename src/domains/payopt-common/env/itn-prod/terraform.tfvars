prefix         = "pagopa"
env_short      = "p"
env            = "prod"
domain         = "payopt"
location       = "italynorth"
location_short = "itn"
instance       = "prod"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/paymentoptions-common"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### 🚩Features flags

is_feature_enabled = {
  eventhub = true
}

### CIRDs

cidr_paymentoptions_eventhub_italy = ["10.3.13.0/27"]

### External resources

monitor_italy_resource_group_name                 = "pagopa-p-itn-core-monitor-rg"
log_analytics_italy_workspace_name                = "pagopa-p-itn-core-law"
log_analytics_italy_workspace_resource_group_name = "pagopa-p-itn-core-monitor-rg"

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

### Aks

ingress_load_balancer_ip = "10.3.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"

#
# EventHub
#
ehns_sku_name = "Standard"

# to avoid https://docs.microsoft.com/it-it/azure/event-hubs/event-hubs-messaging-exceptions#error-code-50002
ehns_auto_inflate_enabled     = true
ehns_maximum_throughput_units = 5
ehns_capacity                 = 5
ehns_alerts_enabled           = false
ehns_zone_redundant           = true

ehns_public_network_access       = false
ehns_private_endpoint_is_present = true

# ehns_metric_alerts = {
#   no_trx = {
#     aggregation = "Total"
#     metric_name = "IncomingMessages"
#     description = "No transactions received from acquirer in the last 24h"
#     operator    = "LessThanOrEqual"
#     threshold   = 1000
#     frequency   = "PT1H"
#     window_size = "P1D"
#     dimension = [
#       {
#         name     = "EntityName"
#         operator = "Include"
#         values   = ["rtd-trx"]
#       }
#     ],
#   },
#   active_connections = {
#     aggregation = "Average"
#     metric_name = "ActiveConnections"
#     description = null
#     operator    = "LessThanOrEqual"
#     threshold   = 0
#     frequency   = "PT5M"
#     window_size = "PT15M"
#     dimension   = [],
#   },
#   error_trx = {
#     aggregation = "Total"
#     metric_name = "IncomingMessages"
#     description = "Transactions rejected from one acquirer file received. trx write on eventhub. check immediately"
#     operator    = "GreaterThan"
#     threshold   = 0
#     frequency   = "PT5M"
#     window_size = "PT30M"
#     dimension = [
#       {
#         name     = "EntityName"
#         operator = "Include"
#         values = [
#           "nodo-dei-pagamenti-log",
#           "nodo-dei-pagamenti-re"
#         ]
#       }
#     ],
#   },
# }

