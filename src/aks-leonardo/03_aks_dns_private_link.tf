#
# Vnet Link
# vnet needs a vnet link with aks private dns zone
# aks terraform module doesn't export private dns zone


moved {
  from = azurerm_private_dns_zone_virtual_network_link.aks_dns_private_link_vs_vnet_core
  to   = azurerm_private_dns_zone_virtual_network_link.aks_dns_private_link_vs_vnet_ita
}


locals {
  # "pagopa-u-itn-uat-3arbio4v.e2d0397d-0af5-42b4-aaf1-e2e7956499a9.privatelink.italynorth.azmk8s.io"
  aks_fqdn_levels                   = length(split(".", module.aks_leonardo.private_fqdn))
  aks_managed_private_dns_zone_name = join(".", slice(split(".", module.aks_leonardo.private_fqdn), 1, local.aks_fqdn_levels))

}

resource "azurerm_private_dns_zone_virtual_network_link" "aks_dns_private_link_vs_vnet_ita" {
  count = var.aks_private_cluster_enabled ? 1 : 0

  name                  = data.azurerm_virtual_network.vnet_ita.name
  virtual_network_id    = data.azurerm_virtual_network.vnet_ita.id
  resource_group_name   = module.aks_leonardo.managed_resource_group_name #external.get_dns_zone[0].result["dns_zone_resource_group_name"]
  private_dns_zone_name = local.aks_managed_private_dns_zone_name         #data.external.get_dns_zone[0].result["dns_zone_name"]

  depends_on = [
    module.aks_leonardo,
  ]

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "aks_dns_private_link_vs_vnet_core_weu" {
  count = var.aks_private_cluster_enabled ? 1 : 0

  name                  = data.azurerm_virtual_network.vnet_core.name
  virtual_network_id    = data.azurerm_virtual_network.vnet_core.id
  resource_group_name   = module.aks_leonardo.managed_resource_group_name #data.external.get_dns_zone[0].result["dns_zone_resource_group_name"]
  private_dns_zone_name = local.aks_managed_private_dns_zone_name         #data.external.get_dns_zone[0].result["dns_zone_name"]

  depends_on = [
    module.aks_leonardo,
  ]

  tags = var.tags
}
