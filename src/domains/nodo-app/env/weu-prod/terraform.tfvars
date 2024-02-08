prefix          = "pagopa"
env_short       = "p"
env             = "prod"
domain          = "nodo"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "prod"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/nodo-app"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

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
  node_count_min  = "3"
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
    name                   = "aks-outbound-to-nexi-aks-cloud-subnet"
    address_prefix         = "10.70.135.0/24"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.10.150"
  },
  {
    # aks nodo nexi postgres onprem
    name                   = "aks-outbound-to-nexi-postgres-onprem-subnet"
    address_prefix         = "10.222.209.84/32"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.230.10.150"
  },

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
  "nodo-cfg-data-migration" = {
    minAvailable = 1
    matchLabels = {
      "app.kubernetes.io/instance" = "nodo-cfg-data-migration"
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

storage_account_info = {
  account_kind                      = "StorageV2"
  account_tier                      = "Standard"
  account_replication_type          = "GZRS"
  access_tier                       = "Hot"
  advanced_threat_protection_enable = true
}
