# general
env_short = "d"
env       = "dev"
enabled_features = {
  vnet_ita          = true
  node_forwarder_ha = false

}


# networking
# main vnet

# common
cidr_subnet_postgresql = ["10.1.129.0/24"]


# specific
# zabbix
external_domain = "pagopa.it"
dns_zone_prefix = "dev.platform"
app_gateway_allowed_paths_pagopa_onprem_only = {
  paths = [
    "/allowed/*",
  ]
  ips = [
    "0.0.0.0",
    "0.0.0.0",
    "0.0.0.0",
    "0.0.0.0",
    "0.0.0.0",
    "0.0.0.0",
    "0.0.0.0",
    "0.0.0.0",
    "0.0.0.0",
    "0.0.0.0",
    "0.0.0.0",
    "0.0.0.0",
  ]
}


# postgresql
postgres_private_endpoint_enabled = false


# apim x nodo pagamenti
apim_nodo_decoupler_enable      = true
apim_nodo_auth_decoupler_enable = true
ecommerce_ingress_hostname      = "weudev.ecommerce.internal.dev.platform.pagopa.it"







# payment-manager clients
cstar_outbound_ip_1 = "20.105.180.187"
cstar_outbound_ip_2 = "20.76.239.212"



# CosmosDb AFM
apim_logger_resource_id = "/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/loggers/pagopa-d-apim-logger"

# WISP-dismantling-cfg
create_wisp_converter = true
