data "azurerm_virtual_network" "vnet_italy" {
  name                = local.vnet_italy_name
  resource_group_name = local.vnet_italy_resource_group_name
}

data "azurerm_resource_group" "rg_vnet_italy" {
  name = local.vnet_italy_resource_group_name
}

data "azurerm_resource_group" "rg_vnet_core" {
  name = local.vnet_core_resource_group_name
}

module "secret_core" {
  source = "./.terraform/modules/__v4__/key_vault_secrets_query"

  resource_group = local.key_vault_core_rg_name
  key_vault_name = local.key_vault_core_name

  secrets = [
    "metabase-db-admin-login",
    "metabase-db-admin-password",
    # "metabase-db-login",
    # "metabase-db-password"
  ]
}

data "azurerm_log_analytics_workspace" "log_analytics_italy" {
  name                = local.log_analytics_italy_workspace_name
  resource_group_name = local.log_analytics_italy_workspace_resource_group_name
}


data "azurerm_private_dns_zone" "postgres" {
  count               = var.env_short != "d" ? 1 : 0
  name                = "private.postgres.database.azure.com"
  resource_group_name = data.azurerm_resource_group.rg_vnet_core.name
}


data "azurerm_subnet" "vpn_subnet" {
  name                 = "GatewaySubnet"
  virtual_network_name = local.vnet_core_name
  resource_group_name  = local.vnet_core_resource_group_name
}

data "azurerm_private_dns_zone" "azurewebsites" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = data.azurerm_resource_group.rg_vnet_core.name
}

data "azurerm_subnet" "private_endpoint_subnet" {
  name                 = "${local.product}-common-private-endpoint-snet"
  virtual_network_name = data.azurerm_virtual_network.vnet_italy.name
  resource_group_name  = data.azurerm_resource_group.rg_vnet_italy.name
}


data "azurerm_subnet" "tools_subnet" {
  count = var.enabled_features.db_vdi ? 1 : 0
  name                 = "${local.product_location}-core-tools-cae-subnet"
  resource_group_name  = data.azurerm_resource_group.rg_vnet_italy.name
  virtual_network_name = data.azurerm_virtual_network.vnet_italy.name

}
