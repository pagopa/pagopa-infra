resource "azurerm_resource_group" "data" {
  name     = format("%s-data-rg", local.project)
  location = var.location

  tags = var.tags
}


resource "azurerm_resource_group" "flex_data" {
  name     = format("%s-flex-data-rg", local.project)
  location = var.location

  tags = var.tags
}
