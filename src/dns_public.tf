resource "azurerm_dns_zone" "public" {
  count               = (var.dns_zone_prefix == null || var.external_domain == null) ? 0 : 1
  name                = join(".", [var.dns_zone_prefix, var.external_domain])
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = var.tags
}

# DEV public DNS delegation
resource "azurerm_dns_ns_record" "platform_dev_pagopa_it_ns" {
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
  tags = var.tags
}

# UAT public DNS delegation
resource "azurerm_dns_ns_record" "platform_uat_pagopa_it_ns" {
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
  tags = var.tags
}

## Prod ONLY records 
resource "azurerm_dns_a_record" "dns-a-prod-platform" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "prod"
  zone_name           = azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  records             = ["51.137.18.218"]
  tags                = var.tags
}
resource "azurerm_dns_a_record" "dns-a-developer-production-platform" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "developer"
  zone_name           = azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  records             = ["20.56.3.91"]
  tags                = var.tags
}
resource "azurerm_dns_a_record" "dns-a-management-production-platform" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "management"
  zone_name           = azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  records             = ["20.56.3.91"]
  tags                = var.tags
}
resource "azurerm_dns_a_record" "dns-a-test-platform" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "test"
  zone_name           = azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  records             = ["20.54.178.216"]
  tags                = var.tags
}
resource "azurerm_dns_a_record" "dns-a-developer-test-platform" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "developer-test"
  zone_name           = azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  records             = ["104.45.74.7"]
  tags                = var.tags
}
resource "azurerm_dns_a_record" "dns-a-management-test-platform" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "management-test"
  zone_name           = azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  records             = ["104.45.74.7"]
  tags                = var.tags
}

# application gateway records
resource "azurerm_dns_a_record" "dns_a_appgw_api" {
  name                = "api"
  zone_name           = azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  records             = [azurerm_public_ip.apigateway_public_ip.ip_address]
  tags                = var.tags
}
resource "azurerm_dns_a_record" "dns_a_apim_dev_portal" {
  name                = "portal"
  zone_name           = azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  records             = [azurerm_public_ip.apigateway_public_ip.ip_address]
  tags                = var.tags
}


resource "azurerm_dns_a_record" "dns-a-management_platform" {
  count               = var.env_short == "p" ? 0 : 1
  name                = "management"
  zone_name           = azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  records             = [azurerm_public_ip.apigateway_public_ip.ip_address]
  tags                = var.tags
}
