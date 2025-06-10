data "azurerm_private_dns_zone" "db_nodo_pagamenti_com" {
  name                = "${var.env_short}.db-nodo-pagamenti.com"
  resource_group_name = "pagopa-${var.env_short}-data-rg"
}

data "azurerm_private_dns_zone" "internal_postgresql_pagopa_it" {
  name                = "${var.env_short}.internal.postgresql.pagopa.it"
  resource_group_name = "pagopa-${var.env_short}-vnet-rg"
}

data "azurerm_private_dns_zone" "env_platform_pagopa_it" {
  name                = "${var.platform_dns_zone_prefix}.${var.external_domain}"
  resource_group_name = "pagopa-${var.env_short}-vnet-rg"
}

data "azurerm_private_dns_zone" "internal_env_platform_pagopa_it" {
  name                = var.env_short != "p" ? "internal.${var.env}.platform.pagopa.it" : "internal.platform.pagopa.it"
  resource_group_name = "pagopa-${var.env_short}-vnet-rg"
}

data "azurerm_private_dns_zone" "privatelink_azurecr_io" {
  name                = "privatelink.azurecr.io"
  resource_group_name = "pagopa-${var.env_short}-vnet-rg"
}

data "azurerm_private_dns_zone" "privatelink_blob_core_windows_net" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = "pagopa-${var.env_short}-vnet-rg"
}

data "azurerm_private_dns_zone" "privatelink_datafactory_azure_net" {
  name                = "privatelink.datafactory.azure.net"
  resource_group_name = "pagopa-${var.env_short}-vnet-rg"
}

data "azurerm_private_dns_zone" "privatelink_documents_azure_com" {
  name                = "privatelink.documents.azure.com"
  resource_group_name = "pagopa-${var.env_short}-vnet-rg"
}

data "azurerm_private_dns_zone" "privatelink_mongo_cosmos_azure_com" {
  name                = "privatelink.mongo.cosmos.azure.com"
  resource_group_name = "pagopa-${var.env_short}-vnet-rg"
}

data "azurerm_private_dns_zone" "privatelink_queue_core_windows_net" {
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = "pagopa-${var.env_short}-vnet-rg"
}

data "azurerm_private_dns_zone" "privatelink_redis_cache_windows_net" {
  name                = "privatelink.redis.cache.windows.net"
  resource_group_name = "pagopa-${var.env_short}-vnet-rg"
}

data "azurerm_private_dns_zone" "privatelink_servicebus_windows_net" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = "pagopa-${var.env_short}-msg-rg"
}

data "azurerm_private_dns_zone" "privatelink_table_core_windows_net" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = "pagopa-${var.env_short}-vnet-rg"
}

data "azurerm_private_dns_zone" "privatelink_table_cosmos_azure_com" {
  name                = "privatelink.table.cosmos.azure.com"
  resource_group_name = "pagopa-${var.env_short}-vnet-rg"
}

data "azurerm_private_dns_zone" "privatelink_postgres_azure_com" {
  count               = var.env_short != "d" ? 1 : 0
  name                = "private.postgres.database.azure.com"
  resource_group_name = "pagopa-${var.env_short}-vnet-rg"
}
