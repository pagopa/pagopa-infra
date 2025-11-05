data "azurerm_kubernetes_cluster" "aks" {
  name                = local.aks_name
  resource_group_name = local.aks_resource_group_name
}

resource "azurerm_kubernetes_cluster_node_pool" "user_nodepool_pay_wallet" {

  kubernetes_cluster_id = data.azurerm_kubernetes_cluster.aks.id

  name = var.aks_user_node_pool.name

  ### vm configuration
  vm_size = var.aks_user_node_pool.vm_size
  # https://docs.microsoft.com/en-us/azure/virtual-machines/sizes-general
  os_disk_type            = var.aks_user_node_pool.os_disk_type # Managed or Ephemeral
  os_disk_size_gb         = var.aks_user_node_pool.os_disk_size_gb
  zones                   = var.aks_user_node_pool.zones
  ultra_ssd_enabled       = var.aks_user_node_pool.ultra_ssd_enabled
  host_encryption_enabled = var.aks_user_node_pool.enable_host_encryption
  os_type                 = "Linux"

  ### autoscaling
  auto_scaling_enabled = true
  node_count           = var.aks_user_node_pool.node_count_min
  min_count            = var.aks_user_node_pool.node_count_min
  max_count            = var.aks_user_node_pool.node_count_max

  ### K8s node configuration
  max_pods    = var.aks_user_node_pool.max_pods
  node_labels = var.aks_user_node_pool.node_labels
  node_taints = var.aks_user_node_pool.node_taints

  ### networking
  vnet_subnet_id         = azurerm_subnet.pay_wallet_user_aks_subnet.id
  node_public_ip_enabled = false

  upgrade_settings {
    max_surge                     = var.aks_user_node_pool.upgrade_settings_max_surge
    drain_timeout_in_minutes      = 30
    node_soak_duration_in_minutes = 0
  }

  tags = merge(module.tag_config.tags, var.aks_user_node_pool.node_tags)

  lifecycle {
    ignore_changes = [
      node_count
    ]
  }
}
