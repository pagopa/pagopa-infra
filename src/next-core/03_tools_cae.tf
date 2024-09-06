resource "azurerm_resource_group" "tools_rg" {
  count = var.is_feature_enabled.container_app_tools_cae ? 1 : 0

  name     = "${local.product}-${var.domain}-tools-rg"
  location = var.location

  tags = var.tags
}

resource "azurerm_subnet" "tools_cae_subnet" {
  name                 = "${local.product}-tools-cae-subnet"
  resource_group_name  = module.vnet.resource_group_name
  virtual_network_name = module.vnet.name
  address_prefixes     = var.cidr_subnet_tools_cae
}

resource "azurerm_container_app_environment" "tools_cae" {
  count = var.is_feature_enabled.container_app_tools_cae ? 1 : 0

  name                       = "${local.product}-tools-cae"
  location                   = azurerm_resource_group.tools_rg[0].location
  resource_group_name        = azurerm_resource_group.tools_rg[0].name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
  infrastructure_subnet_id   = azurerm_subnet.tools_cae_subnet.id
}
