resource "azurerm_resource_group" "aks_rg" {
  name     = "${local.project}-aks-rg"
  location = var.location

  tags = module.tag_config.tags
}


module "aks" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_cluster?ref=v8.90.0"

  name                       = local.aks_name
  location                   = var.location
  dns_prefix                 = local.project
  resource_group_name        = azurerm_resource_group.aks_rg.name
  kubernetes_version         = var.aks_kubernetes_version
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics.id
  sku_tier                   = var.aks_sku_tier

  workload_identity_enabled = var.aks_enable_workload_identity
  oidc_issuer_enabled       = var.aks_enable_workload_identity

  ## Prometheus managed
  # ffppa: ⚠️ Installed on all ENV please do not change
  enable_prometheus_monitor_metrics = true

  # ffppa: Enabled cost analysis on UAT/PROD
  cost_analysis_enabled = var.env_short != "d" ? true : false

  automatic_channel_upgrade = null
  node_os_channel_upgrade   = "None"
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
  # 👤 User node pool
  #
  user_node_pool_enabled = var.aks_user_node_pool.enabled
  user_node_pool_name    = var.aks_user_node_pool.name
  ### vm configuration
  user_node_pool_vm_size         = var.aks_user_node_pool.vm_size
  user_node_pool_os_disk_type    = var.aks_user_node_pool.os_disk_type
  user_node_pool_os_disk_size_gb = var.aks_user_node_pool.os_disk_size_gb
  user_node_pool_node_count_min  = var.aks_user_node_pool.node_count_min
  user_node_pool_node_count_max  = var.aks_user_node_pool.node_count_max
  ### K8s node configuration
  user_node_pool_node_labels = var.aks_user_node_pool.node_labels
  user_node_pool_node_taints = var.aks_user_node_pool.node_taints
  user_node_pool_tags        = var.aks_user_node_pool.node_tags
  # end user node pool

  #
  # ☁️ Network
  #
  vnet_id        = data.azurerm_virtual_network.vnet.id
  vnet_subnet_id = module.aks_snet.id

  outbound_ip_address_ids = azurerm_public_ip.aks_outbound.*.id
  private_cluster_enabled = var.aks_private_cluster_is_enabled
  network_profile = {
    docker_bridge_cidr = "172.17.0.1/16"
    dns_service_ip     = "10.2.0.10"
    network_plugin     = "azure"
    network_policy     = "azure"
    outbound_type      = "loadBalancer"
    service_cidr       = "10.2.0.0/16"
  }
  # end network

  aad_admin_group_ids = var.env_short == "p" ? [data.azuread_group.adgroup_admin.object_id] : [data.azuread_group.adgroup_admin.object_id, data.azuread_group.adgroup_developers.object_id, data.azuread_group.adgroup_externals.object_id, data.azuread_group.adgroup_developer_externals.object_id]

  addon_azure_policy_enabled                     = true
  addon_azure_key_vault_secrets_provider_enabled = true
  addon_azure_pod_identity_enabled               = true

  alerts_enabled     = var.aks_alerts_enabled
  custom_logs_alerts = local.aks_logs_alerts

  # takes a list and replaces any elements that are lists with a
  # flattened sequence of the list contents.
  # In this case, we enable OpsGenie only on prod env
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

  microsoft_defender_log_analytics_workspace_id = var.env == "prod" ? data.azurerm_log_analytics_workspace.log_analytics.id : null

  tags = module.tag_config.tags
}

data "azurerm_container_registry" "acr" {
  name                = local.acr_name
  resource_group_name = local.acr_resource_group_name
}

# add the role to the identity the kubernetes cluster was assigned
resource "azurerm_role_assignment" "aks_to_acr" {
  scope                = data.azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = module.aks.kubelet_identity_id
}
