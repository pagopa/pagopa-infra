data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_private_dns_zone" "internal" {
  name                = local.internal_dns_zone_name
  resource_group_name = local.internal_dns_zone_resource_group_name
}

resource "azurerm_private_dns_a_record" "ingress" {
  name                = local.ingress_hostname
  zone_name           = data.azurerm_private_dns_zone.internal.name
  resource_group_name = local.internal_dns_zone_resource_group_name
  ttl                 = 3600
  records             = [var.ingress_load_balancer_ip]
}

data "azurerm_virtual_network" "vnet_italy" {
  name                = local.vnet_italy_name
  resource_group_name = local.vnet_italy_resource_group_name
}

data "azurerm_resource_group" "rg_vnet_italy" {
  name = local.vnet_italy_resource_group_name
}

data "azurerm_subnet" "aks_subnet" {
  name                 = local.aks_subnet_name
  virtual_network_name = local.vnet_name
  resource_group_name  = local.vnet_resource_group_name
}

data "azurerm_private_dns_zone" "cosmos" {
  name                = local.cosmos_dns_zone_name
  resource_group_name = local.cosmos_dns_zone_resource_group_name
}

#
# Eventhub
#
data "azurerm_private_dns_zone" "eventhub" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = local.msg_resource_group_name
}

data "azurerm_resource_group" "rg_event_private_dns_zone" {
  name = local.msg_resource_group_name
}


module "eventhub_spoke_pe_snet" {
  source            = "./.terraform/modules/__v4__/IDH/subnet"
  env               = var.env
  idh_resource_tier = "slash28_privatelink_true"
  name              = "${local.project_itn}-spoke-streaming-evh-pe-snet"
  product_name      = var.prefix

  resource_group_name  = local.vnet_hub_spoke_rg_name
  virtual_network_name = local.vnet_spoke_streaming_name

  custom_nsg_configuration = {
    target_service               = "eventhub"
    source_address_prefixes_name = "All"
    source_address_prefixes      = ["*"]
  }

  tags = module.tag_config.tags
}

module "cosmosdb_qi_snet" {
  source = "./.terraform/modules/__v4__/subnet"

  name                 = "${local.project}-cosmosb-snet"
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_name

  address_prefixes = var.cidr_subnet_cosmosdb_qi

  private_endpoint_network_policies = "Enabled"
  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
  ]
}
