module "nat_gw" {
  count  = var.nat_gateway_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//nat_gateway?ref=v1.0.77"

  name                = format("%s-natgw", local.project)
  resource_group_name = azurerm_resource_group.rg_vnet.name
  location            = azurerm_resource_group.rg_vnet.location
  public_ips_count    = var.nat_gateway_public_ips
  zone                = "1"
  subnet_ids          = []

  tags = var.tags
}
