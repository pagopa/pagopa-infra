output "vnet_name" {
  value = data.azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  value = data.azurerm_virtual_network.vnet.id
}

output "vnet_address_space" {
  value = data.azurerm_virtual_network.vnet.address_space
}

output "vnet_integration_name" {
  value = data.azurerm_virtual_network.vnet_integration.name
}

output "vnet_integration_address_space" {
  value = data.azurerm_virtual_network.vnet_integration.address_space
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
  value     = format("InstrumentationKey=%s", data.azurerm_application_insights.application_insights.instrumentation_key)
  sensitive = true
}

