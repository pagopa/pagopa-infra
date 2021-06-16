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


  app_settings = {
    CERT_PEM = data.azurerm_key_vault_certificate_data.app_kv_cert_data.pem
    KEY      = data.azurerm_key_vault_certificate_data.app_kv_cert_data.key
  }

}
