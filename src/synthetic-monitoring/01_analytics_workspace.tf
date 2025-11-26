resource "azurerm_resource_group" "synthetic_rg" {
  location = var.location
  name     = "${local.project}-rg"
}


resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                               = "${local.project}-law"
  location                           = azurerm_resource_group.synthetic_rg.location
  resource_group_name                = azurerm_resource_group.synthetic_rg.name
  sku                                = var.law_sku
  retention_in_days                  = var.law_retention_in_days
  daily_quota_gb                     = var.law_daily_quota_gb
  reservation_capacity_in_gb_per_day = var.env_short == "p" ? 100 : null

  tags = module.tag_config.tags

  lifecycle {
    ignore_changes = [
      sku,
      reservation_capacity_in_gb_per_day
    ]
  }
}

# Application insights
resource "azurerm_application_insights" "application_insights" {
  name                = "${local.project}-appinsights"
  location            = azurerm_resource_group.synthetic_rg.location
  resource_group_name = azurerm_resource_group.synthetic_rg.name
  application_type    = "other"

  workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id

  tags = module.tag_config.tags
}

