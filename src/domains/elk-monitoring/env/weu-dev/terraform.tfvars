prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "elk"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "dev"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "IO"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/bizevents"
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

elastic_node_pool = {
  enabled         = true
  name            = "elastic01"
  vm_size         = "Standard_B8ms"
  os_disk_type    = "Managed"
  os_disk_size_gb = "300"
  node_count_min  = "1" #TODO change to 2 or 3 in prod
  node_count_max  = "2"
  node_labels = {
    elastic : "eck",
  },
  node_taints           = [],
  node_tags             = { elastic : "yes" },
  elastic_pool_max_pods = "250",
}

elastic_hot_storage = {
  storage_type           = "StandardSSD_LRS"
  allow_volume_expansion = true
  initialStorageSize     = "100Gi"
}
elastic_warm_storage = {
  storage_type           = "StandardSSD_LRS"
  allow_volume_expansion = true
  initialStorageSize     = "100Gi"
}
elastic_cold_storage = {
  storage_type           = "Standard_LRS"
  allow_volume_expansion = true
  initialStorageSize     = "100Gi"
}

elastic_cluster_config = {
  num_node_balancer     = "1"
  num_node_master       = "1"
  num_node_hot          = "1"
  num_node_warm         = "1"
  num_node_cold         = "1"
  storage_size_balancer = "20Gi"
  storage_size_master   = "20Gi"
  storage_size_hot      = "50Gi"
  storage_size_warm     = "100Gi"
  storage_size_cold     = "100Gi"
}

enable_iac_pipeline = true

ingress_load_balancer_ip = "10.1.100.250"
