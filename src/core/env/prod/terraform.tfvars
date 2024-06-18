# general
env_short          = "p"
env                = "prod"
location           = "westeurope"
location_short     = "weu"
location_ita       = "italynorth"
location_short_ita = "itn"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

#
# Feature flag
#
enabled_features = {
  apim_v2  = true
  vnet_ita = false
  apim_migrated = false
}

upload_endpoint_enabled = false
lock_enable = true

# monitoring
law_sku               = "CapacityReservation" # TODO verify why it is changed from PerGB2018 to CapacityReservation
law_retention_in_days = 30
law_daily_quota_gb    = -1

# networking
ddos_protection_plan = {
  id     = "/subscriptions/0da48c97-355f-4050-a520-f11a18b8be90/resourceGroups/sec-p-ddos/providers/Microsoft.Network/ddosProtectionPlans/sec-p-ddos-protection"
  enable = true
}

# main vnet
cidr_vnet = ["10.1.0.0/16"]

# common
cidr_subnet_appgateway               = ["10.1.128.0/24"]
cidr_subnet_postgresql               = ["10.1.129.0/24"]
cidr_subnet_azdoa                    = ["10.1.130.0/24"]
cidr_subnet_pagopa_proxy_redis       = ["10.1.131.0/24"]
cidr_subnet_pagopa_proxy             = ["10.1.132.0/24"]
cidr_subnet_checkout_be              = ["10.1.133.0/24"]
cidr_subnet_buyerbanks               = ["10.1.134.0/24"]
cidr_subnet_reporting_fdr            = ["10.1.135.0/24"]
cidr_subnet_cosmosdb_paymentsdb      = ["10.1.139.0/24"]
cidr_subnet_canoneunico_common       = ["10.1.140.0/24"]
cidr_subnet_pg_flex_dbms             = ["10.1.141.0/24"]
cidr_subnet_vpn                      = ["10.1.142.0/24"]
cidr_subnet_dns_forwarder            = ["10.1.143.0/29"]
cidr_common_private_endpoint_snet    = ["10.1.144.0/23"]
cidr_subnet_logicapp_biz_evt         = ["10.1.146.0/24"]
cidr_subnet_advanced_fees_management = ["10.1.147.0/24"]
# cidr_subnet_gps_cosmosdb             = ["10.1.149.0/24"]
cidr_subnet_node_forwarder = ["10.1.158.0/24"]

# specific
cidr_subnet_redis                = ["10.1.163.0/24"]
cidr_subnet_dns_forwarder_backup = ["10.1.251.0/29"] #placeholder

# integration vnet
# https://www.davidc.net/sites/default/subnets/subnets.html?network=10.230.7.0&mask=24&division=7.31
cidr_vnet_integration = ["10.230.10.0/24"] # ask to SIA

cidr_subnet_apim       = ["10.230.10.0/26"]
cidr_subnet_eventhub   = ["10.230.10.64/26"]
cidr_subnet_api_config = ["10.230.10.128/29"]

# dns
external_domain   = "pagopa.it"
dns_zone_prefix   = "platform"
dns_zone_checkout = "checkout"
dns_zone_wisp2    = "wisp2"
dns_zone_wfesp    = "wfesp"

# azure devops
azdo_sp_tls_cert_enabled = true
enable_azdoa             = true
enable_iac_pipeline      = true

# apim
apim_publisher_name = "pagoPA Platform PROD"
apim_sku            = "Premium_1"
apim_alerts_enabled = true

# redis private endpoint
redis_private_endpoint_enabled = true
redis_cache_enabled            = true

apim_autoscale = {
  enabled                       = true
  default_instances             = 3
  minimum_instances             = 1
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

# app_gateway
app_gateway_api_certificate_name        = "api-platform-pagopa-it"
app_gateway_upload_certificate_name     = "upload-platform-pagopa-it"
app_gateway_portal_certificate_name     = "portal-platform-pagopa-it"
app_gateway_management_certificate_name = "management-platform-pagopa-it"
app_gateway_wisp2_certificate_name      = "wisp2-pagopa-it"
app_gateway_wisp2govit_certificate_name = "wisp2-pagopa-gov-it"
app_gateway_kibana_certificate_name     = "kibana-platform-pagopa-it"
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
app_gateway_kibana_deny_paths = [
  "/kibana/*",
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
    "213.215.138.80", # Softlab L1 Pagamenti VPN
    "213.215.138.79", # Softlab L1 Pagamenti VPN
    "82.112.220.178", # Softlab L1 Pagamenti VPN
    "77.43.17.42",    # Softlab L1 Pagamenti VPN
    "151.2.45.1",     # Softlab L1 Pagamenti VPN
    "193.203.229.20", # VPN NEXI
    "193.203.230.22", # VPN NEXI
    "193.203.230.21", # VPN NEXI
  ]
}

# nat_gateway
nat_gateway_enabled    = true
nat_gateway_public_ips = 2

