prefix             = "pagopa"
env_short          = "d"
env                = "dev"
domain             = "core"
location           = "westeurope"
location_short     = "weu"
location_string    = "West Europe"
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
  postgres_private_dns = true
}

### Network
cidr_vnet_italy = ["10.3.0.0/16"]

cidr_subnet_tools_cae = ["10.1.248.0/23"]

#
# Dns
#
external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"

### External resources

monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"

### VPN
dns_forwarder_backup_is_enabled = false

#
# replica settings
#
geo_replica_enabled          = false


#
# apim v2
#
cidr_subnet_apim = ["10.230.8.160/27"]
apim_v2_zones    = ["1"]
apim_v2_subnet_nsg_security_rules = [
  {
    name                       = "inbound-management-3443"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "ApiManagement"
    destination_port_range     = "3443"
    destination_address_prefix = "VirtualNetwork"
  },
  {
    name                       = "inbound-management-6390"
    priority                   = 111
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_port_range     = "6390"
    destination_address_prefix = "VirtualNetwork"
  },
  {
    name                       = "inbound-load-balancer"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_port_range     = "*"
    destination_address_prefix = "VirtualNetwork"
  },
  {
    name                       = "outbound-storage-443"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_port_range     = "443"
    destination_address_prefix = "Storage"
  },
  {
    name                       = "outbound-sql-1433"
    priority                   = 210
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_port_range     = "1433"
    destination_address_prefix = "SQL"
  },
  {
    name                       = "outbound-kv-433"
    priority                   = 220
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_port_range     = "433"
    destination_address_prefix = "AzureKeyVault"
  }
]

apim_v2_publisher_name = "pagoPA Platform DEV"
apim_v2_sku            = "Developer_1"
apim_v2_alerts_enabled = false
dns_zone_prefix        = "dev.platform"

cidr_subnet_appgateway_integration = ["10.230.8.192/27"]
integration_appgateway_private_ip  = "10.230.8.200"
app_gateway_sku_name               = "Standard_v2"
app_gateway_sku_tier               = "Standard_v2"

app_gateway_api_certificate_name        = "api-dev-platform-pagopa-it"
app_gateway_portal_certificate_name     = "portal-dev-platform-pagopa-it"
app_gateway_management_certificate_name = "management-dev-platform-pagopa-it"
integration_appgateway_zones            = []

nodo_pagamenti_psp            = "06529501006,97249640588,06874351007,08301100015,00194450219,02113530345,01369030935,07783020725"
nodo_pagamenti_ec             = "00493410583,77777777777,00113430573,00184260040,00103110573,00939820726,00109190579,00122520570,82501690018,80001220773,84515520017,03509990788,84002410540,00482510542,00326070166,01350940019,00197530298,00379480031,06396970482,00460900038,82005250285,82002770236,80013960036,83000970018,84002970162,82500110158,00429530546,01199250158,80003370477,00111190575,81001650548,00096090550,95001650167,00451080063,80038190163,00433320033,00449050061,82002270724,00682280284,00448140541,00344700034,81000550673,00450150065,80002860775,83001970017,00121490577,00383120037,00366270031,80023530167,01504430016,00221940364,00224320366,00246880397,01315320489,00354730392,00357850395,80008270375,00218770394,00226010395,00202300398,81002910396,00360090393,84002010365,00242920395,80005570561,80015230347,00236340477,92035800488,03428581205,00114510571"
nodo_pagamenti_url            = "http://10.70.66.200/nodo-sit/webservices/input"
ip_nodo                       = "x.x.x.x"      # disabled 10.79.20.32/sit/webservices/input shall use lb_aks
lb_aks                        = "10.70.66.200" # use http protocol + /nodo-<sit|uat|prod> + for SOAP services add /webservices/input ( 👀 look above nodo_pagamenti_url )
schema_ip_nexi                = "http://10.70.66.200"
default_node_id               = "NDP002SIT"
base_path_nodo_ppt_lmi        = "/ppt-lmi-sit-NOT-FOUND"
base_path_nodo_sync           = "/sync-cron-sit/syncWisp"
base_path_nodo_wfesp          = "/wfesp-sit"
base_path_nodo_fatturazione   = "/fatturazione-sit"
base_path_nodo_web_bo         = "/web-bo-sit"
base_path_nodo_web_bo_history = "/web-bo-history-sit"
dns_zone_wisp2                = "dev.wisp2"
base_path_nodo_oncloud        = "/nodo-sit"



