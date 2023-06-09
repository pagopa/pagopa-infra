# Subnet to host canone unico function
module "canoneunico_function_snet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.15.0"
  name                                      = "${local.project}-canoneunico-snet"
  address_prefixes                          = var.cidr_subnet_canoneunico_common
  resource_group_name                       = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name                      = data.azurerm_virtual_network.vnet.name
  private_endpoint_network_policies_enabled = var.private_endpoint_network_policies_enabled

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