# todo change to Premium before launch
# redis_sku_name = "Premium"
# redis_family   = "P"

# postgresql
postgresql_sku_name                      = "GP_Gen5_2" # todo change before launch
postgresql_enable_replica                = false
postgresql_public_network_access_enabled = false
postgres_private_endpoint_enabled        = false


# apim x nodo pagamenti
apim_nodo_decoupler_enable      = true
apim_nodo_auth_decoupler_enable = true
apim_fdr_nodo_pagopa_enable     = false # 👀 https://pagopa.atlassian.net/wiki/spaces/PN5/pages/647497554/Design+Review+Flussi+di+Rendicontazione
# https://pagopa.atlassian.net/wiki/spaces/PPA/pages/464650382/Regole+di+Rete

apim_enable_nm3_decoupler_switch     = false
apim_enable_routing_decoupler_switch = false
default_node_id                      = "NDP003PROD"

nodo_pagamenti_enabled = true
nodo_pagamenti_psp     = "97249640588,05425630968,06874351007,08301100015,02224410023,02224410023,06529501006,00194450219,02113530345,01369030935,07783020725,00304940980,03339200374,14070851002,06556440961"
nodo_pagamenti_ec      = "00493410583,09633951000,06655971007,00856930102,02478610583,97169170822,01266290996,01248040998,01429910183,80007270376,01142420056,80052310580,83000730297,80082160013,94050080038,01032450072,01013130073,10718570012,01013210073,87007530170,01242340998,80012150274,02508710585,80422850588,94032590278,94055970480,92001600524,80043570482,92000530532,80094780378,80016430045,80011170505,80031650486,00337870406,09227921005,01928010683,00608810057,03299640163,82002730487,02928200241"
nodo_pagamenti_url     = "https://10.79.20.34/webservices/input"
ip_nodo                = "10.79.20.34"   # TEMP Nodo On Premises
lb_aks                 = "10.70.135.200" # use http protocol + /nodo-<sit|uat|prod> + for SOAP services add /webservices/input

schema_ip_nexi = "https://10.79.20.34"

base_path_nodo_oncloud        = "/nodo-prd"
base_path_nodo_ppt_lmi        = "/ppt-lmi-prd-NOT-FOUND"
base_path_nodo_sync           = "/sync-cron-prd/syncWisp"
base_path_nodo_wfesp          = "/wfesp-prd"
base_path_nodo_fatturazione   = "/fatturazione-prd"
base_path_nodo_web_bo         = "/web-bo-prd"
base_path_nodo_web_bo_history = "/web-bo-history-prd"

base_path_nodo_postgresql_nexi_onprem = "/"


nodo_auth_subscription_limit = 10000

# eventhub
eventhub_enabled = true

# checkout
checkout_enabled = true

# checkout function
checkout_function_kind              = "Linux"
checkout_function_sku_tier          = "PremiumV3"
checkout_function_sku_size          = "P1v3"
checkout_function_always_on         = true
checkout_function_autoscale_minimum = 1
checkout_function_autoscale_maximum = 3
checkout_function_autoscale_default = 1
checkout_pagopaproxy_host           = "https://io-p-app-pagopaproxyprod.azurewebsites.net"

# ecommerce ingress hostname
ecommerce_ingress_hostname = "weuprod.ecommerce.internal.platform.pagopa.it"

ehns_sku_name = "Standard"

# to avoid https://docs.microsoft.com/it-it/azure/event-hubs/event-hubs-messaging-exceptions#error-code-50002
ehns_auto_inflate_enabled     = true
ehns_maximum_throughput_units = 5

ehns_alerts_enabled = false
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

eventhubs = [
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
    name              = "fdr-re" # used by FdR Fase 1 and Fase 3
    partitions        = 32
    message_retention = 7
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

eventhubs_02 = [
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
  }
]

# acr
acr_enabled = true

# db nodo dei pagamenti
# Before DR switch 👉  dns_a_reconds_dbnodo_ips             = ["10.102.35.58", "10.102.35.57"] # scan: "10.102.35.61", "10.102.35.62", "10.102.35.63", vip: "10.102.35.60", "10.102.35.59",
dns_a_reconds_dbnodo_ips             = ["10.101.35.37", "10.101.35.38"]                                     # scan: "10.102.35.61", "10.102.35.62", "10.102.35.63", vip: "10.102.35.60", "10.102.35.59",
dns_a_reconds_dbnodo_ips_dr          = ["10.250.45.145", "10.250.45.146", "10.250.45.147", "10.250.45.148"] # authdbsep01-vip.carte.local   NAT 10.250.45.145 authdbsep02-vip.carte.local   NAT 10.250.45.146 authdbpep01-vip.carte.local   NAT 10.250.45.147 authdbpep02-vip.carte.local   NAT 10.250.45.148
dns_a_reconds_dbnodonexipostgres_ips = ["10.222.209.84"]                                                    # db onPrem PostgreSQL
private_dns_zone_db_nodo_pagamenti   = "p.db-nodo-pagamenti.com"

