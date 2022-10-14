# general
env_short = "d"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

lock_enable = false

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
cidr_subnet_reporting_common         = ["10.1.136.0/24"]
cidr_subnet_gpd                      = ["10.1.138.0/24"]
cidr_subnet_cosmosdb_paymentsdb      = ["10.1.139.0/24"]
cidr_subnet_canoneunico_common       = ["10.1.140.0/24"]
cidr_subnet_pg_flex_dbms             = ["10.1.141.0/24"]
cidr_subnet_vpn                      = ["10.1.142.0/24"]
cidr_subnet_dns_forwarder            = ["10.1.143.0/29"]
cidr_common_private_endpoint_snet    = ["10.1.144.0/23"]
cidr_subnet_logicapp_biz_evt         = ["10.1.146.0/24"]
cidr_subnet_advanced_fees_management = ["10.1.147.0/24"]
cidr_subnet_node_forwarder           = ["10.1.158.0/24"]

# specific
cidr_subnet_mock_ec              = ["10.1.137.0/29"]
cidr_subnet_mock_payment_gateway = ["10.1.137.8/29"]


# integration vnet
# https://www.davidc.net/sites/default/subnets/subnets.html?network=10.230.7.0&mask=24&division=7.31
cidr_vnet_integration = ["10.230.8.0/24"] # ask to SIA

cidr_subnet_apim       = ["10.230.8.0/26"]
cidr_subnet_eventhub   = ["10.230.8.64/26"]
cidr_subnet_api_config = ["10.230.8.128/29"]

# dns
external_domain   = "pagopa.it"
dns_zone_prefix   = "dev.platform"
dns_zone_checkout = "dev.checkout"
dns_zone_wisp2    = "dev.wisp2"

# azure devops
azdo_sp_tls_cert_enabled = true
enable_azdoa             = true
enable_iac_pipeline      = true

# redis private endpoint
redis_private_endpoint_enabled = true

# apim
apim_publisher_name = "pagoPA Platform DEV"
apim_sku            = "Developer_1"
apim_alerts_enabled = false

# app_gateway
app_gateway_api_certificate_name        = "api-dev-platform-pagopa-it"
app_gateway_portal_certificate_name     = "portal-dev-platform-pagopa-it"
app_gateway_management_certificate_name = "management-dev-platform-pagopa-it"
app_gateway_wisp2_certificate_name      = "dev-wisp2-pagopa-it"
app_gateway_wisp2govit_certificate_name = ""
app_gateway_sku_name                    = "Standard_v2"
app_gateway_sku_tier                    = "Standard_v2"
app_gateway_waf_enabled                 = false
app_gateway_alerts_enabled              = false
app_gateway_deny_paths = [
  "/notfound/*",
]
app_gateway_deny_paths_2 = [
  "/notfound2/*",
]
app_gateway_allowed_paths_pagopa_onprem_only = {
  paths = [
    "/allowed/*",
  ]
  ips = [
    "0.0.0.0",
    "0.0.0.0"
  ]
}

# postgresql
postgresql_sku_name                      = "B_Gen5_1" # todo fixme verify
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

# mock
mock_ec_enabled                    = true
mock_ec_secondary_enabled          = true
mock_psp_service_enabled           = true
mock_psp_secondary_service_enabled = true
mock_payment_gateway_enabled       = true

# apim x nodo pagamenti
# https://pagopa.atlassian.net/wiki/spaces/PPA/pages/464650382/Regole+di+Rete
nodo_pagamenti_enabled = true
nodo_pagamenti_psp     = "06529501006,97735020584,97249640588,08658331007,06874351007,08301100015,02224410023,02224410023,00194450219,02113530345,01369030935,07783020725"
nodo_pagamenti_ec      = "00493410583,77777777777,00113430573,00184260040,00103110573,00939820726,00109190579,00122520570,82501690018,80001220773,84515520017,03509990788,84002410540,00482510542,00326070166,01350940019,00197530298,00379480031,06396970482,00460900038,82005250285,82002770236,80013960036,83000970018,84002970162,82500110158,00429530546,01199250158,80003370477,00111190575,81001650548,00096090550,95001650167,00451080063,80038190163,00433320033,00449050061,82002270724,00682280284,00448140541,00344700034,81000550673,00450150065,80002860775,83001970017,00121490577,00383120037,00366270031,80023530167,01504430016,00221940364,00224320366,00246880397,01315320489,00354730392,00357850395,80008270375,00218770394,00226010395,00202300398,81002910396,00360090393,84002010365,00242920395,80005570561,80015230347,00236340477,92035800488,03428581205,00114510571"
nodo_pagamenti_url     = "http://10.70.66.200/nodo-sit/webservices/input"
ip_nodo                = "x.x.x.x"      # disabled in DEV allOnCloud shall use lb_aks
lb_aks                 = "10.70.66.200" # use http protocol + /nodo-<sit|uat|prod> + for SOAP services add /webservices/input ( 👀 look above nodo_pagamenti_url )

base_path_nodo_oncloud        = "/nodo-sit"
base_path_nodo_ppt_lmi        = "/ppt-lmi-sit"
base_path_nodo_sync           = "/sync-cron-sit/syncWisp"
base_path_nodo_wfesp          = "/wfesp-sit"
base_path_nodo_fatturazione   = "/fatturazione-sit"
base_path_nodo_web_bo         = "/web-bo-sit"
base_path_nodo_web_bo_history = "/web-bo-history-sit"

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
ecommerce_ingress_hostname = "weudev.ecommerce.internal.dev.platform.pagopa.it"

