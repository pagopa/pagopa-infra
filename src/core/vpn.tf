## VPN subnet
module "vpn_snet" {
  count                                          = var.env_short != "d" ? 1 : 0
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.90"
  name                                           = "GatewaySubnet"
  address_prefixes                               = var.cidr_subnet_vpn
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name
  service_endpoints                              = []
  enforce_private_link_endpoint_network_policies = true
}

data "azuread_application" "vpn_app" {
  display_name = format("%s-app-vpn", local.project)
}

module "vpn" {
  count  = var.env_short != "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//vpn_gateway?ref=v2.0.28"

  name                = format("%s-vpn", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  sku                 = var.vpn_sku
  pip_sku             = var.vpn_pip_sku
  subnet_id           = module.vpn_snet[0].id

  vpn_client_configuration = [
    {
      address_space         = ["172.16.1.0/24"],
      vpn_client_protocols  = ["OpenVPN"],
      aad_audience          = data.azuread_application.vpn_app.application_id
      aad_issuer            = format("https://sts.windows.net/%s/", data.azurerm_subscription.current.tenant_id)
      aad_tenant            = format("https://login.microsoftonline.com/%s", data.azurerm_subscription.current.tenant_id)
      radius_server_address = null
      radius_server_secret  = null
      revoked_certificate   = []
      root_certificate      = []
    }
  ]

  tags = var.tags
}

## DNS Forwarder
module "dns_forwarder_snet" {
  count  = var.env_short != "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v4.15.0"

  name                                           = format("%s-dns-forwarder-snet", local.project)
  address_prefixes                               = var.cidr_subnet_dns_forwarder
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name
  enforce_private_link_endpoint_network_policies = true

  delegation = {
    name = "delegation"
    service_delegation = {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "random_id" "dns_forwarder_hash" {
  byte_length = 3
}

module "dns_forwarder" {
  count  = var.env_short != "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//dns_forwarder?ref=v4.15.0"

  name                = "${local.project}-${random_id.dns_forwarder_hash.hex}-dns-forwarder"
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  subnet_id           = module.dns_forwarder_snet[0].id

  tags = var.tags
}



# DNS FORWARDER FOR DISASTER RECOVERY

#
# DNS Forwarder
#
module "dns_forwarder_pair_subnet" {
  count = var.dns_forwarder_pair_enabled ? 1 : 0
  source                                    = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.0.28"



name                                           = format("%s-dns-forwarder-snet", local.project_pair)
address_prefixes                               = var.cidr_subnet_pair_dnsforwarder
resource_group_name                            = azurerm_resource_group.rg_pair_vnet[count.index].name
virtual_network_name                           = module.vnet_pair[count.index].name
enforce_private_link_endpoint_network_policies = false

delegation = {
  name = "delegation"
  service_delegation = {
    name    = "Microsoft.ContainerInstance/containerGroups"
    actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
  }
}

}


resource "random_id" "pair_dns_forwarder_hash" {
  byte_length = 3
}

module "vpn_pair_dns_forwarder" {
  count = var.dns_forwarder_pair_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//dns_forwarder?ref=v2.0.28"

  name                = "${local.project}-${random_id.pair_dns_forwarder_hash.hex}-dns-forwarder"
  location            = var.location_pair
  resource_group_name = azurerm_resource_group.rg_pair_vnet[count.index].name
  subnet_id           = module.dns_forwarder_pair_subnet[count.index].id
  tags                = var.tags
}
