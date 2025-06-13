# general
env_short          = "p"
env                = "prod"
location           = "westeurope"
location_short     = "weu"
location_ita       = "italynorth"
location_short_ita = "itn"


#
# Feature flag
#
enabled_features = {
  vnet_ita          = false
  node_forwarder_ha = true
}


# main vnet

# common
cidr_subnet_postgresql = ["10.1.129.0/24"]

# specific
cidr_subnet_dns_forwarder_backup = ["10.1.251.0/29"] #placeholder


cidr_subnet_api_config = ["10.230.10.128/29"]

# dns
external_domain   = "pagopa.it"
dns_zone_prefix   = "platform"
dns_zone_checkout = "checkout"





# app_gateway
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
    "127.0.0.1",      # Softlab L1 Pagamenti VPN DISMESSO al 1/10/2024
    "127.0.0.1",      # Softlab L1 Pagamenti VPN DISMESSO al 1/10/2024
    "127.0.0.1",      # Softlab L1 Pagamenti VPN DISMESSO al 1/10/2024
    "127.0.0.1",      # Softlab L1 Pagamenti VPN DISMESSO al 1/10/2024
    "127.0.0.1",      # Softlab L1 Pagamenti VPN DISMESSO al 1/10/2024
    "193.203.229.20", # VPN NEXI
    "193.203.230.22", # VPN NEXI
    "193.203.230.21", # VPN NEXI
    "2.33.87.3"       # S.M.I. TECHNOLOGIES AND CONSULTING S.R.L attivo dal 1/10/2024
  ]
}


# todo change to Premium before launch
# redis_sku_name = "Premium"
# redis_family   = "P"

# postgresql
postgres_private_endpoint_enabled = false


# apim x nodo pagamenti
apim_nodo_decoupler_enable      = true
apim_nodo_auth_decoupler_enable = true
apim_fdr_nodo_pagopa_enable     = false # 👀 https://pagopa.atlassian.net/wiki/spaces/PN5/pages/647497554/Design+Review+Flussi+di+Rendicontazione
# https://pagopa.atlassian.net/wiki/spaces/PPA/pages/464650382/Regole+di+Rete






nodo_auth_subscription_limit = 10000



# ecommerce ingress hostname
ecommerce_ingress_hostname = "weuprod.ecommerce.internal.platform.pagopa.it"






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











function_app_storage_account_info = {
  account_kind                      = "StorageV2"
  account_tier                      = "Standard"
  account_replication_type          = "GZRS"
  access_tier                       = "Hot"
  advanced_threat_protection_enable = true
}


buyer_banks_storage_account_replication_type = "GZRS"


apim_logger_resource_id = "/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/loggers/pagopa-p-apim-logger"

# WISP-dismantling-cfg
create_wisp_converter = true
