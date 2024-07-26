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
  vnet_ita          = false
  node_forwarder_ha = true
}




# main vnet

# common
cidr_subnet_postgresql          = ["10.1.129.0/24"]
cidr_subnet_buyerbanks          = ["10.1.134.0/24"]
cidr_subnet_reporting_fdr       = ["10.1.135.0/24"]
cidr_subnet_cosmosdb_paymentsdb = ["10.1.139.0/24"]
cidr_subnet_canoneunico_common  = ["10.1.140.0/24"]
cidr_subnet_vpn                 = ["10.1.142.0/24"]
cidr_subnet_dns_forwarder       = ["10.1.143.0/29"]

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

lb_aks = "10.70.135.200" # use http protocol + /nodo-<sit|uat|prod> + for SOAP services add /webservices/input





nodo_auth_subscription_limit = 10000



# ecommerce ingress hostname
ecommerce_ingress_hostname = "weuprod.ecommerce.internal.platform.pagopa.it"



# buyerbanks functions
buyerbanks_function_kind              = "Linux"
buyerbanks_function_sku_tier          = "Standard"
buyerbanks_function_sku_size          = "S1"
buyerbanks_function_autoscale_minimum = 1
buyerbanks_function_autoscale_maximum = 3
buyerbanks_function_autoscale_default = 1
buyerbanks_delete_retention_days      = 30



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
