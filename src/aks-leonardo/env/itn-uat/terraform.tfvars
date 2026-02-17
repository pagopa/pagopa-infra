# general
prefix              = "pagopa"
env_short           = "u"
env                 = "uat"
domain              = "uat"
location            = "italynorth"
location_string     = "Italy North"
location_short      = "itn"
location_westeurope = "westeurope"


### Network

cidr_subnet_system_aks = ["10.3.1.0/24"]
cidr_subnet_user_aks   = ["10.3.2.0/24"]

### Monitor
monitor_italy_resource_group_name                 = "pagopa-u-itn-core-monitor-rg"
log_analytics_italy_workspace_name                = "pagopa-u-itn-core-law"
log_analytics_italy_workspace_resource_group_name = "pagopa-u-itn-core-monitor-rg"
monitor_appinsights_italy_name                    = "pagopa-u-itn-core-appinsights"

monitor_resource_group_name                 = "pagopa-u-monitor-rg"
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"
monitor_appinsights_name                    = "pagopa-u-appinsights"


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
  name            = "pauaksleosys",
  vm_size         = "Standard_D2ds_v5",
  os_disk_type    = "Ephemeral",
  os_disk_size_gb = 75,
  node_count_min  = 1,
  node_count_max  = 3,
  node_labels     = { node_name : "aks-uat01-sys", node_type : "system" },
  node_tags       = { node_tag_1 : "1" },
}
aks_user_node_pool = {
  enabled         = true,
  name            = "pauaksleousr",
  vm_size         = "Standard_D8ds_v5",
  os_disk_type    = "Ephemeral",
  os_disk_size_gb = 300,
  node_count_min  = 1,
  node_count_max  = 2,
  node_labels     = { node_name : "aks-uat01-user", node_type : "user" },
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
nginx_helm_version       = "4.14.2"

keda_helm_version    = "2.17.2"
enable_elastic_agent = false
