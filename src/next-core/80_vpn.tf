module "vpn_snet" {
  count = var.is_feature_enabled.vpn ? 1 : 0

  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.76.0"
  name                                      = "GatewaySubnet"
  address_prefixes                          = var.cidr_subnet_vpn
  virtual_network_name                      = data.azurerm_virtual_network.vnet_core.name
  resource_group_name                       = data.azurerm_resource_group.rg_vnet_core.name
  service_endpoints                         = []
  private_endpoint_network_policies_enabled = true
}

data "azuread_application" "vpn_app" {
  display_name = "${local.product}-app-vpn"
}

module "vpn" {
  count  = var.is_feature_enabled.vpn ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//vpn_gateway?ref=v7.76.0"

  name                  = "${local.product}-vpn"
  location              = var.location
  resource_group_name   = data.azurerm_resource_group.rg_vnet_core.name
  sku                   = "VpnGw1"
  pip_sku               = "Standard"
  pip_allocation_method = "Static"
  subnet_id             = module.vpn_snet[0].id

  vpn_client_configuration = [
    {
      address_space         = ["172.16.1.0/24"],
      vpn_client_protocols  = ["OpenVPN"],
      aad_audience          = data.azuread_application.vpn_app.application_id
      aad_issuer            = "https://sts.windows.net/${data.azurerm_subscription.current.tenant_id}/"
      aad_tenant            = "https://login.microsoftonline.com/${data.azurerm_subscription.current.tenant_id}"
      radius_server_address = null
      radius_server_secret  = null
      revoked_certificate   = []
      root_certificate      = []
    }
  ]

  tags = var.tags
}
