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
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.5.0"
  name                 = "${local.project}-cosmosb-snet"
  address_prefixes     = var.cidr_subnet_cosmosdb_pay_wallet
  resource_group_name  = local.vnet_italy_resource_group_name
  virtual_network_name = local.vnet_italy_name

  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
  ]
}

module "redis_pagopa_pay_wallet_snet" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.5.0"

  name                                      = "${local.project}-redis-snet"
  address_prefixes                          = var.cidr_subnet_redis_pay_wallet
  resource_group_name                       = local.vnet_italy_resource_group_name
  virtual_network_name                      = local.vnet_italy_name
  private_endpoint_network_policies_enabled = true
}

module "storage_pay_wallet_snet" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.5.0"

  name                 = "${local.project}-storage-snet"
  address_prefixes     = var.cidr_subnet_storage_pay_wallet
  resource_group_name  = local.vnet_italy_resource_group_name
  virtual_network_name = local.vnet_italy_name

  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Storage",
  ]
}

