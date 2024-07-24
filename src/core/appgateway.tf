data "azurerm_application_gateway" "app_gw" {
  name                = format("%s-app-gw", local.project)
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}
