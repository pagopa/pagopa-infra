# general
env_short = "p"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

lock_enable = true

# networking
# main vnet
cidr_vnet              = ["10.1.0.0/16"]
cidr_subnet_appgateway = ["10.1.128.0/24"]
cidr_subnet_postgresql = ["10.1.129.0/24"]
cidr_subnet_azdoa      = ["10.1.130.0/24"]
# prod only
cidr_subnet_redis = ["10.1.132.0/24"]

cidr_subnet_checkout_be = ["10.1.133.0/24"]

# integration vnet
# https://www.davidc.net/sites/default/subnets/subnets.html?network=10.230.7.0&mask=24&division=7.31
cidr_vnet_integration = ["10.230.10.0/24"] # ask to SIA
cidr_subnet_apim      = ["10.230.10.0/26"]
cidr_subnet_eventhub  = ["10.230.10.64/26"]
cidr_subnet_lb        = ["10.230.10.136/29"]

# dns
external_domain   = "pagopa.it"
dns_zone_prefix   = "platform"
dns_zone_checkout = "checkout"

# azure devops
azdo_sp_tls_cert_enabled = true
enable_azdoa             = true
enable_iac_pipeline      = true

# apim
apim_publisher_name = "pagoPA Platform PROD"
apim_sku            = "Developer_1" # todo change to Premium_1 before launch

# app_gateway
app_gateway_api_certificate_name        = "api-platform-pagopa-it"
app_gateway_portal_certificate_name     = "portal-platform-pagopa-it"
app_gateway_management_certificate_name = "management-platform-pagopa-it"
app_gateway_min_capacity                = 0 # todo change to at least 1
app_gateway_max_capacity                = 2

# nat_gateway
nat_gateway_enabled    = true
nat_gateway_public_ips = 2

# todo change to Premium before launch
# redis_sku_name = "Premium"
# redis_family   = "P"

# postgresql
prostgresql_enabled                      = false
postgresql_sku_name                      = "GP_Gen5_2" # todo change before launch
postgresql_enable_replica                = false
postgresql_public_network_access_enabled = false

# mock
mock_ec_enabled  = false
mock_psp_enabled = false

# api_config
api_config_enabled = false

# apim x nodo pagmenti
nodo_pagamenti_enabled = true
nodo_pagamenti_psp     = "97735020584,97735020583,97735020582,97735020581"
nodo_pagamenti_ec      = "77777777777,00493410583"
nodo_pagamenti_url     = "https://10.79.20.32/uat/webservices/input" # future need - here we'll set PROD node url


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
        values = ["nodo-dei-pagamenti-log",
        "nodo-dei-pagamenti-re"]
      }
    ],
  },
}

eventhubs = [
  {
    name              = "nodo-dei-pagamenti-log"
    partitions        = 32 # in PROD shall be changed
    message_retention = 7  # in PROD shall be changed
    consumers         = ["logstash-rx1", "logstash-rx2", "logstash-rx3"]
    keys = [
      {
        name   = "logstash-SIA"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "logstash-rx1"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "logstash-rx2"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "logstash-rx3"
        listen = true
        send   = false
        manage = false
      }

    ]
  },
  {
    name              = "nodo-dei-pagamenti-re"
    partitions        = 32 # in PROD shall be changed
    message_retention = 7  # in PROD shall be changed
    consumers         = ["nodo-dei-pagamenti-rx1"]
    keys = [
      {
        name   = "nodo-dei-pagamenti-SIA"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "nodo-dei-pagamenti-rx1"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
]

# lb
lb_enabled          = true
lb_backend_pool_ips = ["10.102.35.61", "10.102.35.62", "10.102.35.63"]
