# info for cosmos mongodb
data "azurerm_cosmosdb_account" "mongo_fdr_re_account" {
  name                = "${local.project}-re-cosmos-account"
  resource_group_name = "${local.project}-db-rg"
}

data "azurerm_cosmosdb_mongo_database" "fdr_re" {
  name                = "fdr-re"
  resource_group_name = "${local.project}-db-rg"
  account_name        = "${local.project}-re-cosmos-account"
}

# info for event hub
data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns03_fdr-re_fdr-re-rx" {
  name                = "fdr-re-rx"
  namespace_name      = "${local.product}-${var.location_short}-core-evh-ns03"
  eventhub_name       = "fdr-re"
  resource_group_name = "${local.product}-msg-rg"
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
  function_re_to_datastore_app_settings = {
    linux_fx_version               = "JAVA|11"
    FUNCTIONS_WORKER_RUNTIME       = "java"
    FUNCTIONS_WORKER_PROCESS_COUNT = 4
    // Keepalive fields are all optionals
    FETCH_KEEPALIVE_ENABLED             = "true"
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITE_ENABLE_SYNC_UPDATE_SITE     = true

    DOCKER_REGISTRY_SERVER_URL      = local.docker_settings.DOCKER_REGISTRY_SERVER_URL
    DOCKER_REGISTRY_SERVER_USERNAME = local.docker_settings.DOCKER_REGISTRY_SERVER_USERNAME
    DOCKER_REGISTRY_SERVER_PASSWORD = local.docker_settings.DOCKER_REGISTRY_SERVER_PASSWORD

    COSMOS_CONN_STRING        = "mongodb://${local.project}-re-cosmos-account:${data.azurerm_cosmosdb_account.mongo_fdr_re_account.primary_key}@${local.project}-re-cosmos-account.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@${local.project}-re-cosmos-account@"
    COSMOS_DB_NAME            = data.azurerm_cosmosdb_mongo_database.fdr_re.name
    COSMOS_DB_COLLECTION_NAME = "events"

    EVENTHUB_CONN_STRING = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns03_fdr-re_fdr-re-rx.primary_connection_string

    TABLE_STORAGE_CONN_STRING = data.azurerm_storage_account.fdr_re_storage_account.primary_connection_string
    TABLE_STORAGE_TABLE_NAME  = "events"
  }

  docker_settings = {
    IMAGE_NAME = "pagopa/pagopa-fdr-re-to-datastore"
    # ACR
    DOCKER_REGISTRY_SERVER_URL      = "ghcr.io"
    DOCKER_REGISTRY_SERVER_USERNAME = null
    DOCKER_REGISTRY_SERVER_PASSWORD = null
  }
}

## Function fdr_re
module "fdr_re_function" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v6.20.0"

  resource_group_name = data.azurerm_resource_group.fdr_re_rg.name
  name                = "${local.project}-re-fn"

  location          = var.location
  health_check_path = "/info"
  subnet_id         = module.fdr_re_function_snet.id
  runtime_version   = "~4"

  system_identity_enabled = true

  always_on = var.fdr_re_function.always_on

  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  docker = {
    image_name        = local.docker_settings.IMAGE_NAME
    image_tag         = var.fdr_re_function_app_image_tag
    registry_url      = local.docker_settings.DOCKER_REGISTRY_SERVER_URL
    registry_username = local.docker_settings.DOCKER_REGISTRY_SERVER_USERNAME
    registry_password = local.docker_settings.DOCKER_REGISTRY_SERVER_PASSWORD
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

  storage_account_info = var.storage_account_info

  app_settings = local.function_re_to_datastore_app_settings

  allowed_subnets = [data.azurerm_subnet.apim_vnet.id]
  allowed_ips     = []

  tags = var.tags
}

module "fdr_re_function_slot_staging" {
  count = var.env_short == "p" ? 1 : 0

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot?ref=v6.9.0"

  app_service_plan_id                      = module.fdr_re_function.app_service_plan_id
  function_app_id                          = module.fdr_re_function.id
  storage_account_name                     = module.fdr_re_function.storage_account_name
  storage_account_access_key               = module.fdr_re_function.storage_account.primary_access_key
  name                                     = "staging"
  resource_group_name                      = data.azurerm_resource_group.fdr_re_rg.name
  location                                 = var.location
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key
  always_on                                = var.fdr_re_function.always_on
  health_check_path                        = "/info"
  runtime_version                          = "~4"
  subnet_id                                = module.fdr_re_function_snet.id

  # App settings
  app_settings = local.function_re_to_datastore_app_settings

  docker = {
    image_name        = local.docker_settings.IMAGE_NAME
    image_tag         = var.fdr_re_function_app_image_tag
    registry_url      = local.docker_settings.DOCKER_REGISTRY_SERVER_URL
    registry_username = local.docker_settings.DOCKER_REGISTRY_SERVER_USERNAME
    registry_password = local.docker_settings.DOCKER_REGISTRY_SERVER_PASSWORD
  }

  allowed_subnets = [data.azurerm_subnet.apim_vnet.id]
  allowed_ips     = []

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "fdr_re_to_datastore_function" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "${module.fdr_re_function.name}-autoscale"
  resource_group_name = data.azurerm_resource_group.fdr_re_rg.name
  location            = var.location
  target_resource_id  = module.fdr_re_function.app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.fdr_re_function_autoscale.default
      minimum = var.fdr_re_function_autoscale.minimum
      maximum = var.fdr_re_function_autoscale.maximum
    }

    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = module.fdr_re_function.app_service_plan_id
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
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = module.fdr_re_function.app_service_plan_id
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
        cooldown  = "PT5M"
      }
    }
  }
}


