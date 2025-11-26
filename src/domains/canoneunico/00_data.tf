locals {
  monitor_action_group_opsgenie_name = "Opsgenie"
}

# resource_group
data "azurerm_resource_group" "rg_vnet" {
  name = "${local.project}-vnet-rg"
}

data "azurerm_resource_group" "container_registry_rg" {
  name = "${local.project}-container-registry-rg"
}

data "azurerm_resource_group" "monitor_rg" {
  name = "${local.project}-monitor-rg"
}

# vnet
data "azurerm_virtual_network" "vnet" {
  name                = "${local.project}-vnet"
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}

data "azurerm_virtual_network" "vnet_integration" {
  name                = "${local.project}-vnet-integration"
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}

# snet

data "azurerm_subnet" "apim_snet" {
  name                 = "${local.project}-apim-snet"
  virtual_network_name = data.azurerm_virtual_network.vnet_integration.name
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
}

# application_insights
data "azurerm_application_insights" "application_insights" {
  name                = "${local.project}-appinsights"
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
}

# container registry
data "azurerm_container_registry" "login_server" {
  name                = replace("${local.project}-common-acr", "-", "")
  resource_group_name = data.azurerm_resource_group.container_registry_rg.name
}

# monitor_action_group
data "azurerm_monitor_action_group" "email" {
  name                = "PagoPA"
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
}

data "azurerm_monitor_action_group" "slack" {
  name                = "SlackPagoPA"
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
}

data "azurerm_monitor_action_group" "opsgenie" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_opsgenie_name
}
