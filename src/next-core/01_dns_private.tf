### 🔮 Private DNS zone: nodo dei pagamenti
resource "azurerm_private_dns_zone" "db_nodo_dns_zone" {
  name                = var.private_dns_zone_db_nodo_pagamenti
  resource_group_name = azurerm_resource_group.data.name

  tags = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "db_nodo_dns_zone_virtual_link" {
  name                  = "${local.product}-db_nodo-private-dns-zone-link"
  resource_group_name   = azurerm_resource_group.data.name
  private_dns_zone_name = azurerm_private_dns_zone.db_nodo_dns_zone.name
  virtual_network_id    = module.vnet_integration.id

  tags = module.tag_config.tags
}

resource "azurerm_private_dns_a_record" "private_dns_a_record_db_nodo" {
  name                = "db-nodo-pagamenti"
  zone_name           = azurerm_private_dns_zone.db_nodo_dns_zone.name
  resource_group_name = azurerm_resource_group.data.name
  ttl                 = 60
  records             = var.dns_a_reconds_dbnodo_ips
}

resource "azurerm_private_dns_a_record" "private_dns_a_record_db_nodo_dr" {
  count               = var.env_short == "p" ? 1 : 0 # DR only in PROD env
  name                = "db-nodo-pagamenti-dr"
  zone_name           = azurerm_private_dns_zone.db_nodo_dns_zone.name
  resource_group_name = azurerm_resource_group.data.name
  ttl                 = 60
  records             = var.dns_a_reconds_dbnodo_ips_dr
}

resource "azurerm_private_dns_a_record" "private_dns_a_record_db_nodo_nexi_postgres" {
  name                = "db-postgres-ndp"
  zone_name           = azurerm_private_dns_zone.db_nodo_dns_zone.name
  resource_group_name = azurerm_resource_group.data.name
  ttl                 = 60
  records             = var.dns_a_reconds_dbnodonexipostgres_ips
}

resource "azurerm_private_dns_a_record" "private_dns_a_record_db_nodo_prf" {
  count               = var.env_short == "u" ? 1 : 0
  name                = "db-nodo-pagamenti-prf"
  zone_name           = azurerm_private_dns_zone.db_nodo_dns_zone.name
  resource_group_name = azurerm_resource_group.data.name
  ttl                 = 60
  records             = var.dns_a_reconds_dbnodo_prf_ips
}

resource "azurerm_private_dns_a_record" "private_dns_a_record_db_nodo_nexi_postgres_prf" {
  count               = var.env_short == "u" ? 1 : 0
  name                = "db-postgres-ndp-prf"
  zone_name           = azurerm_private_dns_zone.db_nodo_dns_zone.name
  resource_group_name = azurerm_resource_group.data.name
  ttl                 = 60
  records             = var.dns_a_reconds_dbnodonexipostgres_prf_ips
}

### 🔮 Private dns zone: Redis

resource "azurerm_private_dns_zone" "privatelink_redis_cache_windows_net" {
  name                = "privatelink.redis.cache.windows.net"
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = module.tag_config.tags
}

moved {
  from = azurerm_private_dns_zone.privatelink_redis_cache_windows_net[0]
  to   = azurerm_private_dns_zone.privatelink_redis_cache_windows_net
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_redis_cache_windows_net_vnet" {
  name                  = module.vnet.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_redis_cache_windows_net.name
  virtual_network_id    = module.vnet.id
  registration_enabled  = false

  tags = module.tag_config.tags
}

moved {
  from = azurerm_private_dns_zone_virtual_network_link.privatelink_redis_cache_windows_net_vnet[0]
  to   = azurerm_private_dns_zone_virtual_network_link.privatelink_redis_cache_windows_net_vnet
}

### 🔮 Private dns zone: storage queue

resource "azurerm_private_dns_zone" "privatelink_queue_core_windows_net" {
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = module.tag_config.tags
}

moved {
  from = azurerm_private_dns_zone.privatelink_queue_core_windows_net[0]
  to   = azurerm_private_dns_zone.privatelink_queue_core_windows_net
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link_privatelink_queue_core_windows_net" {

  name                  = module.vnet.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_queue_core_windows_net.name
  virtual_network_id    = module.vnet.id
  registration_enabled  = false

  tags = module.tag_config.tags
}

moved {
  from = azurerm_private_dns_zone_virtual_network_link.vnet_link_privatelink_queue_core_windows_net[0]
  to   = azurerm_private_dns_zone_virtual_network_link.vnet_link_privatelink_queue_core_windows_net
}

### 🔮 DNS private 👉 <prod|uat|dev>.platform.pagopa.it
resource "azurerm_private_dns_zone" "platform_private_dns_zone" {
  name                = "${var.dns_zone_prefix}.${var.external_domain}"
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = module.tag_config.tags
}

resource "azurerm_private_dns_a_record" "platform_dns_a_private_apim" {

  for_each            = toset(var.platform_private_dns_zone_records)
  name                = each.key
  zone_name           = azurerm_private_dns_zone.platform_private_dns_zone.name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  records             = module.apim[0].private_ip_addresses
  tags                = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "platform_vnetlink_vnet" {
  name                  = module.vnet.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.platform_private_dns_zone.name
  virtual_network_id    = module.vnet.id
  registration_enabled  = false

  tags = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "platform_vnetlink_vnet_integration" {
  name                  = module.vnet_integration.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.platform_private_dns_zone.name
  virtual_network_id    = module.vnet_integration.id
  registration_enabled  = false

  tags = module.tag_config.tags
}

### 🔮 DNS private 👉 prf.platform.pagopa.it

resource "azurerm_private_dns_zone" "platform_private_dns_zone_prf" {
  count               = var.env_short == "u" ? 1 : 0
  name                = "${var.dns_zone_prefix_prf}.${var.external_domain}"
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = module.tag_config.tags
}

resource "azurerm_private_dns_a_record" "platform_dns_a_private_prf" {
  count               = var.env_short == "u" ? 1 : 0
  name                = "api"
  zone_name           = azurerm_private_dns_zone.platform_private_dns_zone_prf[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  records             = module.apim[0].private_ip_addresses
  tags                = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "platform_vnetlink_vnet_prf" {
  count                 = var.env_short == "u" ? 1 : 0
  name                  = module.vnet.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.platform_private_dns_zone_prf[0].name
  virtual_network_id    = module.vnet.id
  registration_enabled  = false

  tags = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "platform_vnetlink_vnet_integration_prf" {
  count                 = var.env_short == "u" ? 1 : 0
  name                  = module.vnet_integration.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.platform_private_dns_zone_prf[0].name
  virtual_network_id    = module.vnet_integration.id
  registration_enabled  = false

  tags = module.tag_config.tags
}

### 🔮 Private DNS Zone for Postgres Databases

resource "azurerm_private_dns_zone" "postgres" {
  name                = "private.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.rg_vnet.name
}

moved {
  from = azurerm_private_dns_zone.postgres[0]
  to   = azurerm_private_dns_zone.postgres
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgres_vnet" {
  name                  = module.vnet.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.postgres.name
  virtual_network_id    = module.vnet.id
}

moved {
  from = azurerm_private_dns_zone_virtual_network_link.postgres_vnet[0]
  to   = azurerm_private_dns_zone_virtual_network_link.postgres_vnet
}

### 🔮 Private DNS Zone for ACR azure container registry

resource "azurerm_private_dns_zone" "privatelink_azurecr_pagopa" {
  name                = "privatelink.azurecr.io"
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = module.tag_config.tags
}

### 🔮 Private DNS Zone for Cosmos Document DB
# https://docs.microsoft.com/it-it/azure/cosmos-db/how-to-configure-private-endpoints
resource "azurerm_private_dns_zone" "privatelink_documents_azure_com" {
  name                = "privatelink.documents.azure.com"
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_documents_azure_com_vnet" {
  name                  = module.vnet.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_documents_azure_com.name
  virtual_network_id    = module.vnet.id
  registration_enabled  = false

  tags = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_documents_azure_com_vnet_integration" {
  name                  = module.vnet_integration.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_documents_azure_com.name
  virtual_network_id    = module.vnet_integration.id
  registration_enabled  = false

  tags = module.tag_config.tags
}

### 🔮 Private DNS Zone for Cosmos DB Table API
# https://docs.microsoft.com/it-it/azure/cosmos-db/how-to-configure-private-endpoints
resource "azurerm_private_dns_zone" "privatelink_table_cosmos_azure_com" {
  name                = "privatelink.table.cosmos.azure.com"
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_table_cosmos_azure_com_vnet" {
  name                  = module.vnet.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_table_cosmos_azure_com.name
  virtual_network_id    = module.vnet.id
  registration_enabled  = false

  tags = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_table_cosmos_azure_com_vnet_integration" {
  name                  = module.vnet_integration.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_table_cosmos_azure_com.name
  virtual_network_id    = module.vnet_integration.id
  registration_enabled  = false

  tags = module.tag_config.tags
}

### 🔮 Private DNS Zone for Storage Accounts

resource "azurerm_private_dns_zone" "storage_account" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_blob_azure_com_vnet" {
  name                  = module.vnet.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.storage_account.name
  virtual_network_id    = module.vnet.id
  registration_enabled  = false

  tags = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_blob_azure_com_vnet_integration" {
  name                  = module.vnet_integration.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.storage_account.name
  virtual_network_id    = module.vnet_integration.id
  registration_enabled  = false

  tags = module.tag_config.tags
}

### 🔮 Private DNS Zone for Storage Accounts File Shared

resource "azurerm_private_dns_zone" "storage_account_file_shared" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_file_azure_com_vnet" {
  name                  = module.vnet.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.storage_account_file_shared.name
  virtual_network_id    = module.vnet.id
  registration_enabled  = false

  tags = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_file_azure_com_vnet_integration" {
  name                  = module.vnet_integration.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.storage_account_file_shared.name
  virtual_network_id    = module.vnet_integration.id
  registration_enabled  = false

  tags = module.tag_config.tags
}

### 🔮 DNS private: internal.dev.platform.pagopa.it

resource "azurerm_private_dns_zone" "internal_platform_pagopa_it" {
  name                = "internal.${var.dns_zone_prefix}.${var.external_domain}"
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "internal_platform_pagopa_it_private_vnet" {
  name                  = module.vnet_integration.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.internal_platform_pagopa_it.name
  virtual_network_id    = module.vnet_integration.id
  registration_enabled  = false

  tags = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "internal_platform_vnetlink_vnet_core" {
  name                  = module.vnet.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.internal_platform_pagopa_it.name
  virtual_network_id    = module.vnet.id
  registration_enabled  = false

  tags = module.tag_config.tags
}

### 🔮 Cosmos MongoDB for ecommerce - private dns zone

resource "azurerm_private_dns_zone" "privatelink_mongo_cosmos_azure_com" {

  name                = "privatelink.mongo.cosmos.azure.com"
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_privatelink_mongo_cosmos_azure_com" {

  name                  = module.vnet.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_mongo_cosmos_azure_com.name
  virtual_network_id    = module.vnet.id
  registration_enabled  = false

  tags = module.tag_config.tags
}

### 🔮 Private DNS Zone for Table Storage Account
# https://learn.microsoft.com/en-us/azure/storage/common/storage-private-endpoints?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&bc=%2Fazure%2Fstorage%2Fblobs%2Fbreadcrumb%2Ftoc.json
resource "azurerm_private_dns_zone" "table_storage_account" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_table_azure_com_vnet" {
  name                  = module.vnet.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.table_storage_account.name
  virtual_network_id    = module.vnet.id
  registration_enabled  = false

  tags = module.tag_config.tags
}

resource "azurerm_dns_a_record" "dns_a_forwarder" {
  count               = var.nat_gateway_enabled ? 1 : 0
  name                = "forwarder"
  zone_name           = azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  records             = tolist(data.azurerm_public_ip.natgateway_public_ip.*.ip_address)
  tags                = module.tag_config.tags
}

resource "azurerm_private_dns_zone" "appservice_private_dns" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_azurewebsite_vnet" {
  name                  = module.vnet.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.appservice_private_dns.name
  virtual_network_id    = module.vnet.id
  registration_enabled  = false

  tags = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_azurewebsite_vnet_integration" {
  name                  = module.vnet_integration.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.appservice_private_dns.name
  virtual_network_id    = module.vnet_integration.id
  registration_enabled  = false

  tags = module.tag_config.tags
}
