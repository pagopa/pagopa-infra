# Subnet to host the api config
module "container_apps_dns_forwardersnet" {
  count = var.env_short == "u" ? 1 : 0

  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v5.3.0"
  name                 = "${local.project}-capp-dns-forwarder-snet"
  address_prefixes     = ["10.1.250.0/23"]
  virtual_network_name = data.azurerm_virtual_network.vnet_core.name

  resource_group_name = data.azurerm_resource_group.rg_vnet_core.name

  private_endpoint_network_policies_enabled = true
}


resource "azurerm_container_app_environment" "dns_forwarder_env" {
  count = var.env_short == "u" ? 1 : 0
  name                       = local.container_app_dns_forwarder_environment_name
  location                   = data.azurerm_resource_group.rg_vnet_core.name.location
  resource_group_name        = data.azurerm_resource_group.rg_vnet_core.name.name
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics.id
  infrastructure_subnet_id   = module.container_apps_dns_forwardersnet[0].id
}
