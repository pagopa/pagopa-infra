prefix             = "pagopa"
env_short          = "u"
env                = "uat"
domain             = "core"
location           = "westeurope"
location_short     = "weu"
location_string    = "West Europe"
location_ita       = "italynorth"
location_short_ita = "itn"
instance           = "uat"


### Feature Flag
is_feature_enabled = {
  vnet_ita                  = false,
  container_app_tools_cae   = true,
  node_forwarder_ha_enabled = false,
  vpn                       = false,
  dns_forwarder_lb          = true,
  postgres_private_dns      = true,
  apim_core_import          = true
  use_new_apim              = false
}

#
# CIRDs
#
# main vnet
cidr_vnet = ["10.1.0.0/16"]
# integration vnet
# https://www.davidc.net/sites/default/subnets/subnets.html?network=10.230.7.0&mask=24&division=7.31
cidr_vnet_integration = ["10.230.9.0/24"] # ask to SIA

cidr_vnet_italy                   = ["10.3.0.0/16"]
cidr_subnet_appgateway            = ["10.1.128.0/24"]
cidr_subnet_dns_forwarder_backup  = ["10.1.251.0/29"]
cidr_subnet_tools_cae             = ["10.1.248.0/23"]
cidr_subnet_azdoa                 = ["10.1.130.0/24"]
cidr_subnet_node_forwarder        = ["10.1.158.0/24"]
cidr_subnet_loadtest_agent        = ["10.1.159.0/24"]
cidr_subnet_eventhub              = ["10.230.9.64/26"]
cidr_common_private_endpoint_snet = ["10.1.144.0/23"]
cidr_subnet_dns_forwarder         = ["10.1.143.0/29"]
cidr_subnet_vpn                   = ["10.1.142.0/24"]

#
# Dns
#
external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.uat.platform"
dns_zone_prefix_prf      = "prf.platform"
dns_zone_wfesp           = "wfesp.test"

private_dns_zone_db_nodo_pagamenti   = "u.db-nodo-pagamenti.com"
dns_a_reconds_dbnodo_ips             = ["10.70.73.10"]    # db onCloud
dns_a_reconds_dbnodo_prf_ips         = ["10.70.73.20"]    # db onCloud prf
dns_a_reconds_dbnodonexipostgres_ips = ["10.222.214.174"] # db onPrem PostgreSQL

dns_a_reconds_dbnodonexipostgres_balancer_1_ips     = ["10.222.214.174"] # db onPrem UAT PostgreSQL
dns_a_reconds_dbnodonexipostgres_balancer_2_ips     = ["10.222.214.176"] # db onPrem UAT PostgreSQL
dns_a_reconds_dbnodonexipostgres_prf_ips            = ["10.6.52.93"]     # db onPrem PRF balancer PostgreSQL
dns_a_reconds_dbnodonexipostgres_prf_balancer_1_ips = ["10.222.214.127"] # db onPrem PRF PostgreSQL
dns_a_reconds_dbnodonexipostgres_prf_balancer_2_ips = ["10.222.214.128"] # db onPrem PRF PostgreSQL
### External resources

monitor_resource_group_name                 = "pagopa-u-monitor-rg"
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"

### VPN
dns_forwarder_vm_image_name = "pagopa-u-dns-forwarder-ubuntu2204-image-v4"

#
# replica settings
#
geo_replica_enabled = false

#
# apim v2
#
redis_cache_enabled = true
cidr_subnet_apim    = ["10.230.9.0/26"]
apim_v2_zones       = ["1"]
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

apim_v2_publisher_name = "pagoPA Platform UAT"
apim_v2_sku            = "Developer_1"
apim_v2_alerts_enabled = false
dns_zone_prefix        = "uat.platform"

cidr_subnet_appgateway_integration                  = ["10.230.9.192/27"]
integration_appgateway_private_ip                   = "10.230.9.200"
integration_app_gateway_sku_name                    = "Standard_v2"
integration_app_gateway_sku_tier                    = "Standard_v2"
integration_app_gateway_api_certificate_name        = "api-uat-platform-pagopa-it-stable"
integration_app_gateway_portal_certificate_name     = "portal-uat-platform-pagopa-it-stable"
integration_app_gateway_management_certificate_name = "management-uat-platform-pagopa-it-stable"
integration_appgateway_zones                        = []

