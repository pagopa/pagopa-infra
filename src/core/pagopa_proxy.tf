locals {
  pagopa_proxy_config = {
    WEBSITE_NODE_DEFAULT_VERSION = "18.16.0"
    WEBSITE_RUN_FROM_PACKAGE     = "1"
    WEBSITE_VNET_ROUTE_ALL       = "1"
    WEBSITE_DNS_SERVER           = "168.63.129.16"

    # Monitoring
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.application_insights.instrumentation_key

    # proxy-specific env vars
    PAGOPA_HOST                = format("https://api.%s.%s", var.dns_zone_prefix, var.external_domain)
    PAGOPA_PORT                = 443
    PAGOPA_WS_NODO_PER_PSP_URI = "/nodo/nodo-per-psp/v1"
    PAGOPA_WS_NODE_FOR_PSP_URI = "/nodo/node-for-psp/v1"
    PAGOPA_WS_NODE_FOR_IO_URI  = "/nodo/node-for-io/v1"
    NM3_ENABLED                = true
    NODE_CONNECTIONS_CONFIG    = data.azurerm_key_vault_secret.pagopaproxy_node_clients_config.value

    REDIS_DB_URL      = format("redis://%s", module.pagopa_proxy_redis.hostname)
    REDIS_DB_PORT     = module.pagopa_proxy_redis.ssl_port
    REDIS_DB_PASSWORD = module.pagopa_proxy_redis.primary_access_key
    REDIS_USE_CLUSTER = false
  }
}

data "azurerm_key_vault_secret" "pagopaproxy_node_clients_config" {
  name         = "pagopaproxy-node-clients-config"
  key_vault_id = module.key_vault.id
}

resource "azurerm_resource_group" "pagopa_proxy_rg" {
  name     = format("%s-pagopa-proxy-rg", local.project)
  location = var.location

  tags = var.tags
}

module "pagopa_proxy_redis_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.0.28"
  name                                           = format("%s-pagopa-proxy-redis-snet", local.project)
  address_prefixes                               = var.cidr_subnet_pagopa_proxy_redis
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name
  enforce_private_link_endpoint_network_policies = true
}

module "pagopa_proxy_redis" {
  source                = "git::https://github.com/pagopa/azurerm.git//redis_cache?ref=v2.0.28"
  name                  = format("%s-pagopa-proxy-redis", local.project)
  resource_group_name   = azurerm_resource_group.pagopa_proxy_rg.name
  location              = azurerm_resource_group.pagopa_proxy_rg.location
  capacity              = var.pagopa_proxy_redis_capacity
  enable_non_ssl_port   = false
  family                = var.pagopa_proxy_redis_family
  sku_name              = var.pagopa_proxy_redis_sku_name
  enable_authentication = true

  private_endpoint = {
    enabled              = var.redis_private_endpoint_enabled
    virtual_network_id   = azurerm_resource_group.rg_vnet.id
    subnet_id            = module.pagopa_proxy_redis_snet.id
    private_dns_zone_ids = var.redis_private_endpoint_enabled ? [azurerm_private_dns_zone.privatelink_redis_cache_windows_net[0].id] : []
  }

  // when azure can apply patch?
  patch_schedules = [
    {
      day_of_week    = "Sunday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Monday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Tuesday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Wednesday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Thursday"
      start_hour_utc = 23
    },
  ]

  tags = var.tags
}
