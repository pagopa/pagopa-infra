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
  enable_non_ssl_port   = true
  family                = var.pagopa_proxy_redis_family
  sku_name              = var.pagopa_proxy_redis_sku_name
  enable_authentication = true
  subnet_id             = length(module.pagopa_proxy_snet[0].*.id) == 0 ? null : module.pagopa_proxy_snet[0].id

  tags = var.tags
}

module "pagopa_proxy_app_service" {
  count  = var.pagopa_proxy_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v2.0.19"

  resource_group_name = azurerm_resource_group.pagopa_proxy_rg[0].name
  location            = var.location

  # App service plan vars
  plan_name     = format("%s-plan-pagopa-proxy", local.project)
  plan_kind     = "Linux"
  plan_sku_tier = var.pagopa_proxy_tier
  plan_sku_size = var.pagopa_proxy_size
  plan_reserved = true # Mandatory for Linux plan

  # App service plan
  name                = format("%s-app-pagopa-proxy", local.project)
  client_cert_enabled = false
  always_on           = var.pagopa_proxy_always_on
  linux_fx_version    = "NODE|14-lts"
  health_check_path   = "/ping"

  app_settings = {
    # Monitoring
    APPINSIGHTS_INSTRUMENTATIONKEY                  = azurerm_application_insights.application_insights.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING           = format("InstrumentationKey=%s", azurerm_application_insights.application_insights.instrumentation_key)
    APPINSIGHTS_PROFILERFEATURE_VERSION             = "1.0.0"
    APPINSIGHTS_SNAPSHOTFEATURE_VERSION             = "1.0.0"
    APPLICATIONINSIGHTS_CONFIGURATION_CONTENT       = ""
    ApplicationInsightsAgent_EXTENSION_VERSION      = "~3"
    DiagnosticServices_EXTENSION_VERSION            = "~3"
    InstrumentationEngine_EXTENSION_VERSION         = "disabled"
    SnapshotDebugger_EXTENSION_VERSION              = "disabled"
    XDT_MicrosoftApplicationInsights_BaseExtensions = "disabled"
    XDT_MicrosoftApplicationInsights_Mode           = "recommended"
    XDT_MicrosoftApplicationInsights_PreemptSdk     = "disabled"
    WEBSITE_HEALTHCHECK_MAXPINGFAILURES             = 10
    TIMEOUT_DELAY                                   = 300

    # proxy-specific env vars
    # Taken from https://github.com/pagopa/io-infrastructure/blob/6f43d141e7695b96cdb192535a30b78efdd9df81/infrastructure/kubernetes/pagopa-pagopa_proxy.yml
    PAGOPA_HOST    = "localhost"
    PAGOPA_PORT    = 80
    PAGOPA_HOST                = "http://10.250.1.182"
    PAGOPA_HOST_HEADER         = "nodopa.sia.eu"
    PAGOPA_ID_CANALE           = data.azurerm_key_vault_secret.pagopa_proxy_id_canale[0].value
    PAGOPA_ID_CANALE_PAGAMENTO = data.azurerm_key_vault_secret.pagopa_proxy_id_canale_pagamento[0].value
    PAGOPA_ID_INT_PSP          = data.azurerm_key_vault_secret.pagopa_proxy_id_intermediario_psp[0].value
    PAGOPA_ID_PSP              = data.azurerm_key_vault_secret.pagopa_proxy_id_psp[0].value
    PAGOPA_PASSWORD            = data.azurerm_key_vault_secret.pagopa_proxy_password[0].value
    PAGOPA_PORT                = 80
    PAGOPA_TIMEOUT_MSEC        = 500000
    REDIS_DB_PASSWORD          = data.azurerm_key_vault_secret.pagopa_proxy_redis_db_passsword[0].value
    REDIS_DB_PORT              = 6380
    REDIS_DB_URL               = module.pagopa_proxy_redis[0].hostname
    REDIS_USE_CLUSTER          = true
    WINSTON_LOG_LEVEL          = "debug"

  }

  allowed_subnets = [module.apim_snet.id]
  allowed_ips     = []

  subnet_name = module.pagopa_proxy_snet[0].name
  subnet_id   = module.pagopa_proxy_snet[0].id

  tags = var.tags
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

data "azurerm_key_vault_secret" "pagopa_proxy_password" {
  count        = var.pagopa_proxy_enabled ? 1 : 0
  name         = "pagopa-proxy-password"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "pagopa_proxy_redis_db_passsword" {
  count        = var.pagopa_proxy_enabled ? 1 : 0
  name         = "pagopa-proxy-redis-db-password"
  key_vault_id = module.key_vault.id
}
