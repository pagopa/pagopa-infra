locals {
  portal_image_name_no_registry = replace(var.container_image_name, "${data.azurerm_container_registry.acr.login_server}/", "")
  portal_docker_image_name      = length(split(":", local.portal_image_name_no_registry)) > 1 ? local.portal_image_name_no_registry : "${local.portal_image_name_no_registry}:latest"
}

resource "azurerm_service_plan" "portal" {
  name                = "${local.project}-plan"
  resource_group_name = azurerm_resource_group.portal.name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.app_service_sku_name

  tags = module.tag_config.tags
}

resource "azurerm_linux_web_app" "portal" {
  name                = "${local.project}-app"
  resource_group_name = azurerm_resource_group.portal.name
  location            = var.location
  service_plan_id     = azurerm_service_plan.portal.id
  https_only          = true

  identity {
    type = "SystemAssigned"
  }

  app_settings = local.app_settings

  site_config {
    always_on                               = true
    container_registry_use_managed_identity = true

    application_stack {
      docker_image_name   = local.portal_docker_image_name
      docker_registry_url = format("https://%s", data.azurerm_container_registry.acr.login_server)
    }
  }

  tags = module.tag_config.tags
}

resource "azurerm_role_assignment" "portal_acr_pull" {
  scope                = data.azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_linux_web_app.portal.identity[0].principal_id
}

resource "azurerm_key_vault_access_policy" "portal_webapp" {
  key_vault_id = data.azurerm_key_vault.portal.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_linux_web_app.portal.identity[0].principal_id

  secret_permissions = ["Get", "List"]
}
