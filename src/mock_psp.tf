resource "azurerm_resource_group" "mock_psp_rg" {
  count    = var.mock_psp_enabled ? 1 : 0
  name     = format("%s-mock-psp-rg", local.project)
  location = var.location

  tags = var.tags
}

# Subnet to host the mock psp
module "mock_psp_snet" {
  count                                          = var.mock_psp_enabled && var.cidr_subnet_mock_psp != null ? 1 : 0
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-mock-psp-snet", local.project)
  address_prefixes                               = var.cidr_subnet_mock_psp
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name
  enforce_private_link_endpoint_network_policies = true

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "mock_psp" {
  count  = var.mock_psp_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v1.0.14"

  resource_group_name = azurerm_resource_group.mock_psp_rg[0].name
  location            = var.location

  # App service plan vars
  plan_name     = format("%s-plan-mock-psp", local.project)
  plan_kind     = "Linux"
  plan_sku_tier = var.mock_psp_tier
  plan_sku_size = var.mock_psp_size
  plan_reserved = true # Mandatory for Linux plan

  # App service plan
  name                = format("%s-app-mock-psp", local.project)
  client_cert_enabled = false
  always_on           = var.mock_psp_always_on
  linux_fx_version    = "TOMCAT|9.0-java11"
  health_check_path   = "/mockPspService/api/v1/info"

  app_settings = {
  }

  allowed_subnets = [module.apim_snet.id]
  allowed_ips     = []

  subnet_name = module.mock_psp_snet[0].name
  subnet_id   = module.mock_psp_snet[0].id

  tags = var.tags
}
