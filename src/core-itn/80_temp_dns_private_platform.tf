### 🔮 Italy DNS private 👉 <prod|uat|dev>.platform.pagopa.it
resource "azurerm_private_dns_zone" "italy_platform_private_dns_zone" {
  name                = "${var.platform_dns_zone_prefix}.${var.external_domain}"
  resource_group_name = azurerm_resource_group.rg_ita_vnet.name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "dev_platform_pagopa_it_vnet_core_link" {
  name                  = module.vnet_italy[0].name
  private_dns_zone_name = azurerm_private_dns_zone.italy_platform_private_dns_zone.name
  resource_group_name   = azurerm_private_dns_zone.italy_platform_private_dns_zone.resource_group_name
  virtual_network_id    = module.vnet_italy[0].id
  tags                  = var.tags
}

#
# RECORDS
#
resource "azurerm_private_dns_a_record" "platform_dns_a_private_apim" {

  for_each            = toset(["api", "portal", "management"])
  name                = each.key
  zone_name           = azurerm_private_dns_zone.italy_platform_private_dns_zone.name
  resource_group_name = azurerm_private_dns_zone.italy_platform_private_dns_zone.resource_group_name
  ttl                 = var.dns_default_ttl_sec
  records             = [data.azurerm_application_gateway.app_gw_integration.frontend_ip_configuration[1].private_ip_address]
  tags                = var.tags
}

