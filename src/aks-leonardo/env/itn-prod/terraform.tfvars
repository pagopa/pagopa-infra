# general
prefix              = "pagopa"
env_short           = "p"
env                 = "prod"
domain              = "prod"
location            = "italynorth"
location_string     = "Italy North"
location_short      = "itn"
location_westeurope = "westeurope"



### Network

cidr_subnet_system_aks = ["10.3.1.0/24"]
cidr_subnet_user_aks   = ["10.3.2.0/24"]

### Monitor
monitor_italy_resource_group_name                 = "pagopa-p-itn-core-monitor-rg"
log_analytics_italy_workspace_name                = "pagopa-p-itn-core-law"
log_analytics_italy_workspace_resource_group_name = "pagopa-p-itn-core-monitor-rg"
monitor_appinsights_italy_name                    = "pagopa-p-itn-core-appinsights"

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"
monitor_appinsights_name                    = "pagopa-p-appinsights"


### Aks

#
# ⛴ AKS
#
aks_private_cluster_enabled  = true
aks_alerts_enabled           = false
aks_kubernetes_version       = "1.32.4"
aks_sku_tier                 = "Standard"
aks_enable_workload_identity = true

aks_system_node_pool = {
  name            = "papaksleosys",
  vm_size         = "Standard_D2ds_v5",
  os_disk_type    = "Ephemeral",
  os_disk_size_gb = 75,
  node_count_min  = 1,
  node_count_max  = 3,
  node_labels     = { node_name : "aks-prod01-sys", node_type : "system" },
  zones           = [1, 2, 3]
  node_tags       = { node_tag_1 : "1" },
}
aks_user_node_pool = {
  enabled         = true,
  name            = "papaksleousr",
  vm_size         = "Standard_D8ds_v5",
  os_disk_type    = "Ephemeral",
  os_disk_size_gb = 300,
  node_count_min  = 3,
  node_count_max  = 3,
  zones           = [1, 2, 3]
  node_labels     = { node_name : "aks-prod01-user", node_type : "user" },
  node_taints     = [],
  node_tags       = { node_tag_2 : "2" },
}

aks_addons = {
  azure_policy                     = true,
  azure_key_vault_secrets_provider = true,
  pod_identity_enabled             = true,
}

# This is the k8s ingress controller ip. It must be in the aks subnet range.
ingress_load_balancer_ip = "10.3.2.250"
ingress_replica_count    = "2"
nginx_helm_version       = "4.12.1"

keda_helm_version = "2.17.1"

enable_elastic_agent = false
