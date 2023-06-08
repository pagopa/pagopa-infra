data "azurerm_resource_group" "rg_vnet" {
  name = "${local.project}-vnet-rg"
}