data "azurerm_resource_group" "rg_api" {
  name = format("%s-api-rg", local.product)
}

data "azurerm_api_management" "apim" {
  name                = "${local.product}-apim"
  resource_group_name = data.azurerm_resource_group.rg_api.name
}
