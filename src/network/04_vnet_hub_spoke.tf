resource "azurerm_resource_group" "hub_spoke_rg" {
  location = var.location_hub_spoke
  name     = "${local.project_hub_spoke}-hub-spoke-rg"
}

# hub and spoke vnets
module "vnet_hub_spoke" {
  source   = "./.terraform/modules/__v4__/virtual_network"
  for_each = local.hub_spoke_vnet


  address_space       = [data.azurerm_key_vault_secret.vnet_address_space[each.key].value]
  location            = var.location_hub_spoke
  name                = "${local.product_location_hub_spoke}-${each.key}-vnet"
  resource_group_name = azurerm_resource_group.hub_spoke_rg.name
  tags                = module.tag_config.tags

  ddos_protection_plan = var.vnet_ita_ddos_protection_plan
}

# Peering between Hub and Spoke VNETs
locals {
  # generate list of peerings to create with format "source-target"
  peerings_to_create = toset(flatten([
    for vnet_k, vnet in local.hub_spoke_vnet : [for peered in vnet.peer_with : "${vnet_k}#${peered}"]
  ]))
}

module "vnet_hub_spoke_peering" {
  source                           = "./.terraform/modules/__v4__/virtual_network_peering"
  for_each                         = local.peerings_to_create
  source_resource_group_name       = azurerm_resource_group.hub_spoke_rg.name
  source_virtual_network_name      = module.vnet_hub_spoke[split("#", each.key)[0]].name
  source_remote_virtual_network_id = module.vnet_hub_spoke[split("#", each.key)[0]].id
  source_use_remote_gateways       = false
  source_allow_forwarded_traffic   = true
  source_allow_gateway_transit     = true

  target_resource_group_name       = azurerm_resource_group.hub_spoke_rg.name
  target_virtual_network_name      = module.vnet_hub_spoke[split("#", each.key)[1]].name
  target_remote_virtual_network_id = module.vnet_hub_spoke[split("#", each.key)[1]].id
  target_allow_gateway_transit     = true
  target_allow_forwarded_traffic   = true
}

# peerings to weu fe vnet
module "vnet_weu_fe_peering" {
  source                           = "./.terraform/modules/__v4__/virtual_network_peering"
  for_each                         = local.hub_spoke_vnet
  source_resource_group_name       = azurerm_resource_group.hub_spoke_rg.name
  source_virtual_network_name      = module.vnet_hub_spoke[each.key].name
  source_remote_virtual_network_id = module.vnet_hub_spoke[each.key].id
  source_use_remote_gateways       = false
  source_allow_forwarded_traffic   = true
  source_allow_gateway_transit     = true

  target_resource_group_name       = local.vnet_integration_resource_group_name
  target_virtual_network_name      = data.azurerm_virtual_network.vnet_weu_fe.name
  target_remote_virtual_network_id = data.azurerm_virtual_network.vnet_weu_fe.id
  target_allow_gateway_transit     = true
  target_allow_forwarded_traffic   = true
}

# peerings to itn compute vnet
module "vnet_itn_compute_peering" {
  source                           = "./.terraform/modules/__v4__/virtual_network_peering"
  for_each                         = local.hub_spoke_vnet
  source_resource_group_name       = azurerm_resource_group.hub_spoke_rg.name
  source_virtual_network_name      = module.vnet_hub_spoke[each.key].name
  source_remote_virtual_network_id = module.vnet_hub_spoke[each.key].id
  source_use_remote_gateways       = false
  source_allow_forwarded_traffic   = true
  source_allow_gateway_transit     = true

  target_resource_group_name       = local.vnet_italy_resource_group_name
  target_virtual_network_name      = data.azurerm_virtual_network.vnet_itn_compute.name
  target_remote_virtual_network_id = data.azurerm_virtual_network.vnet_itn_compute.id
  target_allow_gateway_transit     = true
  target_allow_forwarded_traffic   = true
}

# peerings to weu vnet
module "vnet_weu_core_peering" {
  source                           = "./.terraform/modules/__v4__/virtual_network_peering"
  for_each                         = local.hub_spoke_vnet
  source_resource_group_name       = azurerm_resource_group.hub_spoke_rg.name
  source_virtual_network_name      = module.vnet_hub_spoke[each.key].name
  source_remote_virtual_network_id = module.vnet_hub_spoke[each.key].id
  source_use_remote_gateways       = true
  source_allow_forwarded_traffic   = true
  source_allow_gateway_transit     = false

  target_resource_group_name       = local.vnet_core_resource_group_name
  target_virtual_network_name      = data.azurerm_virtual_network.vnet_weu_core.name
  target_remote_virtual_network_id = data.azurerm_virtual_network.vnet_weu_core.id
  target_allow_gateway_transit     = true
  target_allow_forwarded_traffic   = true
  target_use_remote_gateways       = false
}
