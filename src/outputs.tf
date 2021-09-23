output "vnet_name" {
  value = module.vnet.name
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

# output "azurerm_key_vault_certificate_management_platform" {
#   value = data.azurerm_key_vault_certificate.management_platform
# }
