resource "azurerm_resource_group" "nodo_switcher" {
  name     = "${local.project}-nodo-switcher-rg"
  location = var.location
}
