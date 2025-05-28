data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_dns_zone" "public" {
  name = join(".", [var.apim_dns_zone_prefix, var.external_domain])
}

data "azurerm_private_dns_zone" "private" {
  name = join(".", [var.apim_dns_zone_prefix, var.external_domain])
}

resource "azurerm_private_dns_cname_record" "config_platform_dns_private_cname" {
  name                = "config"
  zone_name           = data.azurerm_private_dns_zone.private.name
  resource_group_name = data.azurerm_virtual_network.vnet.resource_group_name
  ttl                 = var.dns_default_ttl_sec
  record              = module.api_config_fe_cdn[0].hostname
  tags                = module.tag_config.tags
}
