resource "azurerm_dns_zone" "public" {
  count               = (var.dns_zone_prefix == null || var.external_domain == null) ? 0 : 1
  name                = join(".", [var.dns_zone_prefix, var.external_domain])
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = module.tag_config.tags
}

resource "azurerm_dns_zone" "public_prf" {
  count               = (var.dns_zone_prefix_prf == "") ? 0 : 1
  name                = join(".", [var.dns_zone_prefix_prf, var.external_domain])
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = module.tag_config.tags
}

resource "azurerm_dns_cname_record" "statuspage_platform_pagopa_it_cname" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "status"
  zone_name           = azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  record              = "statuspage.betteruptime.com"
  ttl                 = var.dns_default_ttl_sec
  tags                = module.tag_config.tags
}

# Prod ONLY record to DEV public DNS delegation
resource "azurerm_dns_ns_record" "dev_pagopa_it_ns" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "dev"
  zone_name           = azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  records = [
    "ns1-08.azure-dns.com.",
    "ns2-08.azure-dns.net.",
    "ns3-08.azure-dns.org.",
    "ns4-08.azure-dns.info.",
  ]
  ttl  = var.dns_default_ttl_sec
  tags = module.tag_config.tags
}

# Prod ONLY record to UAT public DNS delegation
resource "azurerm_dns_ns_record" "uat_pagopa_it_ns" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "uat"
  zone_name           = azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  records = [
    "ns1-07.azure-dns.com.",
    "ns2-07.azure-dns.net.",
    "ns3-07.azure-dns.org.",
    "ns4-07.azure-dns.info.",
  ]
  ttl  = var.dns_default_ttl_sec
  tags = module.tag_config.tags
}

# Prod ONLY record to PRF public DNS delegation
resource "azurerm_dns_ns_record" "prf_pagopa_it_ns" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "prf"
  zone_name           = azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  records = [
    "ns1-02.azure-dns.com.",
    "ns2-02.azure-dns.net.",
    "ns3-02.azure-dns.org.",
    "ns4-02.azure-dns.info.",
  ]
  ttl  = var.dns_default_ttl_sec
  tags = module.tag_config.tags
}

resource "azurerm_dns_caa_record" "api_platform_pagopa_it" {
  name                = "@"
  zone_name           = azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec

  record {
    flags = 0
    tag   = "issue"
    value = "letsencrypt.org"
  }

  record {
    flags = 0
    tag   = "issue"
    value = "digicert.com"
  }
  record {
    flags = 0
    tag   = "iodef"
    value = "mailto:security+caa@pagopa.it"
  }

  tags = module.tag_config.tags
}


# application gateway records
resource "azurerm_dns_a_record" "dns_a_api" {
  name                = "api"
  zone_name           = azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  records             = [azurerm_public_ip.appgateway_public_ip.ip_address]
  tags                = module.tag_config.tags
}

resource "azurerm_dns_a_record" "dns_a_upload" {
  name                = "upload"
  zone_name           = azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  records             = [azurerm_public_ip.appgateway_public_ip.ip_address]
  tags                = module.tag_config.tags
}

resource "azurerm_dns_a_record" "dns_a_portal" {
  name                = "portal"
  zone_name           = azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  records             = [azurerm_public_ip.appgateway_public_ip.ip_address]
  tags                = module.tag_config.tags
}

resource "azurerm_dns_a_record" "dns_a_management" {
  name                = "management"
  zone_name           = azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  records             = [azurerm_public_ip.appgateway_public_ip.ip_address]
  tags                = module.tag_config.tags
}

# #####################
# Replicate to PRF env
# #####################
resource "azurerm_dns_caa_record" "api_platform_pagopa_it_prf" {
  count = (var.dns_zone_prefix_prf == "") ? 0 : 1

  name                = "@"
  zone_name           = azurerm_dns_zone.public_prf[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
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

# application gateway records
resource "azurerm_dns_a_record" "dns_a_api_prf" {
  count = (var.dns_zone_prefix_prf == "") ? 0 : 1

  name                = "api"
  zone_name           = azurerm_dns_zone.public_prf[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  records             = [azurerm_public_ip.appgateway_public_ip.ip_address]
  tags                = module.tag_config.tags
}

resource "azurerm_dns_a_record" "dns_a_portal_prf" {
  count = (var.dns_zone_prefix_prf == "") ? 0 : 1

  name                = "portal"
  zone_name           = azurerm_dns_zone.public_prf[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  records             = [azurerm_public_ip.appgateway_public_ip.ip_address]
  tags                = module.tag_config.tags
}

resource "azurerm_dns_a_record" "dns_a_management_prf" {
  count = (var.dns_zone_prefix_prf == "") ? 0 : 1

  name                = "management"
  zone_name           = azurerm_dns_zone.public_prf[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  records             = [azurerm_public_ip.appgateway_public_ip.ip_address]
  tags                = module.tag_config.tags
}

# accounting reconciliation DCV TXT record
resource "azurerm_dns_txt_record" "dns-txt-acc-recon-platform-pagopa-it-digicert" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "accounting-reconciliation"
  zone_name           = azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  record {
    value = "_l31s4aq6548d0fj0q1kakhat5dilgxe"
  }
  tags = module.tag_config.tags
}

# accounting reconciliation www DCV TXT record
resource "azurerm_dns_txt_record" "dns-txt-www-acc-recon-platform-pagopa-it-digicert" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "www.accounting-reconciliation"
  zone_name           = azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  record {
    value = "_l31s4aq6548d0fj0q1kakhat5dilgxe"
  }
  tags = module.tag_config.tags
}

# Node Forwarder DCV TXT record
resource "azurerm_dns_txt_record" "dns-txt-forwarder-platform-pagopa-it-digicert" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "forwarder"
  zone_name           = azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  record {
    value = "_s0z8yt7tycb0u7ieit5re0mgtnucpf4"
  }
  tags = module.tag_config.tags
}

# Node Forwarder www DCV TXT record
resource "azurerm_dns_txt_record" "dns-txt-www-forwarder-platform-pagopa-it-digicert" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "www.forwarder"
  zone_name           = azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  record {
    value = "_s0z8yt7tycb0u7ieit5re0mgtnucpf4"
  }
  tags = module.tag_config.tags
}
