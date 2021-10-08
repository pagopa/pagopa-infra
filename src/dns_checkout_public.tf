resource "azurerm_dns_zone" "checkout" {
  count               = (var.dns_zone_checkout == null || var.external_domain == null) ? 0 : 1
  name                = join(".", [var.dns_zone_checkout, var.external_domain])
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = var.tags
}

# Prod ONLY record to UAT public DNS delegation
# resource "azurerm_dns_ns_record" "uat_checkout" {
#   count               = var.env_short == "p" ? 1 : 0
#   name                = "uat"
#   zone_name           = azurerm_dns_zone.checkout[0].name
#   resource_group_name = azurerm_resource_group.rg_vnet.name
#   records = [
#     # todo delegation records after create DNS zone in UAT env
#     "ns1-07.azure-dns.com.",
#     "ns2-07.azure-dns.net.",
#     "ns3-07.azure-dns.org.",
#     "ns4-07.azure-dns.info.",
#   ]
#   ttl  = var.dns_default_ttl_sec
#   tags = var.tags
# }