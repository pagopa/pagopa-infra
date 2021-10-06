resource "azurerm_resource_group" "rg_vnet" {
  name     = format("%s-vnet-rg", local.project)
  location = var.location

  tags = var.tags
}

# vnet
module "vnet" {
  source              = "git::https://github.com/pagopa/azurerm.git//virtual_network?ref=v1.0.51"
  name                = format("%s-vnet", local.project)
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  address_space       = var.cidr_vnet

  tags = var.tags
}

# vnet integration
module "vnet_integration" {
  source              = "git::https://github.com/pagopa/azurerm.git//virtual_network?ref=v1.0.51"
  name                = format("%s-vnet-integration", local.project)
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  address_space       = var.cidr_vnet_integration

  tags = var.tags
}

## Peering between the vnet(main) and integration vnet 
module "vnet_peering" {
  source = "git::https://github.com/pagopa/azurerm.git//virtual_network_peering?ref=v1.0.30"

  location = azurerm_resource_group.rg_vnet.location

  source_resource_group_name       = azurerm_resource_group.rg_vnet.name
  source_virtual_network_name      = module.vnet.name
  source_remote_virtual_network_id = module.vnet.id
  source_allow_gateway_transit     = true # needed by vpn gateway for enabling routing from vnet to vnet_integration
  target_resource_group_name       = azurerm_resource_group.rg_vnet.name
  target_virtual_network_name      = module.vnet_integration.name
  target_remote_virtual_network_id = module.vnet_integration.id
  target_use_remote_gateways       = false # needed by vnet peering with SIA
}


module "route_table_peering_sia" {
  source = "git::https://github.com/pagopa/azurerm.git//route_table?ref=v1.0.25"

  name                          = format("%s-sia-rt", local.project)
  location                      = azurerm_resource_group.rg_vnet.location
  resource_group_name           = azurerm_resource_group.rg_vnet.name
  disable_bgp_route_propagation = false

  subnet_ids = [module.apim_snet.id, (var.api_config_enabled ? module.api_config_snet[0].id : null)]

  routes = [{
    # production
    name                   = "to-sia-prod-subnet"
    address_prefix         = "10.70.132.0/24"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.70.249.10"
    },
    {
      # uat
      name                   = "to-sia-uat-subnet"
      address_prefix         = "10.70.67.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.70.249.10"
    },
    {
      # dev
      name                   = "to-sia-dev-subnet"
      address_prefix         = "10.70.65.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.70.249.10"
    },
  ]

  tags = var.tags
}