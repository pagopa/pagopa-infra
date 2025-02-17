# Global vnet

data "azurerm_resource_group" "rg_vnet" {
  name = format("%s-vnet-rg", local.parent_project)
}

data "azurerm_virtual_network" "vnet" {
  name                = format("%s-vnet", local.parent_project)
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}

# Integration vnet

data "azurerm_virtual_network" "vnet_integration" {
  name                = format("%s-vnet-integration", local.parent_project)
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}

# APIM subnet

data "azurerm_subnet" "apim_snet" {
  name                 = format("%s-apim-snet", local.parent_project)
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = data.azurerm_virtual_network.vnet_integration.name
}

# APIM

data "azurerm_resource_group" "rg_api" {
  name = format("%s-api-rg", local.parent_project)
}

data "azurerm_api_management" "apim" {
  name                = format("%s-apim", local.parent_project)
  resource_group_name = data.azurerm_resource_group.rg_api.name
}

# DevOps Agent subnet

data "azurerm_subnet" "azdoa_snet" {
  name                 = format("%s-azdoa-snet", local.parent_project)
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}

# pagopa-proxy Redis subnet

data "azurerm_subnet" "pagopa_proxy_redis_snet" {
  name                 = format("%s-pagopa-proxy-redis-snet", local.parent_project)
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}

# pagopa-proxy subnet

module "pagopa_proxy_snet" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.42.3"
  name                 = format("%s-pagopa-proxy-snet", local.parent_project)
  address_prefixes     = var.cidr_subnet_pagopa_proxy
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name

  private_endpoint_network_policies_enabled = false

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "pagopa_proxy_snet_ha" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.42.3"
  name                 = format("%s-pagopa-proxy-ha-snet", local.parent_project)
  address_prefixes     = var.cidr_subnet_pagopa_proxy_ha
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name

  private_endpoint_network_policies_enabled = false

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
