data "azurerm_container_registry" "acr" {
  name                = local.acr_name
  resource_group_name = local.acr_resource_group_name
}

resource "azurerm_resource_group" "gpd_rg" {
  name     = format("%s-gpd-rg", local.project)
  location = var.location

  tags = var.tags
}

resource "azurerm_app_service_plan" "gpd_reporting_service_plan" {
  name                = format("%s-plan-gpd-reporting", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.gpd_rg.name

  kind     = var.reporting_functions_app_sku.kind
  reserved = var.reporting_functions_app_sku.kind == "Linux" ? true : false

  sku {
    tier = var.reporting_functions_app_sku.sku_tier
    size = var.reporting_functions_app_sku.sku_size
  }

  tags = var.tags
}

locals {
  function_batch_app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "java"
    // Keepalive fields are all optionals
    FETCH_KEEPALIVE_ENABLED             = "true"
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
    FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
    FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"

    # custom configuration
    FLOW_SA_CONNECTION_STRING = data.azurerm_key_vault_secret.flows_sa_connection_string.value
    ORGANIZATIONS_TABLE       = replace("${local.product}flowsaorgstable", "-", "")
    FLOWS_TABLE               = replace("${local.product}flowsatable", "-", "")
    ORGANIZATIONS_QUEUE       = replace("${local.product}flowsaqueueorg", "-", "")
    FLOWS_QUEUE               = replace("${local.product}flowsaqueueflows", "-", "")
    # GPD_HOST             = format("https://api.%s.%s/%s/%s",var.dns_zone_prefix, var.external_domain, module.apim_api_gpd_api.path, module.apim_api_gpd_api.api_version )
    GPD_HOST             = format("https://api.%s.%s/%s/%s", var.dns_zone_prefix, var.external_domain, "gpd/api", "v1")
    NODO_HOST            = format("https://api.%s.%s/%s-nodo-per-pa-api/v1", var.dns_zone_prefix, var.external_domain, var.env_short)
    PAA_ID_INTERMEDIARIO = var.gpd_paa_id_intermediario
    PAA_STAZIONE_INT     = var.gpd_paa_stazione_int
    PAA_PASSWORD         = data.azurerm_key_vault_secret.gpd_paa_pwd.value
    NCRON_SCHEDULE_BATCH = var.gpd_reporting_schedule_batch
    MAX_RETRY_QUEUING    = var.gpd_max_retry_queuing
    QUEUE_RETENTION_SEC  = var.gpd_queue_retention_sec
    QUEUE_DELAY_SEC      = var.gpd_queue_delay_sec

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITE_ENABLE_SYNC_UPDATE_SITE     = true

    # ACR
    DOCKER_REGISTRY_SERVER_URL      = "https://${data.azurerm_container_registry.acr.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = data.azurerm_container_registry.acr.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = data.azurerm_container_registry.acr.admin_password
  }
}

## Function reporting_batch
module "reporting_batch_function" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v2.2.0"

  resource_group_name                      = azurerm_resource_group.gpd_rg.name
  name                                     = replace("${local.project}fn-gpd-batch", "gps", "")
  location                                 = var.location
  health_check_path                        = "info"
  subnet_id                                = module.reporting_function_snet.id
  runtime_version                          = "~3"
  os_type                                  = "linux"
  always_on                                = var.reporting_batch_function_always_on
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key
  app_service_plan_id                      = azurerm_app_service_plan.gpd_reporting_service_plan.id
  app_settings                             = local.function_batch_app_settings

  allowed_subnets = [data.azurerm_subnet.apim_vnet.id]
  allowed_ips     = []

  tags = var.tags

  depends_on = [
    azurerm_app_service_plan.gpd_reporting_service_plan
  ]
}

module "reporting_batch_function_slot_staging" {
  count = var.env_short == "p" ? 1 : 0

  source = "git::https://github.com/pagopa/azurerm.git//function_app_slot?ref=v2.2.0"

  app_service_plan_id                      = azurerm_app_service_plan.gpd_reporting_service_plan.id
  function_app_name                        = module.reporting_batch_function.name
  function_app_id                          = module.reporting_batch_function.id
  storage_account_name                     = module.reporting_batch_function.storage_account_name
  storage_account_access_key               = module.reporting_batch_function.storage_account.primary_access_key
  os_type                                  = "linux"
  name                                     = "staging"
  resource_group_name                      = azurerm_resource_group.gpd_rg.name
  location                                 = var.location
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key
  always_on                                = var.reporting_batch_function_always_on
  health_check_path                        = "info"

  # App settings
  app_settings = local.function_batch_app_settings

  allowed_subnets = [data.azurerm_subnet.apim_vnet.id]
  allowed_ips     = []
  subnet_id       = module.reporting_function_snet.id

  tags = var.tags
}
