# info for cosmosdb nosql
data "azurerm_cosmosdb_account" "nodo_re_cosmosdb_nosql" {
  count               = var.enable_nodo_re ? 1 : 0
  name                = "${local.project}-re-cosmos-nosql-account"
  resource_group_name = format("%s-db-rg", local.project)
}

data "azurerm_cosmosdb_sql_database" "nodo_re_cosmosdb_nosql_db" {
  count               = var.enable_nodo_re ? 1 : 0
  name                = "nodo_re"
  resource_group_name = data.azurerm_cosmosdb_account.nodo_re_cosmosdb_nosql[0].resource_group_name
  account_name        = data.azurerm_cosmosdb_account.nodo_re_cosmosdb_nosql[0].name
}

# info for event hub
data "azurerm_eventhub" "pagopa-evh-ns03_nodo-dei-pagamenti-re_nodo-dei-pagamenti-re" {
  count               = var.enable_nodo_re ? 1 : 0
  name                = "nodo-dei-pagamenti-re"
  resource_group_name = "${local.product}-msg-rg"
  namespace_name      = "${local.product}-${var.location_short}-core-evh-ns03"
}


data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns03_nodo-dei-pagamenti-re_nodo-dei-pagamenti-re-to-datastore-rx" {
  count               = var.enable_nodo_re ? 1 : 0
  name                = "nodo-dei-pagamenti-re-to-datastore-rx"
  namespace_name      = "${local.product}-${var.location_short}-core-evh-ns03"
  eventhub_name       = "nodo-dei-pagamenti-re"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_container_registry" "acr" {
  name                = local.acr_name
  resource_group_name = local.acr_resource_group_name
}

data "azurerm_subnet" "apim_vnet" {
  name                 = local.apim_snet
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_integration_name
}

resource "azurerm_resource_group" "nodo_re_to_datastore_rg" {
  count = var.enable_nodo_re || var.env_short != "d" ? 1 : 0

  name     = format("%s-re-to-datastore-rg", local.project)
  location = var.location

  tags = module.tag_config.tags
}

locals {
  function_re_to_datastore_app_settings = {
    linux_fx_version               = "JAVA|11"
    FUNCTIONS_WORKER_RUNTIME       = "java"
    FUNCTIONS_WORKER_PROCESS_COUNT = 4
    // Keepalive fields are all optionals
    FETCH_KEEPALIVE_ENABLED             = "true"
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
    FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
    FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITE_ENABLE_SYNC_UPDATE_SITE     = true

    DOCKER_REGISTRY_SERVER_URL = local.docker_settings.DOCKER_REGISTRY_SERVER_URL

    COSMOS_CONN_STRING        = var.enable_nodo_re ? "AccountEndpoint=https://${local.project}-re-cosmos-nosql-account.documents.azure.com:443/;AccountKey=${data.azurerm_cosmosdb_account.nodo_re_cosmosdb_nosql[0].primary_key}" : ""
    COSMOS_DB_NAME            = "nodo_re"
    COSMOS_DB_COLLECTION_NAME = "events"

    EVENTHUB_CONN_STRING = var.enable_nodo_re ? data.azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-re_nodo-dei-pagamenti-re-to-datastore-rx[0].primary_connection_string : ""
  }

  docker_settings = {
    IMAGE_NAME = "pagopa/pagopa-nodo-re-to-datastore"
    # ghcr
    DOCKER_REGISTRY_SERVER_URL = "ghcr.io"
  }
}

## Function nodo_re_to_datastore
module "nodo_re_to_datastore_function" {
  count = var.enable_nodo_re ? 1 : 0

  source = "./.terraform/modules/__v3__/function_app"

  resource_group_name = azurerm_resource_group.nodo_re_to_datastore_rg[0].name
  name                = "${local.project}-re-fn"

  location          = var.location
  health_check_path = "/info"
  subnet_id         = module.nodo_re_to_datastore_function_snet[0].id
  runtime_version   = "~4"

