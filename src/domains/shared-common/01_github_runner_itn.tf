data "azurerm_virtual_network" "vnet_ita" {
  name                = "${local.product}-${var.location_short_italy}-vnet"
  resource_group_name = "${local.product}-${var.location_short_italy}-vnet-rg"
}

resource "azurerm_resource_group" "github_runner_rg_italy" {
  count = var.github_runner_ita_enabled ? 1 : 0

  name     = "${var.prefix}-${var.env_short}-${var.location_short_italy}-github-runner-rg"
  location = var.location_italy

  tags = var.tags
}

resource "azurerm_subnet" "github_runner_snet_italy" {
  count = var.github_runner_ita_enabled ? 1 : 0

  name                 = "github-runner-snet-ita"
  resource_group_name  = data.azurerm_virtual_network.vnet_ita.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_ita.name
  address_prefixes     = var.github_runner_italy.subnet_address_prefixes
}

module "github_runner_environment_italy" { # itn
  count  = var.github_runner_ita_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//container_app_environment_v2?ref=v8.53.0"

  name                       = "${var.prefix}-${var.env_short}-${var.location_short_italy}-github-runner-cae"
  resource_group_name        = azurerm_resource_group.github_runner_rg_italy[0].name
  location                   = var.location_italy
  subnet_id                  = azurerm_subnet.github_runner_snet_italy[0].id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics.id
  zone_redundant             = false
  internal_load_balancer     = true

  tags = var.tags
}

