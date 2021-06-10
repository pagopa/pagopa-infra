resource "azurerm_resource_group" "app_service_rg" {
  name     = format("%s-app-rg", local.project)
  location = var.location
}

resource "azurerm_app_service_plan" "app_service_plan" {
  name                = var.plan_name
  location            = var.location
  resource_group_name = azurerm_resource_group.app_service_rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app_service" {
  name                = format("%s-app-mockec", var.prefix)
  location            = var.location
  resource_group_name = azurerm_resource_group.app_service_rg.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id
  https_only          = true
  client_cert_enabled = true

  site_config {
    always_on         = var.always_on
    linux_fx_version  = var.linux_fx_version
    app_command_line  = var.app_command_line
    min_tls_version   = "1.2"
    ftps_state        = "Disabled"
    health_check_path = var.health_check_path != null ? var.health_check_path : null
  }

  identity {
    type = "SystemAssigned"
  }


}
