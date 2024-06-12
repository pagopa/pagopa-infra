# general
env_short          = "u"
env                = "uat"
location           = "westeurope"
location_short     = "weu"
location_ita       = "italynorth"
location_short_ita = "itn"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

#
# Feature flag
#
enabled_features = {
  apim_v2  = false
  vnet_ita = false
  apim_migrated = true
}

lock_enable = true

# monitoring
law_sku               = "PerGB2018"
law_retention_in_days = 30
law_daily_quota_gb    = 30

# networking
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
cidr_subnet_node_forwarder       = ["10.1.158.0/24"]
cidr_subnet_loadtest_agent       = ["10.1.159.0/24"]
cidr_subnet_dns_forwarder_backup = ["10.1.251.0/29"] #placeholder



# specific
cidr_subnet_redis = ["10.1.163.0/24"]

# integration vnet
# https://www.davidc.net/sites/default/subnets/subnets.html?network=10.230.7.0&mask=24&division=7.31
cidr_vnet_integration = ["10.230.9.0/24"] # ask to SIA

cidr_subnet_apim       = ["10.230.9.0/26"]
cidr_subnet_eventhub   = ["10.230.9.64/26"]
cidr_subnet_api_config = ["10.230.9.128/29"]

# dns
external_domain     = "pagopa.it"
dns_zone_prefix     = "uat.platform"
dns_zone_prefix_prf = "prf.platform"
dns_zone_checkout   = "uat.checkout"
dns_zone_selc       = "selfcare.uat.platform"
dns_zone_wisp2      = "uat.wisp2"
dns_zone_wfesp      = "wfesp.test"

# azure devops
azdo_sp_tls_cert_enabled = true
enable_azdoa             = true
enable_iac_pipeline      = true

# apim
apim_publisher_name = "pagoPA Platform UAT"
apim_sku            = "Developer_1"
apim_alerts_enabled = false

# redis private endpoint
redis_private_endpoint_enabled = true
redis_cache_enabled            = true

