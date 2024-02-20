data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_subnet" "apim_vnet" {
  name                 = local.pagopa_apim_snet
  resource_group_name  = local.pagopa_vnet_rg
  virtual_network_name = local.pagopa_vnet_integration
}

# Subnet to host the payment wallet services
module "payment_wallet_services_snet" {
  source                                        = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.52.0"
  name                                          = "${local.project}-services-snet"
  address_prefixes                              = var.cidr_subnet_payment_wallet_services
  resource_group_name                           = local.vnet_resource_group_name
  virtual_network_name                          = local.vnet_name
  private_link_service_network_policies_enabled = true

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
