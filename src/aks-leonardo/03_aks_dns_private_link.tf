#
# Vnet Link
# vnet needs a vnet link with aks private dns zone
# aks terraform module doesn't export private dns zone


moved {
  from = azurerm_private_dns_zone_virtual_network_link.aks_dns_private_link_vs_vnet_core
  to   = azurerm_private_dns_zone_virtual_network_link.aks_dns_private_link_vs_vnet_ita
}

resource "azurerm_private_dns_zone_virtual_network_link" "aks_dns_private_link_vs_vnet_ita" {
  count = var.aks_private_cluster_enabled ? 1 : 0

  name                  = data.azurerm_virtual_network.vnet_ita.name
  virtual_network_id    = data.azurerm_virtual_network.vnet_ita.id
  resource_group_name   = module.aks_leonardo.managed_resource_group_name
  private_dns_zone_name = module.aks_leonardo.managed_private_dns_zone_name

  depends_on = [
    module.aks_leonardo,
  ]

  tags = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "aks_dns_private_link_vs_vnet_core_weu" {
  count = var.aks_private_cluster_enabled ? 1 : 0

  name                  = data.azurerm_virtual_network.vnet_core.name
  virtual_network_id    = data.azurerm_virtual_network.vnet_core.id
  resource_group_name   = module.aks_leonardo.managed_resource_group_name
  private_dns_zone_name = module.aks_leonardo.managed_private_dns_zone_name

  depends_on = [
    module.aks_leonardo,
  ]

  tags = module.tag_config.tags
}

# Virtual Network Link for Hub - Spoke Network
resource "azurerm_private_dns_zone_virtual_network_link" "aks_dns_private_link_vs_vnet_hub_spoke" {
  for_each = var.aks_private_cluster_enabled ? data.azurerm_virtual_network.vnet_hub_spoke : {}

  name                  = each.value.name
  virtual_network_id    = each.value.id
  resource_group_name   = module.aks_leonardo.managed_resource_group_name
  private_dns_zone_name = module.aks_leonardo.managed_private_dns_zone_name

  depends_on = [
    module.aks_leonardo,
  ]

  tags = module.tag_config.tags
}