data "azurerm_resource_group" "identity_rg" {
  name = "${local.product}-identity-rg"
}

data "azuread_application" "apiconfig-fe" {
  display_name = format("pagopa-%s-apiconfig-fe", var.env_short)
}
