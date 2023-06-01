data "azurerm_subnet" "apim_snet" {
  name                 = local.apim_subnet_name
  virtual_network_name = local.vnet_integration_name
  resource_group_name  = local.vnet_resource_group_name
}

data "azurerm_application_insights" "application_insights" {
  name                = local.monitor_appinsights_name
  resource_group_name = var.monitor_resource_group_name
}