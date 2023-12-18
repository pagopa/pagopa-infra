data "azurerm_resource_group" "data" {
  name = format("%s-data-rg", local.product)
}
