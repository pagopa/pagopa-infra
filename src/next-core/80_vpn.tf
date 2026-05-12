moved {
  from = module.vpn_snet[0]
  to   = module.vpn_snet
}

module "vpn_snet" {
  source               = "./.terraform/modules/__v4__/subnet"
  name                 = "GatewaySubnet"
  address_prefixes     = var.cidr_subnet_vpn
  virtual_network_name = module.vnet.name
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  service_endpoints = [
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
    "Microsoft.Web"
  ]
  private_endpoint_network_policies = "Disabled"
}

data "azuread_application" "vpn_app" {
  display_name = "${local.product}-app-vpn"
}


moved {
  from = module.vpn[0]
  to   = module.vpn
}


module "vpn" {
  source = "./.terraform/modules/__v4__/vpn_gateway"

  name                  = "${local.product}-vpn"
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  sku                   = var.vpn_gw_sku
  pip_sku               = var.vpn_gw_pip_sku
  pip_allocation_method = var.vpn_gw_pip_allocation_method
  subnet_id             = module.vpn_snet.id

  random_special = var.vpn_random_specials_char
  random_upper   = var.vpn_random_specials_char

  vpn_client_configuration = [
    {
      address_space         = ["172.16.1.0/24"],
      vpn_client_protocols  = ["OpenVPN"],
      aad_audience          = data.azuread_application.vpn_app.client_id
      aad_issuer            = "https://sts.windows.net/${data.azurerm_subscription.current.tenant_id}/"
      aad_tenant            = "https://login.microsoftonline.com/${data.azurerm_subscription.current.tenant_id}"
      radius_server_address = null
      radius_server_secret  = null
      revoked_certificate   = []
      root_certificate      = []
    }
  ]

  tags = module.tag_config.tags
}



## DNS Forwarder
module "dns_forwarder_snet" {
  count  = var.env_short != "d" ? 1 : 0
  source = "./.terraform/modules/__v4__/subnet"

  name                              = "${local.product}-dns-forwarder-snet"
  address_prefixes                  = var.cidr_subnet_dns_forwarder
  resource_group_name               = azurerm_resource_group.rg_vnet.name
  virtual_network_name              = module.vnet.name
  private_endpoint_network_policies = "Disabled"

  delegation = {
    name = "delegation"
    service_delegation = {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "random_id" "dns_forwarder_hash" {
  count       = var.env_short != "d" ? 1 : 0
  byte_length = 3
}

module "dns_forwarder" {
  count  = var.env_short != "d" ? 1 : 0
  source = "./.terraform/modules/__v4__/dns_forwarder_deprecated"

  name                = "${local.product}-${random_id.dns_forwarder_hash[count.index].hex}-dns-forwarder"
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  subnet_id           = module.dns_forwarder_snet[0].id

  tags = module.tag_config.tags
}

