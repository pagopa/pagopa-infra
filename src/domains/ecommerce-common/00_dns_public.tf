resource "azurerm_dns_zone" "ecommerce_public" {
  count               = (var.dns_zone_ecommerce == null || var.external_domain == null) ? 0 : 1
  name                = join(".", [var.dns_zone_ecommerce, var.external_domain])
  resource_group_name = data.azurerm_resource_group.rg_vnet.name

  tags = module.tag_config.tags
}

//Prod ONLY record to DEV public DNS delegation
resource "azurerm_dns_ns_record" "dev_ecommerce" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "dev"
  zone_name           = azurerm_dns_zone.ecommerce_public[0].name
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  records = [
    "ns1-02.azure-dns.com.",
    "ns2-02.azure-dns.net.",
    "ns3-02.azure-dns.org.",
    "ns4-02.azure-dns.info."
  ]
  ttl  = var.dns_default_ttl_sec
  tags = module.tag_config.tags
}

//Prod ONLY record to UAT public DNS delegation
resource "azurerm_dns_ns_record" "uat_ecommerce" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "uat"
  zone_name           = azurerm_dns_zone.ecommerce_public[0].name
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  records = [
    "ns1-06.azure-dns.com.",
    "ns2-06.azure-dns.net.",
    "ns3-06.azure-dns.org.",
    "ns4-06.azure-dns.info."
  ]
  ttl  = var.dns_default_ttl_sec
  tags = module.tag_config.tags
}

resource "azurerm_dns_caa_record" "ecommerce_pagopa_it" {
  name                = "@"
  zone_name           = azurerm_dns_zone.ecommerce_public[0].name
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec

  record {
    flags = 0
    tag   = "issue"
    value = "letsencrypt.org"
  }

  record {
    flags = 0
    tag   = "iodef"
    value = "mailto:security+caa@pagopa.it"
  }

  tags = module.tag_config.tags
}
