# region
resource "azurerm_resource_group" "advanced_fees_management_rg" {
  name     = format("%s-afm-rg", local.project)
  location = var.location

  tags = var.tags
}

# local variables
locals {
  advanced_fees_management_cors_configuration = {
    origins = ["*"]
    methods = ["*"]
  },

  advanced_fees_management_cosmosdb_enable_serverless = contains(var.advanced_fees_management_cosmosdb_extra_capabilities, "EnableServerless"),

  advanced_fees_management_cosmosdb_containers = [
    {
      name = "bundle",
      partition_key_path = "/idPSP",
    },
    {
      name = "cibundle",
      partition_key_path = "/ciFiscalCode",
    },
    {
      name = "bundlerequest",
      partition_key_path = "/idPSP",
    },
    {
      name = "bundleoffer",
      partition_key_path = "/ciFiscalCode",
    },
  ]
}

# subnet
module "advanced_fees_management_snet" {
  count                                          = var.advanced_fees_management_enabled && var.cidr_subnet_advanced_fees_management != null ? 1 : 0

  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-afm-snet", local.project)
  address_prefixes                               = var.cidr_subnet_advanced_fees_management
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name
  enforce_private_link_endpoint_network_policies = true

#  service_endpoints                              = ["Microsoft.Web"]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

# afm app configuration

# app service: this is used only for PoC
module "advanced_fees_management_app_service" {
  count  = var.advanced_fees_management_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v2.8.0"

  vnet_integration    = false
  resource_group_name = azurerm_resource_group.advanced_fees_management_rg.name
  location            = var.location

  # App service plan vars
  plan_name     = format("%s-plan-afm", local.project)
  plan_kind     = "Linux"
  plan_sku_tier = var.advanced_fees_management_tier
  plan_sku_size = var.advanced_fees_management_size
  plan_reserved = true # Mandatory for Linux plan

  # App service plan
  name                = format("%s-app-afm", local.project)
  client_cert_enabled = false
  always_on           = false
  # linux_fx_version    = "JAVA|11-java11"
  linux_fx_version  = format("DOCKER|%s/api-afm-backend:%s", module.acr[0].login_server, "latest")
  health_check_path = "/api/v1/info"


  app_settings = {
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
    COSMOS_KEY1 = data.azurerm_key_vault_secret.afm_cosmos_key1.value
    COSMOS_KEY2 = data.azurerm_key_vault_secret.afm_cosmos_key2.value
    COSMOS_URI  = null

    CORS_CONFIGURATION         = jsonencode(local.advanced_fees_management_cors_configuration)

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 8080

    DOCKER_REGISTRY_SERVER_URL      = "https://${module.acr[0].login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = module.acr[0].admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = module.acr[0].admin_password
  }

  allowed_subnets = [module.apim_snet.id]
  allowed_ips     = []

  subnet_id = module.advanced_fees_management_snet[0].id

  tags = var.tags
}

# afm cosmos configuration

# cosmosdb account
module "advanced_fees_management_cosmosdb_account" {
  count  = var.advanced_fees_management_enabled ? 1 : 0

  source   = "git::https://github.com/pagopa/azurerm.git//cosmosdb_account?ref=v2.1.18"
  name     = format("%s-afm-cosmos-account", local.project)
  location = var.location

  resource_group_name = azurerm_resource_group.advanced_fees_management_rg.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  public_network_access_enabled    = var.advanced_fees_management_cosmosdb_public_network_access_enabled
  main_geo_location_zone_redundant = false

  enable_free_tier          = false
  enable_automatic_failover = true

  consistency_policy = {
    consistency_level       = "Strong"
    max_interval_in_seconds = null
    max_staleness_prefix    = null
  }

  main_geo_location_location = "westeurope"

  # in order to disable redundancy in dev
  main_geo_location_zone_redundant = var.advanced_fees_management_enabled

  # for the PoC we are not interested to redundancy
#  additional_geo_locations = [
#    {
#      location          = "northeurope"
#      failover_priority = 1
#      zone_redundant    = true
#    }
#  ]

  # for the PoC we are not interested to backup
  backup_continuous_enabled = false

  is_virtual_network_filter_enabled = true

  ip_range = ""

  # add data.azurerm_subnet.<my_service>.id
  allowed_virtual_network_subnet_ids = [module.advanced_fees_management_snet[0].id]

  # private endpoint
  private_endpoint_name    = format("%s-afm-cosmosdb-sql-endpoint", local.project)
  private_endpoint_enabled = true
  subnet_id                = module.advanced_fees_management_snet.id
  private_dns_zone_ids     = [azurerm_private_dns_zone.privatelink_afm_cosmos_azure_com.id]

  tags = var.tags
}

# cosmosdb database
module "advanced_fees_management_cosmosdb_database" {
  count  = var.advanced_fees_management_enabled ? 1 : 0

  source              = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_database?ref=v2.1.15"
  name                = "db"
  resource_group_name = azurerm_resource_group.advanced_fees_management_rg.name
  account_name        = module.advanced_fees_management_cosmosdb_account[0].name
}

# cosmosdb container
module "advanced_fees_management_cosmosdb_containers" {
  source   = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_container?ref=v2.1.8"
  for_each = { for c in local.advanced_fees_management_cosmosdb_containers : c.name => c }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.advanced_fees_management_rg.name
  account_name        = module.advanced_fees_management_cosmosdb_account[0].name
  database_name       = module.advanced_fees_management_cosmosdb_database[0].name
  partition_key_path  = each.value.partition_key_path
  partition_key_version  = 2
  throughput          = lookup(each.value, "throughput", null)

  autoscale_settings = lookup(each.value, "autoscale_settings", null)

}