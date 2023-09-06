resource "azurerm_dns_zone" "payment_wallet_public" {
  name                = "${var.dns_zone_prefix}.${var.external_domain}"
  resource_group_name = data.azurerm_resource_group.rg_vnet.name

  tags = var.tags
}

//Prod ONLY record to DEV public DNS delegation
resource "azurerm_dns_ns_record" "dev_payment_wallet" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "dev"
  zone_name           = azurerm_dns_zone.payment_wallet_public.name
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  records = [
    "ns1-35.azure-dns.com.",
    "ns2-35.azure-dns.net.",
    "ns3-35.azure-dns.org.",
    "ns4-35.azure-dns.info."
  ]
  ttl  = var.dns_default_ttl_sec
  tags = var.tags
}

//Prod ONLY record to UAT public DNS delegation
resource "azurerm_dns_ns_record" "uat_payment_wallet" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "uat"
  zone_name           = azurerm_dns_zone.payment_wallet_public.name
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  records = [
    "ns1-35.azure-dns.com.",
    "ns2-35.azure-dns.net.",
    "ns3-35.azure-dns.org.",
    "ns4-35.azure-dns.info."
  ]
  ttl  = var.dns_default_ttl_sec
  tags = var.tags
}

resource "azurerm_dns_caa_record" "payment_wallet_pagopa_it" {
  name                = "@"
  zone_name           = azurerm_dns_zone.payment_wallet_public.name
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

  tags = var.tags
}
