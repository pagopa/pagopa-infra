resource "azurerm_resource_group" "api_config_rg" {
  count    = var.api_config_enabled ? 1 : 0
  name     = format("%s-api-config-rg", local.project)
  location = var.location

  tags = var.tags
}

# Subnet to host the api config
module "api_config_snet" {
  count                                          = var.api_config_enabled && var.cidr_subnet_api_config != null ? 1 : 0
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-api-config-snet", local.project)
  address_prefixes                               = var.cidr_subnet_api_config
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name # we temporarily use vnet to test.
  enforce_private_link_endpoint_network_policies = true

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "api_config_app_service" {
  count  = var.api_config_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v1.0.14"

  resource_group_name = azurerm_resource_group.api_config_rg[0].name
  location            = var.location

  # App service plan vars
  plan_name     = format("%s-plan-api-config", local.project)
  plan_kind     = "Linux"
  plan_sku_tier = var.api_config_tier
  plan_sku_size = var.api_config_size
  plan_reserved = true # Mandatory for Linux plan

  # App service plan
  name                = format("%s-app-api-config", local.project)
  client_cert_enabled = false
  always_on           = var.api_config_always_on
  linux_fx_version    = "TOMCAT|9.0-java11"
  health_check_path   = "/apiconfig/api/v1/info"

  app_settings = {
  }

  allowed_subnets = [module.apim_snet.id]
  allowed_ips     = []

  subnet_name = module.api_config_snet[0].name
  subnet_id   = module.api_config_snet[0].id

  tags = var.tags
}
