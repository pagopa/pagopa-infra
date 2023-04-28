resource "azurerm_resource_group" "gpd_rg" {
  name     = format("%s-gpd-rg", local.project)
  location = var.location

  tags = var.tags
}

# gpd service plan

resource "azurerm_app_service_plan" "gpd_service_plan" {
  name                = format("%s-plan-gpd", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.gpd_rg.name

  kind     = var.gpd_plan_kind
  reserved = var.gpd_plan_kind == "Linux" ? true : false

  sku {
    tier = var.gpd_plan_sku_tier
    size = var.gpd_plan_sku_size
  }

  tags = var.tags
}
