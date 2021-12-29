resource "azurerm_resource_group" "pagopa_proxy_rg" {
  count    = var.pagopa_proxy_enabled ? 1 : 0
  name     = format("%s-pagopa_proxy-rg", local.project)
  location = var.location

  tags = var.tags
}

module "pagopa_proxy_snet" {
  count                = var.pagopa_proxy_enabled && var.cidr_subnet_pagopa_proxy != null ? 1 : 0
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.0.19"
  name                 = format("%s-pagopa_proxy-snet", local.project)
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

module "pagopa_proxy_redis" {
  count                 = var.pagopa_proxy_enabled ? 1 : 0
  source                = "git::https://github.com/pagopa/azurerm.git//redis_cache?ref=v2.0.19"
  name                  = format("%s-pagopa_proxy-redis", local.project)
  resource_group_name   = azurerm_resource_group.pagopa_proxy_rg[0].name
  location              = azurerm_resource_group.pagopa_proxy_rg[0].location
  capacity              = var.pagopa_proxy_redis_capacity
  enable_non_ssl_port   = false
  family                = var.pagopa_proxy_redis_family
  sku_name              = var.pagopa_proxy_redis_sku_name
  enable_authentication = true
  subnet_id             = module.pagopa_proxy_snet[0].id

  tags = var.tags

  private_endpoint = {
    enabled              = var.pagopa_proxy_redis_private_endpoint_enabled
    virtual_network_id   = azurerm_resource_group.rg_vnet.id
    subnet_id            = module.pagopa_proxy_snet[0].id
    private_dns_zone_ids = var.pagopa_proxy_redis_private_endpoint_enabled ? [azurerm_private_dns_zone.privatelink_redis_pagopa_proxy[0].id] : []
  }
}

module "pagopa_proxy_app_service" {
  count  = var.pagopa_proxy_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v2.0.19"

  resource_group_name = azurerm_resource_group.pagopa_proxy_rg[0].name
  location            = var.location

  # App service plan vars
  plan_name     = format("%s-plan-pagopa-proxy", local.project)
  plan_kind     = "Windows"
  plan_type     = "internal"
  plan_sku_tier = var.pagopa_proxy_tier
  plan_sku_size = var.pagopa_proxy_size

  # App service plan
  name                = format("%s-app-pagopa-proxy", local.project)
  client_cert_enabled = false
  always_on           = var.pagopa_proxy_always_on
  health_check_path   = "/ping"

  app_settings = {
    WEBSITE_NODE_DEFAULT_VERSION = "14.16.0"
    WEBSITE_RUN_FROM_PACKAGE     = "1"

    # Monitoring
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.application_insights.instrumentation_key

    # proxy-specific env vars
    PAGOPA_HOST                = data.azurerm_key_vault_secret.pagopa_proxy_host[0].value
    PAGOPA_PORT                = data.azurerm_key_vault_secret.pagopa_proxy_port[0].value
    PAGOPA_PASSWORD            = data.azurerm_key_vault_secret.pagopa_proxy_password[0].value
    PAGOPA_ID_PSP              = data.azurerm_key_vault_secret.pagopa_proxy_id_psp[0].value
    PAGOPA_ID_INT_PSP          = data.azurerm_key_vault_secret.pagopa_proxy_id_intermediario_psp[0].value
    PAGOPA_ID_CANALE           = data.azurerm_key_vault_secret.pagopa_proxy_id_canale[0].value
    PAGOPA_ID_CANALE_PAGAMENTO = data.azurerm_key_vault_secret.pagopa_proxy_id_canale_pagamento[0].value
    PAGOPA_WS_URI              = data.azurerm_key_vault_secret.pagopa_proxy_ws_uri[0].value

    REDIS_DB_URL      = module.pagopa_proxy_redis[0].hostname
    REDIS_DB_PORT     = module.pagopa_proxy_redis[0].ssl_port
    REDIS_DB_PASSWORD = module.pagopa_proxy_redis[0].primary_access_key
    REDIS_USE_CLUSTER = true
  }

  allowed_subnets = [module.apim_snet.id]
  allowed_ips     = []
  subnet_id       = module.pagopa_proxy_snet[0].id

  tags = var.tags
}

data "azurerm_key_vault_secret" "pagopa_proxy_host" {
  count        = var.pagopa_proxy_enabled ? 1 : 0
  name         = "pagopa-proxy-host"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "pagopa_proxy_port" {
  count        = var.pagopa_proxy_enabled ? 1 : 0
  name         = "pagopa-proxy-port"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "pagopa_proxy_password" {
  count        = var.pagopa_proxy_enabled ? 1 : 0
  name         = "pagopa-proxy-password"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "pagopa_proxy_id_canale" {
  count        = var.pagopa_proxy_enabled ? 1 : 0
  name         = "pagopa-proxy-id-canale"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "pagopa_proxy_id_canale_pagamento" {
  count        = var.pagopa_proxy_enabled ? 1 : 0
  name         = "pagopa-proxy-id-canale-pagamento"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "pagopa_proxy_id_intermediario_psp" {
  count        = var.pagopa_proxy_enabled ? 1 : 0
  name         = "pagopa-proxy-id-intermediario-psp"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "pagopa_proxy_id_psp" {
  count        = var.pagopa_proxy_enabled ? 1 : 0
  name         = "pagopa-proxy-id-psp"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "pagopa_proxy_ws_uri" {
  count        = var.pagopa_proxy_enabled ? 1 : 0
  name         = "pagopa-proxy-ws-uri"
  key_vault_id = module.key_vault.id
}
