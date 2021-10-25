resource "azurerm_resource_group" "checkout_be_rg" {
  count    = var.checkout_enabled ? 1 : 0
  name     = format("%s-checkout-be-rg", local.project)
  location = var.location

  tags = var.tags
}

# Subnet to host checkout function
module "checkout_function_snet" {
  count                                          = var.checkout_enabled && var.cidr_subnet_checkout_be != null ? 1 : 0
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-checkout-be-snet", local.project)
  address_prefixes                               = var.cidr_subnet_checkout_be
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name
  enforce_private_link_endpoint_network_policies = true

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "checkout_function" {
  count  = var.checkout_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v1.0.78"

  resource_group_name                      = azurerm_resource_group.checkout_be_rg[0].name
  prefix                                   = var.prefix
  env_short                                = var.env_short
  name                                     = "checkout"
  location                                 = var.location
  health_check_path                        = "api/v1/info"
  subnet_out_id                            = module.checkout_function_snet[0].id
  runtime_version                          = "~3"
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = {
    kind     = var.checkout_function_kind
    sku_tier = var.checkout_function_sku_tier
    sku_size = var.checkout_function_sku_size
  }

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME       = "node"
    WEBSITE_NODE_DEFAULT_VERSION   = "12.18.0"
    FUNCTIONS_WORKER_PROCESS_COUNT = 4
    NODE_ENV                       = "production"

    // Keepalive fields are all optionals
    FETCH_KEEPALIVE_ENABLED             = "true"
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
    FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
    FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"

    IO_PAGOPA_PROXY  = var.checkout_pagopaproxy_host
    PAGOPA_BASE_PATH = "/pagopa/api/v1"


    IO_PAY_CHALLENGE_RESUME_URL = format("%s.%s/response.html?id=idTransaction", var.dns_zone_checkout, var.external_domain)
    IO_PAY_ORIGIN               = format("%s.%s", var.dns_zone_checkout, var.external_domain)
    IO_PAY_XPAY_REDIRECT        = format("%s.%s/response.html?id=_id_&resumeType=_resumeType_&_queryParams_", var.dns_zone_checkout, var.external_domain)

    PAY_PORTAL_RECAPTCHA_SECRET = data.azurerm_key_vault_secret.google_recaptcha_secret.value
  }

  allowed_subnets = [module.apim_snet.id]

  allowed_ips = []

  tags = var.tags
}
