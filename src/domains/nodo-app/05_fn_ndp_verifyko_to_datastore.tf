# info for cosmosdb nosql
data "azurerm_cosmosdb_account" "nodo_verifyko_cosmosdb_nosql" {
  name                = "${local.project}-verifyko-cosmos-account"
  resource_group_name = data.azurerm_resource_group.nodo_verify_ko_rg.name
}

data "azurerm_cosmosdb_sql_database" "nodo_verifyko_cosmosdb_nosql_db" {
  name                = "nodo_verifyko"
  resource_group_name = data.azurerm_cosmosdb_account.nodo_verifyko_cosmosdb_nosql.resource_group_name
  account_name        = data.azurerm_cosmosdb_account.nodo_verifyko_cosmosdb_nosql.name
}

data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns03_nodo-dei-pagamenti-verify-ko_nodo-dei-pagamenti-verify-ko-datastore-rx" {
  name                = "nodo-dei-pagamenti-verify-ko-datastore-rx"
  namespace_name      = "${local.product}-${var.location_short}-core-evh-ns03"
  eventhub_name       = "nodo-dei-pagamenti-verify-ko"
  resource_group_name = "${local.product}-msg-rg"
}

locals {
  function_verifyko_to_datastore_app_settings = {
    linux_fx_version = "JAVA|11"
    #    linux_fx_version               = "DOCKER|${local.verifyko_ds_docker_settings.DOCKER_REGISTRY_SERVER_URL}/${local.verifyko_ds_docker_settings.IMAGE_NAME}:${var.nodo_verifyko_to_datastore_function_app_image_tag}"
    FUNCTIONS_WORKER_RUNTIME       = "java"
    FUNCTIONS_WORKER_PROCESS_COUNT = 4

    // Keepalive fields are all optionals
    #    FETCH_KEEPALIVE_ENABLED             = "true"
    #    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
    #    FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
    #    FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
    #    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    #    FETCH_KEEPALIVE_TIMEOUT             = "60000"

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITE_ENABLE_SYNC_UPDATE_SITE     = true

    DOCKER_REGISTRY_SERVER_URL = local.verifyko_ds_docker_settings.DOCKER_REGISTRY_SERVER_URL

    COSMOS_CONN_STRING        = "AccountEndpoint=https://${local.project}-verifyko-cosmos-account.documents.azure.com:443/;AccountKey=${data.azurerm_cosmosdb_account.nodo_verifyko_cosmosdb_nosql.primary_key}"
    COSMOS_DB_NAME            = "nodo_verifyko"
    COSMOS_DB_COLLECTION_NAME = "events"

    EVENTHUB_CONN_STRING = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-verify-ko_nodo-dei-pagamenti-verify-ko-datastore-rx.primary_connection_string
  }

  verifyko_ds_docker_settings = {
    IMAGE_NAME = "pagopa/pagopa-nodo-verifyko-to-datastore"
    # ghcr
    DOCKER_REGISTRY_SERVER_URL = "ghcr.io"
  }
}

## Function nodo_verifyko_to_datastore
module "nodo_verifyko_to_datastore_function" {
  source = "./.terraform/modules/__v3__/function_app"

  resource_group_name = data.azurerm_resource_group.nodo_verify_ko_rg.name
  name                = "${local.project}-verifyko2ds-fn"

  location          = var.location
  health_check_path = "/info"
  subnet_id         = module.nodo_verifyko_to_datastore_function_snet.id
  runtime_version   = "~4"

  system_identity_enabled = true

  always_on = var.nodo_verifyko_to_datastore_function.always_on

  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  docker = {
    image_name        = local.verifyko_ds_docker_settings.IMAGE_NAME
    image_tag         = var.nodo_verifyko_to_datastore_function_app_image_tag
    registry_url      = local.verifyko_ds_docker_settings.DOCKER_REGISTRY_SERVER_URL
    registry_username = null
    registry_password = null
  }

