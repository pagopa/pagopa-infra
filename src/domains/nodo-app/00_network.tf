data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group_name
}
module "aks_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.12.0"
  name                                           = "${local.project}-aks-snet"
  address_prefixes                               = var.aks_cidr_subnet
  resource_group_name                            = data.azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name                           = data.azurerm_virtual_network.vnet.name
  enforce_private_link_endpoint_network_policies = true
}