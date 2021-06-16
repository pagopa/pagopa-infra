output "plan_name" {
  value = azurerm_app_service_plan.app_service_plan.name
}

output "fqdn" {
  value = azurerm_app_service.app_service.default_site_hostname
}
