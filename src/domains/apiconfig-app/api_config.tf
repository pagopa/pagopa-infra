resource "azurerm_resource_group" "api_config_rg" {
  name     = format("%s-api-config-rg", local.product)
  location = var.location

  tags = module.tag_config.tags
}

locals {
  apiconfig_cors_configuration = {
    origins = ["*"]
    methods = ["*"]
  }
}

# Subnet to host the api config
module "api_config_snet" {
  count  = var.cidr_subnet_api_config != null ? 1 : 0
  source = "./.terraform/modules/__v3__/subnet"

  name                                      = format("%s-api-config-snet", local.product)
  address_prefixes                          = var.cidr_subnet_api_config
  resource_group_name                       = data.azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name                      = format("%s-vnet-integration", local.product)
  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
