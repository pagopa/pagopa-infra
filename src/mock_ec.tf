resource "azurerm_resource_group" "mock_ec_rg" {
  count    = var.mock_ec_enabled ? 1 : 0
  name     = format("%s-mock-ec-rg", local.project)
  location = var.location

  tags = var.tags
}

# Subnet to host the mock ec
module "mock_ec_snet" {
  count                                          = var.mock_ec_enabled && var.cidr_subnet_mock_ec != null ? 1 : 0
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-mock-ec-snet", local.project)
  address_prefixes                               = var.cidr_subnet_mock_ec
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
  client_cert_enabled = false
  always_on           = var.mock_ec_always_on
  linux_fx_version    = "NODE|12-lts"
  app_command_line    = "node /home/site/wwwroot/dist/index.js"
  health_check_path   = "/mockEcService/api/v1/info"

  app_settings = {
    WEBSITE_RUN_FROM_PACKAGE     = "1"
    WEBSITE_NODE_DEFAULT_VERSION = "12.18.0"
    NODE_ENV                     = "production"
    PORT                         = "8080"

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
  }

  allowed_subnets = [module.apim_snet.id]
  allowed_ips     = []

  subnet_name = module.mock_ec_snet[0].name
  subnet_id   = module.mock_ec_snet[0].id

  tags = var.tags
}
