#
# Vnet italy
#
resource "azurerm_resource_group" "rg_ita_vnet" {
  name     = "${local.product_ita}-vnet-rg"
  location = var.location_ita

  tags = module.tag_config.tags
}

module "vnet_italy" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//virtual_network?ref=v8.13.0"
  count               = 1
  name                = "${local.product_ita}-vnet"
  location            = var.location_ita
  resource_group_name = azurerm_resource_group.rg_ita_vnet.name

  address_space        = var.cidr_vnet_italy
  ddos_protection_plan = var.vnet_ita_ddos_protection_plan

  tags = module.tag_config.tags
}

#
# 🔗 PEERING
#

## Peering between the vnet(main) and italy vnet
module "vnet_ita_peering" {
  source                           = "git::https://github.com/pagopa/terraform-azurerm-v3.git//virtual_network_peering?ref=v8.13.0"
  count                            = 1
  source_resource_group_name       = azurerm_resource_group.rg_ita_vnet.name
  source_virtual_network_name      = module.vnet_italy[0].name
  source_remote_virtual_network_id = module.vnet_italy[0].id
  source_use_remote_gateways       = true
  source_allow_forwarded_traffic   = true
  source_allow_gateway_transit     = true

  target_resource_group_name       = data.azurerm_resource_group.rg_vnet_core.name
  target_virtual_network_name      = data.azurerm_virtual_network.vnet_core.name
  target_remote_virtual_network_id = data.azurerm_virtual_network.vnet_core.id
  target_allow_gateway_transit     = true
  target_allow_forwarded_traffic   = true
}

module "vnet_ita_to_integration_peering" {
  source                           = "git::https://github.com/pagopa/terraform-azurerm-v3.git//virtual_network_peering?ref=v8.13.0"
  count                            = 1
  source_resource_group_name       = azurerm_resource_group.rg_ita_vnet.name
  source_virtual_network_name      = module.vnet_italy[0].name
  source_remote_virtual_network_id = module.vnet_italy[0].id
  source_use_remote_gateways       = false
  source_allow_forwarded_traffic   = false
  source_allow_gateway_transit     = true

  target_resource_group_name       = data.azurerm_resource_group.rg_vnet_integration.name
  target_virtual_network_name      = data.azurerm_virtual_network.vnet_integration.name
  target_remote_virtual_network_id = data.azurerm_virtual_network.vnet_integration.id
  target_allow_gateway_transit     = false
  target_allow_forwarded_traffic   = true
}

#
# PUBLIC IP
#
resource "azurerm_public_ip" "aks_leonardo_public_ip" {
  name                = "${local.product}-itn-${var.env}-aksoutbound-pip"
  resource_group_name = azurerm_resource_group.rg_ita_vnet.name
  location            = azurerm_resource_group.rg_ita_vnet.location
  sku                 = "Standard"
  allocation_method   = "Static"

  zones = [1, 2, 3]

  tags = module.tag_config.tags
}

#
# 🕸️ Subnets
#
resource "azurerm_subnet" "eventhubs_italy" {
  name                 = "${local.project}-eventhubs-snet"
  resource_group_name  = module.vnet_italy[0].resource_group_name
  virtual_network_name = module.vnet_italy[0].name
  address_prefixes     = var.cidr_eventhubs_italy
}

resource "azurerm_subnet" "subnet_container_app_tools" {
  name                 = "${local.project}-tools-cae-subnet"
  resource_group_name  = module.vnet_italy[0].resource_group_name
  virtual_network_name = module.vnet_italy[0].name
  address_prefixes     = var.cidr_subnet_tools_cae
}

# subnet acr
module "common_private_endpoint_snet" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.83.0"
  name                 = "${local.product}-common-private-endpoint-snet"
  address_prefixes     = var.cidr_common_private_endpoint_snet
  resource_group_name  = azurerm_resource_group.rg_ita_vnet.name
  virtual_network_name = module.vnet_italy.0.name

  private_link_service_network_policies_enabled = true


  service_endpoints = var.env_short == "p" ? ["Microsoft.Storage"] : []
}
