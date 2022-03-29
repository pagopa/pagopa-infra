resource "azurerm_resource_group" "data" {
  name     = format("%s-data-rg", local.project)
  location = var.location

  tags = var.tags
}


resource "azurerm_resource_group" "flex_data" {
  count = var.env_short != "d" ? 1 : 0

  name     = format("%s-flex-data-rg", local.project)
  location = var.location

  tags = var.tags
}
