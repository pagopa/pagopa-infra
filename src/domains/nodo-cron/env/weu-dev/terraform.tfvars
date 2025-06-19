prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "nodo"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "dev"


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
  name            = "nodocron01"
  vm_size         = "Standard_B8ms"
  os_disk_type    = "Managed"
  os_disk_size_gb = "300"
  node_count_min  = "1"
  node_count_max  = "4"
  node_labels = {
  "nodo-cron" = "true", },
  node_taints        = ["dedicated=nodo-cron:NoSchedule"],
  node_tags          = { node_tag_1 : "1" },
  nodo_pool_max_pods = "250",
}

aks_cidr_subnet = ["10.1.0.0/17"]
