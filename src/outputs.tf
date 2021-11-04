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

output "nat_gw_outbound_ip_addresses" {
  value = var.nat_gateway_enabled ? module.nat_gw[0].public_ip_address : null
}

## Container registry ##
output "container_registry_login_server" {
  value = module.acr[0].login_server
}

output "container_registry_admin_username" {
  value = module.acr[0].admin_username
}

output "container_registry_admin_password" {
  value     = module.acr[0].admin_password
  sensitive = true
}
