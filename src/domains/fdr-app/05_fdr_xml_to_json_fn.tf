

# info for table storage
data "azurerm_resource_group" "fdr_rg" {
  name = "${local.project}-rg"
}

data "azurerm_storage_account" "fdr_storage_account" {
  name                = replace("${local.project}-sa", "-", "")
  resource_group_name = data.azurerm_resource_group.fdr_rg.name
}

locals {
  function_xml_to_json_app_settings = {
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

    STORAGE_ACCOUNT_CONN_STRING        = data.azurerm_storage_account.fdr_storage_account.primary_connection_string
    FDR_NEW_BASE_URL                   = var.env == "prod" ? "https://api.platform.pagopa.it/fdr-internal/service/v1" : "https://api.${var.env}.platform.pagopa.it/fdr-internal/service/v1"
    FDR_NEW_API_KEY                    = data.azurerm_key_vault_secret.fdr_internal_product_subscription_key.value
    ADD_PAYMENT_REQUEST_PARTITION_SIZE = "1000"
    TABLE_STORAGE_CONN_STRING          = data.azurerm_storage_account.fdr_storage_account.primary_connection_string
    TABLE_STORAGE_TABLE_NAME           = "xmlsharefileerror"
    BLOB_CONTAINER_NAME                = "xmlsharefile"
  }

  xml_to_json_docker_settings = {
    IMAGE_NAME = "pagopa/pagopa-fdr-xml-to-json"
    # ACR
    DOCKER_REGISTRY_SERVER_URL = "ghcr.io"
  }
}

## Function fdr_xml_to_json
module "fdr_xml_to_json_function" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v6.20.0"

  resource_group_name = data.azurerm_resource_group.fdr_rg.name
  name                = "${local.project}-xml-to-json-fn"

  location          = var.location
  health_check_path = "/info"
  subnet_id         = module.fdr_xml_to_json_function_snet.id
  runtime_version   = "~4"

  system_identity_enabled = true

  always_on = var.fdr_xml_to_json_function.always_on

  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  docker = {
    image_name        = local.xml_to_json_docker_settings.IMAGE_NAME
    image_tag         = var.fdr_xml_to_json_function_app_image_tag
    registry_url      = local.xml_to_json_docker_settings.DOCKER_REGISTRY_SERVER_URL
    registry_username = null
    registry_password = null
  }

  #sticky_connection_string_names = ["COSMOS_CONN_STRING"]
  client_certificate_mode = "Optional"

  cors = {
    allowed_origins = []
  }

  app_service_plan_name = "${local.project}-xml-to-json-fn-plan"
  app_service_plan_info = {
    kind                         = var.fdr_xml_to_json_function.kind
    sku_size                     = var.fdr_xml_to_json_function.sku_size
    maximum_elastic_worker_count = var.fdr_xml_to_json_function.maximum_elastic_worker_count
    worker_count                 = 1
    zone_balancing_enabled       = false
  }

  storage_account_name = replace(format("%s-xml-2-json-sa", local.project), "-", "")

  storage_account_info = var.storage_account_info

  app_settings = local.function_xml_to_json_app_settings

  allowed_subnets = [data.azurerm_subnet.apim_snet.id, data.azurerm_subnet.apim_v2_snet.id]
  allowed_ips     = []

  tags = var.tags
}

module "fdr_xml_to_json_function_slot_staging" {
  count = var.env_short == "p" ? 1 : 0

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot?ref=v6.9.0"

  app_service_plan_id                      = module.fdr_xml_to_json_function.app_service_plan_id
  function_app_id                          = module.fdr_xml_to_json_function.id
  storage_account_name                     = module.fdr_xml_to_json_function.storage_account_name
  storage_account_access_key               = module.fdr_xml_to_json_function.storage_account.primary_access_key
  name                                     = "staging"
  resource_group_name                      = data.azurerm_resource_group.fdr_rg.name
  location                                 = var.location
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key
  always_on                                = var.fdr_xml_to_json_function.always_on
  health_check_path                        = "/info"
  runtime_version                          = "~4"
  subnet_id                                = module.fdr_xml_to_json_function_snet.id

  # App settings
  app_settings = local.function_xml_to_json_app_settings

  docker = {
    image_name        = local.xml_to_json_docker_settings.IMAGE_NAME
    image_tag         = var.fdr_xml_to_json_function_app_image_tag
    registry_url      = local.xml_to_json_docker_settings.DOCKER_REGISTRY_SERVER_URL
    registry_username = null
    registry_password = null
  }

  allowed_subnets = [data.azurerm_subnet.apim_snet.id, data.azurerm_subnet.apim_v2_snet.id]
  allowed_ips     = []

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "fdr_xml_to_json_function" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "${module.fdr_xml_to_json_function.name}-autoscale"
  resource_group_name = data.azurerm_resource_group.fdr_rg.name
  location            = var.location
  target_resource_id  = module.fdr_xml_to_json_function.app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.fdr_xml_to_json_function_autoscale.default
      minimum = var.fdr_xml_to_json_function_autoscale.minimum
      maximum = var.fdr_xml_to_json_function_autoscale.maximum
    }

    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = module.fdr_xml_to_json_function.app_service_plan_id
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
        metric_resource_id = module.fdr_xml_to_json_function.app_service_plan_id
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


