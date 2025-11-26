data "azurerm_api_management" "apim" {
  name                = "${local.product}-apim"
  resource_group_name = "${local.product}-api-rg"
}

data "azurerm_resource_group" "identity_rg" {
  name = "${local.product}-identity-rg"
}
