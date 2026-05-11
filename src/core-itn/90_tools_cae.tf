resource "azurerm_resource_group" "tools_rg" {
  count = var.is_feature_enabled.container_app_tools_cae ? 1 : 0

  name     = "${local.project}-tools-rg"
  location = var.location

  tags = module.tag_config.tags
}

resource "azurerm_container_app_environment" "tools_cae" {
  count = var.is_feature_enabled.container_app_tools_cae ? 1 : 0

  name = "${local.project}-tools-cae"

  location            = azurerm_resource_group.tools_rg[0].location
  resource_group_name = azurerm_resource_group.tools_rg[0].name

  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
  infrastructure_subnet_id   = azurerm_subnet.subnet_container_app_tools.id

  tags = module.tag_config.tags
}

resource "azurerm_container_app_environment" "spoke_cae" {
  count = var.is_feature_enabled.container_app_tools_cae ? 1 : 0

  name = "${local.project}-spoke-tools-cae"

  location            = azurerm_resource_group.tools_rg[0].location
  resource_group_name = azurerm_resource_group.tools_rg[0].name

  log_analytics_workspace_id     = azurerm_log_analytics_workspace.log_analytics_workspace.id
  infrastructure_subnet_id       = module.spoke_subnet_container_app.id
  internal_load_balancer_enabled = true
  public_network_access          = "Disabled"

  tags = module.tag_config.tags

  lifecycle {
    ignore_changes = [
      infrastructure_resource_group_name
    ]
  }
}
