data "azurerm_dns_zone" "public" {
  count               = (var.dns_zone_prefix == null || var.external_domain == null) ? 0 : 1
  name = join(".", [var.dns_zone_prefix, var.external_domain])
}

data "azurerm_dns_zone" "public_prf" {
  count               = (var.dns_zone_prefix_prf == "") ? 0 : 1
  name                = join(".", [var.dns_zone_prefix_prf, var.external_domain])
}

data "azurerm_dns_a_record" "dns_a_api"{
  name                = "api"
  zone_name           = data.azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
}

data "azurerm_dns_a_record" "dns_a_upload"{
  count               = var.upload_endpoint_enabled ? 1 : 0
  name                = "upload"
  zone_name           = data.azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
}

data "azurerm_dns_a_record" "dns_a_portal"{
  count               = var.upload_endpoint_enabled ? 1 : 0
  name                = "portal"
  zone_name           = data.azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
}

data "azurerm_dns_a_record" "dns_a_management"{
  name                = "management"
  zone_name           = data.azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
}

data "azurerm_dns_a_record" "dns_a_kibana"{
  name                = "kibana"
  zone_name           = data.azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
}
