data "azurerm_dns_zone" "checkout_public" {
  count               = (var.dns_zone_checkout == null || var.external_domain == null) ? 0 : 1
  name                = join(".", [var.dns_zone_checkout, var.external_domain])
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}
