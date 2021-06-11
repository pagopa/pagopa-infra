resource "azurerm_resource_group" "app_service_rg" {
  name     = format("%s-app-rg", local.project)
  location = var.location
}


module "mockpa_service" {
  source = "./modules/app_service"

  resource_group    = azurerm_resource_group.app_service_rg.name
  location          = var.location
  prefix            = local.project
  name              = format("partner")
  always_on         = true
  linux_fx_version  = null
  app_command_line  = null
  health_check_path = ""

}
