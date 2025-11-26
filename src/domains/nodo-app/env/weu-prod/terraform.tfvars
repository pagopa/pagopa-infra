prefix          = "pagopa"
env_short       = "p"
env             = "prod"
domain          = "nodo"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "prod"


### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"
apim_dns_zone_prefix     = "platform"

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "2.0.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.3.4@sha256:c3d45736706c981493b6216451fc65e99a69d5d64409ccb1c4ca93fef57c921d"
}

nodo_user_node_pool = {
  enabled         = true
  name            = "nodo01"
  vm_size         = "Standard_D8ds_v5"
  os_disk_type    = "Managed"
  os_disk_size_gb = "300"
  node_count_min  = "4"
  node_count_max  = "10"
  node_labels = {
  "nodo" = "true", },
  node_taints        = ["dedicated=nodo:NoSchedule"],
  node_tags          = { node_tag_1 : "1" },
  nodo_pool_max_pods = "250",
}

aks_cidr_subnet = ["10.1.0.0/17"]

cidr_subnet_vmss               = ["10.230.10.144/28"]
lb_frontend_private_ip_address = "10.230.10.150"

route_aks = [
  {
    #  aks nodo to nexi proxy
    name                   = "aks-outbound-to-nexy-sianet-prod-subnet"
    address_prefix         = "10.102.1.85/32"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.10.150"
  },
  {
    # dev aks nodo oncloud
    name                   = "aks-outbound-to-nexy-proxy-subnet"
    address_prefix         = "10.79.20.35/32"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.10.150"
  },
  {
    #  aks nodo to nexi proxy
    name                   = "aks-outbound-to-nexy-sianet-dr-subnet"
    address_prefix         = "10.101.1.85/32"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.10.150"
  },
  {
    #  aks nodo to nexi sfg
    name                   = "aks-outbound-to-nexi-sfg-subnet"
    address_prefix         = "10.92.8.180/32"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.10.150"
  },
  {
    #  aks nodo to nexi sftp
    name                   = "aks-outbound-to-nexi-sftp-subnet"
    address_prefix         = "10.103.3.0/24"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.10.150"
  },
  {
    #  aks nodo to nexi oncloud oracle
    name                   = "aks-outbound-to-nexi-oracle-cloud-subnet"
    address_prefix         = "10.70.139.0/24"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.10.150"
  },
  {
    #  aks nodo to nexi oncloud oracle
    name                   = "aks-outbound-to-nexi-oracle-onprem-subnet"
    address_prefix         = "10.102.35.0/24"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.10.150"
  },
  {
    #  aks nodo to nexi oncloud oracle
    name                   = "aks-outbound-to-nexi-oracle-dr-onprem-subnet"
    address_prefix         = "10.101.35.0/24"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.10.150"
  },
  {
    #  aks nodo to nexi oncloud oracle
    name                   = "aks-outbound-to-nexi-aks-cloud-subnet"
    address_prefix         = "10.70.135.0/24"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.10.150"
  },
  {
    # aks nodo nexi postgres onprem
    name                   = "aks-outbound-to-nexi-postgres-onprem-subnet"
    address_prefix         = "10.102.1.93/32"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.10.150"
  },
  {
    # aks nodo nexi postgres onprem balancer 1
    name                   = "aks-outbound-to-nexi-postgres-onprem-balancer-1-subnet"
    address_prefix         = "10.222.214.129/32"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.10.150"
  },
  {
    # aks nodo nexi postgres onprem balancer 2
    name                   = "aks-outbound-to-nexi-postgres-onprem-balancer-2-subnet"
    address_prefix         = "10.222.214.134/32"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.10.150"
  },
  {
    # aks nodo nexi oracle settimo onprem
    name                   = "aks-outbound-to-nexi-oracle-onprem-settimo-subnet"
    address_prefix         = "10.102.175.0/24"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.10.150"
  },
  {
    # aks nodo nexi oracle pero onprem
    name                   = "aks-outbound-to-nexi-oracle-onprem-pero-subnet"
    address_prefix         = "10.101.175.0/24"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.10.150"
  }

]

vmss_zones           = ["1", "2", "3"]
vmss_instance_number = 1

nodo_re_to_datastore_function = {
  always_on                    = true
  kind                         = "Linux"
  sku_size                     = "P1v3"
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
  sku_size                     = "P1v3"
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

function_app_storage_account_replication_type = "GZRS"

nodo_verifyko_to_datastore_function = {
  always_on                    = true
  kind                         = "Linux"
  sku_size                     = "P1v3"
  sku_tier                     = "Basic"
  maximum_elastic_worker_count = 3
  zone_balancing_enabled       = true
}
nodo_verifyko_to_datastore_function_always_on       = true
nodo_verifyko_to_datastore_function_subnet          = ["10.1.178.0/24"]
nodo_verifyko_to_datastore_network_policies_enabled = true
nodo_verifyko_to_datastore_function_autoscale = {
  default = 3
  minimum = 3
  maximum = 10
}

nodo_verifyko_to_tablestorage_function = {
  always_on                    = true
  kind                         = "Linux"
  sku_size                     = "P1v3"
  sku_tier                     = "Basic"
  maximum_elastic_worker_count = 3
  zone_balancing_enabled       = false
}
nodo_verifyko_to_tablestorage_function_subnet          = ["10.1.189.0/24"]
nodo_verifyko_to_tablestorage_network_policies_enabled = true
nodo_verifyko_to_tablestorage_function_autoscale = {
  default = 1
  minimum = 1
  maximum = 10
}


pod_disruption_budgets = {
  "node-technicalsupport" = {
    minAvailable = 1
    matchLabels = {
      "app.kubernetes.io/instance" = "node-technicalsupport"
    }
  },

  "nodo" = {
    minAvailable = 1
    matchLabels = {
      "app.kubernetes.io/instance" = "nodo"
    }
  },

  "pagopawebbo" = {
    minAvailable = 1
    matchLabels = {
      "app.kubernetes.io/instance" = "pagopawebbo"
    }
  },
  "pagopawfespwfesp" = {
    minAvailable = 1
    matchLabels = {
      "app.kubernetes.io/instance" = "pagopawfespwfesp"
    }
  },
}

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
  ]
}
storage_account_info = {
  account_kind                      = "StorageV2"
  account_tier                      = "Standard"
  account_replication_type          = "GZRS"
  access_tier                       = "Hot"
  advanced_threat_protection_enable = true
  use_legacy_defender_version       = true
  public_network_access_enabled     = false
}

nodo_auth_subscription_limit = 10000
# node forwarder
nodo_pagamenti_x_forwarded_for = "10.230.10.5"


# WISP-dismantling-cfg
create_wisp_converter = true
wisp_converter = {
  enable_apim_switch                  = true
  brokerPSP_whitelist                 = "97735020584"
  channel_whitelist                   = "97735020584_02"
  nodoinviarpt_paymenttype_whitelist  = "BBT"
  dismantling_primitives              = "nodoInviaRPT,nodoInviaCarrelloRPT"
  dismantling_rt_primitives           = "nodoChiediCopiaRT"
  checkout_predefined_expiration_time = 1800
  wisp_ecommerce_channels             = "97735020584_03,97735020584_09"
}

enable_sendPaymentResultV2_SWClient = false

# WFESP-dismantling-cfg
wfesp_dismantling = {
  channel_list    = "13212880150_90" # When we want to activate WFESP dismantling, insert correct channel list "13212880150_90"
  wfesp_fixed_url = "https://wfesp.pagopa.gov.it/redirect/wpl05/get?idSession="
}
