data "azurerm_kubernetes_cluster" "aks" {
  name                = local.aks_name
  resource_group_name = local.aks_resource_group_name
}

locals {
  aks_api_url = var.env_short == "d" ? data.azurerm_kubernetes_cluster.aks.fqdn : data.azurerm_kubernetes_cluster.aks.private_fqdn
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "aks_apiserver_url" {
  name         = "${local.aks_name}-apiserver-url"
  value        = "https://${local.aks_api_url}:443"
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_kubernetes_cluster_node_pool" "nodo_pool" {

  kubernetes_cluster_id = data.azurerm_kubernetes_cluster.aks.id

  name = var.nodo_user_node_pool.name

  ### vm configuration
  vm_size = var.nodo_user_node_pool.vm_size
  # https://docs.microsoft.com/en-us/azure/virtual-machines/sizes-general
  os_disk_type    = var.nodo_user_node_pool.os_disk_type # Managed or Ephemeral
  os_disk_size_gb = var.nodo_user_node_pool.os_disk_size_gb
  zones           = ["1", "2", "3"]

  os_type = "Linux"

  ### autoscaling
  enable_auto_scaling = true
  node_count          = var.nodo_user_node_pool.node_count_min
  min_count           = var.nodo_user_node_pool.node_count_min
  max_count           = var.nodo_user_node_pool.node_count_max

  ### K8s node configuration
  max_pods    = var.nodo_user_node_pool.nodo_pool_max_pods
  node_labels = var.nodo_user_node_pool.node_labels
  node_taints = var.nodo_user_node_pool.node_taints

  ### networking
  vnet_subnet_id        = data.azurerm_subnet.aks_snet.id
  enable_node_public_ip = false

  upgrade_settings {
    max_surge                     = "50%"
    drain_timeout_in_minutes      = 30
    node_soak_duration_in_minutes = 0
  }

  tags = merge(module.tag_config.tags, var.nodo_user_node_pool.node_tags)

}
