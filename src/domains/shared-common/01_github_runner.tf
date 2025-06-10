resource "azurerm_resource_group" "github_runner_rg" {
  name     = "${var.prefix}-${var.env_short}-${var.location_short}-github-runner-rg"
  location = var.location

  tags = module.tag_config.tags
}

resource "azurerm_subnet" "github_runner_snet" {
  name                 = "github-runner-snet"
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  address_prefixes     = var.github_runner.subnet_address_prefixes
}


module "github_runner_environment" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//container_app_environment_v2?ref=v8.53.0"

  name                       = "${var.prefix}-${var.env_short}-${var.location_short}-github-runner-cae"
  resource_group_name        = azurerm_resource_group.github_runner_rg.name
  location                   = var.location
  subnet_id                  = azurerm_subnet.github_runner_snet.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics.id
  zone_redundant             = false
  internal_load_balancer     = true

  tags = module.tag_config.tags
}

