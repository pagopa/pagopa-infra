# gpd_rg
resource "azurerm_resource_group" "gpd_rg" {
  name     = "${local.product}-gpd-rg"
  location = var.location

  tags = module.tag_config.tags
}
