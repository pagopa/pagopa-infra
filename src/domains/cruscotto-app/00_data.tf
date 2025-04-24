data "azurerm_api_management" "apim" {
  name                = "${var.prefix}-${var.env_short}-apim"
  resource_group_name = "${var.prefix}-${var.env_short}-api-rg"
}
data "azurerm_resource_group" "identity_rg" {
  name = "${local.product}-identity-rg"
}
