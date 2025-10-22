resource "azurerm_dns_zone" "ecommerce_public" {
  count               = (var.dns_zone_ecommerce == null || var.external_domain == null) ? 0 : 1
  name                = join(".", [var.dns_zone_ecommerce, var.external_domain])
  resource_group_name = data.azurerm_resource_group.rg_vnet.name

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
