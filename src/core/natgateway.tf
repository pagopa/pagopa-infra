locals {
  subnet_in_nat_gw_ids = [
    module.node_forwarder_snet.id # pagopa-node-forwarder ( aka GAD replacemnet )
  ]
}

module "nat_gw" {
  count  = var.nat_gateway_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//nat_gateway?ref=v1.0.90"

  name                = format("%s-natgw", local.project)
  resource_group_name = azurerm_resource_group.rg_vnet.name
  location            = azurerm_resource_group.rg_vnet.location
  public_ips_count    = var.nat_gateway_public_ips
  zone                = "1"
  subnet_ids          = local.subnet_in_nat_gw_ids

  tags = var.tags
}
