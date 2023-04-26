resource "azurerm_resource_group" "github_runner_rg" {
  name     = "${local.project}-github-runner-rg"
  location = var.location

  tags = var.tags
}

resource "azurerm_subnet" "github_runner_snet" {
  name                 = "github-runner-snet"
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  address_prefixes     = var.github_runner.subnet_address_prefixes
}

module "github_runner" {
  # source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//container_app_environment?ref=v4.1.18"
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//container_app_environment?ref=try-remove-outBoundType-managedEnvironments"

  name                      = "${local.project}-github-runner-cae"
  resource_group_name       = azurerm_resource_group.github_runner_rg.name
  location                  = var.location
  vnet_internal             = true
  subnet_id                 = azurerm_subnet.github_runner_snet.id
  log_destination           = "log-analytics"
  log_analytics_customer_id = data.azurerm_log_analytics_workspace.log_analytics.workspace_id
  log_analytics_shared_key  = data.azurerm_log_analytics_workspace.log_analytics.primary_shared_key
  zone_redundant            = false
  # outbound_type             = "loadBalancer"
  tags = var.tags
}
