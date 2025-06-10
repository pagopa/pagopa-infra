prefix             = "pagopa"
env_short          = "d"
env                = "dev"
domain             = "observ"
location           = "westeurope" # weu
location_short     = "weu"        # weu
location_itn       = "italynorth" # itn
location_short_itn = "itn"        # itn
instance           = "dev"


### External resources

monitor_resource_group_name = "pagopa-d-monitor-rg"

# Data Explorer
dexp_params = {
  enabled = true
  sku = {
    name     = "Dev(No SLA)_Standard_E2a_v4"
    capacity = 1
  }
  autoscale = {
    enabled       = false
    min_instances = 2
    max_instances = 3
  }
  public_network_access_enabled = true
  double_encryption_enabled     = false
  disk_encryption_enabled       = true
  purge_enabled                 = false
}

dexp_db = {
  enable             = true
  hot_cache_period   = "P5D"
  soft_delete_period = "P30D" // P1M
}

dexp_re_db_linkes_service = {
  enable = true
}

app_forwarder_enabled = true

external_domain      = "pagopa.it"
apim_dns_zone_prefix = "dev.platform"

# observability Ingestion cfg
cidr_subnet_observability_storage = ["10.3.14.0/27"]
cidr_subnet_observability_evh     = ["10.3.14.32/27"]
cidr_subnet_observability_gpd_evh = ["10.3.14.64/27"]
# <free>= ["10.3.14.96/27"]
# <free>= ["10.3.14.128/27"]
# <free>= ["10.3.14.160/27"]


#
# EventHub
#
ehns_sku_name = "Standard"

# to avoid https://docs.microsoft.com/it-it/azure/event-hubs/event-hubs-messaging-exceptions#error-code-50002
ehns_auto_inflate_enabled     = false
ehns_maximum_throughput_units = 5
ehns_capacity                 = 1
ehns_alerts_enabled           = false
ehns_zone_redundant           = false

ehns_public_network_access       = true
ehns_private_endpoint_is_present = false

eventhubs = [
  {
    name              = "gec-ingestion-bundles-dl"
    partitions        = 1
    message_retention = 1
    consumers         = ["gec-ingestion-bundles-evt-rx", "gec-ingestion-bundles-evt-rx-pdnd"]
    keys = [
      {
        name   = "gec-ingestion-bundles-evt-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "gec-ingestion-bundles-evt-rx"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "gec-ingestion-bundles-evt-rx-pdnd"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "gec-ingestion-cibundles-dl"
    partitions        = 1
    message_retention = 1
    consumers         = ["gec-ingestion-cibundles-evt-rx", "gec-ingestion-cibundles-evt-rx-pdnd"]
    keys = [
      {
        name   = "gec-ingestion-cibundles-evt-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "gec-ingestion-cibundles-evt-rx"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "gec-ingestion-cibundles-evt-rx-pdnd"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "gec-ingestion-paymenttypes-dl"
    partitions        = 1
    message_retention = 1
    consumers         = ["gec-ingestion-paymenttypes-evt-rx", "gec-ingestion-paymenttypes-evt-rx-pdnd"]
    keys = [
      {
        name   = "gec-ingestion-paymenttypes-evt-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "gec-ingestion-paymenttypes-evt-rx"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "gec-ingestion-paymenttypes-evt-rx-pdnd"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "gec-ingestion-touchpoints-dl"
    partitions        = 1
    message_retention = 1
    consumers         = ["gec-ingestion-touchpoints-evt-rx", "gec-ingestion-touchpoints-evt-rx-pdnd"]
    keys = [
      {
        name   = "gec-ingestion-touchpoints-evt-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "gec-ingestion-touchpoints-evt-rx"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "gec-ingestion-touchpoints-evt-rx-pdnd"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "payment-wallet-ingestion-dl"
    partitions        = 1
    message_retention = 1
    consumers         = ["payment-wallet-evt-rx", "payment-wallet-evt-rx-pdnd"]
    keys = [
      {
        name   = "payment-wallet-evt-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "payment-wallet-evt-rx"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "payment-wallet-evt-rx-pdnd"
        listen = true
        send   = false
        manage = false
      }
    ]
  }
]

# alert evh
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
        values   = ["gec-ingestion-bundles-evt-tx", "gec-ingestion-cibundles-evt-tx", "gec-ingestion-paymenttypes-evt-tx", "gec-ingestion-touchpoints-evt-tx"]
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
          "gec-ingestion-bundles-evt-rx-pdnd",
          "gec-ingestion-cibundles-evt-rx-pdnd",
          "gec-ingestion-paymenttypes-evt-rx-pdnd",
          "gec-ingestion-touchpoints-evt-rx-pdnd"
        ]
      }
    ],
  },
}

eventhubs_gpd = [
  {
    name              = "gpd-ingestion.apd.payment_option"
    partitions        = 1
    message_retention = 1
    consumers         = ["gpd-ingestion.apd.payment_option-rx-dl", ]
    keys = [
      {
        name   = "gpd-ingestion.apd.payment_option-rx-dl"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "gpd-ingestion.apd.payment_option-tx"
        listen = false
        send   = true
        manage = false
      }
    ]
  },
  {
    name              = "gpd-ingestion.apd.payment_position"
    partitions        = 1
    message_retention = 1
    consumers         = ["gpd-ingestion.apd.payment_position-rx-dl", ]
    keys = [
      {
        name   = "gpd-ingestion.apd.payment_position-rx-dl"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "gpd-ingestion.apd.payment_position-tx"
        listen = false
        send   = true
        manage = false
      }
    ]
  },
  {
    name              = "gpd-ingestion.apd.transfer"
    partitions        = 1
    message_retention = 1
    consumers         = ["gpd-ingestion.apd.transfer-rx-dl", ]
    keys = [
      {
        name   = "gpd-ingestion.apd.transfer-rx-dl"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "gpd-ingestion.apd.transfer-tx"
        listen = false
        send   = true
        manage = false
      }
    ]
  },
]

app_forwarder_ip_restriction_default_action = "Allow"


# alert evh
# ehns_metric_alerts_gpd = {
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
#         values   = ["gec-ingestion-bundles-evt-tx", "gec-ingestion-cibundles-evt-tx", "gec-ingestion-paymenttypes-evt-tx", "gec-ingestion-touchpoints-evt-tx"]
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
#           "gec-ingestion-bundles-evt-rx-pdnd",
#           "gec-ingestion-cibundles-evt-rx-pdnd",
#           "gec-ingestion-paymenttypes-evt-rx-pdnd",
#           "gec-ingestion-touchpoints-evt-rx-pdnd"
#         ]
#       }
#     ],
#   },
# }
