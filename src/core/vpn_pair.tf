## VPN subnet
module "vpn_snet_integration" {
  count                                          = var.env_short == "d" ? 1 : 0
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v4.18.1"
  name                                           = "GatewaySubnet"
  address_prefixes                               = ["10.230.8.144/29"]
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet_integration.name
  service_endpoints                              = []
  enforce_private_link_endpoint_network_policies = false
}

data "azuread_application" "vpn_app" {
  display_name = "${local.project}-app-vpn"
}

module "vpn_integration" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//vpn_gateway?ref=v4.18.1"

  name                = "${local.project}-vpn-integration"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  sku                 = var.vpn_sku
  pip_sku             = var.vpn_pip_sku
  subnet_id           = module.vpn_snet_integration[0].id

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

# DNS FORWARDER FOR DISASTER RECOVERY

#
# DNS Forwarder Pair
#
module "dns_forwarder_integration_subnet" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v4.18.1"

  name                                           = "${local.project}-integration-dns-forwarder-snet"
  address_prefixes                               = ["10.230.8.152/29"]
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet_integration.name
  enforce_private_link_endpoint_network_policies = false

  delegation = {
    name = "delegation"
    service_delegation = {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}


resource "random_id" "integration_dns_forwarder_hash" {
  count       = var.env_short == "d" ? 1 : 0
  byte_length = 3
}

module "vpn_integration_dns_forwarder" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//dns_forwarder?ref=v4.18.1"

  name                = "${local.project}-${random_id.integration_dns_forwarder_hash[0].hex}-dns-integration-forwarder"
  location            = var.location_pair
  resource_group_name = azurerm_resource_group.rg_vnet.name
  subnet_id           = module.dns_forwarder_integration_subnet[0].id
  tags                = var.tags
}
