# Subnet to host the api config
module "container_apps_snet" {
  count = var.is_resource_enabled.container_app_diego_env ? 1 : 0

  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v5.3.0"
  name                 = "${local.project}-container-apps-snet"
  address_prefixes     = var.cidr_subnet_container_apps
  virtual_network_name = data.azurerm_virtual_network.vnet_core.name

  resource_group_name = data.azurerm_resource_group.rg_vnet_core.name

  private_endpoint_network_policies_enabled = true
}


resource "azurerm_container_app_environment" "diego_env" {
  count = var.is_resource_enabled.container_app_diego_env ? 1 : 0

  name                       = local.container_app_diego_environment_name
  location                   = azurerm_resource_group.container_app_diego.location
  resource_group_name        = azurerm_resource_group.container_app_diego.name
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics.id
  infrastructure_subnet_id   = module.container_apps_snet[0].id
}
