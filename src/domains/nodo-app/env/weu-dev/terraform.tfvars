prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "nodo"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "dev"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/nodo-app"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"
apim_dns_zone_prefix     = "dev.platform"

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
  vm_size         = "Standard_B8ms"
  os_disk_type    = "Managed"
  os_disk_size_gb = "300"
  node_count_min  = "0" # PSFC-TODO da ripristinare prima del merge a 2
  node_count_max  = "0" # PSFC-TODO da ripristinare prima del merge a 4
  node_labels = {
    "nodo" = "true",
  },
  node_taints        = ["dedicated=nodo:NoSchedule"],
  node_tags          = { node_tag_1 : "1" },
  nodo_pool_max_pods = "250",
}

aks_cidr_subnet = ["10.1.0.0/17"]

cidr_subnet_vmss               = ["10.230.8.144/28"]
lb_frontend_private_ip_address = "10.230.8.150"

route_aks = [
  {
    # dev aks nodo oncloud
    name                   = "aks-outbound-to-nexy-sianet-subnet"
    address_prefix         = "10.97.20.33/32"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.8.150"
  },
  {
    # dev aks nodo oncloud
    name                   = "aks-outbound-to-nexy-proxy-subnet"
    address_prefix         = "10.79.20.33/32"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.8.150"
  },
  {
    # dev aks nodo oncloud
    name                   = "aks-outbound-to-nexi-sfg-subnet"
    address_prefix         = "10.101.38.180/32"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.8.150"
  },
  {
    #  aks nodo to nexi oncloud oracle
    name                   = "aks-outbound-to-nexi-oracle-cloud-subnet"
    address_prefix         = "10.70.67.0/24"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.8.150"
  },
  {
    #  aks nodo to nexi oncloud app
    name                   = "aks-outbound-to-nexi-app-cloud-subnet"
    address_prefix         = "10.70.66.0/24"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.8.150"
  },
  {
    #  dev aks nodo nexi postgres onprem
    name                   = "aks-outbound-to-nexi-postgres-onprem-subnet"
    address_prefix         = "10.222.214.176/32"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.8.150"
  },
]

vmss_zones           = ["1"]
vmss_instance_number = 1

nodo_re_to_datastore_function = {
  always_on                    = true
  kind                         = "Linux"
  sku_size                     = "B1"
  sku_tier                     = "Basic"
  maximum_elastic_worker_count = null
}
nodo_re_to_datastore_function_always_on       = true
nodo_re_to_datastore_function_subnet          = ["10.1.178.0/24"]
nodo_re_to_datastore_network_policies_enabled = false
nodo_re_to_datastore_function_autoscale = {
  default = 1
  minimum = 1
  maximum = 3
}
nodo_re_to_tablestorage_function = {
  always_on                    = true
  kind                         = "Linux"
  sku_size                     = "B1"
  sku_tier                     = "Basic"
  maximum_elastic_worker_count = null
}
nodo_re_to_tablestorage_function_subnet          = ["10.1.184.0/24"]
nodo_re_to_tablestorage_network_policies_enabled = false
nodo_re_to_tablestorage_function_autoscale = {
  default = 1
  minimum = 1
  maximum = 3
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
nodo_verifyko_to_datastore_network_policies_enabled = false
nodo_verifyko_to_datastore_function_autoscale = {
  default = 1
  minimum = 1
  maximum = 3
}

nodo_verifyko_to_tablestorage_function = {
  always_on                    = true
  kind                         = "Linux"
  sku_size                     = "B1"
  sku_tier                     = "Basic"
  maximum_elastic_worker_count = null
  zone_balancing_enabled       = false
}
nodo_verifyko_to_tablestorage_function_subnet          = ["10.1.189.0/24"]
nodo_verifyko_to_tablestorage_network_policies_enabled = false
nodo_verifyko_to_tablestorage_function_autoscale = {
  default = 1
  minimum = 1
  maximum = 3
}

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
  ]
}


# node forwarder
nodo_pagamenti_x_forwarded_for = "10.230.8.5"


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
  brokerPSP_whitelist    = "97735020584"    # AGID
  channel_whitelist      = "97735020584_02" # https://pagopa.atlassian.net/wiki/spaces/PAG/pages/135924270/Canali+Particolari
  station_whitelist      = "15376371009_09" # https://config.dev.platform.pagopa.it/stations/15376371009_09 in UAT x i test quella di MockEC
  dismantling_primitives = "nodoInviaRPT,nodoInviaCarrelloRPT"
}

enable_sendPaymentResultV2_SWClient = true
