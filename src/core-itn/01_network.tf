#
# Vnet italy
#
resource "azurerm_resource_group" "rg_ita_vnet" {
  name     = "${local.product_ita}-vnet-rg"
  location = var.location_ita

  tags = module.tag_config.tags
}

module "vnet_italy" {
  source              = "./.terraform/modules/__v4__/virtual_network"
  count               = 1
  name                = "${local.product_ita}-vnet"
  location            = var.location_ita
  resource_group_name = azurerm_resource_group.rg_ita_vnet.name

  address_space        = var.cidr_vnet_italy
  ddos_protection_plan = var.vnet_ita_ddos_protection_plan

  tags = module.tag_config.tags
}


module "vnet_integration_cstar" {
  source              = "./.terraform/modules/__v4__/virtual_network"
  name                = "${local.product_ita}-cstar-integration-vnet"
  location            = var.location_ita
  resource_group_name = azurerm_resource_group.rg_ita_vnet.name

  address_space        = var.cidr_vnet_italy_cstar_integration
  ddos_protection_plan = var.vnet_ita_ddos_protection_plan

  tags = module.tag_config.tags
}


#
# 🔗 PEERING
#

## Peering between the vnet(main) and italy vnet
module "vnet_ita_peering" {
  source                           = "./.terraform/modules/__v4__/virtual_network_peering"
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

module "vnet_cstar_integration_to_vnet_ita_peering" {
  source                           = "./.terraform/modules/__v4__/virtual_network_peering"
  source_resource_group_name       = azurerm_resource_group.rg_ita_vnet.name
  source_virtual_network_name      = module.vnet_integration_cstar.name
  source_remote_virtual_network_id = module.vnet_integration_cstar.id
  source_use_remote_gateways       = false
  source_allow_forwarded_traffic   = true
  source_allow_gateway_transit     = true

  target_resource_group_name       = azurerm_resource_group.rg_ita_vnet.name
  target_virtual_network_name      = module.vnet_italy[0].name
  target_remote_virtual_network_id = module.vnet_italy[0].id
  target_allow_gateway_transit     = true
  target_allow_forwarded_traffic   = true
}

module "vnet_cstar_integration_to_vnet_weu_peering" {
  source                           = "./.terraform/modules/__v4__/virtual_network_peering"
  source_resource_group_name       = azurerm_resource_group.rg_ita_vnet.name
  source_virtual_network_name      = module.vnet_integration_cstar.name
  source_remote_virtual_network_id = module.vnet_integration_cstar.id
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
  source                           = "./.terraform/modules/__v4__/virtual_network_peering"
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

  private_endpoint_network_policies = "Enabled"
}

resource "azurerm_subnet" "subnet_container_app_tools" {
  name                 = "${local.project}-tools-cae-subnet"
  resource_group_name  = module.vnet_italy[0].resource_group_name
  virtual_network_name = module.vnet_italy[0].name
  address_prefixes     = var.cidr_subnet_tools_cae

  private_endpoint_network_policies = "Enabled"

}

# subnet acr
module "common_private_endpoint_snet" {
  source               = "./.terraform/modules/__v4__/subnet"
  name                 = "${local.product}-common-private-endpoint-snet"
  address_prefixes     = var.cidr_common_private_endpoint_snet
  resource_group_name  = azurerm_resource_group.rg_ita_vnet.name
  virtual_network_name = module.vnet_italy.0.name

  private_link_service_network_policies_enabled = true


  service_endpoints = var.env_short == "p" ? ["Microsoft.Storage"] : []
}


module "cstar_integration_private_endpoint_snet" {
  source = "./.terraform/modules/__v4__/IDH/subnet"

  env               = var.env
  idh_resource_tier = "private_endpoint"
  product_name      = var.prefix

  name                 = "${local.product_ita}-private-endpoint-snet"
  resource_group_name  = azurerm_resource_group.rg_ita_vnet.name
  virtual_network_name = module.vnet_integration_cstar.name
}
