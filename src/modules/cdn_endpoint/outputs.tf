output "id" {
  value = azurerm_cdn_endpoint.cdn_endpoint.id
}

output "hostname" {
  value = "${azurerm_cdn_endpoint.cdn_endpoint.name}.azureedge.net"
}

output "name" {
  value = azurerm_cdn_endpoint.cdn_endpoint.name
}