#
# Vnet Link
# vnet needs a vnet link with aks private dns zone
# aks terraform module doesn't export private dns zone

data "external" "get_dns_zone" {
  count = var.aks_private_cluster_enabled ? 1 : 0

  program = ["bash", "-c", <<-EOH
    dns_zone_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${module.aks[0].name}')].{name:name}")
    dns_zone_resource_group_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${module.aks[0].name}')].{resourceGroup:resourceGroup}")
    echo "{\"dns_zone_name\": \"$dns_zone_name\", \"dns_zone_resource_group_name\": \"$dns_zone_resource_group_name\"}"
  EOH
  ]
}

resource "azurerm_private_dns_zone_virtual_network_link" "aks_dns_private_link_vs_vnet_core" {
  count = var.aks_private_cluster_enabled ? 1 : 0

  name                  = data.azurerm_virtual_network.vnet_core.name
  virtual_network_id    = data.azurerm_virtual_network.vnet_core.id
  resource_group_name   = data.external.get_dns_zone[0].result["dns_zone_resource_group_name"]
  private_dns_zone_name = data.external.get_dns_zone[0].result["dns_zone_name"]

  depends_on = [
    module.aks,
    data.external.get_dns_zone
  ]
}

resource "azurerm_private_dns_zone_virtual_network_link" "aks_dns_private_link_vs_vnet_integration" {
  count = var.aks_private_cluster_enabled ? 1 : 0

  name                  = data.azurerm_virtual_network.vnet_integration.name
  virtual_network_id    = data.azurerm_virtual_network.vnet_integration.id
  resource_group_name   = data.external.get_dns_zone[0].result["dns_zone_resource_group_name"]
  private_dns_zone_name = data.external.get_dns_zone[0].result["dns_zone_name"]

  depends_on = [
    module.aks,
    data.external.get_dns_zone
  ]
}

resource "azurerm_private_dns_zone_virtual_network_link" "aks_dns_private_link_vs_vnet_pair" {
  count = var.aks_private_cluster_enabled ? 1 : 0

  name                  = data.azurerm_virtual_network.vnet_pair.name
  virtual_network_id    = data.azurerm_virtual_network.vnet_pair.id
  resource_group_name   = data.external.get_dns_zone[0].result["dns_zone_resource_group_name"]
  private_dns_zone_name = data.external.get_dns_zone[0].result["dns_zone_name"]

  depends_on = [
    module.aks,
    data.external.get_dns_zone
  ]
}


# # linking aks network to core vnet
# resource "null_resource" "create_vnet_core_aks_link" {

#   count = var.aks_enabled && var.aks_private_cluster_enabled ? 1 : 0
#   triggers = {
#     cluster_name = module.aks[0].name
#     vnet_id      = data.azurerm_virtual_network.vnet_core.id
#     vnet_name    = data.azurerm_virtual_network.vnet_core.name
#   }

#   provisioner "local-exec" {
#     command = <<EOT
#       dns_zone_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${self.triggers.cluster_name}')].{name:name}")
#       dns_zone_resource_group_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${self.triggers.cluster_name}')].{resourceGroup:resourceGroup}")
#       az network private-dns link vnet create \
#         --name ${self.triggers.vnet_name} \
#         --registration-enabled false \
#         --resource-group $dns_zone_resource_group_name \
#         --virtual-network ${self.triggers.vnet_id} \
#         --zone-name $dns_zone_name
#     EOT
#   }

#   provisioner "local-exec" {
#     when    = destroy
#     command = <<EOT
#       dns_zone_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${self.triggers.cluster_name}')].{name:name}")
#       dns_zone_resource_group_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${self.triggers.cluster_name}')].{resourceGroup:resourceGroup}")
#       az network private-dns link vnet delete \
#         --name ${self.triggers.vnet_name} \
#         --resource-group $dns_zone_resource_group_name \
#         --zone-name $dns_zone_name \
#         --yes
#     EOT
#   }

#   depends_on = [
#     module.aks
#   ]
# }

# # linking vnet AKS to vnet integration
# resource "null_resource" "create_vnet_integration_aks_link" {

#   count = var.aks_enabled && var.aks_private_cluster_enabled ? 1 : 0
#   triggers = {
#     cluster_name = module.aks[0].name
#     vnet_id      = data.azurerm_virtual_network.vnet_integration.id
#     vnet_name    = data.azurerm_virtual_network.vnet_integration.name
#   }

#   provisioner "local-exec" {
#     command = <<EOT
#       dns_zone_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${self.triggers.cluster_name}')].{name:name}")
#       dns_zone_resource_group_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${self.triggers.cluster_name}')].{resourceGroup:resourceGroup}")
#       az network private-dns link vnet create \
#         --name ${self.triggers.vnet_name} \
#         --registration-enabled false \
#         --resource-group $dns_zone_resource_group_name \
#         --virtual-network ${self.triggers.vnet_id} \
#         --zone-name $dns_zone_name
#     EOT
#   }

#   provisioner "local-exec" {
#     when    = destroy
#     command = <<EOT
#       dns_zone_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${self.triggers.cluster_name}')].{name:name}")
#       dns_zone_resource_group_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${self.triggers.cluster_name}')].{resourceGroup:resourceGroup}")
#       az network private-dns link vnet delete \
#         --name ${self.triggers.vnet_name} \
#         --resource-group $dns_zone_resource_group_name \
#         --zone-name $dns_zone_name \
#         --yes
#     EOT
#   }

#   depends_on = [
#     module.aks
#   ]
# }

# # linking vnet AKS to vnet pair
# resource "null_resource" "create_aks_dns_private_link_to_vnet_pair" {

#   count = var.aks_enabled && var.aks_private_cluster_enabled ? 1 : 0
#   triggers = {
#     cluster_name = module.aks[0].name
#     vnet_id      = data.azurerm_virtual_network.vnet_pair.id
#     vnet_name    = data.azurerm_virtual_network.vnet_pair.name
#   }

#   provisioner "local-exec" {
#     command = <<EOT
#       dns_zone_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${self.triggers.cluster_name}')].{name:name}")
#       dns_zone_resource_group_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${self.triggers.cluster_name}')].{resourceGroup:resourceGroup}")
#       az network private-dns link vnet create \
#         --name ${self.triggers.vnet_name} \
#         --registration-enabled false \
#         --resource-group $dns_zone_resource_group_name \
#         --virtual-network ${self.triggers.vnet_id} \
#         --zone-name $dns_zone_name
#     EOT
#   }

#   provisioner "local-exec" {
#     when    = destroy
#     command = <<EOT
#       dns_zone_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${self.triggers.cluster_name}')].{name:name}")
#       dns_zone_resource_group_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${self.triggers.cluster_name}')].{resourceGroup:resourceGroup}")
#       az network private-dns link vnet delete \
#         --name ${self.triggers.vnet_name} \
#         --resource-group $dns_zone_resource_group_name \
#         --zone-name $dns_zone_name \
#         --yes
#     EOT
#   }

#   depends_on = [
#     module.aks
#   ]
# }
