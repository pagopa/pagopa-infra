# general
env_short          = "d"
env                = "dev"
location           = "westeurope"
location_short     = "weu"
location_ita       = "italynorth"
location_short_ita = "itn"



#
# Feature flag
#
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
cidr_subnet_tools_cae      = ["10.1.248.0/23"] #placeholders
cidr_subnet_pg_flex_zabbix = ["10.1.254.0/24"] #placeholders


cidr_subnet_api_config = ["10.230.8.128/29"]

# dns
external_domain   = "pagopa.it"
dns_zone_prefix   = "dev.platform"
dns_zone_checkout = "dev.checkout"




# app_gateway
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


apim_fdr_nodo_pagopa_enable = false # 👀 https://pagopa.atlassian.net/wiki/spaces/PN5/pages/647497554/Design+Review+Flussi+di+Rendicontazione
# https://pagopa.atlassian.net/wiki/spaces/PPA/pages/464650382/Regole+di+Rete



# ecommerce ingress hostname
ecommerce_ingress_hostname = "weudev.ecommerce.internal.dev.platform.pagopa.it"







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






node_forwarder_autoscale_enabled = false




apim_logger_resource_id = "/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-api-rg/providers/Microsoft.ApiManagement/service/pagopa-d-apim/loggers/pagopa-d-apim-logger"

# WISP-dismantling-cfg
create_wisp_converter = true
