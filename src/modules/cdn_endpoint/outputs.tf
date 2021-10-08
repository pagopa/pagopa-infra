output "id" {
  value = azurerm_cdn_endpoint.cdn_endpoint.id
}

output "hostname" {
  value = "${var.name}.azureedge.net"
}

output "name" {
  value = var.name
}