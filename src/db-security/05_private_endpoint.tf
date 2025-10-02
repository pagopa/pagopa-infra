resource "azurerm_private_dns_zone" "private_dns_vdi" {
      count = var.enabled_features.db_vdi ? 1 : 0
  name                = "privatelink.wvd.microsoft.com"
  resource_group_name = azurerm_resource_group.vdi_rg[0].name
  tags                = module.tag_config.tags
}

resource "azurerm_private_dns_zone" "private_dns_vdi_global" {
      count = var.enabled_features.db_vdi ? 1 : 0
  name                = "privatelink-global.wvd.microsoft.com"
  resource_group_name = azurerm_resource_group.vdi_rg[0].name
  tags                = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "vdi_local_to_core_vnet" {
  count = var.enabled_features.db_vdi ? 1 : 0
  name                  = local.vnet_core_name
  resource_group_name   = local.vnet_core_resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_vdi[0].name
  virtual_network_id    = data.azurerm_virtual_network.vnet_core.id
  registration_enabled  = false

  tags = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "vdi_global_to_core_vnet" {
  count = var.enabled_features.db_vdi ? 1 : 0
  name                  = local.vnet_core_name
  resource_group_name   = local.vnet_core_resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_vdi_global[0].name
  virtual_network_id    = data.azurerm_virtual_network.vnet_core.id
  registration_enabled  = false

  tags = module.tag_config.tags
}

resource "azurerm_private_endpoint" "host_pool_pe" {
    count = var.enabled_features.db_vdi ? 1 : 0
  name                = "${local.project_vdi}-hosptool-pe"
  location            = var.db_vdi_settings.location
  resource_group_name = azurerm_resource_group.vdi_rg[0].name
  subnet_id           = data.azurerm_subnet.tools_subnet[0].id


  private_dns_zone_group {
    name                 = "privatelink.wvd.microsoft.com"
    private_dns_zone_ids = [azurerm_private_dns_zone.private_dns_vdi[0].id]
  }

  private_service_connection {
    is_manual_connection           = false
    name                           = "${local.project_vdi}-hosptool-sconn"
    private_connection_resource_id = azurerm_virtual_desktop_host_pool.vdi_host_pool[0].id
    subresource_names              = ["connection"]
  }
  tags = module.tag_config.tags
}

resource "azurerm_private_endpoint" "workspace_pe" {
    count = var.enabled_features.db_vdi ? 1 : 0
  name                = "${local.project_vdi}-workspace-feed-pe"
  location            = var.db_vdi_settings.location
  resource_group_name = azurerm_resource_group.vdi_rg[0].name
  subnet_id           = data.azurerm_subnet.tools_subnet[0].id

  private_dns_zone_group {
    name                 = "privatelink.wvd.microsoft.com"
    private_dns_zone_ids = [azurerm_private_dns_zone.private_dns_vdi[0].id]
  }

  private_service_connection {
    is_manual_connection           = false
    name                           = "${local.project_vdi}-workspace-feed-sconn"
    private_connection_resource_id = azurerm_virtual_desktop_workspace.workspace[0].id
    subresource_names              = ["feed"]
  }
  tags = module.tag_config.tags
}

resource "azurerm_private_endpoint" "workspace_global_pe" {
    count = var.enabled_features.db_vdi ? 1 : 0
  name                = "${local.project_vdi}-workspace-global-pe"
  location            = var.db_vdi_settings.location
  resource_group_name = azurerm_resource_group.vdi_rg[0].name
  subnet_id           = data.azurerm_subnet.tools_subnet[0].id

  private_dns_zone_group {
    name                 = "privatelink-global.wvd.microsoft.com"
    private_dns_zone_ids = [azurerm_private_dns_zone.private_dns_vdi_global[0].id]
  }

  private_service_connection {
    is_manual_connection           = false
    name                           = "${local.project_vdi}-workspace-global-sconn"
    private_connection_resource_id = azurerm_virtual_desktop_workspace.workspace[0].id
    subresource_names              = ["global"]
  }
  tags = module.tag_config.tags
}
