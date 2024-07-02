data "azurerm_dns_zone" "public" {
  count = (var.dns_zone_prefix == null || var.external_domain == null) ? 0 : 1
  name  = join(".", [var.dns_zone_prefix, var.external_domain])
}

data "azurerm_dns_zone" "public_prf" {
  count = (var.dns_zone_prefix_prf == "") ? 0 : 1
  name  = join(".", [var.dns_zone_prefix_prf, var.external_domain])
}
