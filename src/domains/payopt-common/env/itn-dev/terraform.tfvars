prefix         = "pagopa"
env_short      = "d"
env            = "dev"
domain         = "payopt"
location       = "italynorth"
location_short = "itn"
instance       = "dev"


### 🚩Features flags

is_feature_enabled = {
  eventhub = true
}

### CIRDs
monitor_italy_resource_group_name                 = "pagopa-d-itn-core-monitor-rg"
log_analytics_italy_workspace_name                = "pagopa-d-itn-core-law"
log_analytics_italy_workspace_resource_group_name = "pagopa-d-itn-core-monitor-rg"

monitor_resource_group_name = "pagopa-d-monitor-rg"
ingress_load_balancer_ip    = "10.3.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"

#
# EventHub
#
ehns_sku_name = "Standard"

# to avoid https://docs.microsoft.com/it-it/azure/event-hubs/event-hubs-messaging-exceptions#error-code-50002
ehns_auto_inflate_enabled        = false
ehns_maximum_throughput_units    = 5
ehns_capacity                    = 1
ehns_alerts_enabled              = false
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
