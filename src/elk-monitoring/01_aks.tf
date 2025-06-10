data "azurerm_kubernetes_cluster" "aks" {
  name                = local.aks_name
  resource_group_name = local.aks_resource_group_name
}

resource "azurerm_kubernetes_cluster_node_pool" "elastic" {
  kubernetes_cluster_id = data.azurerm_kubernetes_cluster.aks.id

  name = var.elastic_node_pool.name

  ### vm configuration
  vm_size = var.elastic_node_pool.vm_size
  # https://docs.microsoft.com/en-us/azure/virtual-machines/sizes-general
  os_disk_type    = var.elastic_node_pool.os_disk_type # Managed or Ephemeral
  os_disk_size_gb = var.elastic_node_pool.os_disk_size_gb
  zones           = ["1", "2", "3"]

  os_type = "Linux"

  ### autoscaling
  enable_auto_scaling = true
  #node_count          = var.elastic_node_pool.node_count_min
  min_count = var.elastic_node_pool.node_count_min
  max_count = var.elastic_node_pool.node_count_max

  ### K8s node configuration
  max_pods    = var.elastic_node_pool.elastic_pool_max_pods
  node_labels = var.elastic_node_pool.node_labels
  node_taints = var.elastic_node_pool.node_taints

  ### networking
  vnet_subnet_id        = data.azurerm_subnet.aks_snet.id
  enable_node_public_ip = false


  tags = merge(var.tags, var.elastic_node_pool.node_tags)

  lifecycle {
    ignore_changes = [
      node_count,
      upgrade_settings
    ]
  }

}
