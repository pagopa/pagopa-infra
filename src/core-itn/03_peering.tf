# resource "azurerm_virtual_network_peering" "peer_itn_to_cstar" {
#   name                      = "${local.product_ita}-vnet-to-cstar"
#   resource_group_name       = azurerm_resource_group.rg_ita_vnet.name
#   virtual_network_name      = module.vnet_italy.name
#   remote_virtual_network_id = "/subscriptions/${data.azurerm_key_vault_secret.cstar_subscription_id.value}/resourceGroups/${local.cstar_vnet_rg_name}/providers/Microsoft.Network/virtualNetworks/${local.cstar_vnet_name}"
# }
