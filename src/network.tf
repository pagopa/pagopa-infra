resource "azurerm_resource_group" "rg_vnet" {
  name     = format("%s-vnet-rg", local.project)
  location = var.location

  tags = var.tags
}

# vnet integration
module "vnet_integration" {
  source              = "git::https://github.com/pagopa/azurerm.git//virtual_network?ref=v1.0.26"
  name                = format("%s-integration-vnet", local.project)
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  address_space       = var.cidr_integration_vnet

  tags = var.tags
}

module "vnet" {
  source              = "git::https://github.com/pagopa/azurerm.git//virtual_network?ref=v1.0.7"
  name                = format("%s-vnet", local.project)
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  address_space       = var.cidr_vnet

  tags = var.tags

}

module "vnet_app" {
  source              = "git::https://github.com/pagopa/azurerm.git//virtual_network?ref=v1.0.7"
  name                = format("%s-vnetapi", local.project)
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  address_space       = var.cidr_vnet_app

  tags = var.tags

}

# APIM subnet
module "apim_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.7"
  name                 = format("%s-apim-snet", local.project)
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet_integration.name
  address_prefixes     = var.cidr_subnet_apim

  service_endpoints = ["Microsoft.Web"]

  enforce_private_link_endpoint_network_policies = true
}

## Database subnet
module "redis_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.7"
  count                = var.redis_sku_name == "Premium" && length(var.cidr_subnet_redis) > 0 ? 1 : 0
  name                 = format("%s-redis-snet", local.project)
  address_prefixes     = var.cidr_subnet_redis
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet.name
}


# appservice_snet subnet 
module "appservice_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.7"
  name                                           = format("%s-appservice-snet", local.project)
  address_prefixes                               = var.cidr_subnet_appservice
  resource_group_name                            = azurerm_resource_group.rg_vnet.name

  virtual_network_name                           = module.vnet.name
  enforce_private_link_endpoint_network_policies = true
#   delegation = {
#     name = "delegation"
#     service_delegation = {
#       name    = "Microsoft.ContainerInstance/containerGroups"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
#     }
#   }

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }  

}


