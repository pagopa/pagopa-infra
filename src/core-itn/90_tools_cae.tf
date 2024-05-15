resource "azurerm_resource_group" "tools_rg" {
  count = var.is_feature_enabled.container_app_tools_cae ? 1 : 0

  name     = "${local.project}-tools-rg"
  location = var.location

  tags = var.tags
}

resource "azurerm_container_app_environment" "tools_cae" {
  count = var.is_feature_enabled.container_app_tools_cae ? 1 : 0

  name = "${local.project}-tools-cae"

  location            = azurerm_resource_group.tools_rg[0].location
  resource_group_name = azurerm_resource_group.tools_rg[0].name

  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
  infrastructure_subnet_id   = azurerm_subnet.subnet_container_app_tools.id
}

resource "azurerm_management_lock" "lock_cae" {
  lock_level = "CanNotDelete"
  name       = azurerm_container_app_environment.tools_cae[0].name
  scope      = azurerm_container_app_environment.tools_cae[0].id
  notes      = "This Container App Environment cannot be deleted"
}
