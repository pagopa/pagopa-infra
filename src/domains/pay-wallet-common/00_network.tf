### VNET

# data "azurerm_resource_group" "rg_vnet" {
#   name = local.vnet_core_resource_group_name
# }
#
# data "azurerm_virtual_network" "vnet" {
#   name                = local.vnet_core_name
#   resource_group_name = data.azurerm_resource_group.rg_vnet.name
# }

# 🇮🇹

data "azurerm_resource_group" "rg_vnet_italy" {
  name = local.vnet_italy_resource_group_name
}

data "azurerm_virtual_network" "vnet_italy" {
  name                = local.vnet_italy_name
  resource_group_name = data.azurerm_resource_group.rg_vnet_italy.name
}

### DNS ZONE

data "azurerm_private_dns_zone" "internal" {
  name                = local.internal_dns_zone_name
  resource_group_name = local.internal_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "cosmos" {
  name                = local.cosmos_dns_zone_name
  resource_group_name = local.cosmos_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "privatelink_documents_azure_com" {
  name                = "privatelink.redis.cache.windows.net"
  resource_group_name = local.vnet_core_resource_group_name
}

data "azurerm_private_dns_zone" "privatelink_blob_azure_com" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = local.vnet_core_resource_group_name
}

data "azurerm_private_dns_zone" "privatelink_table_azure_com" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = local.vnet_core_resource_group_name
}

data "azurerm_private_dns_zone" "privatelink_queue_azure_com" {
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = local.vnet_core_resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_italy_name
  resource_group_name = data.azurerm_resource_group.rg_vnet_italy.name
}

data "azurerm_subnet" "vpn_subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = local.vnet_core_resource_group_name
  virtual_network_name = local.vnet_core_name
}

resource "azurerm_subnet" "pay_wallet_user_aks_subnet" {
  name                 = "${local.project}-user-aks"
  resource_group_name  = local.vnet_italy_resource_group_name
  virtual_network_name = local.vnet_italy_name
  address_prefixes     = var.cidr_subnet_pay_wallet_user_aks

  private_endpoint_network_policies             = "Enabled"
  private_link_service_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]
}