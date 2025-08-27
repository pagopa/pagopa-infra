resource "azurerm_resource_group" "managed_identities_rg" {
  name     = "${local.product}-identity-rg"
  location = var.location

  tags = module.tag_config.tags
}

resource "azurerm_resource_group" "default_roleassignment_rg" {
  #Important: do not create any resource inside this resource group
  name     = "default-roleassignment-rg"
  location = var.location

  tags = module.tag_config.tags
}
