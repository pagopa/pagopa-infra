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
    GPD_HOST                      = format("https://api.%s.%s/%s/%s", var.dns_zone_prefix, var.external_domain, "gpd/api", "v1")
    PAYMENTS_SA_CONNECTION_STRING = module.payments_receipt.primary_connection_string
    RECEIPTS_TABLE                = azurerm_storage_table.payments_receipts_table.name
    CONNECTION_TIMEOUT            = 3000
    RETRY_MAX_ATTEMPTS            = 1
    RETRY_MAX_DELAY               = 2000
    LOGGING_LEVEL                 = var.payments_logging_level
    CACHE_SIZE                    = 1000
    CACHE_EXPIRATION_TIME         = "1d" # 1 day

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 8080

    DOCKER_REGISTRY_SERVER_URL      = "https://${module.container_registry.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = module.container_registry.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = module.container_registry.admin_password

  }

  gpd_payments_allowed_subnets = [module.apim_snet.id]
}

# https://pagopa.atlassian.net/wiki/spaces/DEVOPS/pages/467435830/App+service#pricing-e-reservation
# Quando si raggruppano app service o function nello stesso app service plan
# è possibile associare una sola subnet all’app service plan.

# Subnet
# module "payments_snet" {
#   source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
#   name                                           = format("%s-payments-snet", local.project)
#   address_prefixes                               = var.cidr_subnet_payments
#   resource_group_name                            = azurerm_resource_group.rg_vnet.name
#   virtual_network_name                           = module.vnet.name
#   enforce_private_link_endpoint_network_policies = true

#   delegation = {
#     name = "default"
#     service_delegation = {
#       name    = "Microsoft.Web/serverFarms"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
#     }
#   }
# }

module "payments_app_service" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v2.8.0"

  vnet_integration    = true
  resource_group_name = azurerm_resource_group.gpd_rg.name
  plan_type           = "external"
  # plan condiviso con GPD
  plan_id = azurerm_app_service_plan.gpd_service_plan.id

  # App service
  name                = format("%s-app-payments", local.project)
  client_cert_enabled = false
  always_on           = var.payments_always_on
  linux_fx_version    = format("DOCKER|%s/api-payments-backend:%s", module.container_registry.login_server, "latest")
  health_check_path   = "/info"

  app_settings = local.gpd_payments_app_settings

  allowed_subnets = local.gpd_payments_allowed_subnets
  allowed_ips     = []

  subnet_id = module.gpd_snet[0].id # shared plan

  tags = var.tags

}

module "payments_app_service_slot_staging" {
  count = var.env_short == "p" ? 1 : 0

  source = "git::https://github.com/pagopa/azurerm.git//app_service_slot?ref=v2.2.0"

  # App service plan
  app_service_plan_id = module.payments_app_service.plan_id
  app_service_id      = module.payments_app_service.id
  app_service_name    = module.payments_app_service.name

  # App service
  name                = "staging"
  resource_group_name = azurerm_resource_group.gpd_rg.name
  location            = azurerm_resource_group.gpd_rg.location

  always_on         = true
  linux_fx_version  = format("DOCKER|%s/api-payments-backend:%s", module.container_registry.login_server, "latest")
  health_check_path = "/info"

  # App settings
  app_settings = local.gpd_payments_app_settings

  allowed_subnets = local.gpd_payments_allowed_subnets
  allowed_ips     = []
  subnet_id       = module.gpd_snet[0].id

  tags = var.tags
}

# resource "azurerm_monitor_autoscale_setting" "payments_app_service_autoscale" {
#   name                = format("%s-autoscale-payments", local.project)
#   resource_group_name = azurerm_resource_group.gpd_rg.name
#   location            = azurerm_resource_group.gpd_rg.location
#   target_resource_id  = module.payments_app_service.plan_id

#   profile {
#     name = "default"

#     capacity {
#       default = var.gpd_payments_autoscale_default
#       minimum = var.gpd_payments_autoscale_minimum
#       maximum = var.gpd_payments_autoscale_maximum
#     }

#     rule {
#       metric_trigger {
#         metric_name              = "Requests"
#         metric_resource_id       = module.payments_app_service.id
#         metric_namespace         = "microsoft.web/sites"
#         time_grain               = "PT1M"
#         statistic                = "Average"
#         time_window              = "PT5M"
#         time_aggregation         = "Average"
#         operator                 = "GreaterThan"
#         threshold                = 3000
#         divide_by_instance_count = false
#       }

#       scale_action {
#         direction = "Increase"
#         type      = "ChangeCount"
#         value     = "2"
#         cooldown  = "PT5M"
#       }
#     }

#     rule {
#       metric_trigger {
#         metric_name              = "Requests"
#         metric_resource_id       = module.payments_app_service.id
#         metric_namespace         = "microsoft.web/sites"
#         time_grain               = "PT1M"
#         statistic                = "Average"
#         time_window              = "PT5M"
#         time_aggregation         = "Average"
#         operator                 = "LessThan"
#         threshold                = 2500
#         divide_by_instance_count = false
#       }

#       scale_action {
#         direction = "Decrease"
#         type      = "ChangeCount"
#         value     = "1"
#         cooldown  = "PT5M"
#       }
#     }
#   }
# }

# storage
module "payments_receipt" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v2.8.0"

  name                       = replace(format("%s-payments-sa", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = "LRS"
  access_tier                = "Hot"
  versioning_name            = "versioning"
  enable_versioning          = var.gpd_payments_versioning
  resource_group_name        = azurerm_resource_group.gpd_rg.name
  location                   = var.location
  advanced_threat_protection = var.gpd_payments_advanced_threat_protection
  allow_blob_public_access   = false

  blob_properties_delete_retention_policy_days = var.gpd_payments_delete_retention_days

  tags = var.tags
}


## table receipts storage
resource "azurerm_storage_table" "payments_receipts_table" {
  name                 = format("%sreceiptstable", module.payments_receipt.name)
  storage_account_name = module.payments_receipt.name
}
