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

module "printit_pdf_engine_app_service_snet" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.3.0"
  count  = var.is_feature_enabled.pdf_engine ? 1 : 0

  name                                      = format("%s-pdf-engine-snet", local.project)
  address_prefixes                          = var.cidr_subnet_pdf_engine_app_service
  resource_group_name                       = local.vnet_resource_group_name
  virtual_network_name                      = local.vnet_name
  private_endpoint_network_policies_enabled = true

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}


#--------------------------------------------------

resource "azurerm_private_dns_a_record" "ingress" {
  name                = local.ingress_hostname
  zone_name           = data.azurerm_private_dns_zone.internal.name
  resource_group_name = local.internal_dns_zone_resource_group_name
  ttl                 = 3600
  records             = [var.ingress_load_balancer_ip]
}
