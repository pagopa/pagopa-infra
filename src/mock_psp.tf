resource "azurerm_resource_group" "mock_psp_rg" {
  count    = var.mock_psp_enabled ? 1 : 0
  name     = format("%s-mock-ec-rg", local.project)
  location = var.location

  tags = var.tags
}

module "mock_ec" {
  count  = var.mock_psp_enabled ? 1 : 0
  source = "./modules/app_service"
  # fixme # source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v1.0.14"

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
  linux_fx_version    = "JAVA|Tomcat9.0" // to check
  health_check_path   = "actuator/health"

  # Networking
  subnet_name     = module.vnet_app.name
  allowed_subnets = [module.apim_snet.id]
  allowed_ips     = []
  subnet_id       = module.appservice_snet.id


  app_settings = {
   
  }

  tags = var.tags
}