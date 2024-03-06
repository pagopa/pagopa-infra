resource "azurerm_app_configuration" "selfcare_appconf" {
  name                = "${local.project}-app-conf"
  resource_group_name = azurerm_resource_group.bopagopa_rg.name
  location            = azurerm_resource_group.bopagopa_rg.location
}


resource "azurerm_role_assignment" "selfcare_appconf_dataowner" {
  scope                = azurerm_app_configuration.selfcare_appconf.id
  role_definition_name = "App Configuration Data Owner"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_app_configuration_feature" "maintenance_banner_flag" {
  configuration_store_id = azurerm_app_configuration.selfcare_appconf.id
  description            = "It enables the banner"
  name                   = "maintenance-banner"
  enabled                = false

  lifecycle {
    ignore_changes = [
      enabled,
    ]
  }
}

resource "azurerm_app_configuration_feature" "maintenance_flag" {
  configuration_store_id = azurerm_app_configuration.selfcare_appconf.id
  description            = "It enables the Maintenance Page"
  name                   = "maintenance"
  enabled                = false

  lifecycle {
    ignore_changes = [
      enabled,
    ]
  }
}
