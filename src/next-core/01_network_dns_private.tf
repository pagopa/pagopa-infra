# db dns

resource "azurerm_private_dns_zone" "private_db_dns_zone" {
  count               = var.postgres_private_dns_enabled ? 1 : 0
  name                = "${var.env_short}.internal.postgresql.pagopa.it"
  resource_group_name = data.azurerm_resource_group.rg_vnet_core.name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_db_zone_to_core_vnet" {
  count = var.postgres_private_dns_enabled ? 1 : 0

  name                  = data.azurerm_virtual_network.vnet_core.name
  resource_group_name   = data.azurerm_resource_group.rg_vnet_core.name
  private_dns_zone_name = azurerm_private_dns_zone.private_db_dns_zone[0].name
  virtual_network_id    = data.azurerm_virtual_network.vnet_core.id
  registration_enabled  = false

  tags = var.tags
}