  system_identity_enabled = true

  always_on = var.nodo_re_to_datastore_function.always_on

  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  docker = {
    image_name        = local.docker_settings.IMAGE_NAME
    image_tag         = var.nodo_re_to_datastore_function_app_image_tag
    registry_url      = local.docker_settings.DOCKER_REGISTRY_SERVER_URL
    registry_username = null
    registry_password = null
  }

  sticky_connection_string_names = ["COSMOS_CONN_STRING"]
  client_certificate_mode        = "Optional"

  cors = {
    allowed_origins = []
  }

  app_service_plan_name = "${local.project}-re-to-datastore-plan"
  app_service_plan_info = {
    kind                         = var.nodo_re_to_datastore_function.kind
    sku_size                     = var.nodo_re_to_datastore_function.sku_size
    maximum_elastic_worker_count = var.nodo_re_to_datastore_function.maximum_elastic_worker_count
    worker_count                 = 1
    zone_balancing_enabled       = false
  }

  storage_account_name = replace("${local.project}-re-2-dst-fn-sa", "-", "")
  storage_account_info = {
    account_kind                      = "StorageV2"
    account_tier                      = "Standard"
    account_replication_type          = var.function_app_storage_account_replication_type
    access_tier                       = "Hot"
    advanced_threat_protection_enable = true
    use_legacy_defender_version       = true
    public_network_access_enabled     = false
  }

  app_settings = local.function_re_to_datastore_app_settings

  allowed_subnets = [data.azurerm_subnet.apim_vnet.id]
  allowed_ips     = []

  tags = module.tag_config.tags
}

module "nodo_re_to_datastore_function_slot_staging" {
  count = var.enable_nodo_re && var.env_short == "p" ? 1 : 0

  source = "./.terraform/modules/__v3__/function_app_slot"

  app_service_plan_id                      = module.nodo_re_to_datastore_function[0].app_service_plan_id
  function_app_id                          = module.nodo_re_to_datastore_function[0].id
  storage_account_name                     = module.nodo_re_to_datastore_function[0].storage_account_name
  storage_account_access_key               = module.nodo_re_to_datastore_function[0].storage_account.primary_access_key
  name                                     = "staging"
  resource_group_name                      = azurerm_resource_group.nodo_re_to_datastore_rg[0].name
  location                                 = var.location
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key
  always_on                                = var.nodo_re_to_datastore_function.always_on
  health_check_path                        = "/info"
  runtime_version                          = "~4"
  subnet_id                                = module.nodo_re_to_datastore_function_snet[0].id

  # App settings
  app_settings = local.function_re_to_datastore_app_settings

  docker = {
    image_name        = local.docker_settings.IMAGE_NAME
    image_tag         = var.nodo_re_to_datastore_function_app_image_tag
    registry_url      = local.docker_settings.DOCKER_REGISTRY_SERVER_URL
    registry_username = null
    registry_password = null
  }

  allowed_subnets = [data.azurerm_subnet.apim_vnet.id]
  allowed_ips     = []

  tags = module.tag_config.tags
}

resource "azurerm_monitor_autoscale_setting" "nodo_re_to_datastore_function" {
  count               = var.enable_nodo_re && var.env_short == "p" ? 1 : 0
  name                = "${module.nodo_re_to_datastore_function[0].name}-autoscale"
  resource_group_name = azurerm_resource_group.nodo_re_to_datastore_rg[0].name
  location            = var.location
  target_resource_id  = module.nodo_re_to_datastore_function[0].app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.nodo_re_to_datastore_function_autoscale.default
      minimum = var.nodo_re_to_datastore_function_autoscale.minimum
      maximum = var.nodo_re_to_datastore_function_autoscale.maximum
    }

    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = module.nodo_re_to_datastore_function[0].app_service_plan_id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = module.nodo_re_to_datastore_function[0].app_service_plan_id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 30
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }
}
