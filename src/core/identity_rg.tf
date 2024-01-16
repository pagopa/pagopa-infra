resource "azurerm_resource_group" "managed_identities_rg" {
  name     = "${local.project}-identity-rg"
  location = var.location

  tags = var.tags
}

# to avoid to delete the resource group
resource "azurerm_management_lock" "managed_identities_rg_lock" {
  name       = "identity-rg-lock"
  scope      = azurerm_resource_group.managed_identities_rg.id
  lock_level = "CanNotDelete"
  notes      = "Items can't be deleted in this subscription!"
}
