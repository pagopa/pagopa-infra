# general
env_short = "u"
env       = "uat"
enabled_features = {
  vnet_ita          = false
  node_forwarder_ha = false
}



# networking

# common
cidr_subnet_postgresql = ["10.1.129.0/24"]
external_domain        = "pagopa.it"
dns_zone_prefix        = "uat.platform"
dns_zone_prefix_prf    = "prf.platform"
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
    "151.1.203.68"    # Softlab backup support line
  ]
}


# postgresql
postgres_private_endpoint_enabled = false


# apim x nodo pagamenti
apim_nodo_decoupler_enable      = true
apim_nodo_auth_decoupler_enable = true
nodo_auth_subscription_limit    = 10000


# ecommerce ingress hostname
ecommerce_ingress_hostname = "weuuat.ecommerce.internal.uat.platform.pagopa.it"







# payment-manager clients
cstar_outbound_ip_1 = "20.93.160.60"
cstar_outbound_ip_2 = "20.76.182.7"











apim_logger_resource_id = "/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/loggers/pagopa-u-apim-logger"

# WISP-dismantling-cfg
create_wisp_converter = true
