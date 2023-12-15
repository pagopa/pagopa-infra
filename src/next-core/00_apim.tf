data "azurerm_api_management" "apim" {
  name                = format("%s-apim", local.product)
  resource_group_name = format("%s-api-rg", local.product)
}
