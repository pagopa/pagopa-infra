module "non_critical_node_pool" {
  source = "./.terraform/modules/__v4__/IDH/aks_node_pool"

  product_name      = var.prefix
  env               = var.env
  idh_resource_tier = "Standard_B4ms"

  name                  = "noncrit"
  kubernetes_cluster_id = module.aks_leonardo.id

  embedded_subnet = {
    enabled      = true
    vnet_name    = data.azurerm_virtual_network.vnet_ita.name
    vnet_rg_name = data.azurerm_virtual_network.vnet_ita.resource_group_name
    subnet_name  = "${local.project}-non-critical"
    natgw_id     = null
  }

  node_count_min = 1
  node_count_max = 1

  node_labels = {
    "critical" = "false"
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

  node_taints = [ "dedicated=nonCritical:NoSchedule" ]
  node_tags = module.tag_config.tags
  tags      = module.tag_config.tags
}
