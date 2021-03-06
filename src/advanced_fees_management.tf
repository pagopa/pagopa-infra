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
  }

  advanced_fees_management_cosmosdb_containers = [
    {
      name               = "bundles",
      partition_key_path = "/idPSP",
    },
    {
      name               = "archivedbundles",
      partition_key_path = "/idPSP",
    },
    {
      name               = "cibundles",
      partition_key_path = "/ciFiscalCode",
    },
    {
      name               = "archivedcibundles",
      partition_key_path = "/ciFiscalCode",
    },
    {
      name               = "bundlerequests",
      partition_key_path = "/idPSP",
    },
    {
      name               = "archivedbundlerequests",
      partition_key_path = "/idPSP",
    },
    {
      name               = "bundleoffers",
      partition_key_path = "/ciFiscalCode",
    },
    {
      name               = "archivedbundleoffers",
      partition_key_path = "/ciFiscalCode",
    },
  ]
}

# subnet
module "advanced_fees_management_snet" {
  count = var.env_short == "d" ? 1 : 0

  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-afm-snet", local.project)
  address_prefixes                               = var.cidr_subnet_advanced_fees_management
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name
  enforce_private_link_endpoint_network_policies = true

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]

}


# afm app configuration

# app service: this is used only for PoC
module "advanced_fees_management_app_service" {
  count  = var.env_short == "d" ? 1 : 0
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
  linux_fx_version  = format("DOCKER|%s/api-afm-backend:%s", module.container_registry.login_server, "latest")
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
    COSMOS_KEY = module.advanced_fees_management_cosmosdb_account[0].primary_key
    COSMOS_URI = module.advanced_fees_management_cosmosdb_account[0].connection_strings[0]

    CORS_CONFIGURATION = jsonencode(local.advanced_fees_management_cors_configuration)

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 8080

    DOCKER_REGISTRY_SERVER_URL      = "https://${module.container_registry.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = module.container_registry.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = module.container_registry.admin_password
  }

  allowed_subnets = [module.apim_snet.id]
  allowed_ips     = []

  subnet_id = module.advanced_fees_management_snet[0].id

  tags = var.tags
}

# afm cosmos configuration

# cosmosdb account
# module "advanced_fees_management_cosmosdb_account" {
#   count = var.env_short == "d" ? 1 : 0

#   source   = "git::https://github.com/pagopa/azurerm.git//cosmosdb_account?ref=v2.1.18"
#   name     = format("%s-afm-cosmosdb-account", local.project)
#   location = var.location

#   resource_group_name = azurerm_resource_group.advanced_fees_management_rg.name
#   offer_type          = "Standard"
#   kind                = "GlobalDocumentDB"

#   public_network_access_enabled = var.advanced_fees_management_cosmosdb_public_network_access_enabled

#   enable_free_tier          = false
#   enable_automatic_failover = true

#   consistency_policy = {
#     consistency_level       = "Strong"
#     max_interval_in_seconds = null
#     max_staleness_prefix    = null
#   }

#   main_geo_location_location = "westeurope"

#   # in order to disable redundancy in dev
#   main_geo_location_zone_redundant = false

#   # for the PoC we are not interested to backup
#   backup_continuous_enabled = false

#   is_virtual_network_filter_enabled = true

#   ip_range = ""

#   # add data.azurerm_subnet.<my_service>.id
#   allowed_virtual_network_subnet_ids = [module.advanced_fees_management_snet[0].id]

#   # private endpoint
#   private_endpoint_name    = format("%s-afm-cosmosdb-sql-endpoint", local.project)
#   private_endpoint_enabled = true
#   subnet_id                = module.advanced_fees_management_snet[0].id
#   private_dns_zone_ids     = [azurerm_private_dns_zone.privatelink_documents_azure_com.id]

#   tags = var.tags
# }

module "advanced_fees_management_cosmosdb_account" {
  count = var.env_short == "d" ? 1 : 0

  source   = "git::https://github.com/pagopa/azurerm.git//cosmosdb_account?ref=v2.1.18"
  name     = format("%s-afm-cosmosdb-account", local.project)
  location = var.location

  resource_group_name = azurerm_resource_group.advanced_fees_management_rg.name
  offer_type          = var.cosmos_afm_db_params.offer_type
  kind                = var.cosmos_afm_db_params.kind

  public_network_access_enabled    = var.cosmos_afm_db_params.public_network_access_enabled
  main_geo_location_zone_redundant = var.cosmos_afm_db_params.main_geo_location_zone_redundant

  enable_free_tier          = var.cosmos_afm_db_params.enable_free_tier
  enable_automatic_failover = true

  capabilities       = var.cosmos_afm_db_params.capabilities
  consistency_policy = var.cosmos_afm_db_params.consistency_policy

  main_geo_location_location = var.location
  additional_geo_locations   = var.cosmos_afm_db_params.additional_geo_locations
  backup_continuous_enabled  = var.cosmos_afm_db_params.backup_continuous_enabled

  is_virtual_network_filter_enabled = var.cosmos_afm_db_params.is_virtual_network_filter_enabled

  ip_range = ""

  # add data.azurerm_subnet.<my_service>.id
  allowed_virtual_network_subnet_ids = var.cosmos_afm_db_params.public_network_access_enabled ? [] : [module.advanced_fees_management_snet[0].id]

  # private endpoint
  private_endpoint_name    = format("%s-afm-cosmosdb-sql-endpoint", local.project)
  private_endpoint_enabled = var.cosmos_afm_db_params.private_endpoint_enabled
  subnet_id                = module.advanced_fees_management_snet[0].id
  private_dns_zone_ids     = [azurerm_private_dns_zone.privatelink_documents_azure_com.id]

  tags = var.tags
}


# cosmosdb database
module "advanced_fees_management_cosmosdb_database" {
  count = var.env_short == "d" ? 1 : 0

  source              = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_database?ref=v2.1.15"
  name                = "db"
  resource_group_name = azurerm_resource_group.advanced_fees_management_rg.name
  account_name        = module.advanced_fees_management_cosmosdb_account[0].name
}

# cosmosdb container
module "advanced_fees_management_cosmosdb_containers" {
  source   = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_container?ref=v2.1.8"
  for_each = { for c in local.advanced_fees_management_cosmosdb_containers : c.name => c if var.env_short == "d" }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.advanced_fees_management_rg.name
  account_name        = module.advanced_fees_management_cosmosdb_account[0].name
  database_name       = module.advanced_fees_management_cosmosdb_database[0].name
  partition_key_path  = each.value.partition_key_path
  throughput          = lookup(each.value, "throughput", null)

  autoscale_settings = lookup(each.value, "autoscale_settings", null)
}
