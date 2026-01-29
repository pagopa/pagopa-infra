# general
prefix              = "pagopa"
env_short           = "d"
env                 = "dev"
domain              = "dev"
location            = "italynorth"
location_string     = "Italy North"
location_short      = "itn"
location_westeurope = "westeurope"


### Network

cidr_subnet_system_aks = ["10.3.1.0/24"]
cidr_subnet_user_aks   = ["10.3.2.0/24"]

### Monitor
monitor_italy_resource_group_name                 = "pagopa-d-itn-core-monitor-rg"
log_analytics_italy_workspace_name                = "pagopa-d-itn-core-law"
log_analytics_italy_workspace_resource_group_name = "pagopa-d-itn-core-monitor-rg"
monitor_appinsights_italy_name                    = "pagopa-d-itn-core-appinsights"

monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"
monitor_appinsights_name                    = "pagopa-d-appinsights"


### Aks

#
# ⛴ AKS
#
aks_private_cluster_enabled  = false
aks_alerts_enabled           = false
aks_kubernetes_version       = "1.34.1"
aks_enable_workload_identity = true

aks_system_node_pool = {
  name            = "padaksleosys",
  vm_size         = "Standard_B2ms",
  os_disk_type    = "Managed",
  os_disk_size_gb = 75,
  node_count_min  = 1,
  node_count_max  = 3,
  node_labels     = { node_name : "aks-leonardo-sys", node_type : "system" },
  node_tags       = {},
}
aks_user_node_pool = {
  enabled         = true,
  name            = "padaksleousr",
  vm_size         = "Standard_B8ms",
  os_disk_type    = "Managed",
  os_disk_size_gb = 75,
  node_count_min  = 1,
  node_count_max  = 3,
  node_labels     = { node_name : "aks-leonardo-user", node_type : "user" },
  node_taints     = [],
  node_tags       = {},
}

aks_addons = {
  azure_policy                     = true,
  azure_key_vault_secrets_provider = true,
  pod_identity_enabled             = true,
}

# This is the k8s ingress controller ip. It must be in the aks subnet range.
ingress_load_balancer_ip = "10.3.2.250"
ingress_replica_count    = "2"
nginx_helm_version       = "4.14.2"

keda_helm_version    = "2.17.2"
enable_elastic_agent = false
