data "azurerm_subnet" "apim_snet" {
  name                 = local.apim_subnet_name
  virtual_network_name = local.vnet_integration_name
  resource_group_name  = local.vnet_resource_group_name
}

data "azurerm_subnet" "apim_v2_snet" {
  name                 = "${local.product}-${var.location_short}-core-apimv2-snet"
  virtual_network_name = local.vnet_integration_name
  resource_group_name  = local.vnet_resource_group_name
}

data "azurerm_application_insights" "application_insights" {
  name                = local.monitor_appinsights_name
  resource_group_name = var.monitor_resource_group_name
}

data "azurerm_key_vault" "kv" {
  name                = "${local.product}-kv"
  resource_group_name = "${local.product}-sec-rg"
}
