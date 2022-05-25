resource "azurerm_resource_group" "rg_aks" {
  name     = format("%s-aks-rg", local.project)
  location = var.location
  tags     = var.tags
}

module "acr" {
  source              = "git::https://github.com/pagopa/azurerm.git//container_registry?ref=v1.0.7"
  count               = var.acr_enabled ? 1 : 0
  name                = replace(format("%s-acr", local.project), "-", "")
  resource_group_name = azurerm_resource_group.rg_aks.name
  location            = azurerm_resource_group.rg_aks.location
  admin_enabled       = true

  tags = var.tags
}
