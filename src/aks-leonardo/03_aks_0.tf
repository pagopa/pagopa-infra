#--------------------------------------------------------------------------------------------------
resource "azurerm_resource_group" "rg_aks" {
  name     = local.aks_rg_name
  location = var.location
  tags     = module.tag_config.tags
}

module "aks_leonardo" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_cluster?ref=v8.90.0"

  name                       = local.aks_cluster_name
  location                   = var.location
  dns_prefix                 = local.project
  resource_group_name        = azurerm_resource_group.rg_aks.name
  kubernetes_version         = var.aks_kubernetes_version
  log_analytics_workspace_id = var.env_short != "d" ? data.azurerm_log_analytics_workspace.log_analytics_italy.id : data.azurerm_log_analytics_workspace.log_analytics.id
  sku_tier                   = var.aks_sku_tier

  ## Prometheus managed
  # ffppa: ⚠️ Installed on all ENV please do not change
  enable_prometheus_monitor_metrics = true

  # ff: Enabled cost analysis on UAT/PROD
  cost_analysis_enabled = var.env_short != "d" ? true : false

  automatic_channel_upgrade = "node-image"
  node_os_channel_upgrade   = "NodeImage"
  maintenance_windows_node_os = {
    enabled = true
  }

  #
  # 🤖 System node pool
  #
  system_node_pool_name = var.aks_system_node_pool.name
  ### vm configuration
  system_node_pool_vm_size         = var.aks_system_node_pool.vm_size
  system_node_pool_os_disk_type    = var.aks_system_node_pool.os_disk_type
  system_node_pool_os_disk_size_gb = var.aks_system_node_pool.os_disk_size_gb
  system_node_pool_node_count_min  = var.aks_system_node_pool.node_count_min
  system_node_pool_node_count_max  = var.aks_system_node_pool.node_count_max
  ### K8s node configuration
  system_node_pool_only_critical_addons_enabled = var.aks_system_node_pool.only_critical_addons_enabled
  system_node_pool_node_labels                  = var.aks_system_node_pool.node_labels
  system_node_pool_tags                         = var.aks_system_node_pool.node_tags

  #
  # ☁️ Network
  #
  vnet_id        = data.azurerm_virtual_network.vnet_ita.id
  vnet_subnet_id = azurerm_subnet.system_aks_subnet.id

  outbound_ip_address_ids = data.azurerm_public_ip.pip_aks_outboud.*.id
  private_cluster_enabled = var.aks_private_cluster_enabled
  network_profile = {
    docker_bridge_cidr  = "172.17.0.1/16"
    dns_service_ip      = "10.0.0.10"
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy      = "azure"
    outbound_type       = "loadBalancer"
    service_cidr        = "10.0.0.0/16"
  }
  # end network

  aad_admin_group_ids = var.env_short == "p" ? [data.azuread_group.adgroup_admin.object_id] : [data.azuread_group.adgroup_admin.object_id, data.azuread_group.adgroup_developers.object_id, data.azuread_group.adgroup_externals.object_id]

  addon_azure_policy_enabled                     = true
  addon_azure_key_vault_secrets_provider_enabled = true
  addon_azure_pod_identity_enabled               = true
  workload_identity_enabled                      = var.aks_enable_workload_identity
  oidc_issuer_enabled                            = var.aks_enable_workload_identity


  alerts_enabled = var.aks_alerts_enabled
  # custom_metric_alerts = local.aks_metrics_alerts
  custom_logs_alerts = local.aks_logs_alerts

  action = flatten([
    [
      {
        action_group_id    = data.azurerm_monitor_action_group.slack.id
        webhook_properties = null
      },
      {
        action_group_id    = data.azurerm_monitor_action_group.email.id
        webhook_properties = null
      }
    ],
    (var.env == "prod" ? [
      {
        action_group_id    = data.azurerm_monitor_action_group.opsgenie.0.id
        webhook_properties = null
      }
    ] : [])
  ])

  microsoft_defender_log_analytics_workspace_id = var.env == "prod" ? data.azurerm_log_analytics_workspace.log_analytics_italy.id : null

  tags = module.tag_config.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "user_nodepool_default" {
  count = var.aks_user_node_pool.enabled ? 1 : 0

  kubernetes_cluster_id = module.aks_leonardo.id

  name = var.aks_user_node_pool.name

  ### vm configuration
  vm_size = var.aks_user_node_pool.vm_size
  # https://docs.microsoft.com/en-us/azure/virtual-machines/sizes-general
  os_disk_type           = var.aks_user_node_pool.os_disk_type # Managed or Ephemeral
  os_disk_size_gb        = var.aks_user_node_pool.os_disk_size_gb
  zones                  = var.aks_user_node_pool.zones
  ultra_ssd_enabled      = var.aks_user_node_pool.ultra_ssd_enabled
  enable_host_encryption = var.aks_user_node_pool.enable_host_encryption
  os_type                = "Linux"

  ### autoscaling
  enable_auto_scaling = true
  node_count          = var.aks_user_node_pool.node_count_min
  min_count           = var.aks_user_node_pool.node_count_min
  max_count           = var.aks_user_node_pool.node_count_max

  ### K8s node configuration
  max_pods    = var.aks_user_node_pool.max_pods
  node_labels = var.aks_user_node_pool.node_labels
  node_taints = var.aks_user_node_pool.node_taints

  ### networking
  vnet_subnet_id        = azurerm_subnet.user_aks_subnet.id
  enable_node_public_ip = false

  upgrade_settings {
    max_surge = var.aks_user_node_pool.upgrade_settings_max_surge
  }

  tags = merge(module.tag_config.tags, var.aks_user_node_pool.node_tags)

  lifecycle {
    ignore_changes = [
      node_count
    ]
  }
}

#
# Pod identity permissions
#
resource "azurerm_role_assignment" "managed_identity_operator_vs_aks_managed_identity" {
  scope                = azurerm_resource_group.rg_aks.id
  role_definition_name = "Managed Identity Operator"
  principal_id         = module.aks_leonardo.identity_principal_id
}

#
# 📦 ACR
#
data "azurerm_container_registry" "acr" {
  name                = local.acr_name_ita
  resource_group_name = local.acr_resource_group_name_ita
}

# add the role to the identity the kubernetes cluster was assigned
resource "azurerm_role_assignment" "aks_to_acr" {
  scope                = data.azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = module.aks_leonardo.kubelet_identity_id
}
