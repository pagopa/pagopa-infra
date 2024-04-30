data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_private_dns_zone" "internal" {
  name                = local.internal_dns_zone_name
  resource_group_name = local.internal_dns_zone_resource_group_name
}

data "azurerm_subnet" "apim_vnet" {
  name                 = local.pagopa_apim_snet
  resource_group_name  = local.pagopa_vnet_rg
  virtual_network_name = local.pagopa_vnet_integration
}

data "azurerm_subnet" "printit_pdf_engine_app_service_snet" {
  count                = var.is_feature_enabled.pdf_engine ? 1 : 0
  name                 = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}-pdf-engine-snet"
  resource_group_name  = "${var.prefix}-${var.env_short}-${var.location_short}-vnet-rg"
  virtual_network_name = "${var.prefix}-${var.env_short}-${var.location_short}-vnet"
}

#--------------------------------------------------

resource "azurerm_private_dns_a_record" "ingress" {
  name                = local.ingress_hostname
  zone_name           = data.azurerm_private_dns_zone.internal.name
  resource_group_name = local.internal_dns_zone_resource_group_name
  ttl                 = 3600
  records             = [var.ingress_load_balancer_ip]
}