nodo_pagamenti_psp                           = "06529501006,97249640588,08301100015,00194450219,02113530345,01369030935,07783020725,00304940980,03339200374,14070851002,06556440961"
nodo_pagamenti_ec                            = "00493410583,77777777777,00113430573,00184260040,00103110573,00939820726,00109190579,00122520570,82501690018,80001220773,84515520017,03509990788,84002410540,00482510542,00326070166,01350940019,00197530298,00379480031,06396970482,00460900038,82005250285,82002770236,80013960036,83000970018,84002970162,82500110158,00429530546,01199250158,80003370477,00111190575,81001650548,00096090550,95001650167,00451080063,80038190163,00433320033,00449050061,82002270724,00682280284,00448140541,00344700034,81000550673,00450150065,80002860775,83001970017,00121490577,00383120037,00366270031,80023530167,01504430016,00221940364,00224320366,00246880397,01315320489,00354730392,00357850395,80008270375,00218770394,00226010395,00202300398,81002910396,00360090393,84002010365,00242920395,80005570561,80015230347,00236340477,92035800488,03428581205,00114510571,97086740582,80029030568,87007530170,92000530532,80023370168,01349510436,10718570012,01032450072,01248040998,00608810057,80094780378,82002730487,80016430045,03299640163,94032590278,01928010683,91007750937,80052310580,97169170822,80043570482,80011170505,94050080038,01013130073,09227921005,94055970480,01429910183,01013210073,80031650486,83002410260,00337870406,92001600524,80007270376,02928200241,80082160013,01242340998,83000730297,01266290996,80012150274,02508710585,01142420056,02438750586"
lb_aks                                       = "10.70.74.200" # use http protocol + /nodo-<sit|uat|prod> + for SOAP services add /webservices/input
schema_ip_nexi                               = "https://10.79.20.63"
default_node_id                              = "NDP004UAT"
base_path_nodo_ppt_lmi                       = "/ppt-lmi-uat-NOT-FOUND"
base_path_nodo_sync                          = "/sync-cron-uat/syncWisp"
base_path_nodo_wfesp                         = "/wfesp-uat"
base_path_nodo_fatturazione                  = "/fatturazione-uat"
base_path_nodo_web_bo                        = "/web-bo-uat"
base_path_nodo_web_bo_history                = "/web-bo-history-uat"
dns_zone_wisp2                               = "uat.wisp2"
integration_app_gateway_prf_certificate_name = "api-prf-platform-pagopa-it-stable"
base_path_nodo_oncloud                       = "/nodo-uat"




# to avoid https://docs.microsoft.com/it-it/azure/event-hubs/event-hubs-messaging-exceptions#error-code-50002
ehns_auto_inflate_enabled     = true
ehns_maximum_throughput_units = 5
ehns_capacity                 = 5
ehns_public_network_access    = true

