resource "azurerm_resource_group" "identity_rg" {
  name     = "${var.prefix}-${var.env_short}-identity-rg"
  location = var.location

  tags = var.tags
}