ehns_sku_name = "Standard"

ehns_alerts_enabled = false
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

eventhubs = [
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
    partitions        = 1 # in PROD shall be changed
    message_retention = 1 # in PROD shall be changed
    consumers         = ["nodo-dei-pagamenti-pdnd", "nodo-dei-pagamenti-oper", "nodo-dei-pagamenti-sia-rx"]
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
      }

    ]
  },
  {
    name              = "nodo-dei-pagamenti-fdr"
    partitions        = 1 # in PROD shall be changed
    message_retention = 1 # in PROD shall be changed
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
]

# acr
acr_enabled = true

# db nodo dei pagamenti
db_port                            = 1522
db_service_name                    = "NDPSPCT_PP_NODO4_CFG"
dns_a_reconds_dbnodo_ips           = ["10.70.67.18"]
private_dns_zone_db_nodo_pagamenti = "d.db-nodo-pagamenti.com"

# API Config
xsd_ica                 = "https://raw.githubusercontent.com/pagopa/pagopa-api/master/general/InformativaContoAccredito_1_2_1.xsd"
api_config_always_on    = false
apiconfig_logging_level = "DEBUG"

# API Config FE
api_config_fe_enabled = true
cname_record_name     = "config"

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
pagopa_proxy_redis_sku_name = "Basic"
pagopa_proxy_redis_family   = "C"
pagopa_proxy_tier           = "Standard"
pagopa_proxy_size           = "S1"
nodo_ip_filter              = "10.70.66.200"

# nodo-dei-pagamenti-test
nodo_pagamenti_test_enabled = true

# payment-manager clients
io_bpd_hostname    = "portal.test.pagopa.gov.it"
xpay_hostname      = "int-ecommerce.nexi.it"
paytipper_hostname = "st.paytipper.com"
bpd_hostname       = "api.dev.cstar.pagopa.it"
cobadge_hostname   = "portal.test.pagopa.gov.it/pmmockserviceapi"
fesp_hostname      = "portal.test.pagopa.gov.it"
satispay_hostname  = "portal.test.pagopa.gov.it/pmmockserviceapi"

cstar_outbound_ip_1 = "20.105.180.187"
cstar_outbound_ip_2 = "20.76.239.212"

# fdr
fdr_delete_retention_days       = 30
reporting_fdr_function_kind     = "Linux"
reporting_fdr_function_sku_tier = "Standard"
reporting_fdr_function_sku_size = "S1"

# gpd
gpd_plan_kind                = "Linux"
gpd_plan_sku_tier            = "Standard"
gpd_plan_sku_size            = "S1"
gpd_always_on                = false
gpd_cron_schedule_valid_to   = "0 */30 * * * *"
gpd_cron_schedule_expired_to = "0 */40 * * * *"

reporting_function_autoscale_minimum = 1
reporting_function_autoscale_maximum = 3
reporting_function_autoscale_default = 1

users = [
  {
    name = "APD_USER"
    grants = [
      {
        object_type = "schema"
        database    = "apd"
        schema      = "apd"
        privileges  = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE"]
      }
    ]
  }
]

# GPD Payments
# https://pagopa.atlassian.net/wiki/spaces/~345445188/pages/484278477/Stazioni+particolari#Canone-Unico
payments_always_on       = false
gpd_paa_id_intermediario = "15376371009"
gpd_paa_stazione_int     = "15376371009_01"
payments_logging_level   = "DEBUG"

# canone unico
canoneunico_plan_sku_tier = "Standard"
canoneunico_plan_sku_size = "S1"

# each 15 minutes
canoneunico_schedule_batch = "0 */15 * * * *"

canoneunico_function_autoscale_minimum = 1
canoneunico_function_autoscale_maximum = 3
canoneunico_function_autoscale_default = 1

# Postgres Flexible
# pgres_flex_params = {

#   private_endpoint_enabled = true
#   sku_name                 = "B_Standard_B1ms"
#   db_version               = "13"
#   # Possible values are 32768, 65536, 131072, 262144, 524288, 1048576,
#   # 2097152, 4194304, 8388608, 16777216, and 33554432.
#   storage_mb                   = 32768
#   zone                         = 1
#   backup_retention_days        = 7
#   geo_redundant_backup_enabled = false
#   create_mode                  = "Default"
#   high_availability_enabled    = false
#   standby_availability_zone    = 2
#   pgbouncer_enabled            = false

# }

# CosmosDb Payments
cosmos_document_db_params = {
  kind         = "GlobalDocumentDB"
  capabilities = ["EnableServerless"]
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "Strong"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  server_version                   = "4.0"
  main_geo_location_zone_redundant = false
  enable_free_tier                 = false

  additional_geo_locations          = []
  private_endpoint_enabled          = false
  public_network_access_enabled     = true
  is_virtual_network_filter_enabled = false

  backup_continuous_enabled = false

}

# CosmosDb AFM
cosmos_afm_db_params = {
  kind         = "GlobalDocumentDB"
  capabilities = ["EnableServerless"]
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "Strong"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  server_version                   = "4.0"
  main_geo_location_zone_redundant = false
  enable_free_tier                 = false

  additional_geo_locations          = []
  private_endpoint_enabled          = false
  public_network_access_enabled     = true
  is_virtual_network_filter_enabled = false

  backup_continuous_enabled = false

}

storage_queue_private_endpoint_enabled = true

platform_private_dns_zone_records = ["api", "portal", "management"]

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
  hot_cache_period   = "P7D"
  soft_delete_period = "P1M"
}

dexp_re_db_linkes_service = {
  enable = true
}
