resource "azurerm_resource_group" "mock_payment_gateway_rg" {
  count    = var.mock_payment_gateway_enabled ? 1 : 0
  name     = format("%s-mock-payment-gateway-rg", local.project_legacy)
  location = var.location
  tags     = var.tags
}

# Subnet to host the mock mock-payment-gateway
module "mock_payment_gateway_snet" {
  count                                         = var.mock_payment_gateway_enabled && var.cidr_subnet_mock_payment_gateway != null ? 1 : 0
  source                                        = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.2.1"
  name                                          = format("%s-mock-payment-gateway-snet", local.project_legacy)
  address_prefixes                              = var.cidr_subnet_mock_payment_gateway
  resource_group_name                           = local.vnet_resource_group_name
  virtual_network_name                          = local.vnet_name
  private_link_service_network_policies_enabled = true

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
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service?ref=v6.14.1"

  resource_group_name = azurerm_resource_group.mock_payment_gateway_rg[0].name
  location            = var.location

  # App service plan vars
  plan_name = format("%s-plan-mock-payment-gateway", local.project_legacy)
  plan_kind = "Linux"
  sku_name  = var.mock_payment_gateway_size

  # App service plan
  name                = format("%s-app-mock-payment-gateway", local.project_legacy)
  client_cert_enabled = false
  always_on           = var.mock_payment_gateway_always_on
  java_version        = "8"
  health_check_path   = "/actuator/health"

  app_settings = {
    SERVER_PUBLIC_URL = var.env_short == "d" ? format("https://api.%s.%s/mock-payment-gateway/api", var.dns_zone_prefix, var.external_domain) : format("https://api.prf.platform.%s/mock-payment-gateway/api", var.external_domain),
    MOCK_PROFILE      = var.env_short == "d" ? "sit" : "perf",
    XPAY_APIKEY_ALIAS = data.azurerm_key_vault_secret.mock_pgs_xpay_apikey_alias[0].value,
    XPAY_SECRET_KEY   = data.azurerm_key_vault_secret.mock_pgs_xpay_secret_key[0].value
  }

  allowed_subnets = [data.azurerm_subnet.apim_snet.id, data.azurerm_subnet.apim_v2_snet.id]
  allowed_ips     = []

  subnet_id = module.mock_payment_gateway_snet[0].id

  tags = var.tags
}

data "azurerm_key_vault_secret" "mock_pgs_xpay_apikey_alias" {
  count        = var.mock_payment_gateway_enabled ? 1 : 0
  name         = "mock-pgs-xpay-apikey-alias"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "mock_pgs_xpay_secret_key" {
  count        = var.mock_payment_gateway_enabled ? 1 : 0
  name         = "mock-pgs-xpay-secret-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}
