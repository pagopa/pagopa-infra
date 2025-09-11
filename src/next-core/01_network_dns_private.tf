# db dns

resource "azurerm_private_dns_zone" "private_db_dns_zone" {
  count               = var.is_feature_enabled.postgres_private_dns ? 1 : 0
  name                = "${var.env_short}.internal.postgresql.pagopa.it"
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_db_zone_to_core_vnet" {
  count = var.is_feature_enabled.postgres_private_dns ? 1 : 0

  name                  = module.vnet.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.private_db_dns_zone[0].name
  virtual_network_id    = module.vnet.id
  registration_enabled  = false

  tags = module.tag_config.tags
}
