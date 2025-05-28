data "azurerm_resource_group" "taxonomy_rg" {
  name = "${local.project}-${local.taxonomy_label}-rg"
}

data "azurerm_storage_account" "taxonomy_storage_account" {
  name                = replace("${local.project}-${local.taxonomy_label}-sa", "-", "")
  resource_group_name = data.azurerm_resource_group.taxonomy_rg.name
}

locals {
  taxonomy_label = "txnm"
  taxonomy_docker_settings = {
    IMAGE_NAME = "pagopa/pagopa-taxonomy"
    # ACR
    DOCKER_REGISTRY_SERVER_URL = "ghcr.io"
  }

  function_taxonomy_app_settings = {
    linux_fx_version               = "JAVA|11"
    FUNCTIONS_WORKER_RUNTIME       = "java"
    FUNCTIONS_WORKER_PROCESS_COUNT = 4
    // Keepalive fields are all optionals
    FETCH_KEEPALIVE_ENABLED           = "true"
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL = "110000"

    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITE_ENABLE_SYNC_UPDATE_SITE     = true

    DOCKER_REGISTRY_SERVER_URL = local.taxonomy_docker_settings.DOCKER_REGISTRY_SERVER_URL

    STORAGE_ACCOUNT_CONN_STRING = data.azurerm_storage_account.taxonomy_storage_account.primary_connection_string
    BLOB_CONTAINER_NAME_INPUT   = "input"
    CSV_NAME                    = "taxonomy.csv"
    BLOB_CONTAINER_NAME_OUTPUT  = "output"
    JSON_NAME                   = "taxonomy.json"
  }
}

## Function taxonomy
module "taxonomy_function" {
  source = "./.terraform/modules/__v3__/function_app"

  resource_group_name = data.azurerm_resource_group.taxonomy_rg.name
  name                = "${local.project}-${local.taxonomy_label}-fn"

  location          = var.location
  health_check_path = "/info"
  subnet_id         = module.taxonomy_function_snet.id
  runtime_version   = "~4"

  system_identity_enabled = true

  always_on = var.taxonomy_function.always_on

  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  docker = {
    image_name        = local.taxonomy_docker_settings.IMAGE_NAME
    image_tag         = var.taxonomy_function_app_image_tag
    registry_url      = local.taxonomy_docker_settings.DOCKER_REGISTRY_SERVER_URL
    registry_username = null
    registry_password = null
  }

  client_certificate_mode = "Optional"

  app_service_plan_name = "${local.project}-${local.taxonomy_label}-fn-plan"
  app_service_plan_info = {
    kind                         = var.taxonomy_function.kind
    sku_size                     = var.taxonomy_function.sku_size
    maximum_elastic_worker_count = var.taxonomy_function.maximum_elastic_worker_count
    worker_count                 = 1
    zone_balancing_enabled       = false
  }

  storage_account_name = replace(format("%s-${local.taxonomy_label}-fn-sa", local.project), "-", "")
  storage_account_info = {
    account_kind                      = "StorageV2"
    account_tier                      = "Standard"
    account_replication_type          = var.function_app_storage_account_replication_type
    access_tier                       = "Hot"
    advanced_threat_protection_enable = true
    public_network_access_enabled     = false
    use_legacy_defender_version       = true
  }

  app_settings = local.function_taxonomy_app_settings

  allowed_subnets = [data.azurerm_subnet.apim_vnet.id]
  allowed_ips     = []

  tags = module.tag_config.tags
}

module "taxonomy_function_slot_staging" {
  count = var.env_short == "p" ? 1 : 0

  source = "./.terraform/modules/__v3__/function_app_slot"

  app_service_plan_id                      = module.taxonomy_function.app_service_plan_id
  function_app_id                          = module.taxonomy_function.id
  storage_account_name                     = module.taxonomy_function.storage_account_name
  storage_account_access_key               = module.taxonomy_function.storage_account.primary_access_key
  name                                     = "staging"
  resource_group_name                      = data.azurerm_resource_group.taxonomy_rg.name
  location                                 = var.location
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key
  always_on                                = var.taxonomy_function.always_on
  health_check_path                        = "/info"
  runtime_version                          = "~4"
  subnet_id                                = module.taxonomy_function_snet.id

  # App settings
  app_settings = local.function_taxonomy_app_settings

  docker = {
    image_name        = local.taxonomy_docker_settings.IMAGE_NAME
    image_tag         = var.taxonomy_function_app_image_tag
    registry_url      = local.taxonomy_docker_settings.DOCKER_REGISTRY_SERVER_URL
    registry_username = null
    registry_password = null
  }

  allowed_subnets = [data.azurerm_subnet.apim_vnet.id]
  allowed_ips     = []

  tags = module.tag_config.tags
}

resource "azurerm_monitor_autoscale_setting" "taxonomy_function" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "${module.taxonomy_function.name}-autoscale"
  resource_group_name = data.azurerm_resource_group.taxonomy_rg.name
  location            = var.location
  target_resource_id  = module.taxonomy_function.app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.taxonomy_function_autoscale.default
      minimum = var.taxonomy_function_autoscale.minimum
      maximum = var.taxonomy_function_autoscale.maximum
    }

    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = module.taxonomy_function.app_service_plan_id
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
        metric_resource_id = module.taxonomy_function.app_service_plan_id
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


