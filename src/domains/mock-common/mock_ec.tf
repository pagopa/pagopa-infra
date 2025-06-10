resource "azurerm_resource_group" "mock_ec_rg" {
  count    = var.mock_ec_enabled ? 1 : 0
  name     = format("%s-mock-ec-rg", local.project_legacy)
  location = var.location

  tags = module.tag_config.tags
}

# Subnet to host the mock ec
module "mock_ec_snet" {
  count                                         = var.mock_ec_enabled && var.cidr_subnet_mock_ec != null ? 1 : 0
  source                                        = "./.terraform/modules/__v3__/subnet"
  name                                          = format("%s-mock-ec-snet", local.project_legacy)
  address_prefixes                              = var.cidr_subnet_mock_ec
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

module "mock_ec" {
  count  = var.mock_ec_enabled ? 1 : 0
  source = "./.terraform/modules/__v3__/app_service"

  resource_group_name = azurerm_resource_group.mock_ec_rg[0].name
  location            = var.location

  # App service plan vars
  plan_name = format("%s-plan-mock-ec", local.project_legacy)
  # plan_kind = "Linux"
  plan_type = "internal"
  sku_name  = var.mock_ec_size

  # App service plan
  name                = format("%s-app-mock-ec", local.project_legacy)
  client_cert_enabled = false
  always_on           = var.mock_ec_always_on
  app_command_line    = "node /home/site/wwwroot/dist/index.js"
  health_check_path   = "/mock-ec/info"
  node_version        = "12-lts"

  app_settings = {
    WEBSITE_RUN_FROM_PACKAGE     = "1"
    WEBSITE_NODE_DEFAULT_VERSION = "12.18.0"
    NODE_ENV                     = "production"
    PORT                         = "8080"
    PPT_NODO                     = "/mock-ec"

    # Monitoring
    APPINSIGHTS_INSTRUMENTATIONKEY                  = data.azurerm_application_insights.application_insights.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING           = format("InstrumentationKey=%s", data.azurerm_application_insights.application_insights.instrumentation_key)
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
    # WEBSITE_HEALTHCHECK_MAXPINGFAILURES             = 10

    # custom
    CC_POST_PRIMARY_EC   = "IT57N0760114800000011050036"
    CC_BANK_PRIMARY_EC   = "IT30N0103076271000001823603"
    CC_POST_SECONDARY_EC = "IT21Q0760101600000000546200"
    CC_BANK_SECONDARY_EC = "IT15V0306901783100000300001"
    CC_BANK_THIRD_EC     = "IT80E0306904013100000046039"
    TIMEOUT_DELAY        = 500000

  }

  allowed_subnets = [data.azurerm_subnet.apim_snet.id]
  allowed_ips     = []

  subnet_id = module.mock_ec_snet[0].id

  tags                          = module.tag_config.tags
  ip_restriction_default_action = "Allow"
}