# app_gateway
app_gateway_api_certificate_name        = "api-uat-platform-pagopa-it"
app_gateway_upload_certificate_name     = "upload-uat-platform-pagopa-it"
upload_endpoint_enabled                 = true
app_gateway_prf_certificate_name        = "api-prf-platform-pagopa-it"
app_gateway_portal_certificate_name     = "portal-uat-platform-pagopa-it"
app_gateway_management_certificate_name = "management-uat-platform-pagopa-it"
app_gateway_wisp2_certificate_name      = "uat-wisp2-pagopa-it"
app_gateway_wisp2govit_certificate_name = "uat-wisp2-pagopa-gov-it"
app_gateway_wfespgovit_certificate_name = "wfesp-test-pagopa-gov-it"
app_gateway_kibana_certificate_name     = "kibana-uat-platform-pagopa-it"
app_gateway_sku_name                    = "WAF_v2"
app_gateway_sku_tier                    = "WAF_v2"
app_gateway_waf_enabled                 = true
# app_gateway_sku_name                    = "Standard_v2"
# app_gateway_sku_tier                    = "Standard_v2"
# app_gateway_waf_enabled                 = false
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
  "/shared/iuv-generator-service/.*",     # internal use no sub-keys
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
app_gateway_kibana_deny_paths = [
  "/kibana/*",
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
nat_gateway_enabled = true

# postgresql
postgresql_sku_name                      = "GP_Gen5_2" # todo fixme verify
postgresql_enable_replica                = false
postgresql_public_network_access_enabled = true
postgres_private_endpoint_enabled        = false

postgresql_network_rules = {
  ip_rules = [
    "0.0.0.0/0"
  ]
  # dblink
  allow_access_to_azure_services = false
}
prostgresql_db_mockpsp = "mock-psp"

# apim x nodo pagamenti
apim_nodo_decoupler_enable      = true
apim_nodo_auth_decoupler_enable = true

apim_enable_nm3_decoupler_switch     = false
apim_enable_routing_decoupler_switch = false
default_node_id                      = "NDP002UAT"

apim_fdr_nodo_pagopa_enable = false # 👀 https://pagopa.atlassian.net/wiki/spaces/PN5/pages/647497554/Design+Review+Flussi+di+Rendicontazione
# https://pagopa.atlassian.net/wiki/spaces/PPA/pages/464650382/Regole+di+Rete
nodo_pagamenti_enabled = true
nodo_pagamenti_psp     = "06529501006,97249640588,08301100015,00194450219,02113530345,01369030935,07783020725,00304940980,03339200374,14070851002,06556440961"
nodo_pagamenti_ec      = "00493410583,77777777777,00113430573,00184260040,00103110573,00939820726,00109190579,00122520570,82501690018,80001220773,84515520017,03509990788,84002410540,00482510542,00326070166,01350940019,00197530298,00379480031,06396970482,00460900038,82005250285,82002770236,80013960036,83000970018,84002970162,82500110158,00429530546,01199250158,80003370477,00111190575,81001650548,00096090550,95001650167,00451080063,80038190163,00433320033,00449050061,82002270724,00682280284,00448140541,00344700034,81000550673,00450150065,80002860775,83001970017,00121490577,00383120037,00366270031,80023530167,01504430016,00221940364,00224320366,00246880397,01315320489,00354730392,00357850395,80008270375,00218770394,00226010395,00202300398,81002910396,00360090393,84002010365,00242920395,80005570561,80015230347,00236340477,92035800488,03428581205,00114510571,97086740582,80029030568,87007530170,92000530532,80023370168,01349510436,10718570012,01032450072,01248040998,00608810057,80094780378,82002730487,80016430045,03299640163,94032590278,01928010683,91007750937,80052310580,97169170822,80043570482,80011170505,94050080038,01013130073,09227921005,94055970480,01429910183,01013210073,80031650486,83002410260,00337870406,92001600524,80007270376,02928200241,80082160013,01242340998,83000730297,01266290996,80012150274,02508710585,01142420056,02438750586"
nodo_pagamenti_url     = "https://10.70.74.200/nodo-uat/webservices/input"
ip_nodo                = "x.x.x.x"      # disabled 10.79.20.32/uat/webservices/input shall use lb_aks
lb_aks                 = "10.70.74.200" # use http protocol + /nodo-<sit|uat|prod> + for SOAP services add /webservices/input

schema_ip_nexi = "http://10.70.74.200"

base_path_nodo_oncloud        = "/nodo-uat"
base_path_nodo_ppt_lmi        = "/ppt-lmi-uat-NOT-FOUND"
base_path_nodo_sync           = "/sync-cron-uat/syncWisp"
base_path_nodo_wfesp          = "/wfesp-uat"
base_path_nodo_fatturazione   = "/fatturazione-uat"
base_path_nodo_web_bo         = "/web-bo-uat"
base_path_nodo_web_bo_history = "/web-bo-history-uat"

base_path_nodo_postgresql_nexi_onprem = "/"

nodo_auth_subscription_limit = 10000

# eventhub
eventhub_enabled = true

# checkout
checkout_enabled = true

# checkout function
checkout_function_kind              = "Linux"
checkout_function_sku_tier          = "Standard"
checkout_function_sku_size          = "S1"
checkout_function_autoscale_minimum = 1
checkout_function_autoscale_maximum = 3
checkout_function_autoscale_default = 1
checkout_pagopaproxy_host           = "https://io-p-app-pagopaproxytest.azurewebsites.net"

# ecommerce ingress hostname
ecommerce_ingress_hostname = "weuuat.ecommerce.internal.uat.platform.pagopa.it"

ecommerce_xpay_psps_list = "CHARITY_NEXI,CIPBITMM"
ecommerce_vpos_psps_list = "ATPIITM1,ABI36080,NIPSITR1,BIC36019,CHARITY_AMEX,CRGEITGG,BCEPITMM,BMLUIT3L,ABI03048,ABI03211,POCAIT3C,BPBAIT3B,SELBIT2B,ABI03268,ABI08899,ABI08327,BPMOIT22,CRACIT33,ABI03266,ABI01030,PASCITMM,PASBITGG,SENVITT1,BPPNIT2PXXX,BPPUIT33,ABI05033,BEPOIT21,BAPPIT21,POSOIT22XXX,ABI02008,ABI08913,BCABIT21,SARDIT31,CRBIIT2B,CHARITY_MPS,CHARITY_UNCR,CASRIT22,CRFIIT2SXXX,CRPPIT2PXXX,MICSITM1,CIPYIT31,RSANIT3P,BPCVIT2S,ABI14156,ABI19164,ABI03110,ABI36925,ABI36772,IFSPIT21,ABI03395,ABI03069,BCITITMM,BIC32698,SIGPITM1XXX,MOETIT31,ABI36092,idPsp1,AGID_02,PAYTITM1,BPPIITRRXXX,PPAYITR1XXX,RZSBIT2B,LB000484,SEPFIT31XXX,PIRLITM1XXX,SATYLUL1,SATYGB21,ABI36052,ABI36068,UNPLIT22,BLOPIT22,UNCRITMM,BNLIITRR,ABI18164,ABI03667,UNGCIT21"

# buyerbanks functions
buyerbanks_function_kind              = "Linux"
buyerbanks_function_sku_tier          = "Basic"
buyerbanks_function_sku_size          = "B1"
buyerbanks_function_autoscale_minimum = 1
buyerbanks_function_autoscale_maximum = 3
buyerbanks_function_autoscale_default = 1
buyerbanks_delete_retention_days      = 30

ehns_sku_name = "Standard"
# to avoid https://docs.microsoft.com/it-it/azure/event-hubs/event-hubs-messaging-exceptions#error-code-50002
ehns_auto_inflate_enabled     = true
ehns_maximum_throughput_units = 5
ehns_capacity                 = 5

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
    partitions        = 30
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
  }
]

