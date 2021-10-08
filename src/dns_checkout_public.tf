resource "azurerm_dns_zone" "checkout_public" {
  count               = (var.dns_zone_checkout == null || var.external_domain == null) ? 0 : 1
  name                = join(".", [var.dns_zone_checkout, var.external_domain])
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = var.tags
}

//Prod ONLY record to DEV public DNS delegation
resource "azurerm_dns_ns_record" "dev_checkout" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "dev"
  zone_name           = azurerm_dns_zone.checkout_public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  records = [
    "ns1-03.azure-dns.com.",
    "ns2-03.azure-dns.net.",
    "ns3-03.azure-dns.org.",
    "ns4-03.azure-dns.info."
  ]
  ttl  = var.dns_default_ttl_sec
  tags = var.tags
}

//Prod ONLY record to UAT public DNS delegation
resource "azurerm_dns_ns_record" "uat_checkout" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "uat"
  zone_name           = azurerm_dns_zone.checkout_public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  records = [
    "ns1-02.azure-dns.com.",
    "ns2-02.azure-dns.net.",
    "ns3-02.azure-dns.org.",
    "ns4-02.azure-dns.info."
  ]
  ttl  = var.dns_default_ttl_sec
  tags = var.tags
}