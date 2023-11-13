# apim
data "azurerm_api_management" "apim" {
  name                = "${local.product}-apim"
  resource_group_name = data.azurerm_resource_group.rg_api.name
}

data "azurerm_resource_group" "rg_api" {
  name = "${local.product}-api-rg"
}

