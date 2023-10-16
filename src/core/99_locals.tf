locals {
  apim_x_node_product_id = "apim_for_node"
  vpn_pair_enabled       = var.vnet_pair_linking_enabled && var.pair_vpn_enabled && var.env_short != "d"
}
