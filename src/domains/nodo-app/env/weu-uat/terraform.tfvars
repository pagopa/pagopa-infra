prefix          = "pagopa"
env_short       = "u"
env             = "uat"
domain          = "nodo"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "uat"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/nodo-app"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "pagopa-u-monitor-rg"
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.uat.platform"
apim_dns_zone_prefix     = "uat.platform"

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "1.21.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.2.2@sha256:22f4b53177cc8891bf10cbd0deb39f60e1cd12877021c3048a01e7738f63e0f9"
}

nodo_user_node_pool = {
  enabled         = true
  name            = "nodo01"
  vm_size         = "Standard_D8ds_v5"
  os_disk_type    = "Managed"
  os_disk_size_gb = "300"
  node_count_min  = "0" # PSFC-TODO da ripristinare prima del merge a 2
  node_count_max  = "0" # PSFC-TODO da ripristinare prima del merge a 6
  node_labels = {
  "nodo" = "true", },
  node_taints        = ["dedicated=nodo:NoSchedule"],
  node_tags          = { node_tag_1 : "1" },
  nodo_pool_max_pods = "250",
}

aks_cidr_subnet = ["10.1.0.0/17"]

cidr_subnet_vmss               = ["10.230.9.144/28"]
lb_frontend_private_ip_address = "10.230.9.150"

route_aks = [
  {
    #  aks nodo to nexi proxy
    name                   = "aks-outbound-to-nexy-sianet-subnet"
    address_prefix         = "10.101.1.95/32"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.9.150"
  },
  {
    # dev aks nodo oncloud
    name                   = "aks-outbound-to-nexy-proxy-subnet"
    address_prefix         = "10.79.20.33/32"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.9.150"
  },
  {
    #  aks nodo to nexi sfg
    name                   = "aks-outbound-to-nexi-sfg-subnet"
    address_prefix         = "10.101.38.180/32"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.9.150"
  },
  {
    #  aks nodo to nexi sftp
    name                   = "aks-outbound-to-nexi-sftp-subnet"
    address_prefix         = "10.48.23.0/24"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.9.150"
  },
  {
    #  aks nodo to nexi oncloud oracle
    name                   = "aks-outbound-to-nexi-oracle-cloud-subnet"
    address_prefix         = "10.70.73.0/24"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.9.150"
  },
  {
    #  aks nodo to nexi oncloud oracle
    name                   = "aks-outbound-to-nexi-aks-cloud-subnet"
    address_prefix         = "10.70.74.0/24"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.9.150"
  },
  {
    # uat aks nodo nexi postgres onprem
    name                   = "aks-outbound-to-nexi-postgres-onprem-subnet"
    address_prefix         = "10.222.214.174/32"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.9.150"
  },
  {
    #  prf aks nodo nexi postgres onprem
    name                   = "aks-outbound-to-nexi-postgres-prf-onprem-subnet"
    address_prefix         = "10.222.214.184/32"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.9.150"
  },
]

vmss_zones           = ["1"]
vmss_instance_number = 1

nodo_re_to_datastore_function = {
  always_on                    = true
  kind                         = "Linux"
  sku_size                     = "B1"
  sku_tier                     = "Basic"
  maximum_elastic_worker_count = 0
}
nodo_re_to_datastore_function_always_on       = true
nodo_re_to_datastore_function_subnet          = ["10.1.178.0/24"]
nodo_re_to_datastore_network_policies_enabled = true
nodo_re_to_datastore_function_autoscale = {
  default = 1
  minimum = 1
  maximum = 10
}
nodo_re_to_tablestorage_function = {
  always_on                    = true
  kind                         = "Linux"
  sku_size                     = "B1"
  sku_tier                     = "Basic"
  maximum_elastic_worker_count = 0
}
nodo_re_to_tablestorage_function_subnet          = ["10.1.184.0/24"]
nodo_re_to_tablestorage_network_policies_enabled = true
nodo_re_to_tablestorage_function_autoscale = {
  default = 1
  minimum = 1
  maximum = 10
}

nodo_verifyko_to_datastore_function = {
  always_on                    = true
  kind                         = "Linux"
  sku_size                     = "B1"
  sku_tier                     = "Basic"
  maximum_elastic_worker_count = null
  zone_balancing_enabled       = false
}
nodo_verifyko_to_datastore_function_always_on       = true
nodo_verifyko_to_datastore_function_subnet          = ["10.1.188.0/24"]
nodo_verifyko_to_datastore_network_policies_enabled = true
nodo_verifyko_to_datastore_function_autoscale = {
  default = 1
  minimum = 1
  maximum = 10
}

nodo_verifyko_to_tablestorage_function = {
  always_on                    = true
  kind                         = "Linux"
  sku_size                     = "B1"
  sku_tier                     = "Basic"
  maximum_elastic_worker_count = 0
  zone_balancing_enabled       = false
}
nodo_verifyko_to_tablestorage_function_subnet          = ["10.1.189.0/24"]
nodo_verifyko_to_tablestorage_network_policies_enabled = true
nodo_verifyko_to_tablestorage_function_autoscale = {
  default = 1
  minimum = 1
  maximum = 10
}

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
  ]
}

nodo_auth_subscription_limit = 10000

# node forwarder
nodo_pagamenti_x_forwarded_for = "10.230.9.5"


storage_account_info = {
  account_kind                      = "StorageV2"
  account_tier                      = "Standard"
  account_replication_type          = "ZRS"
  access_tier                       = "Hot"
  advanced_threat_protection_enable = true
}

# WISP-dismantling-cfg
create_wisp_converter = true
wisp_converter = {
  enable_apim_switch     = true
  brokerPSP_whitelist    = "97735020584"                                                                                                                            # AGID
  channel_whitelist      = "97735020584_02"                                                                                                                         # https://pagopa.atlassian.net/wiki/spaces/PAG/pages/135924270/Canali+Particolari
  station_whitelist      = "15376371009-15376371009_09,80005570561-00799960158_05,80023530167-00799960158_03,12621570154-00053810149_01,77777777777-97735020584_01" # https://config.uat.platform.pagopa.it/stations/15376371009_09 in UAT x i test quella di MockEC
  ci_whitelist           = "15376371009,80005570561,80023530167,12621570154,77777777777"
  dismantling_primitives = "nodoInviaRPT,nodoInviaCarrelloRPT"
}

# 15376371009-15376371009_09 EC PagoPA di test
# 80005570561-00799960158_05 Provincia di Viterbo/Intesa
# 80023530167-00799960158_03 Comune di Villa di Serio/Intesa
# 12621570154-00053810149_01 Bicocca/Banca popolare di Sondrio
# 77777777777-97735020584_01 EC PagoPA di collaudo
# 80207790587-02327910580_02 Dipartimento delle finanze/Sogei
# 80185690585-02327910580_02 Ministero dell'Interno - Dipartimento Affari interni e territoriali/Sogei
# 00833920150-02327910580_02 Riscossione Sicilia S.P.A/Sogei
# 09982061005-02327910580_02 Equitalia Giustizia S.P.A./Sogei
# 06363391001-02327910580_02 Agenzia delle Entrate/Sogei
# 97210890584-02327910580_02 Agenzia delle Dogane e dei Monopoli/Sogei
# 80415740580-02327910580_02 Ministero dell'Economia e delle Finanze/Sogei
# 13756881002-02327910580_02 Agenzia delle entrate-Riscossione/Sogei

enable_sendPaymentResultV2_SWClient = true
