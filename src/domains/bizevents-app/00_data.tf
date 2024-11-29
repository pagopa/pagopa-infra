data "azurerm_resource_group" "identity_rg" {
  name = "${local.product}-identity-rg"
}
