resource "azurerm_resource_group" "rg_vnet" {
  name     = format("%s-vnet-rg", local.project)
  location = var.location

  tags = var.tags
}

locals {

  subnet_ids_ = [
    module.apim_snet.id,
    (var.api_config_enabled ? module.api_config_snet[0].id : ""),
    (var.eventhub_enabled ? module.eventhub_snet[0].id : ""),
  ]

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


  subnet_ids = [for s in local.subnet_ids_ : s if s != ""]

  # 1 - apim pagopa       → nodo sia                  -- 10.230.[8|9|10].0/24               --> test 185.91.56.142 (10.79.20.32) - prod 185.91.56.143 (10.79.20.34)
  # 2 - api config pagopa → db nodo sia               -- 10.230.[8|9|10].128/24             --> test xxx.xxx.xxx.xxx:

  # 3 - nodo sia          → api config pagopa         -- 10.79.55.23-24 e 10.79.51.23-24    --> 10.230.[8|9|10].128/24
  # 4 - nodo sia          → eventhub pagopa           -- 10.79.55.23-24 e 10.79.51.23-24    --> 10.230.[8|9|10].64/24 (porte 5671 5672 443)
  # 5 - logstash sia      → eventhub pagopa           -- xxx.xxx.xxx.xxx                    --> 10.230.[8|9|10].64/24 (porta 9093)
  # 6 - nodo sia          → apim pagopa               -- 10.79.55.23-24 e 10.79.51.23-24    --> 10.230.[8|9|10].0/24
  # 7 – xxx.xxx.xxx.xxx   → payment manager db        -- 


  routes = [
    #########
    ### prod
    #########
    {
      # db nodo
      name                   = "to-sia-db-nodo-prod-subnet"
      address_prefix         = "10.79.21.0/24" # SIA - todo #fixme
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.70.249.10" # SIA fixed
    },
    {
      # nodo dei pagamenti
      name                   = "to-sia-app-nodo-prod-subnet"
      address_prefix         = "10.79.20.0/24" # SIA 
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.70.249.10" # SIA 
    },
    #########
    ### uat
    #########
    # {
    #   # db nodo
    #   name                   = "to-sia-db-nodo-uat-subnet"
    #   address_prefix         = "10.79.21.0/24" # SIA - todo #fixme
    #   next_hop_type          = "VirtualAppliance"
    #   next_hop_in_ip_address = "10.70.249.10" # SIA 
    # },
    # {
    #   # nodo dei pagamenti
    #   name                   = "to-sia-app-nodo-uat-subnet"
    #   address_prefix         = "10.79.20.0/24" # SIA 
    #   next_hop_type          = "VirtualAppliance"
    #   next_hop_in_ip_address = "10.70.249.10" # SIA 
    # },
    #########
    ### dev
    #########
    {
      # db nodo
      name                   = "to-sia-db-nodo-dev-subnet"
      address_prefix         = "10.70.132.0/24" # SIA  - todo #fixme
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.70.249.10" # SIA 
    },
    {
      # app nodo
      name                   = "to-sia-app-nodo-dev-subnet"
      address_prefix         = "10.70.133.0/24" # SIA - todo #fixme
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.70.249.10" # SIA 
    },

  ]

  tags = var.tags
}