# buyerbanks functions
buyerbanks_function_kind              = "Linux"
buyerbanks_function_sku_tier          = "Standard"
buyerbanks_function_sku_size          = "S1"
buyerbanks_function_autoscale_minimum = 1
buyerbanks_function_autoscale_maximum = 3
buyerbanks_function_autoscale_default = 1
buyerbanks_delete_retention_days      = 30

# pagopa-proxy app service
pagopa_proxy_redis_capacity = 0
pagopa_proxy_redis_sku_name = "Standard"
pagopa_proxy_redis_family   = "C"
pagopa_proxy_tier           = "PremiumV3"
pagopa_proxy_size           = "P1v3"
# TODO this is dev value ... replace with uat value.
nodo_ip_filter = "10.79.20.32"

# redis apim
redis_cache_params = {
  public_access = false
  capacity      = 0
  sku_name      = "Standard"
  family        = "C"
}

# payment-manager clients
io_bpd_hostname    = "portal.test.pagopa.gov.it" #TO UPDATE with prod hostname
xpay_hostname      = "ecommerce.nexi.it"
paytipper_hostname = "st.paytipper.com"
bpd_hostname       = "api.cstar.pagopa.it"
cobadge_hostname   = "portal.test.pagopa.gov.it" #TO UPDATE with prod hostname
fesp_hostname      = "portal.test.pagopa.gov.it"
satispay_hostname  = "mock-ppt-lmi-npa-sit.ocp-tst-npaspc.sia.eu/satispay/v1/consumers"

cstar_outbound_ip_1 = "20.86.161.243"
cstar_outbound_ip_2 = "20.101.29.160"

# fdr
fdr_delete_retention_days        = 30
reporting_fdr_function_kind      = "Linux"
reporting_fdr_function_sku_tier  = "PremiumV3"
reporting_fdr_function_sku_size  = "P1v3"
reporting_fdr_function_always_on = true

# canone unico
canoneunico_plan_sku_tier = "PremiumV3"
canoneunico_plan_sku_size = "P1v3"

canoneunico_function_always_on         = true
canoneunico_function_autoscale_minimum = 1
canoneunico_function_autoscale_maximum = 3
canoneunico_function_autoscale_default = 1

canoneunico_queue_message_delay = 3600 // in seconds = 1h

# Postgres Flexible
# https://docs.microsoft.com/it-it/azure/postgresql/flexible-server/concepts-high-availability
# https://azure.microsoft.com/it-it/global-infrastructure/geographies/#choose-your-region
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server#geo_redundant_backup_enabled
pgres_flex_params = {

  private_endpoint_enabled = true
  sku_name                 = "GP_Standard_D4s_v3"
  db_version               = "13"
  # Possible values are 32768, 65536, 131072, 262144, 524288, 1048576,
  # 2097152, 4194304, 8388608, 16777216, and 33554432.
  storage_mb                   = 32768
  zone                         = 1
  backup_retention_days        = 7
  geo_redundant_backup_enabled = true
  create_mode                  = "Default"
  high_availability_enabled    = true
  standby_availability_zone    = 2
  pgbouncer_enabled            = true

}

# CosmosDb Payments
cosmos_document_db_params = {
  kind         = "GlobalDocumentDB"
  capabilities = []
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  server_version                   = "4.0"
  main_geo_location_zone_redundant = true
  enable_free_tier                 = true

  private_endpoint_enabled      = true
  public_network_access_enabled = false
  additional_geo_locations = [{
    location          = "northeurope"
    failover_priority = 1
    zone_redundant    = false
  }]

  is_virtual_network_filter_enabled = true

  backup_continuous_enabled = true
}

storage_queue_private_endpoint_enabled = true

platform_private_dns_zone_records = ["api", "portal", "management"]

# node forwarder
nodo_pagamenti_x_forwarded_for         = "10.230.10.5"
nodo_pagamenti_x_forwarded_for_apim_v2 = "10.230.10.164"
node_forwarder_tier                    = "PremiumV3"
node_forwarder_size                    = "P1v3"

# lb elk
ingress_elk_load_balancer_ip = "10.1.100.251"

devops_agent_zones         = [1, 2, 3]
devops_agent_balance_zones = false


function_app_storage_account_info = {
  account_kind                      = "StorageV2"
  account_tier                      = "Standard"
  account_replication_type          = "GZRS"
  access_tier                       = "Hot"
  advanced_threat_protection_enable = true
}


logic_app_storage_account_replication_type   = "LRS"
buyer_banks_storage_account_replication_type = "GZRS"
cdn_storage_account_replication_type         = "GRS"
backup_storage_replication_type              = "GRS"
fdr_flow_sa_replication_type                 = "ZRS"

apicfg_core_service_path_value           = "pagopa-api-config-core-service/p"
apicfg_selfcare_integ_service_path_value = "pagopa-api-config-selfcare-integration/p"

apim_logger_resource_id = "/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/loggers/pagopa-p-apim-logger"
