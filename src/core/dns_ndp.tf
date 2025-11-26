resource "azurerm_dns_zone" "ndp_public" {
  count               = var.env_short == "p" ? 1 : 0
  name                = join(".", ["ndp", var.external_domain])
  resource_group_name = data.azurerm_resource_group.rg_vnet.name

  tags = module.tag_config.tags
}

# nexi.ndp.pagopa.it records
resource "azurerm_dns_a_record" "dns_a_nexi_at" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "nexi"
  zone_name           = azurerm_dns_zone.ndp_public[0].name
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  records             = ["185.91.56.184"]
  tags                = module.tag_config.tags
}

# test.nexi.ndp.pagopa.it records
resource "azurerm_dns_a_record" "dns_a_testnexi_at" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "test.nexi"
  zone_name           = azurerm_dns_zone.ndp_public[0].name
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  records             = ["185.91.56.194"]
  tags                = module.tag_config.tags
}

resource "azurerm_dns_caa_record" "ndp_pagopa_it" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "@"
  zone_name           = azurerm_dns_zone.ndp_public[0].name
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


