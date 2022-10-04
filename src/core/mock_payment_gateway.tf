resource "azurerm_resource_group" "mock_payment_gateway_rg" {
  count    = var.mock_payment_gateway_enabled ? 1 : 0
  name     = format("%s-mock-payment-gateway-rg", local.project)
  location = var.location
  tags     = var.tags
}

# Subnet to host the mock mock-payment-gateway
module "mock_payment_gateway_snet" {
  count                                          = var.mock_payment_gateway_enabled && var.cidr_subnet_mock_payment_gateway != null ? 1 : 0
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.90"
  name                                           = format("%s-mock-payment-gateway-snet", local.project)
  address_prefixes                               = var.cidr_subnet_mock_payment_gateway
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

module "mock_payment_gateway" {
  count  = var.mock_payment_gateway_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v1.0.90"

  resource_group_name = azurerm_resource_group.mock_payment_gateway_rg[0].name
  location            = var.location

  # App service plan vars
  plan_name     = format("%s-plan-mock-payment-gateway", local.project)
  plan_kind     = "Linux"
  plan_sku_tier = var.mock_payment_gateway_tier
  plan_sku_size = var.mock_payment_gateway_size
  plan_reserved = true # Mandatory for Linux plan

  # App service plan
  name                = format("%s-app-mock-payment-gateway", local.project)
  client_cert_enabled = false
  always_on           = var.mock_payment_gateway_always_on
  linux_fx_version    = "JAVA|8-jre8"
  health_check_path   = "/actuator/health"

  app_settings = {
    SERVER_PUBLIC_URL = var.env_short == "d" ? format("https://api.%s.%s/mock-payment-gateway/api", var.dns_zone_prefix, var.external_domain) : format("https://api.prf.platform.%s/mock-payment-gateway/api", var.external_domain),
    MOCK_PROFILE      = var.env_short == "d" ? "sit" : "perf",
    XPAY_APIKEY_ALIAS = data.azurerm_key_vault_secret.mock_pgs_xpay_apikey_alias[0].value,
    XPAY_SECRET_ID    = data.azurerm_key_vault_secret.mock_pgs_xpay_secret_key[0].value
  }

  allowed_subnets = [module.apim_snet.id]
  allowed_ips     = []

  subnet_name = module.mock_payment_gateway_snet[0].name
  subnet_id   = module.mock_payment_gateway_snet[0].id

  tags = var.tags
}

data "azurerm_key_vault_secret" "mock_pgs_xpay_apikey_alias" {
  count        = var.mock_payment_gateway_enabled ? 1 : 0
  name         = "mock-pgs-xpay-apikey-alias"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "mock_pgs_xpay_secret_key" {
  count        = var.mock_payment_gateway_enabled ? 1 : 0
  name         = "mock-pgs-xpay-secret-key"
  key_vault_id = module.key_vault.id
}