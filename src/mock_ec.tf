resource "azurerm_resource_group" "mock_ec_rg" {
  name     = format("%s-mock-ec-rg", local.project)
  location = var.location

  tags = var.tags
}

module "mock_ec" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v1.0.14"

  resource_group_name = azurerm_resource_group.mock_ec_rg.name
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
  health_check_path   = "/api/v1/info"

  app_settings = {
    WEBSITE_RUN_FROM_PACKAGE       = "1"
    WEBSITE_NODE_DEFAULT_VERSION   = "12.19.0"
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.application_insights.instrumentation_key
    NODE_ENV                       = "production"
    PORT                           = "8080"

    # CERT_PEM = data.azurerm_key_vault_certificate_data.app_kv_cert_data.pem
    # KEY      = data.azurerm_key_vault_certificate_data.app_kv_cert_data.key
    CERT_PEM = "NA"
    KEY      = "NA"
  }

  tags = var.tags
}
