output "resource_group_name" {
  value = azurerm_resource_group.portal.name
}

output "app_service_name" {
  value = azurerm_linux_web_app.portal.name
}

output "app_service_default_hostname" {
  value = azurerm_linux_web_app.portal.default_hostname
}

output "app_service_principal_id" {
  value = azurerm_linux_web_app.portal.identity[0].principal_id
}
