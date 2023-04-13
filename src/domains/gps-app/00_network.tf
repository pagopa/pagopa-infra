data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_subnet" "apim_vnet" {
  name                 = local.pagopa_apim_snet
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.pagopa_vnet_integration
}

# Subnet to host ecommerce transactions function
module "reporting_function_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v4.3.2"
  name                                           = "${local.project}-reporting-fn-snet"
  address_prefixes                               = var.cidr_subnet_reporting_functions
  resource_group_name                            = local.vnet_resource_group_name
  virtual_network_name                           = data.azurerm_virtual_network.vnet.name
  enforce_private_link_endpoint_network_policies = true

  service_endpoints = [
    "Microsoft.Web",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
