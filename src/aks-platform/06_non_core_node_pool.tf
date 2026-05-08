
module "non_critical_node_pool" {
  source = "./.terraform/modules/__v4__/IDH/aks_node_pool"

  product_name      = var.prefix
  env               = var.env
  idh_resource_tier = var.non_critical_nodepool.idh_tier

  name                  = "noncrit"
  kubernetes_cluster_id = module.aks.id

  vnet_subnet_id = module.aks_snet.id


  node_count_min = var.non_critical_nodepool.min_size
  node_count_max = var.non_critical_nodepool.max_size

  node_taints = []
  node_labels = {
    node_type = "user"
  }

  double_node_pool = {
    enabled = true
    node_pool_foo = {
      active = true
    }
    node_pool_bar = {
      active = false
    }
  }

  node_tags = module.tag_config.tags
  tags      = module.tag_config.tags
}
