data "azurerm_container_app_environment" "tools_cae" {
  name                = "${local.product}-tools-cae"
  resource_group_name = "${local.product}-core-tools-rg"
}


data "azurerm_resource_group" "tools_rg" {
  count = var.enabled_resource.container_app_tools_cae ? 1 : 0
  name  = "${local.product}-core-tools-rg"
}

data "azurerm_resource_group" "monitor_rg" {
  name = local.monitor_resource_group_name
}

data "azurerm_log_analytics_workspace" "log_analytics" {
  name                = local.log_analytics_workspace_name
  resource_group_name = local.log_analytics_workspace_resource_group_name
}

data "azurerm_application_insights" "application_insights" {
  name                = local.monitor_appinsights_name
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
}

data "azurerm_monitor_action_group" "slack" {
  resource_group_name = local.monitor_resource_group_name
  name                = local.monitor_action_group_slack_name
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

