# resource_group
data "azurerm_resource_group" "rg_vnet" {
  name = format("%s-vnet-rg", local.project)
}

data "azurerm_resource_group" "container_registry_rg" {
  name = format("%s-container-registry-rg", local.project)
}

data "azurerm_resource_group" "monitor_rg" {
  name = format("%s-monitor-rg", local.project)
}

# vnet
data "azurerm_virtual_network" "vnet" {
  name                = format("%s-vnet", local.project)
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}

data "azurerm_virtual_network" "vnet_integration" {
  name                = format("%s-vnet-integration", local.project)
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}

# snet

data "azurerm_subnet" "apim_snet" {
  name                 = format("%s-apim-snet", local.project)
  virtual_network_name = data.azurerm_virtual_network.vnet_integration.name
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
}


# application_insights
data "azurerm_application_insights" "application_insights" {
  name                = format("%s-appinsights", local.project)
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
}

# container registry
data "azurerm_container_registry" "login_server" {
  name                = replace(format("%s-common-acr", local.project), "-", "")
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