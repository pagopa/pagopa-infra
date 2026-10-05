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


module "foo_bar_paywallet_node_pool" {
  source = "./.terraform/modules/__v4__/IDH/aks_node_pool"
  count  = var.aks_foobar_paywallet_node_pool_configuration.enabled ? 1 : 0

  product_name      = var.prefix
  env               = var.env
  idh_resource_tier = var.aks_foobar_paywallet_node_pool_configuration.tier

  os_disk_type    = var.aks_foobar_paywallet_node_pool_configuration.os_disk_type
  os_disk_size_gb = var.aks_foobar_paywallet_node_pool_configuration.os_disk_size_gb


  name                  = var.aks_foobar_paywallet_node_pool_configuration.name
  kubernetes_cluster_id = data.azurerm_kubernetes_cluster.aks.id
  vnet_subnet_id        = azurerm_subnet.pay_wallet_user_aks_subnet.id


  node_count_min = var.aks_foobar_paywallet_node_pool_configuration.node_count_min
  node_count_max = var.aks_foobar_paywallet_node_pool_configuration.node_count_max

  max_pods = var.aks_foobar_paywallet_node_pool_configuration.max_pods



  double_node_pool = {
    enabled = true
    node_pool_foo = {
      active = true
    }
    node_pool_bar = {
      active = false
    }
  }

  autoscale_enabled = true

  node_labels = var.aks_foobar_paywallet_node_pool_configuration.node_labels
  node_tags   = var.aks_foobar_paywallet_node_pool_configuration.node_tags
  node_taints = var.aks_foobar_paywallet_node_pool_configuration.node_taints
  tags        = merge(module.tag_config.tags, var.aks_foobar_paywallet_node_pool_configuration.node_tags)
}