# acr
acr_enabled = true

# db nodo dei pagamenti
dns_a_reconds_dbnodo_ips                 = ["10.70.73.10"]    # db onCloud
dns_a_reconds_dbnodo_prf_ips             = ["10.70.73.20"]    # db onCloud prf
dns_a_reconds_dbnodonexipostgres_ips     = ["10.222.214.174"] # db onPrem PostgreSQL
dns_a_reconds_dbnodonexipostgres_prf_ips = ["10.222.214.184"] # db onPrem PostgreSQL
private_dns_zone_db_nodo_pagamenti       = "u.db-nodo-pagamenti.com"


# pagopa-proxy app service
pagopa_proxy_redis_capacity = 0
pagopa_proxy_redis_sku_name = "Basic"
pagopa_proxy_redis_family   = "C"
pagopa_proxy_tier           = "Standard"
pagopa_proxy_size           = "S1"
# TODO this is dev value ... replace with uat value.
nodo_ip_filter = "10.79.20.32"

# redis apim
redis_cache_params = {
  public_access = false
  capacity      = 0
  sku_name      = "Basic"
  family        = "C"
}

# nodo-dei-pagamenti-test
nodo_pagamenti_test_enabled = true

# payment-manager clients
io_bpd_hostname    = "portal.test.pagopa.gov.it" #TO UPDATE with uat hostname
xpay_hostname      = "int-ecommerce.nexi.it"
paytipper_hostname = "st.paytipper.com"
bpd_hostname       = "api.uat.cstar.pagopa.it"
cobadge_hostname   = "portal.test.pagopa.gov.it"
fesp_hostname      = "portal.test.pagopa.gov.it"
satispay_hostname  = "mock-ppt-lmi-npa-sit.ocp-tst-npaspc.sia.eu/satispay/v1/consumers"

cstar_outbound_ip_1 = "20.93.160.60"
cstar_outbound_ip_2 = "20.76.182.7"

# fdr
fdr_delete_retention_days        = 30
reporting_fdr_function_kind      = "Linux"
reporting_fdr_function_sku_tier  = "Standard"
reporting_fdr_function_sku_size  = "S1"
reporting_fdr_function_always_on = true

# canone unico
canoneunico_plan_sku_tier = "Standard"
canoneunico_plan_sku_size = "S1"

canoneunico_function_always_on         = true
canoneunico_function_autoscale_minimum = 1
canoneunico_function_autoscale_maximum = 3
canoneunico_function_autoscale_default = 1

# Postgres Flexible
pgres_flex_params = {

  private_endpoint_enabled = true
  sku_name                 = "GP_Standard_D2s_v3"
  db_version               = "13"
  # Possible values are 32768, 65536, 131072, 262144, 524288, 1048576,
  # 2097152, 4194304, 8388608, 16777216, and 33554432.
  storage_mb                   = 1048576
  zone                         = 1
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  create_mode                  = "Default"
  high_availability_enabled    = false
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
  main_geo_location_zone_redundant = false
  enable_free_tier                 = true

  private_endpoint_enabled      = true
  public_network_access_enabled = false

  additional_geo_locations = []

  is_virtual_network_filter_enabled = true

  backup_continuous_enabled = false
}

# # CosmosDb GPS
# cosmos_gps_db_params = {
#   kind         = "GlobalDocumentDB"
#   capabilities = []
#   offer_type   = "Standard"
#   consistency_policy = {
#     consistency_level       = "BoundedStaleness"
#     max_interval_in_seconds = 300
#     max_staleness_prefix    = 100000
#   }
#   server_version                   = "4.0"
#   main_geo_location_zone_redundant = false
#   enable_free_tier                 = false

#   private_endpoint_enabled      = true
#   public_network_access_enabled = false

#   additional_geo_locations = []

#   is_virtual_network_filter_enabled = true

#   backup_continuous_enabled = false
# }

platform_private_dns_zone_records = ["api", "portal", "management"]

storage_queue_private_endpoint_enabled = true

# node forwarder
nodo_pagamenti_x_forwarded_for         = "10.230.9.5"
nodo_pagamenti_x_forwarded_for_apim_v2 = "10.230.9.164"
node_forwarder_tier                    = "PremiumV3"
node_forwarder_size                    = "P1v3"
node_forwarder_logging_level           = "DEBUG"

# lb elk
ingress_elk_load_balancer_ip = "10.1.100.251"

apicfg_core_service_path_value           = "pagopa-api-config-core-service/p"
apicfg_selfcare_integ_service_path_value = "pagopa-api-config-selfcare-integration/p"

apim_logger_resource_id = "/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/loggers/pagopa-u-apim-logger"
