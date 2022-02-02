locals {
  pagopa_proxy_config = {
    WEBSITE_NODE_DEFAULT_VERSION = "14.16.0"
    WEBSITE_RUN_FROM_PACKAGE     = "1"
    WEBSITE_VNET_ROUTE_ALL       = "1"
    WEBSITE_DNS_SERVER           = "168.63.129.16"

    # Monitoring
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.application_insights.instrumentation_key

    # proxy-specific env vars
    PAGOPA_HOST                = format("https://api.%s.%s", var.dns_zone_prefix, var.external_domain)
    PAGOPA_PORT                = 443
    PAGOPA_PASSWORD            = data.azurerm_key_vault_secret.pagopa_proxy_password.value
    PAGOPA_ID_PSP              = data.azurerm_key_vault_secret.pagopa_proxy_id_psp.value
    PAGOPA_ID_INT_PSP          = data.azurerm_key_vault_secret.pagopa_proxy_id_intermediario_psp.value
    PAGOPA_ID_CANALE           = data.azurerm_key_vault_secret.pagopa_proxy_id_canale.value
    PAGOPA_ID_CANALE_PAGAMENTO = data.azurerm_key_vault_secret.pagopa_proxy_id_canale_pagamento.value
    PAGOPA_WS_NODO_PER_PSP_URI = "/nodo/nodo-per-psp/v1"
    PAGOPA_WS_NODE_FOR_PSP_URI = "/nodo/node-for-psp/v1"
    PAGOPA_WS_NODE_FOR_IO_URI  = "/nodo/node-for-io/v1"
    NM3_ENABLED                = true

    REDIS_DB_URL      = format("redis://%s", module.pagopa_proxy_redis.hostname)
    REDIS_DB_PORT     = module.pagopa_proxy_redis.ssl_port
    REDIS_DB_PASSWORD = module.pagopa_proxy_redis.primary_access_key
    REDIS_USE_CLUSTER = var.env_short == "p"
  }
}

data "azurerm_key_vault_secret" "pagopa_proxy_password" {
  name         = "pagopa-proxy-password"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "pagopa_proxy_id_canale" {
  name         = "pagopa-proxy-id-canale"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "pagopa_proxy_id_canale_pagamento" {
  name         = "pagopa-proxy-id-canale-pagamento"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "pagopa_proxy_id_intermediario_psp" {
  name         = "pagopa-proxy-id-intermediario-psp"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "pagopa_proxy_id_psp" {
  name         = "pagopa-proxy-id-psp"
  key_vault_id = module.key_vault.id
}


resource "azurerm_resource_group" "pagopa_proxy_rg" {
  name     = format("%s-pagopa-proxy-rg", local.project)
  location = var.location

  tags = var.tags
}

module "pagopa_proxy_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.0.19"
  name                 = format("%s-pagopa-proxy-snet", local.project)
  address_prefixes     = var.cidr_subnet_pagopa_proxy
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet.name

  enforce_private_link_endpoint_network_policies = true

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "pagopa_proxy_redis_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.0.19"
  name                                           = format("%s-pagopa-proxy-redis-snet", local.project)
  address_prefixes                               = var.cidr_subnet_pagopa_proxy_redis
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name
  enforce_private_link_endpoint_network_policies = true
}

module "pagopa_proxy_redis" {
  source                = "git::https://github.com/pagopa/azurerm.git//redis_cache?ref=v2.0.19"
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

module "pagopa_proxy_app_service" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v2.0.28"

  depends_on = [
    module.pagopa_proxy_snet
  ]

  resource_group_name = azurerm_resource_group.pagopa_proxy_rg.name
  location            = var.location

  # App service plan vars
  plan_name     = format("%s-plan-pagopa-proxy", local.project)
  plan_kind     = "Linux"
  plan_type     = "internal"
  plan_reserved = true
  plan_sku_tier = var.pagopa_proxy_tier
  plan_sku_size = var.pagopa_proxy_size

  linux_fx_version = "NODE|14-lts"

  # App service plan
  name                = format("%s-app-pagopa-proxy", local.project)
  client_cert_enabled = false
  always_on           = var.env_short == "p" ? true : false
  health_check_path   = "/ping"

  # App settings
  app_settings = local.pagopa_proxy_config

  allowed_subnets = [module.apim_snet.id]
  allowed_ips     = []
  subnet_id       = module.pagopa_proxy_snet.id

  tags = var.tags
}


module "pagopa_proxy_app_service_slot_staging" {
  count = var.env_short == "p" ? 1 : 0

  source = "git::https://github.com/pagopa/azurerm.git//app_service_slot?ref=v2.0.28"

  # App service plan
  app_service_plan_id = module.pagopa_proxy_app_service.plan_id
  app_service_id      = module.pagopa_proxy_app_service.id
  app_service_name    = module.pagopa_proxy_app_service.name

  # App service
  name                = "staging"
  resource_group_name = azurerm_resource_group.pagopa_proxy_rg.name
  location            = azurerm_resource_group.pagopa_proxy_rg.location

  always_on         = true
  linux_fx_version  = "NODE|14-lts"
  health_check_path = "/ping"

  # App settings
  app_settings = local.pagopa_proxy_config

  allowed_subnets = [module.apim_snet.id, module.azdoa_snet[0].id]
  allowed_ips     = []
  subnet_id       = module.pagopa_proxy_snet.id

  tags = var.tags
}