ehns_public_network_access = true
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

eventhubs_03 = [
  {
    name              = "nodo-dei-pagamenti-log"
    partitions        = 1 # in PROD shall be changed
    message_retention = 1 # in PROD shall be changed
    consumers         = ["logstash-pdnd", "logstash-oper", "logstash-tech"]
    keys = [
      {
        name   = "logstash-SIA"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "logstash-pdnd"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "logstash-oper"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "logstash-tech"
        listen = true
        send   = false
        manage = false
      }

    ]
  },
  {
    name              = "nodo-dei-pagamenti-re"
    partitions        = 1
    message_retention = 1
    consumers         = ["nodo-dei-pagamenti-pdnd", "nodo-dei-pagamenti-oper", "nodo-dei-pagamenti-sia-rx"] #, "nodo-dei-pagamenti-re-to-datastore-rx", "nodo-dei-pagamenti-re-to-tablestorage-rx"]
    keys = [
      {
        name   = "nodo-dei-pagamenti-SIA"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "nodo-dei-pagamenti-pdnd" # pdnd
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "nodo-dei-pagamenti-oper" # oper
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "nodo-dei-pagamenti-sia-rx" # oper
        listen = true
        send   = false
        manage = false
      },
      #     disabled because at the moment not used
      #      {
      #        name   = "nodo-dei-pagamenti-re-to-datastore-rx" # re->cosmos
      #        listen = true
      #        send   = false
      #        manage = false
      #      },
      #      {
      #        name   = "nodo-dei-pagamenti-re-to-tablestorage-rx" # re->table storage
      #        listen = true
      #        send   = false
      #        manage = false
      #      }
    ]
  },
  {
    name              = "fdr-re" # used by FdR Fase 1 and Fase 3
    partitions        = 1
    message_retention = 1
    consumers         = ["fdr-re-rx"]
    keys = [
      {
        name   = "fdr-re-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "fdr-re-rx"
        listen = true
        send   = false
        manage = false
      }

    ]
  },
  {
    name              = "nodo-dei-pagamenti-fdr" # used by Monitoring FdR
    partitions        = 1
    message_retention = 1
    consumers         = ["nodo-dei-pagamenti-pdnd", "nodo-dei-pagamenti-oper"]
    keys = [
      {
        name   = "nodo-dei-pagamenti-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "nodo-dei-pagamenti-pdnd" # pdnd
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "nodo-dei-pagamenti-oper" # oper
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "nodo-dei-pagamenti-biz-evt"
    partitions        = 1 # in PROD shall be changed
    message_retention = 1 # in PROD shall be changed
    consumers         = ["pagopa-biz-evt-rx", "pagopa-biz-evt-rx-test", "pagopa-biz-evt-rx-io", "pagopa-biz-evt-rx-pdnd"]
    keys = [
      {
        name   = "pagopa-biz-evt-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pagopa-biz-evt-rx"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "pagopa-biz-evt-rx-test"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "pagopa-biz-evt-rx-io"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "pagopa-biz-evt-rx-pdnd"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "nodo-dei-pagamenti-negative-biz-evt"
    partitions        = 1
    message_retention = 1
    consumers         = ["pagopa-negative-biz-evt-rx", "pagopa-negative-biz-evt-rx-test"]
    keys = [
      {
        name   = "pagopa-negative-biz-evt-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pagopa-negative-biz-evt-rx"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "pagopa-negative-biz-evt-rx-test"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "nodo-dei-pagamenti-biz-evt-enrich"
    partitions        = 1 # in PROD shall be changed
    message_retention = 1 # in PROD shall be changed
    consumers         = ["pagopa-biz-evt-rx", "pagopa-biz-evt-rx-pdnd", "pagopa-biz-evt-rx-pn"]
    keys = [
      {
        name   = "pagopa-biz-evt-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pagopa-biz-evt-rx"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "pagopa-biz-evt-rx-pdnd"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "pagopa-biz-evt-rx-pn"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "nodo-dei-pagamenti-verify-ko"
    partitions        = 32
    message_retention = 7
    consumers         = ["nodo-dei-pagamenti-verify-ko-to-datastore-rx", "nodo-dei-pagamenti-verify-ko-to-tablestorage-rx", "nodo-dei-pagamenti-verify-ko-test-rx"]
    keys = [
      {
        name   = "nodo-dei-pagamenti-verify-ko-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "nodo-dei-pagamenti-verify-ko-datastore-rx" # re->cosmos
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "nodo-dei-pagamenti-verify-ko-tablestorage-rx" # re->table storage
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "nodo-dei-pagamenti-verify-ko-test-rx" # re->anywhere for test
        listen = true
        send   = false
        manage = false
      }
    ]
  }
]

eventhubs_04 = [
  {
    name              = "nodo-dei-pagamenti-negative-awakable-biz-evt"
    partitions        = 32
    message_retention = 7
    consumers         = ["pagopa-biz-evt-rx", "pagopa-biz-evt-rx-pdnd"]
    keys = [
      {
        name   = "pagopa-biz-evt-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pagopa-biz-evt-rx"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "pagopa-biz-evt-rx-pdnd"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "nodo-dei-pagamenti-negative-final-biz-evt"
    partitions        = 32
    message_retention = 7
    consumers         = ["pagopa-biz-evt-rx", "pagopa-biz-evt-rx-pdnd"]
    keys = [
      {
        name   = "pagopa-biz-evt-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pagopa-biz-evt-rx"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "pagopa-biz-evt-rx-pdnd"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "quality-improvement-alerts"
    partitions        = 32
    message_retention = 7
    consumers         = ["pagopa-qi-alert-rx", "pagopa-qi-alert-rx-pdnd", "pagopa-qi-alert-rx-debug"]
    keys = [
      {
        name   = "pagopa-qi-alert-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pagopa-qi-alert-rx"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "pagopa-qi-alert-rx-pdnd"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "pagopa-qi-alert-rx-debug"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "quality-improvement-psp-kpi"
    partitions        = 1 # in PROD shall be changed
    message_retention = 1 # in PROD shall be changed
    consumers         = ["pagopa-qi-psp-kpi-rx", "pagopa-qi-psp-kpi-rx-pdnd"]
    keys = [
      {
        name   = "pagopa-qi-psp-kpi-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pagopa-qi-psp-kpi-rx"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "pagopa-qi-psp-kpi-rx-pdnd"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "nodo-dei-pagamenti-cache"
    partitions        = 1
    message_retention = 7
    consumers         = ["nodo-dei-pagamenti-cache-sync-rx"]
    keys = [
      {
        name   = "nodo-dei-pagamenti-cache-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "nodo-dei-pagamenti-cache-sync-rx" # node-cfg-sync
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "nodo-dei-pagamenti-stand-in"
    partitions        = 1
    message_retention = 7
    consumers         = ["nodo-dei-pagamenti-stand-in-sync-rx"]
    keys = [
      {
        name   = "nodo-dei-pagamenti-stand-in-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "nodo-dei-pagamenti-stand-in-sync-rx" # node-cfg-sync
        listen = true
        send   = false
        manage = false
      }
    ]
  }
]

node_forwarder_autoscale_enabled      = false
node_forwarder_zone_balancing_enabled = false
node_forwarder_sku                    = "B1"

