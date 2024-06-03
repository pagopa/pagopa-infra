locals {
  function_json_to_xml_app_settings = {
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

    STORAGE_ACCOUNT_CONN_STRING = data.azurerm_storage_account.fdr_storage_account.primary_connection_string
    FDR_FASE1_BASE_URL          = var.env == "prod" ? "https://api.platform.pagopa.it/fdr-legacy/service-internal/v1" : "https://api.${var.env}.platform.pagopa.it/fdr-legacy/service-internal/v1"
    FDR_FASE1_API_KEY           = data.azurerm_key_vault_secret.fdr_internal_product_subscription_key.value
    TABLE_STORAGE_CONN_STRING   = data.azurerm_storage_account.fdr_storage_account.primary_connection_string
    TABLE_STORAGE_TABLE_NAME    = "flowidsendqueueerror"
    QUEUE_NAME                  = "flowidsendqueue"
  }

  json_to_xml_docker_settings = {
    IMAGE_NAME = "pagopa/pagopa-fdr-json-to-xml"
    # ACR
    DOCKER_REGISTRY_SERVER_URL = "ghcr.io"
  }
}

## Function fdr_json_to_xml
module "fdr_json_to_xml_function" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v6.20.0"

  resource_group_name = data.azurerm_resource_group.fdr_rg.name
  name                = "${local.project}-json-to-xml-fn"

  location          = var.location
  health_check_path = "/info"
  subnet_id         = module.fdr_json_to_xml_function_snet.id
  runtime_version   = "~4"

  system_identity_enabled = true

  always_on = var.fdr_json_to_xml_function.always_on

  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  docker = {
    image_name        = local.json_to_xml_docker_settings.IMAGE_NAME
    image_tag         = var.fdr_json_to_xml_function_app_image_tag
    registry_url      = local.json_to_xml_docker_settings.DOCKER_REGISTRY_SERVER_URL
    registry_username = null
    registry_password = null
  }



  #sticky_connection_string_names = ["COSMOS_CONN_STRING"]
  client_certificate_mode = "Optional"

  cors = {
    allowed_origins = []
  }

  app_service_plan_name = "${local.project}-json-to-xml-fn-plan"
  app_service_plan_info = {
    kind                         = var.fdr_json_to_xml_function.kind
    sku_size                     = var.fdr_json_to_xml_function.sku_size
    maximum_elastic_worker_count = var.fdr_json_to_xml_function.maximum_elastic_worker_count
    worker_count                 = 1
    zone_balancing_enabled       = false
  }

  storage_account_name = replace(format("%s-json-2-xml-sa", local.project), "-", "")
  storage_account_info = var.storage_account_info

  app_settings = local.function_json_to_xml_app_settings

  allowed_subnets =  local.function_allowed_subnets
  allowed_ips     = []

  tags = var.tags
}

module "fdr_json_to_xml_function_slot_staging" {
  count = var.env_short == "p" ? 1 : 0

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot?ref=v6.9.0"

  app_service_plan_id                      = module.fdr_json_to_xml_function.app_service_plan_id
  function_app_id                          = module.fdr_json_to_xml_function.id
  storage_account_name                     = module.fdr_json_to_xml_function.storage_account_name
  storage_account_access_key               = module.fdr_json_to_xml_function.storage_account.primary_access_key
  name                                     = "staging"
  resource_group_name                      = data.azurerm_resource_group.fdr_rg.name
  location                                 = var.location
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key
  always_on                                = var.fdr_json_to_xml_function.always_on
  health_check_path                        = "/info"
  runtime_version                          = "~4"
  subnet_id                                = module.fdr_json_to_xml_function_snet.id

  # App settings
  app_settings = local.function_json_to_xml_app_settings

  docker = {
    image_name        = local.json_to_xml_docker_settings.IMAGE_NAME
    image_tag         = var.fdr_json_to_xml_function_app_image_tag
    registry_url      = local.json_to_xml_docker_settings.DOCKER_REGISTRY_SERVER_URL
    registry_username = null
    registry_password = null
  }

  allowed_subnets =  local.function_allowed_subnets
  allowed_ips     = []

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "fdr_json_to_xml_function" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "${module.fdr_json_to_xml_function.name}-autoscale"
  resource_group_name = data.azurerm_resource_group.fdr_rg.name
  location            = var.location
  target_resource_id  = module.fdr_json_to_xml_function.app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.fdr_json_to_xml_function_autoscale.default
      minimum = var.fdr_json_to_xml_function_autoscale.minimum
      maximum = var.fdr_json_to_xml_function_autoscale.maximum
    }

    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = module.fdr_json_to_xml_function.app_service_plan_id
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
        metric_resource_id = module.fdr_json_to_xml_function.app_service_plan_id
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


