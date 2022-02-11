# general
env_short = "u"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

lock_enable = true

# networking
# main vnet
cidr_vnet                      = ["10.1.0.0/16"]
cidr_subnet_appgateway         = ["10.1.128.0/24"]
cidr_subnet_postgresql         = ["10.1.129.0/24"]
cidr_subnet_azdoa              = ["10.1.130.0/24"]
cidr_subnet_pagopa_proxy_redis = ["10.1.131.0/24"]

# dev/uat only
cidr_subnet_mock_ec  = ["10.1.240.0/29"]
cidr_subnet_mock_psp = ["10.1.240.8/29"]

cidr_subnet_checkout_be  = ["10.1.240.16/29"]
cidr_subnet_pagopa_proxy = ["10.1.240.24/29"]
cidr_subnet_buyerbanks   = ["10.1.240.32/29"]

cidr_subnet_reporting_fdr = ["10.1.240.40/29"]

# integration vnet
# https://www.davidc.net/sites/default/subnets/subnets.html?network=10.230.7.0&mask=24&division=7.31
cidr_vnet_integration  = ["10.230.9.0/24"] # ask to SIA
cidr_subnet_apim       = ["10.230.9.0/26"]
cidr_subnet_api_config = ["10.230.9.128/29"]
cidr_subnet_eventhub   = ["10.230.9.64/26"]


# dns
external_domain   = "pagopa.it"
dns_zone_prefix   = "uat.platform"
dns_zone_checkout = "uat.checkout"
# azure devops
azdo_sp_tls_cert_enabled = true
enable_azdoa             = true
enable_iac_pipeline      = true

# apim
apim_publisher_name = "pagoPA Platform UAT"
apim_sku            = "Developer_1"
apim_alerts_enabled = false

# app_gateway
app_gateway_api_certificate_name        = "api-uat-platform-pagopa-it"
app_gateway_portal_certificate_name     = "portal-uat-platform-pagopa-it"
app_gateway_management_certificate_name = "management-uat-platform-pagopa-it"
app_gateway_sku_name                    = "Standard_v2"
app_gateway_sku_tier                    = "Standard_v2"
app_gateway_waf_enabled                 = false
app_gateway_alerts_enabled              = false
app_gateway_deny_paths = [
  "/nodo/*",
  "/payment-manager/clients/*",
  "/payment-manager/restapi-rtd/*",
  "/payment-manager/db-logging/*"
]

# nat_gateway
nat_gateway_enabled = true

# postgresql
prostgresql_enabled                      = false
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

# mock
mock_ec_enabled  = true
mock_psp_enabled = false

# api_config
api_config_enabled = true

# apim x nodo pagmenti
nodo_pagamenti_enabled = true
nodo_pagamenti_psp     = "06529501006,97735020584,97249640588,08658331007,06874351007,08301100015,02224410023,02224410023,00194450219,02113530345,01369030935,07783020725,00304940980"
nodo_pagamenti_ec      = "00493410583,77777777777,00113430573,00184260040,00103110573,00939820726,00109190579,00122520570,82501690018,80001220773,84515520017,03509990788,84002410540,00482510542,00326070166,01350940019,00197530298,00379480031,06396970482,00460900038,82005250285,82002770236,80013960036,83000970018,84002970162,82500110158,00429530546,01199250158,80003370477,00111190575,81001650548,00096090550,95001650167,00451080063,80038190163,00433320033,00449050061,82002270724,00682280284,00448140541,00344700034,81000550673,00450150065,80002860775,83001970017,00121490577,00383120037,00366270031,80023530167,01504430016,00221940364,00224320366,00246880397,01315320489,00354730392,00357850395,80008270375,00218770394,00226010395,00202300398,81002910396,00360090393,84002010365,00242920395,80005570561,80015230347,00236340477,92035800488,03428581205,00114510571,97086740582,80029030568,87007530170,92000530532,80023370168,01349510436,10718570012,01032450072,01248040998,00608810057,80094780378,82002730487,80016430045,03299640163,94032590278,01928010683,91007750937,80052310580,97169170822,80043570482,80011170505,94050080038,01013130073,09227921005,94055970480,01429910183,01013210073,80031650486,83002410260,00337870406,92001600524,80007270376,02928200241,80082160013,01242340998,83000730297,01266290996,80012150274,02508710585,01142420056,02438750586"
nodo_pagamenti_url     = "https://10.79.20.32/uat/webservices/input"
ip_nodo                = "10.79.20.32"

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

# buyerbanks functions
buyerbanks_function_kind              = "Linux"
buyerbanks_function_sku_tier          = "Standard"
buyerbanks_function_sku_size          = "S1"
buyerbanks_function_autoscale_minimum = 1
buyerbanks_function_autoscale_maximum = 3
buyerbanks_function_autoscale_default = 1
buyerbanks_delete_retention_days      = 30

ehns_sku_name = "Standard"

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
    consumers         = ["nodo-dei-pagamenti-pdnd", "nodo-dei-pagamenti-oper"]
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
]

# acr
acr_enabled = true

# db nodo dei pagamenti
db_port                            = 1521
db_service_name                    = "NDPSPCA_PP_NODO4_CFG"
dns_a_reconds_dbnodo_ips           = ["10.101.35.39", "10.101.35.40", "10.101.35.41"]
private_dns_zone_db_nodo_pagamenti = "u.db-nodo-pagamenti.com"

# API Config
xsd_ica = "https://raw.githubusercontent.com/pagopa/pagopa-api/master/general/InformativaContoAccredito_1_2_1.xsd"

# API Config FE
api_config_fe_enabled = true
cname_record_name     = "config"

# pagopa-proxy app service
pagopa_proxy_redis_capacity = 0
pagopa_proxy_redis_sku_name = "Basic"
pagopa_proxy_redis_family   = "C"
pagopa_proxy_tier           = "Standard"
pagopa_proxy_size           = "S1"
# TODO this is dev value ... replace with uat value.
nodo_ip_filter = "10.79.20.32"

# nodo-dei-pagamenti-test
nodo_pagamenti_test_enabled = true

# payment-manager clients
io_bpd_hostname    = "portal.test.pagopa.gov.it" #TO UPDATE with uat hostname
xpay_hostname      = "int-ecommerce.nexi.it"
paytipper_hostname = "st.paytipper.com"
bpd_hostname       = "api.uat.cstar.pagopa.it"
cobadge_hostname   = "portal.test.pagopa.gov.it"
fesp_hostname      = "portal.test.pagopa.gov.it"

# fdr
fdr_delete_retention_days       = 30
reporting_fdr_function_kind     = "Linux"
reporting_fdr_function_sku_tier = "Standard"
reporting_fdr_function_sku_size = "S1"