  sticky_connection_string_names = ["COSMOS_CONN_STRING"]
  client_certificate_mode        = "Optional"


  app_service_plan_name = "${local.project}-verifyko-to-datastore-plan"
  app_service_plan_info = {
    kind                         = var.nodo_verifyko_to_datastore_function.kind
    sku_size                     = var.nodo_verifyko_to_datastore_function.sku_size
    maximum_elastic_worker_count = var.nodo_verifyko_to_datastore_function.maximum_elastic_worker_count
    worker_count                 = var.env_short == "p" ? 3 : 1
    zone_balancing_enabled       = var.nodo_verifyko_to_datastore_function.zone_balancing_enabled
  }

  storage_account_name = replace("${local.project}-vko-2-ds-fn-sa", "-", "")
  storage_account_info = var.storage_account_info

  app_settings = local.function_verifyko_to_datastore_app_settings

  allowed_subnets = [data.azurerm_subnet.apim_vnet.id]
  allowed_ips     = []

  tags = module.tag_config.tags
}

module "nodo_verifyko_to_datastore_function_slot_staging" {
  count = var.env_short == "p" ? 1 : 0

  source = "./.terraform/modules/__v3__/function_app_slot"

  app_service_plan_id                      = module.nodo_verifyko_to_datastore_function.app_service_plan_id
  function_app_id                          = module.nodo_verifyko_to_datastore_function.id
  storage_account_name                     = module.nodo_verifyko_to_datastore_function.storage_account_name
  storage_account_access_key               = module.nodo_verifyko_to_datastore_function.storage_account.primary_access_key
  name                                     = "staging"
  resource_group_name                      = data.azurerm_resource_group.nodo_verify_ko_rg.name
  location                                 = var.location
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key
  always_on                                = var.nodo_verifyko_to_datastore_function.always_on
  health_check_path                        = "/info"
  runtime_version                          = "~4"
  subnet_id                                = module.nodo_verifyko_to_datastore_function_snet.id

  # App settings
  app_settings = local.function_verifyko_to_datastore_app_settings

  docker = {
    image_name        = local.verifyko_ds_docker_settings.IMAGE_NAME
    image_tag         = var.nodo_verifyko_to_datastore_function_app_image_tag
    registry_url      = local.verifyko_ds_docker_settings.DOCKER_REGISTRY_SERVER_URL
    registry_username = null
    registry_password = null
  }

  allowed_subnets = [data.azurerm_subnet.apim_vnet.id]
  allowed_ips     = []

  tags = module.tag_config.tags
}

resource "azurerm_monitor_autoscale_setting" "nodo_verifyko_to_datastore_function" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "${module.nodo_verifyko_to_datastore_function.name}-autoscale"
  resource_group_name = data.azurerm_resource_group.nodo_verify_ko_rg.name
  location            = var.location
  target_resource_id  = module.nodo_verifyko_to_datastore_function.app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.nodo_verifyko_to_datastore_function_autoscale.default
      minimum = var.nodo_verifyko_to_datastore_function_autoscale.minimum
      maximum = var.nodo_verifyko_to_datastore_function_autoscale.maximum
    }

    rule {
      metric_trigger {
        metric_name        = "IncomingMessages"
        metric_namespace   = "microsoft.eventhub/namespaces"
        metric_resource_id = data.azurerm_eventhub_namespace.pagopa-evh-ns03.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 100

        dimensions {
          name     = "EntityName"
          operator = "Equals"
          values   = ["nodo-dei-pagamenti-verify-ko"]
        }
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
        metric_name        = "IncomingMessages"
        metric_namespace   = "microsoft.eventhub/namespaces"
        metric_resource_id = data.azurerm_eventhub_namespace.pagopa-evh-ns03.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 30

        dimensions {
          name     = "EntityName"
          operator = "Equals"
          values   = ["nodo-dei-pagamenti-verify-ko"]
        }
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
