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


output "application_insights_instrumentation_key" {
  value     = format("InstrumentationKey=%s", data.azurerm_application_insights.application_insights.instrumentation_key)
  sensitive = true
}

