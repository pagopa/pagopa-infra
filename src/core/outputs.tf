output "vnet_name" {
  value = module.vnet.name
}

output "vnet_id" {
  value = module.vnet.id
}

output "vnet_address_space" {
  value = module.vnet.address_space
}

output "vnet_integration_name" {
  value = module.vnet_integration.name
}

output "vnet_integration_address_space" {
  value = module.vnet_integration.address_space
}

output "nat_gw_outbound_ip_addresses" {
  value = var.nat_gateway_enabled ? module.nat_gw[0].public_ip_address : null
}

## Container registry ##
output "container_registry_login_server" {
  value = var.acr_enabled ? module.container_registry.login_server : null
}

output "container_registry_admin_username" {
  value = var.acr_enabled ? module.container_registry.admin_username : null
}

output "container_registry_admin_password" {
  value     = var.acr_enabled ? module.container_registry.admin_password : null
  sensitive = true
}

# Blob storage
output "nodo_test_sa_blob_host" {
  value = var.nodo_pagamenti_test_enabled ? module.nodo_test_storage[0].primary_blob_host : null
}

output "nodo_test_sa_web_host" {
  value = var.nodo_pagamenti_test_enabled ? module.nodo_test_storage[0].primary_web_host : null
}

output "nodo_test_sa_connection_string" {
  value     = var.nodo_pagamenti_test_enabled ? module.nodo_test_storage[0].primary_connection_string : null
  sensitive = true
}

output "nodo_test_sa_blob_connection_string" {
  value     = var.nodo_pagamenti_test_enabled ? module.nodo_test_storage[0].primary_blob_connection_string : null
  sensitive = true
}

output "application_insights_instrumentation_key" {
  value     = format("InstrumentationKey=%s", azurerm_application_insights.application_insights.instrumentation_key)
  sensitive = true
}

