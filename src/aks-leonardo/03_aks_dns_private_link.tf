#
# Vnet Link
# vnet needs a vnet link with aks private dns zone
# aks terraform module doesn't export private dns zone

data "external" "get_dns_zone" {
  count = var.aks_private_cluster_enabled ? 1 : 0
  depends_on = [module.aks_leonardo]
  program = ["bash", "-c", <<-EOH
    dns_zone_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${module.aks_leonardo.name}')].{name:name}")
    dns_zone_resource_group_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${module.aks_leonardo.name}')].{resourceGroup:resourceGroup}")
    echo "{\"dns_zone_name\": \"$dns_zone_name\", \"dns_zone_resource_group_name\": \"$dns_zone_resource_group_name\"}"
  EOH
  ]
}

moved {
  from = azurerm_private_dns_zone_virtual_network_link.aks_dns_private_link_vs_vnet_core
  to   = azurerm_private_dns_zone_virtual_network_link.aks_dns_private_link_vs_vnet_ita
}

resource "azurerm_private_dns_zone_virtual_network_link" "aks_dns_private_link_vs_vnet_ita" {
  count = var.aks_private_cluster_enabled ? 1 : 0

  name                  = data.azurerm_virtual_network.vnet_ita.name
  virtual_network_id    = data.azurerm_virtual_network.vnet_ita.id
  resource_group_name   = data.external.get_dns_zone[0].result["dns_zone_resource_group_name"]
  private_dns_zone_name = data.external.get_dns_zone[0].result["dns_zone_name"]

  depends_on = [
    module.aks_leonardo,
    data.external.get_dns_zone
  ]
}

resource "azurerm_private_dns_zone_virtual_network_link" "aks_dns_private_link_vs_vnet_core_weu" {
  count = var.aks_private_cluster_enabled ? 1 : 0

  name                  = data.azurerm_virtual_network.vnet_core.name
  virtual_network_id    = data.azurerm_virtual_network.vnet_core.id
  resource_group_name   = data.external.get_dns_zone[0].result["dns_zone_resource_group_name"]
  private_dns_zone_name = data.external.get_dns_zone[0].result["dns_zone_name"]

  depends_on = [
    module.aks_leonardo,
    data.external.get_dns_zone
  ]
}
