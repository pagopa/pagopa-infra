data "azurerm_container_app_environment" "tools_cae" {
  name                = "${local.product}-tools-cae"
  resource_group_name = "${local.product}-core-tools-rg"
}


data "azurerm_resource_group" "tools_rg" {
  count = var.enabled_resource.container_app_tools_cae ? 1 : 0
  name  = "${local.product}-core-tools-rg"
}



data "azurerm_monitor_action_group" "slack" {
  resource_group_name = local.monitor_resource_group_name
  name                = local.monitor_action_group_slack_name
}

data "azurerm_monitor_action_group" "infra_opsgenie" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = local.monitor_resource_group_name
  name                = local.monitor_action_group_infra_opsgenie_name
}

data "azurerm_monitor_action_group" "email" {
  resource_group_name = local.monitor_resource_group_name
  name                = local.monitor_action_group_email_name
}

data "azurerm_resource_group" "rg_vnet_core" {
  name = local.vnet_core_resource_group_name
}


data "azurerm_private_dns_zone" "storage_account_table" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = data.azurerm_resource_group.rg_vnet_core.name
}

data "azurerm_virtual_network" "vnet_core" {
  name                = local.vnet_core_name
  resource_group_name = local.vnet_core_resource_group_name
}

data "azurerm_subnet" "private_endpoint_subnet" {
  count                = var.use_private_endpoint ? 1 : 0
  name                 = "${local.product}-common-private-endpoint-snet"
  resource_group_name  = data.azurerm_resource_group.rg_vnet_core.name
  virtual_network_name = data.azurerm_virtual_network.vnet_core.name
}

data "azurerm_public_ip" "appgateway_public_ip" {
  name                = format("%s-appgateway-pip", local.product)
  resource_group_name = data.azurerm_resource_group.rg_vnet_core.name
}
