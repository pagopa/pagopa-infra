
resource "azurerm_private_dns_zone" "db_nodo_dns_zone" {
  name                = var.private_dns_zone_db_nodo_pagamenti
  resource_group_name = azurerm_resource_group.data.name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "db_nodo_dns_zone_virtual_link" {
  name                  = format("%s-db_nodo-private-dns-zone-link", local.project)
  resource_group_name   = azurerm_resource_group.data.name
  private_dns_zone_name = azurerm_private_dns_zone.db_nodo_dns_zone.name
  virtual_network_id    = module.vnet_integration.id

  tags = var.tags
}

resource "azurerm_private_endpoint" "db_nodo_private_endpoint" {
  name                = format("%s-db_nodo-private-endpoint", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.data.name
  subnet_id           = module.subnet_db.id

  private_dns_zone_group {
    name                 = format("%s-db_nodo-private-dns-zone-group", local.project)
    private_dns_zone_ids = [azurerm_private_dns_zone.db_nodo_dns_zone.id]
  }

  private_service_connection {
    name                           = format("%s-db_nodo-private-service-connection", azurerm_db_nodo_server.db_nodo_server.name)
    private_connection_resource_id = azurerm_db_nodo_server.db_nodo_server.id
    is_manual_connection           = false
    subresource_names              = ["db_nodoServer"]
  }

  tags = var.tags
}

resource "azurerm_private_dns_a_record" "private_dns_a_record_db_nodo" {
  name                = "db-nodo-pagamenti"
  zone_name           = azurerm_private_dns_zone.db_nodo_dns_zone.name
  resource_group_name = azurerm_resource_group.data.name
  ttl                 = 300
  records             = azurerm_private_endpoint.db_nodo_private_endpoint.private_service_connection.*.private_ip_address
}
