locals {
  gpd_payments_app_settings = {
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
    # Integration with private DNS (see more: https://docs.microsoft.com/en-us/answers/questions/85359/azure-app-service-unable-to-resolve-hostname-of-vi.html)
    WEBSITE_ADD_SITENAME_BINDINGS_IN_APPHOST_CONFIG = "1"
    WEBSITE_RUN_FROM_PACKAGE                        = "1"
    WEBSITE_VNET_ROUTE_ALL                          = "1"
    WEBSITE_DNS_SERVER                              = "168.63.129.16"

    # Spring Environment
    PAA_ID_INTERMEDIARIO = var.gpd_paa_id_intermediario
    PAA_STAZIONE_INT     = var.gpd_paa_stazione_int
    # GPD_HOST             = format("https://api.%s.%s/%s/%s",var.dns_zone_prefix, var.external_domain, module.apim_api_gpd_api.path, module.apim_api_gpd_api.api_version )
    GPD_HOST = format("https://api.%s.%s/%s/%s", var.dns_zone_prefix, var.external_domain, "gpd/api", "v1")

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 8080

    DOCKER_REGISTRY_SERVER_URL      = "https://${module.acr[0].login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = module.acr[0].admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = module.acr[0].admin_password

  }

  gpd_payments_allowed_subnets = [module.apim_snet.id, module.reporting_function_snet.id]
}
# Subnet to host the api config
module "payments_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-payments-snet", local.project)
  address_prefixes                               = var.cidr_subnet_payments
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

module "payments_app_service" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v2.2.0"

  resource_group_name = azurerm_resource_group.gpd_rg.name
  plan_type           = "external"
  plan_id             = azurerm_app_service_plan.gpd_service_plan.id

  # App service
  name                = format("%s-app-payments", local.project)
  client_cert_enabled = false
  always_on           = var.payments_always_on
  linux_fx_version    = format("DOCKER|%s/api-payments-backend:%s", module.acr[0].login_server, "latest")
  health_check_path   = "/info"

  app_settings = local.gpd_payments_app_settings

  allowed_subnets = local.gpd_payments_allowed_subnets
  allowed_ips     = []

  subnet_id = module.payments_snet.id

  tags = var.tags

}

module "gpd_payments_app_service_slot_staging" {
//  count = var.env_short == "p" ? 1 : 0

  source = "git::https://github.com/pagopa/azurerm.git//app_service_slot?ref=v2.0.28"

  # App service plan
  app_service_plan_id = module.payments_app_service.plan_id
  app_service_id      = module.payments_app_service.id
  app_service_name    = module.payments_app_service.name

  # App service
  name                = "staging"
  resource_group_name = azurerm_resource_group.gpd_rg.name
  location            = azurerm_resource_group.gpd_rg.location

  always_on         = true
  linux_fx_version    = format("DOCKER|%s/api-payments-backend:%s", module.acr[0].login_server, "latest")
  health_check_path   = "/info"

  # App settings
  app_settings = local.gpd_payments_app_settings

  allowed_subnets = local.gpd_payments_allowed_subnets
  allowed_ips     = []
  subnet_id       = module.gpd_snet[0].id

  tags = var.tags
}
