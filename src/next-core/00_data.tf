data "azurerm_resource_group" "rg_vnet" {
  name = format("%s-vnet-rg", local.product)
}
