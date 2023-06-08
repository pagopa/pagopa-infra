resource "azurerm_resource_group" "canoneunico_rg" {
  name     = format("%s-canoneunico-rg", local.project)
  location = var.location

  tags = var.tags
}

# canone unico service plan

resource "azurerm_app_service_plan" "canoneunico_service_plan" {
  name                = format("%s-plan-canoneunico", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.canoneunico_rg.name

  kind     = var.canoneunico_plan_kind
  reserved = var.canoneunico_plan_kind == "Linux" ? true : false

  sku {
    tier = var.canoneunico_plan_sku_tier
    size = var.canoneunico_plan_sku_size
  }

  tags = var.tags
}
