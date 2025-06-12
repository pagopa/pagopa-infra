resource "azurerm_private_dns_zone_virtual_network_link" "db_nodo_pagamenti_com_vnet_link" {
  name                  = module.vnet_italy[0].name
  private_dns_zone_name = data.azurerm_private_dns_zone.db_nodo_pagamenti_com.name
  resource_group_name   = data.azurerm_private_dns_zone.db_nodo_pagamenti_com.resource_group_name
  virtual_network_id    = module.vnet_italy[0].id
  tags                  = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "internal_postgresql_pagopa_it_vnet_link" {
  name                  = module.vnet_italy[0].name
  private_dns_zone_name = data.azurerm_private_dns_zone.internal_postgresql_pagopa_it.name
  resource_group_name   = data.azurerm_private_dns_zone.internal_postgresql_pagopa_it.resource_group_name
  virtual_network_id    = module.vnet_italy[0].id
  tags                  = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "env_platform_pagopa_it_vnet_link" {
  name                  = module.vnet_italy[0].name
  private_dns_zone_name = data.azurerm_private_dns_zone.env_platform_pagopa_it.name
  resource_group_name   = data.azurerm_private_dns_zone.env_platform_pagopa_it.resource_group_name
  virtual_network_id    = module.vnet_italy[0].id
  tags                  = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "internal_env_platform_pagopa_it_vnet_link" {
  name                  = module.vnet_italy[0].name
  private_dns_zone_name = data.azurerm_private_dns_zone.internal_env_platform_pagopa_it.name
  resource_group_name   = data.azurerm_private_dns_zone.internal_env_platform_pagopa_it.resource_group_name
  virtual_network_id    = module.vnet_italy[0].id
  tags                  = module.tag_config.tags
}

moved {
  from = azurerm_private_dns_zone_virtual_network_link.internal_dev_platform_pagopa_it_vnet_link
  to   = azurerm_private_dns_zone_virtual_network_link.internal_env_platform_pagopa_it_vnet_link
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_azurecr_io_vnet_link" {
  name                  = module.vnet_italy[0].name
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_azurecr_io.name
  resource_group_name   = data.azurerm_private_dns_zone.privatelink_azurecr_io.resource_group_name
  virtual_network_id    = module.vnet_italy[0].id
  tags                  = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_blob_core_windows_net_vnet_link" {
  name                  = module.vnet_italy[0].name
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_blob_core_windows_net.name
  resource_group_name   = data.azurerm_private_dns_zone.privatelink_blob_core_windows_net.resource_group_name
  virtual_network_id    = module.vnet_italy[0].id
  tags                  = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_datafactory_azure_net_vnet_link" {
  name                  = module.vnet_italy[0].name
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_datafactory_azure_net.name
  resource_group_name   = data.azurerm_private_dns_zone.privatelink_datafactory_azure_net.resource_group_name
  virtual_network_id    = module.vnet_italy[0].id
  tags                  = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_documents_azure_com_vnet_link" {
  name                  = module.vnet_italy[0].name
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_documents_azure_com.name
  resource_group_name   = data.azurerm_private_dns_zone.privatelink_documents_azure_com.resource_group_name
  virtual_network_id    = module.vnet_italy[0].id
  tags                  = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_mongo_cosmos_azure_com_vnet_link" {
  name                  = module.vnet_italy[0].name
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_mongo_cosmos_azure_com.name
  resource_group_name   = data.azurerm_private_dns_zone.privatelink_mongo_cosmos_azure_com.resource_group_name
  virtual_network_id    = module.vnet_italy[0].id
  tags                  = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_queue_core_windows_net_vnet_link" {
  name                  = module.vnet_italy[0].name
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_queue_core_windows_net.name
  resource_group_name   = data.azurerm_private_dns_zone.privatelink_queue_core_windows_net.resource_group_name
  virtual_network_id    = module.vnet_italy[0].id
  tags                  = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_redis_cache_windows_net_vnet_link" {
  name                  = module.vnet_italy[0].name
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_redis_cache_windows_net.name
  resource_group_name   = data.azurerm_private_dns_zone.privatelink_redis_cache_windows_net.resource_group_name
  virtual_network_id    = module.vnet_italy[0].id
  tags                  = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_servicebus_windows_net_vnet_link" {
  name                  = module.vnet_italy[0].name
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_servicebus_windows_net.name
  resource_group_name   = data.azurerm_private_dns_zone.privatelink_servicebus_windows_net.resource_group_name
  virtual_network_id    = module.vnet_italy[0].id
  tags                  = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_table_core_windows_net_vnet_link" {
  name                  = module.vnet_italy[0].name
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_table_core_windows_net.name
  resource_group_name   = data.azurerm_private_dns_zone.privatelink_table_core_windows_net.resource_group_name
  virtual_network_id    = module.vnet_italy[0].id
  tags                  = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_table_cosmos_azure_com_vnet_link" {
  name                  = module.vnet_italy[0].name
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_table_cosmos_azure_com.name
  resource_group_name   = data.azurerm_private_dns_zone.privatelink_table_cosmos_azure_com.resource_group_name
  virtual_network_id    = module.vnet_italy[0].id
  tags                  = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_postgres_azure_com_vnet_link" {
  count                 = var.env_short != "d" ? 1 : 0
  name                  = module.vnet_italy[0].name
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_postgres_azure_com[0].name
  resource_group_name   = data.azurerm_private_dns_zone.privatelink_postgres_azure_com[0].resource_group_name
  virtual_network_id    = module.vnet_italy[0].id
  tags                  = module.tag_config.tags
}


# cstar integration vnet links

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_servicebus_windows_net_vnet_cstar_integration_link" {
  name                  = module.vnet_integration_cstar.name
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_servicebus_windows_net.name
  resource_group_name   = data.azurerm_private_dns_zone.privatelink_servicebus_windows_net.resource_group_name
  virtual_network_id    = module.vnet_integration_cstar.id
  tags                  = module.tag_config.tags
}
