resource "azurerm_resource_group" "mock_ec_rg" {
  count    = var.mock_ec_enabled ? 1 : 0
  name     = format("%s-mock-ec-rg", local.project)
  location = var.location

  tags = var.tags
}

module "mock_ec" {
  count  = var.mock_ec_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v1.0.14"

  resource_group_name = azurerm_resource_group.mock_ec_rg[0].name
  location            = var.location

  # App service plan vars
  plan_name     = format("%s-plan-mock-ec", local.project)
  plan_kind     = "Linux"
  plan_sku_tier = var.mock_ec_tier
  plan_sku_size = var.mock_ec_size
  plan_reserved = true # Mandatory for Linux plan

  # App service plan
  name                = format("%s-app-mock-ec", local.project)
  client_cert_enabled = true
  always_on           = var.mock_ec_always_on
  linux_fx_version    = "NODE|12-lts"
  app_command_line    = "node /home/site/wwwroot/dist/index.js"
  health_check_path   = "/mockEcService/api/v1/info"

  app_settings = {
    WEBSITE_RUN_FROM_PACKAGE       = "1"
    WEBSITE_NODE_DEFAULT_VERSION   = "12.19.0"
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.application_insights.instrumentation_key
    NODE_ENV                       = "production"
    PORT                           = "8080"
    WEBSITES_PORT                  = "8080"

    CERT_PEM = data.azurerm_key_vault_secret.mock_ec_CERT_PEM[0].value
    KEY      = data.azurerm_key_vault_secret.mock_ec_CERT_KEY[0].value
  }

  tags = var.tags
}

# secrets form key vault

data "azurerm_key_vault_secret" "mock_ec_CERT_PEM" {
  depends_on = [
    azurerm_key_vault_access_policy.adgroup_admin_policy,
    azurerm_key_vault_access_policy.adgroup_contributors_policy
  ]
  count        = var.mock_ec_enabled ? 1 : 0
  name         = "mock-ec-CERT-PEM"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "mock_ec_CERT_KEY" {
  depends_on = [
    azurerm_key_vault_access_policy.adgroup_admin_policy,
    azurerm_key_vault_access_policy.adgroup_contributors_policy
  ]
  count        = var.mock_ec_enabled ? 1 : 0
  name         = "mock-ec-CERT-KEY"
  key_vault_id = module.key_vault.id
}

# custom domain

# resource "azurerm_app_service_certificate" "mock_ec_certificate" {
#   name                = format("%s-app-mock-ec-certificate", local.project)
#   resource_group_name = var.resource_group_name
#   location            = var.location
#   key_vault_secret_id = data.azurerm_key_vault_secret.certificate_secret.id
# }
