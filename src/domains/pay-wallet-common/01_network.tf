resource "azurerm_private_dns_a_record" "ingress" {
  name                = local.ingress_hostname
  zone_name           = data.azurerm_private_dns_zone.internal.name
  resource_group_name = local.internal_dns_zone_resource_group_name
  ttl                 = 3600
  records             = [var.ingress_load_balancer_ip]
}

#
# Subnets
#

module "cosmosdb_pay_wallet_snet" {
  source               = "./.terraform/modules/__v4__/subnet"
  name                 = "${local.project}-cosmosb-snet"
  address_prefixes     = var.cidr_subnet_cosmosdb_pay_wallet
  resource_group_name  = local.vnet_italy_resource_group_name
  virtual_network_name = local.vnet_italy_name

  private_endpoint_network_policies = "Enabled"

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
  ]
}

module "redis_pagopa_pay_wallet_snet" {
  source = "./.terraform/modules/__v4__/subnet"

  name                              = "${local.project}-redis-snet"
  address_prefixes                  = var.cidr_subnet_redis_pay_wallet
  resource_group_name               = local.vnet_italy_resource_group_name
  virtual_network_name              = local.vnet_italy_name
  private_endpoint_network_policies = "Enabled"
}

# hub spoke
module "redis_spoke_pay_wallet_snet" {
  source            = "./.terraform/modules/__v4__/IDH/subnet"
  count             = var.env_short == "d" ? 0 : 1
  env               = var.env
  idh_resource_tier = "slash28_privatelink_true"
  name              = "${local.project}-spoke-data-redis-pe-snet"
  product_name      = var.prefix

  resource_group_name  = local.vnet_hub_spoke_rg_name
  virtual_network_name = local.vnet_spoke_data_name
  tags                 = module.tag_config.tags

  custom_nsg_configuration = {
    target_service               = "redis"
    source_address_prefixes_name = "Paywallet"
    source_address_prefixes      = ["*"]
  }
}

module "cosmos_spoke_pay_wallet_snet" {
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
    source_address_prefixes_name = "Paywallet"
    source_address_prefixes      = ["*"]
  }
}

module "storage_spoke_pay_wallet_snet" {
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


