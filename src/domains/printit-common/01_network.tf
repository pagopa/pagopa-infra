resource "azurerm_private_dns_a_record" "ingress" {
  name                = local.ingress_hostname
  zone_name           = data.azurerm_private_dns_zone.internal.name
  resource_group_name = local.internal_dns_zone_resource_group_name
  ttl                 = 3600
  records             = [var.ingress_load_balancer_ip]
}

###

resource "azurerm_subnet" "cosmosdb_italy_snet" {
  name                              = "${local.project}-cosmosdb-snet"
  resource_group_name               = data.azurerm_resource_group.rg_vnet_italy.name
  virtual_network_name              = data.azurerm_virtual_network.vnet_italy.name
  address_prefixes                  = var.cidr_printit_cosmosdb_italy
  private_endpoint_network_policies = "Enabled"

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
  ]
}


resource "azurerm_subnet" "cidr_redis_italy" {
  name                              = "${local.project}-redis-snet"
  resource_group_name               = data.azurerm_resource_group.rg_vnet_italy.name
  virtual_network_name              = data.azurerm_virtual_network.vnet_italy.name
  address_prefixes                  = var.cidr_printit_redis_italy
  private_endpoint_network_policies = "Enabled"
}

resource "azurerm_subnet" "pdf_engine_italy_snet" {
  name = "${local.project}-pdf-engine-snet"

  resource_group_name               = data.azurerm_resource_group.rg_vnet_italy.name
  virtual_network_name              = data.azurerm_virtual_network.vnet_italy.name
  address_prefixes                  = var.cidr_printit_pdf_engine_italy
  private_endpoint_network_policies = "Enabled"

  delegation {
    name = "delegation"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}


module "eventhub_spoke_pe_snet" {
  source            = "./.terraform/modules/__v4__/IDH/subnet"
  env               = var.env
  idh_resource_tier = "slash28_privatelink_true"
  name              = "${local.project}-spoke-streaming-evh-pe-snet"
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


module "cosmos_spoke_printit_snet" {
  source            = "./.terraform/modules/__v4__/IDH/subnet"
  count             = var.env_short == "d" ? 0 : 1
  env               = var.env
  idh_resource_tier = "slash28_privatelink_true"
  name              = "${local.project}-spoke-data-cosmos-pe-snet"
  product_name      = var.prefix

  resource_group_name  = local.vnet_hub_spoke_rg_name
  virtual_network_name = local.vnet_spoke_data_name
  tags                 = module.tag_config.tags

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
  ]

  custom_nsg_configuration = {
    target_service               = "cosmos"
    source_address_prefixes_name = "Printit"
    source_address_prefixes      = ["*"]
  }
}

module "storage_spoke_printit_snet" {
  source            = "./.terraform/modules/__v4__/IDH/subnet"
  count             = var.env_short == "d" ? 0 : 1
  env               = var.env
  idh_resource_tier = "slash28_privatelink_true"
  name              = "${local.project}-spoke-data-storage-pe-snet"
  product_name      = var.prefix

  resource_group_name  = local.vnet_hub_spoke_rg_name
  virtual_network_name = local.vnet_spoke_data_name
  tags                 = module.tag_config.tags

  service_endpoints = [
    "Microsoft.Storage",
  ]

  custom_nsg_configuration = {
    target_service               = "storage"
    source_address_prefixes_name = "All"
    source_address_prefixes      = ["*"]
  }
}
