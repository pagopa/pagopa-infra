resource "azurerm_resource_group" "mock_ec_rg" {
  count    = var.mock_ec_enabled ? 1 : 0
  name     = format("%s-mock-ec-rg", local.project_legacy)
  location = var.location

  tags = var.tags
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

# Service Plan
resource "azurerm_service_plan" "mock_ec_plan" {
  count               = var.mock_ec_enabled ? 1 : 0
  name                = format("%s-plan-mock-ec", local.project_legacy)
  location            = var.location
  resource_group_name = azurerm_resource_group.mock_ec_rg[0].name

  sku_name = var.mock_ec_size
  os_type  = "Linux"

  tags = var.tags
}

# Linux Web App
resource "azurerm_linux_web_app" "mock_ec" {
  count               = var.mock_ec_enabled ? 1 : 0
  name                = format("%s-app-mock-ec", local.project_legacy)
  location            = var.location
  resource_group_name = azurerm_resource_group.mock_ec_rg[0].name
  service_plan_id     = azurerm_service_plan.mock_ec_plan[0].id

  client_certificate_enabled = false
  https_only                 = true

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

    # DNS Server for vnet integration
    WEBSITE_DNS_SERVER = "168.63.129.16"
  }

  site_config {
    always_on        = var.mock_ec_always_on
    app_command_line = "node /home/site/wwwroot/dist/index.js"

    application_stack {
      node_version = "12-lts"
    }

    health_check_path                 = "/mock-ec/info"
    health_check_eviction_time_in_min = 10
    # health_check_maxpingfailures      = 10

    ip_restriction_default_action = "Deny"

    dynamic "ip_restriction" {
      for_each = [data.azurerm_subnet.apim_snet.id]
      content {
        virtual_network_subnet_id = ip_restriction.value
        name                      = "rule"
      }
    }

    vnet_route_all_enabled = true
    minimum_tls_version    = "1.2"
    http2_enabled          = true
  }

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [
      app_settings["DOCKER_CUSTOM_IMAGE_NAME"],
      virtual_network_subnet_id,
      app_settings["WEBSITE_HEALTHCHECK_MAXPINGFAILURES"],
      tags["hidden-link: /app-insights-conn-string"],
      tags["hidden-link: /app-insights-instrumentation-key"],
      tags["hidden-link: /app-insights-resource-id"]
    ]
  }

  tags = var.tags
}

# VNet Integration
resource "azurerm_app_service_virtual_network_swift_connection" "mock_ec_vnet_connection" {
  count          = var.mock_ec_enabled ? 1 : 0
  app_service_id = azurerm_linux_web_app.mock_ec[0].id
  subnet_id      = module.mock_ec_snet[0].id
}