ehns03_metric_alerts = {
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

ehns04_metric_alerts = {
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
        values = [
          "fdr-qi-reported-iuv",
          "fdr-qi-flows"
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
}

ehns04_alerts_enabled = false

eventhubs_03 = [
  {
    name              = "nodo-dei-pagamenti-log"
    partitions        = 32
    message_retention = 7
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
    partitions        = 30
    message_retention = 7
    consumers         = ["nodo-dei-pagamenti-pdnd", "nodo-dei-pagamenti-oper"] #, "nodo-dei-pagamenti-re-to-datastore-rx", "nodo-dei-pagamenti-re-to-tablestorage-rx"]
    keys = [
      {
        name   = "nodo-dei-pagamenti-SIA"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "nodo-dei-pagamenti-PAGOPA"
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
    name              = "nodo-dei-pagamenti-fdr" # used by Monitoring FdR
    partitions        = 32
    message_retention = 7
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
    partitions        = 32
    message_retention = 7
    consumers         = ["pagopa-biz-evt-rx", "pagopa-biz-evt-rx-io", "pagopa-biz-evt-rx-pdnd", "pagopa-biz-evt-rx-views"]
    keys = [
      {
        name   = "pagopa-biz-evt-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pagopa-biz-evt-tx-PAGOPA"
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
      },
      {
        name   = "pagopa-biz-evt-rx-views"
        listen = true
        send   = false
        manage = false
      },
    ]
  },
  {
    name              = "nodo-dei-pagamenti-biz-evt-enrich"
    partitions        = 32
    message_retention = 7
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
    name              = "nodo-dei-pagamenti-negative-biz-evt"
    partitions        = 32
    message_retention = 7
    consumers         = ["pagopa-negative-biz-evt-rx"]
    keys = [
      {
        name   = "pagopa-negative-biz-evt-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pagopa-negative-biz-evt-tx-PAGOPA"
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
        name   = "nodo-dei-pagamenti-verify-ko-tx-PAGOPA"
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
    partitions        = 3
    message_retention = 1
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
    partitions        = 32
    message_retention = 7
    consumers         = ["nodo-dei-pagamenti-cache-sync-rx", "nodo-dei-pagamenti-cache-aca-rx", "nodo-dei-pagamenti-cache-stand-in-rx"]
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
      },
      {
        name   = "nodo-dei-pagamenti-cache-aca-rx" # node-cfg for ACA-Payments
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "nodo-dei-pagamenti-cache-stand-in-rx" # node-cfg for Stand-In Manager
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "nodo-dei-pagamenti-stand-in"
    partitions        = 32
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
  },
  {
    name              = "fdr-qi-reported-iuv"
    partitions        = 3
    message_retention = 1
    consumers         = ["fdr-qi-reported-iuv-rx", "gpd-reporting-sync"]
    keys = [
      {
        name   = "fdr-qi-reported-iuv-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "fdr-qi-reported-iuv-rx"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "gpd-reporting-sync"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "fdr-qi-flows"
    partitions        = 3
    message_retention = 1
    consumers         = ["fdr-qi-flows-rx"]
    keys = [
      {
        name   = "fdr-qi-flows-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "fdr-qi-flows-rx"
        listen = true
        send   = false
        manage = false
      }
    ]
  }
]

node_forwarder_logging_level          = "DEBUG"
node_forwarder_zone_balancing_enabled = false
node_forwarder_sku                    = "P1v3"
node_fw_ha_snet_cidr                  = ["10.1.157.0/24"]
node_fw_dbg_snet_cidr                 = ["10.1.195.0/24"]
azdo_agent_vm_image_name              = "pagopa-u-azdo-agent-ubuntu2204-image-v3"

# public app gateway
# app_gateway
app_gateway_api_certificate_name        = "api-uat-platform-pagopa-it-stable"
app_gateway_upload_certificate_name     = "upload-uat-platform-pagopa-it-stable"
upload_endpoint_enabled                 = true
app_gateway_prf_certificate_name        = "api-prf-platform-pagopa-it-stable"
app_gateway_portal_certificate_name     = "portal-uat-platform-pagopa-it-stable"
app_gateway_management_certificate_name = "management-uat-platform-pagopa-it-stable"
app_gateway_wisp2_certificate_name      = "uat-wisp2-pagopa-it-stable"
app_gateway_wisp2govit_certificate_name = "uat-wisp2-pagopa-gov-it"
#app_gateway_wfespgovit_certificate_name = "wfesp-test-pagopa-gov-it-stable" # Rimosso in quando non usato
#app_gateway_sku_name                    = "WAF_v2"
#app_gateway_sku_tier                    = "WAF_v2"
#app_gateway_waf_enabled                 = true
app_gateway_sku_name       = "Standard_v2"
app_gateway_sku_tier       = "Standard_v2"
app_gateway_waf_enabled    = false
app_gateway_alerts_enabled = false
app_gateway_deny_paths = [
  # "/nodo/.*", # TEMP currently leave UAT public for testing, we should add subkeys here as well ( ➕ 🔓 forbid policy api_product/nodo_pagamenti_api/_base_policy.xml)
  # "/nodo-auth/.*" # non serve in quanto queste API sono con subkey required 🔐
  "/payment-manager/clients/.*",
  "/payment-manager/pp-restapi-rtd/.*",
  "/payment-manager/db-logging/.*",
  "/payment-manager/payment-gateway/.*",
  "/payment-manager/internal/.*",
  #  "/payment-manager/pm-per-nodo/.*", # non serve in quanto queste API sono con subkey required 🔐 APIM-for-Node
  #  "/checkout/io-for-node/.*", # non serve in quanto queste API sono con subkey required 🔐 APIM-for-Node
  #  "/gpd-payments/.*", # non serve in quanto queste API sono con subkey required 🔐 APIM-for-Node
  "/tkm/internal/.*",
  "/payment-transactions-gateway/internal/.*",
  "/gps/donation-service/.*",             # internal use no sub-keys
  "/gps/spontaneous-payments-service/.*", # internal use no sub-keys
]
app_gateway_deny_paths_2 = [
  # "/nodo-pagamenti*", - used to test UAT nodo onCloud
  "/sync-cron/.*",
  "/wfesp/.*",
  "/fatturazione/.*",
  "/payment-manager/pp-restapi-server/.*",
  "/shared/authorizer/.*", # internal use no sub-keys
]
app_gateway_allowed_paths_pagopa_onprem_only = {
  paths = [
    "/web-bo/.*",
    "/bo-nodo/.*",
    "/pp-admin-panel/.*",
    "/tkm/tkmacquirermanager/.*",
    "/nodo-monitoring/monitoring/.*",
    "/nodo-ndp/monitoring/.*",
    "/nodo-replica-ndp/monitoring/.*",
    "/wfesp-ndp/.*",
    "/wfesp-replica-ndp/.*",
    "/web-bo-ndp/.*",
  ]
  ips = [
    "93.63.219.230",  # PagoPA on prem VPN
    "93.63.219.234",  # PagoPA on prem VPN DR
    "20.93.160.60",   # CSTAR
    "127.0.0.1",      # Softlab L1 Pagamenti VPN DISMESSO
    "127.0.0.1",      # Softlab L1 Pagamenti VPN DSIMESSO
    "127.0.0.1",      # Softlab L1 Pagamenti VPN DISMESSO
    "127.0.0.1",      # Softlab L1 Pagamenti VPN DISMESSO
    "127.0.0.1",      # Softlab L1 Pagamenti VPN DISMESSO
    "193.203.229.20", # VPN NEXI
    "193.203.230.22", # VPN NEXI
    "193.203.230.21", # VPN NEXI
    "2.33.87.3"       # Nuovo senzanome
  ]
}


redis_cache_params = {
  public_access = false
  capacity      = 0
  sku_name      = "Basic"
  family        = "C"
}

apicfg_core_service_path_value           = "pagopa-api-config-core-service/p"
apicfg_selfcare_integ_service_path_value = "pagopa-api-config-selfcare-integration/p"
# monitoring
law_sku               = "PerGB2018"
law_retention_in_days = 30
law_daily_quota_gb    = 50



monitor_env_test_urls = [
  # api.prf.platform.pagopa.it
  {
    host = "api.prf.platform.pagopa.it"
    path = "",
  },
  # uat.wisp2.pagopa.gov.it
  {
    host = "uat.wisp2.pagopa.gov.it",
    path = "",
  }
]

app_gateway_allowed_paths_upload = [
  "/upload/gpd/.*",
  "/nodo-auth/node-for-psp/.*",
  "/nodo-auth/nodo-per-psp/.*",
  "/nodo/nodo-per-psp/.*",
  "/nodo/nodo-per-pa/.*",
  "/nodo-auth/nodo-per-pa/.*",
  "/nodo-auth/node-for-pa/.*",
  "/nodo/node-for-psp/.*", # "/fdr-legacy/nodo-per-pa/.* and "/fdr-legacy/nodo-per-psp/.*"
  "/fdr-psp/.*"            # ⚠️⚠️⚠️ Added temporarily as workaround for bug https://pagopa.atlassian.net/browse/PAGOPA-2263
]


route_tools = [
  {
    # dev aks nodo oncloud
    name                   = "tools-outbound-to-nexy-nodo"
    address_prefix         = "10.70.74.200/32"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.9.150"
  }
]

eventhubs_prf = [
  {
    name              = "nodo-dei-pagamenti-log"
    partitions        = 32
    message_retention = 3
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
    partitions        = 30
    message_retention = 3
    consumers         = ["nodo-dei-pagamenti-pdnd", "nodo-dei-pagamenti-oper"] #, "nodo-dei-pagamenti-re-to-datastore-rx", "nodo-dei-pagamenti-re-to-tablestorage-rx"]
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
    name              = "nodo-dei-pagamenti-fdr" # used by Monitoring FdR
    partitions        = 32
    message_retention = 3
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
    partitions        = 32
    message_retention = 3
    consumers         = ["pagopa-biz-evt-rx", "pagopa-biz-evt-rx-io", "pagopa-biz-evt-rx-pdnd"]
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
    name              = "nodo-dei-pagamenti-biz-evt-enrich"
    partitions        = 32
    message_retention = 3
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
    name              = "nodo-dei-pagamenti-negative-biz-evt"
    partitions        = 32
    message_retention = 3
    consumers         = ["pagopa-negative-biz-evt-rx"]
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
    ]
  },
  {
    name              = "nodo-dei-pagamenti-verify-ko"
    partitions        = 32
    message_retention = 3
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
