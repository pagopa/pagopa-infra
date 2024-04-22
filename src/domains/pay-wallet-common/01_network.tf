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
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.3.0"
  name                 = "${local.project}-cosmosb-snet"
  address_prefixes     = var.cidr_subnet_cosmosdb_pay_wallet
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_name

  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
  ]
}

module "pagopa_pay_wallet_redis_snet" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.7.0"

  name                                      = "${local.project}-redis-snet"
  address_prefixes                          = var.cidr_subnet_redis_pay_wallet
  resource_group_name                       = local.vnet_resource_group_name
  virtual_network_name                      = local.vnet_name
  private_endpoint_network_policies_enabled = true
}

module "pay_wallet_storage_snet" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.7.0"

  name                 = "${local.project}-storage-snet"
  address_prefixes     = var.cidr_subnet_storage_pay_wallet
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_name

  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Storage",
  ]
}

module "pagopa_pay_wallet_evenhub_snet" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.7.0"

  name                                      = "${local.project}-eventhub-snet"
  address_prefixes                          = var.cidr_subnet_
  resource_group_name                       = local.vnet_resource_group_name
  virtual_network_name                      = local.vnet_name
  private_endpoint_network_policies_enabled = true
}
