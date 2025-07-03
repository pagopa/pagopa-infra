resource "azurerm_virtual_network_peering" "peer_cstar_integration_to_cstar_compute" {
  name                      = "${module.vnet_integration_cstar.name}-to-${local.cstar_vnet_name}"
  resource_group_name       = azurerm_resource_group.rg_ita_vnet.name
  virtual_network_name      = module.vnet_integration_cstar.name
  remote_virtual_network_id = "/subscriptions/${data.azurerm_key_vault_secret.cstar_subscription_id.value}/resourceGroups/${local.cstar_vnet_rg_name}/providers/Microsoft.Network/virtualNetworks/${local.cstar_vnet_name}"
}

resource "azurerm_virtual_network_peering" "peer_cstar_integration_to_cstar_weu" {
  name                      = "${module.vnet_integration_cstar.name}-to-${local.cstar_weu_vnet_name}"
  resource_group_name       = azurerm_resource_group.rg_ita_vnet.name
  virtual_network_name      = module.vnet_integration_cstar.name
  remote_virtual_network_id = "/subscriptions/${data.azurerm_key_vault_secret.cstar_subscription_id.value}/resourceGroups/${local.cstar_weu_vnet_rg_name}/providers/Microsoft.Network/virtualNetworks/${local.cstar_weu_vnet_name}"
}
