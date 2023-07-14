# info for cosmos mongodb
data "azurerm_cosmosdb_account" "mongo_fdr_re_account" {
  name                = "${local.project}-cosmos-account"
  resource_group_name = "${local.project}-db-rg"
}

data "azurerm_cosmosdb_mongo_database" "fdr_re" {
  name                = "fdr-re"
  resource_group_name = "${local.project}-db-rg"
  account_name        = "${local.project}-cosmos-account"
}

# info for event hub
data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns01_fdr-re_fdr-re-rx" {
  name                = "fdr-re-rx"
  namespace_name      = "${local.product}-evh-ns01"
  eventhub_name       = "fdr-re"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_container_registry" "acr" {
  name                = local.acr_name
  resource_group_name = local.acr_resource_group_name
}

# info for table storage
data "azurerm_resource_group" "fdr_re_rg" {
  name = "${local.project}-re-rg"
}

data "azurerm_storage_account" "fdr_re_storage_account" {
  name                = replace("${local.project}-re-sa", "-", "")
  resource_group_name = data.azurerm_resource_group.fdr_re_rg.name
}

locals {
  function_re_to_datastore_settings = {
    FUNCTIONS_WORKER_RUNTIME = "java"
    // Keepalive fields are all optionals
    FETCH_KEEPALIVE_ENABLED             = "true"
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
    FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
    FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"

    EVENTHUB_CONN_STRING = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns01_fdr-re_fdr-re-rx.primary_connection_string
    COSMOS_CONN_STRING   = "mongodb://${local.project}-cosmos-account:${data.azurerm_cosmosdb_account.mongo_fdr_re_account.primary_key}@${local.project}-cosmos-account.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@${local.project}-cosmos-account@"
  }

  docker_settings = {
    # ACR
    DOCKER_REGISTRY_SERVER_URL      = data.azurerm_container_registry.acr.login_server
    DOCKER_REGISTRY_SERVER_USERNAME = data.azurerm_container_registry.acr.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = data.azurerm_container_registry.acr.admin_password
  }
}

## Function fdr_re
module "nodo_re_function" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v6.20.0"

  resource_group_name = data.azurerm_resource_group.fdr_re_rg.name
  name                = "${local.project}-re-to-datastore-fn"

  location          = var.location
  health_check_path = "/info"
  subnet_id         = module.fdr_re_function_snet.id
  runtime_version   = "~4"

  system_identity_enabled = true

  always_on = var.fdr_re_function.always_on

  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  docker = {
    image_name        = "pagopafdrre"
    image_tag         = var.fdr_re_function_app_image_tag
    registry_password = local.docker_settings.DOCKER_REGISTRY_SERVER_PASSWORD
    registry_url      = "https://${local.docker_settings.DOCKER_REGISTRY_SERVER_URL}"
    registry_username = local.docker_settings.DOCKER_REGISTRY_SERVER_USERNAME
  }

  sticky_connection_string_names = ["COSMOS_CONN_STRING"]
  client_certificate_mode        = "Optional"

  cors = {
    allowed_origins = []
  }

  app_service_plan_name = "${local.project}-re-fn-plan"
  app_service_plan_info = {
    kind                         = var.fdr_re_function.kind
    sku_size                     = var.fdr_re_function.sku_size
    maximum_elastic_worker_count = var.fdr_re_function.maximum_elastic_worker_count
    worker_count                 = 1
    zone_balancing_enabled       = false
  }

  storage_account_name = replace(format("%s-re-fn-sa", local.project), "-", "")

  app_settings = {
    linux_fx_version                    = "JAVA|11"
    FUNCTIONS_WORKER_RUNTIME            = "java"
    FUNCTIONS_WORKER_PROCESS_COUNT      = 4
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITE_ENABLE_SYNC_UPDATE_SITE     = true

    DOCKER_REGISTRY_SERVER_URL      = local.docker_settings.DOCKER_REGISTRY_SERVER_URL
    DOCKER_REGISTRY_SERVER_USERNAME = local.docker_settings.DOCKER_REGISTRY_SERVER_USERNAME
    DOCKER_REGISTRY_SERVER_PASSWORD = local.docker_settings.DOCKER_REGISTRY_SERVER_PASSWORD

    COSMOS_CONN_STRING        = local.function_re_to_datastore_settings.COSMOS_CONN_STRING
    COSMOS_DB_NAME            = data.azurerm_cosmosdb_mongo_database.fdr_re.name
    COSMOS_DB_COLLECTION_NAME = "events"

    EVENTHUB_CONN_STRING = local.function_re_to_datastore_settings.EVENTHUB_CONN_STRING

    TABLE_STORAGE_CONN_STRING = data.azurerm_storage_account.fdr_re_storage_account.primary_connection_string
    TABLE_STORAGE_TABLE_NAME  = "events"
  }

  allowed_subnets = [data.azurerm_subnet.apim_vnet.id]
  allowed_ips     = []

  tags = var.tags
}
