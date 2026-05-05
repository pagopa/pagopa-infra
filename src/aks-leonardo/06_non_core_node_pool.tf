
module "non_critical_node_pool" {
  source = "./.terraform/modules/__v4__/IDH/aks_node_pool"

  product_name      = var.prefix
  env               = var.env
  idh_resource_tier = var.non_critical_nodepool.idh_tier

  name                  = "noncrit"
  kubernetes_cluster_id = module.aks_leonardo.id

  embedded_subnet = {
    enabled      = true
    vnet_name    = data.azurerm_virtual_network.vnet_ita.name
    vnet_rg_name = data.azurerm_virtual_network.vnet_ita.resource_group_name
    subnet_name  = "${local.project}-non-critical"
    natgw_id     = null
  }

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
