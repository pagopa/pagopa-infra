prefix             = "pagopa"
env_short          = "p"
env                = "prod"
domain             = "core"
location           = "westeurope"
location_short     = "weu"
location_string    = "West Europe"
location_ita       = "italynorth"
location_short_ita = "itn"
instance           = "prod"


### Feature Flag
is_feature_enabled = {
  vnet_ita                  = false,
  container_app_tools_cae   = true,
  node_forwarder_ha_enabled = true,
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
cidr_vnet_integration = ["10.230.10.0/24"] # ask to SIA

cidr_vnet_italy                   = ["10.3.0.0/16"]
cidr_subnet_appgateway            = ["10.1.128.0/24"]
cidr_subnet_dns_forwarder_backup  = ["10.1.251.0/29"]
cidr_subnet_tools_cae             = ["10.1.248.0/23"]
cidr_subnet_azdoa                 = ["10.1.130.0/24"]
cidr_subnet_eventhub              = ["10.230.10.64/26"]
cidr_common_private_endpoint_snet = ["10.1.144.0/23"]
cidr_subnet_dns_forwarder         = ["10.1.143.0/29"]
cidr_subnet_vpn                   = ["10.1.142.0/24"]

# networking
ddos_protection_plan = {
  id     = "/subscriptions/0da48c97-355f-4050-a520-f11a18b8be90/resourceGroups/sec-p-ddos/providers/Microsoft.Network/ddosProtectionPlans/sec-p-ddos-protection"
  enable = true
}

route_table_peering_sia_additional_routes = [
]

#
# Dns
#
external_domain                                 = "pagopa.it"
dns_zone_internal_prefix                        = "internal.platform"
dns_zone_wfesp                                  = "wfesp"
private_dns_zone_db_nodo_pagamenti              = "p.db-nodo-pagamenti.com"
dns_a_reconds_dbnodo_ips                        = ["10.102.175.23", "10.102.175.24"] # scan: "10.102.35.61", "10.102.35.62", "10.102.35.63", vip: "10.102.35.60", "10.102.35.59",
dns_a_reconds_dbnodo_ips_dr                     = ["10.101.175.23", "10.101.175.24"] # authdbsep01-vip.carte.local   NAT 10.250.45.145 authdbsep02-vip.carte.local   NAT 10.250.45.146 authdbpep01-vip.carte.local   NAT 10.250.45.147 authdbpep02-vip.carte.local   NAT 10.250.45.148
dns_a_reconds_dbnodonexipostgres_ips            = ["10.102.1.93"]
dns_a_reconds_dbnodonexipostgres_balancer_1_ips = ["10.222.214.129"] # db onPrem PostgreSQL
dns_a_reconds_dbnodonexipostgres_balancer_2_ips = ["10.222.214.134"] # db onPrem PostgreSQL

### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

### VPN
dns_forwarder_vm_image_name = "pagopa-p-dns-forwarder-ubuntu2204-image-v1"


#
# replica settings
#
geo_replica_enabled        = true
geo_replica_location       = "northeurope"
geo_replica_location_short = "neu"
geo_replica_cidr_vnet      = ["10.2.0.0/16"]
geo_replica_ddos_protection_plan = {
  id     = "/subscriptions/0da48c97-355f-4050-a520-f11a18b8be90/resourceGroups/sec-p-ddos/providers/Microsoft.Network/ddosProtectionPlans/sec-p-ddos-protection"
  enable = true
}

postgres_private_dns_enabled = true

enable_logos_backup                              = true
logos_backup_retention                           = 30
logos_donations_storage_account_replication_type = "GZRS"

# nat gateway
nat_gateway_public_ips = 2

#
# apim v2
#
cidr_subnet_apim = ["10.230.10.0/26"]
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
apim_v2_sku            = "Premium_3"
apim_v2_alerts_enabled = true
dns_zone_prefix        = "platform"
apim_v2_zones          = ["1", "2", "3"]
create_redis_multiaz   = true
redis_zones            = ["1", "2", "3"]
redis_cache_enabled    = true
apim_v2_autoscale = {
  enabled                       = true
  default_instances             = 3
  minimum_instances             = 3
  maximum_instances             = 5
  scale_out_capacity_percentage = 45
  scale_out_time_window         = "PT10M"
  scale_out_value               = "2"
  scale_out_cooldown            = "PT45M"
  scale_in_capacity_percentage  = 30
  scale_in_time_window          = "PT30M"
  scale_in_value                = "1"
  scale_in_cooldown             = "PT4H"
}


# redis apim

redis_cache_params = {
  public_access = false
  capacity      = 1
  sku_name      = "Premium"
  family        = "P"
}


integration_app_gateway_sku_name                    = "Standard_v2"
integration_app_gateway_sku_tier                    = "Standard_v2"
cidr_subnet_appgateway_integration                  = ["10.230.10.192/26"]
integration_appgateway_private_ip                   = "10.230.10.200"
integration_app_gateway_api_certificate_name        = "api-platform-pagopa-it-stable"
integration_app_gateway_portal_certificate_name     = "portal-platform-pagopa-it-stable"
integration_app_gateway_management_certificate_name = "management-platform-pagopa-it-stable"
integration_appgateway_zones                        = [1, 2, 3]

nodo_pagamenti_psp            = "97249640588,05425630968,06874351007,08301100015,02224410023,02224410023,06529501006,00194450219,02113530345,01369030935,07783020725,00304940980,03339200374,14070851002,06556440961"
nodo_pagamenti_ec             = "00493410583,09633951000,06655971007,00856930102,02478610583,97169170822,01266290996,01248040998,01429910183,80007270376,01142420056,80052310580,83000730297,80082160013,94050080038,01032450072,01013130073,10718570012,01013210073,87007530170,01242340998,80012150274,02508710585,80422850588,94032590278,94055970480,92001600524,80043570482,92000530532,80094780378,80016430045,80011170505,80031650486,00337870406,09227921005,01928010683,00608810057,03299640163,82002730487,02928200241"
lb_aks                        = "10.70.135.200" # use http protocol + /nodo-<sit|uat|prod> + for SOAP services add /webservices/input
schema_ip_nexi                = "https://10.79.20.34"
default_node_id               = "NDP003PROD"
base_path_nodo_ppt_lmi        = "/ppt-lmi-prd-NOT-FOUND"
base_path_nodo_sync           = "/sync-cron-prd/syncWisp"
base_path_nodo_wfesp          = "/wfesp-prd"
base_path_nodo_fatturazione   = "/fatturazione-prd"
base_path_nodo_web_bo         = "/web-bo-prd"
base_path_nodo_web_bo_history = "/web-bo-history-prd"
dns_zone_wisp2                = "wisp2"
base_path_nodo_oncloud        = "/nodo-prd"



# to avoid https://docs.microsoft.com/it-it/azure/event-hubs/event-hubs-messaging-exceptions#error-code-50002
ehns_auto_inflate_enabled     = true
ehns_maximum_throughput_units = 10
ehns_capacity                 = 5
ehns_zone_redundant           = true
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

ehns04_alerts_enabled = true

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
    partitions        = 32
    message_retention = 7
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
    partitions        = 32
    message_retention = 7
    consumers         = ["fdr-qi-reported-iuv-rx"]
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
      }
    ]
  },
  {
    name              = "fdr-qi-flows"
    partitions        = 32
    message_retention = 7
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

node_forwarder_zone_balancing_enabled = true
node_forwarder_sku                    = "P3v3"
node_fw_ha_snet_cidr                  = ["10.1.157.0/24"]
node_fw_dbg_snet_cidr                 = ["10.1.195.0/24"]
devops_agent_zones                    = [1, 2, 3]
devops_agent_balance_zones            = false
azdo_agent_vm_image_name              = "pagopa-p-azdo-agent-ubuntu2204-image-v4"
integration_app_gateway_min_capacity  = 2
integration_app_gateway_max_capacity  = 50

# public app gateway
# app_gateway
app_gateway_api_certificate_name        = "api-platform-pagopa-it-stable"
app_gateway_upload_certificate_name     = "upload-platform-pagopa-it-stable"
app_gateway_portal_certificate_name     = "portal-platform-pagopa-it-stable"
app_gateway_management_certificate_name = "management-platform-pagopa-it-stable"
app_gateway_wisp2_certificate_name      = "wisp2-pagopa-it-stable"
app_gateway_wisp2govit_certificate_name = "wisp2-pagopa-gov-it"
app_gateway_wfespgovit_certificate_name = "wfesp-pagopa-gov-it"
app_gateway_min_capacity                = 8 # 5 capacity=baseline, 8 capacity=high volume event, 15 capacity=very high volume event
app_gateway_max_capacity                = 50
app_gateway_sku_name                    = "WAF_v2"
app_gateway_sku_tier                    = "WAF_v2"
app_gateway_waf_enabled                 = true
app_gateway_alerts_enabled              = true
app_gateway_deny_paths = [
  "/nodo/.*",
  # "/nodo-auth/.*", # non serve in quanto queste API sono con subkey required 🔐
  "/payment-manager/clients/.*",
  "/payment-manager/pp-restapi-rtd/.*",
  "/payment-manager/db-logging/.*",
  "/payment-manager/payment-gateway/.*",
  "/payment-manager/internal*",
  #  "/payment-manager/pm-per-nodo/.*", # non serve in quanto queste API sono con subkey required 🔐 APIM-for-Node
  #  "/checkout/io-for-node/.*", # non serve in quanto queste API sono con subkey required 🔐 APIM-for-Node
  #"/gpd-payments/.*", # non serve in quanto queste API sono con subkey required 🔐 APIM-for-Node
  "/tkm/tkmcardmanager/.*",
  "/tkm/tkmacquirermanager/.*",
  "/tkm/internal/.*",
  "/payment-transactions-gateway/internal/.*",
]
app_gateway_deny_paths_2 = [
  "/nodo-pagamenti/.*",
  "/sync-cron/.*",
  "/wfesp/.*",
  "/fatturazione/.*",
  "/payment-manager/pp-restapi-server/.*",
  "/gps/donation-service/.*",             # internal use no sub-keys
  "/shared/iuv-generator-service/.*",     # internal use no sub-keys
  "/gps/spontaneous-payments-service/.*", # internal use no sub-keys
  "/shared/authorizer/.*",                # internal use no sub-keys
  "/gpd/api/.*",                          # internal use no sub-keys
]
app_gateway_allowed_paths_pagopa_onprem_only = {
  paths = [
    "/web-bo/.*",
    "/bo-nodo/.*",
    "/pp-admin-panel/.*",
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
    "20.86.161.243",  # CSTAR
    "127.0.0.1",      # Softlab L1 Pagamenti VPN DISMESSO dal 1/10/2024
    "127.0.0.1",      # Softlab L1 Pagamenti VPN DISMESSO dal 1/10/2024
    "127.0.0.1",      # Softlab L1 Pagamenti VPN DISMESSO dal 1/10/2024
    "127.0.0.1",      # Softlab L1 Pagamenti VPN DISMESSO dal 1/10/2024
    "127.0.0.1",      # Softlab L1 Pagamenti VPN DISMESSO dal 1/10/2024
    "193.203.229.20", # VPN NEXI
    "193.203.230.22", # VPN NEXI
    "193.203.230.21", # VPN NEXI
    "2.33.87.3"       # S.M.I. TECHNOLOGIES AND CONSULTING S.R.L attivo dal 1/10/2024
  ]
}

cdn_storage_account_replication_type = "GZRS"
backup_storage_replication_type      = "GZRS"

apicfg_core_service_path_value           = "pagopa-api-config-core-service/p"
apicfg_selfcare_integ_service_path_value = "pagopa-api-config-selfcare-integration/p"
# monitoring
law_sku               = "CapacityReservation" # TODO verify why it is changed from PerGB2018 to CapacityReservation
law_retention_in_days = 30
law_daily_quota_gb    = -1


monitor_env_test_urls = [
  # wisp2.pagopa.gov.it
  {
    host = "wisp2.pagopa.gov.it",
    path = "",
  },
  # # status.pagopa.gov.it # remove it after 👀 https://github.com/pagopa/org-infra/pull/243
  # {
  #   host = "status.pagopa.gov.it",
  #   path = "",
  # },
  # assets.cdn.platform.pagopa.it
  {
    host          = "assets.cdn.platform.pagopa.it",
    path          = "",
    alert_enabled = false
  },
  # wfesp.pagopa.gov.it
  {
    host = "wfesp.pagopa.gov.it",
    path = "",
  }
]

enable_node_forwarder_debug_instance = false
route_tools = [
  {
    # dev aks nodo oncloud
    name                   = "tools-outbound-to-nexy-nodo"
    address_prefix         = "10.79.20.34/32"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.10.150"
  },
  {
    # dev aks nodo oncloud postgres
    name                   = "tools-outbound-to-nexy-nodo-postgres"
    address_prefix         = "10.79.20.25/32"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.10.150"
  }
]
