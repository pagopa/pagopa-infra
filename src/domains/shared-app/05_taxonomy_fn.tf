

data "azurerm_storage_account" "shared_storage_account" {
  name                = replace("${local.project}-sa", "-", "")
  resource_group_name = data.azurerm_resource_group.shared_rg.name
}



locals {
  taxonomy_docker_settings = {
    IMAGE_NAME = "pagopataxonomy"
    # ACR
    DOCKER_REGISTRY_SERVER_URL = "https://${data.azurerm_container_registry.acr.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = data.azurerm_container_registry.acr.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = data.azurerm_container_registry.acr.admin_password
  }

  function_taxonomy_app_settings = {
    linux_fx_version                    = "JAVA|11"
    FUNCTIONS_WORKER_RUNTIME            = "java"
    FUNCTIONS_WORKER_PROCESS_COUNT      = 4
    // Keepalive fields are all optionals
    FETCH_KEEPALIVE_ENABLED             = "true"
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"

    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITE_ENABLE_SYNC_UPDATE_SITE     = true

    DOCKER_REGISTRY_SERVER_URL      = local.taxonomy_docker_settings.DOCKER_REGISTRY_SERVER_URL
    DOCKER_REGISTRY_SERVER_USERNAME = local.taxonomy_docker_settings.DOCKER_REGISTRY_SERVER_USERNAME
    DOCKER_REGISTRY_SERVER_PASSWORD = local.taxonomy_docker_settings.DOCKER_REGISTRY_SERVER_PASSWORD

    CSV_URL                            = "https://drive.google.com/uc?id=1vRg7_hQA_7XNG6qULo_y0t_GXtdnIHKw&export=download"
    STORAGE_ACCOUNT_CONN_STRING        = data.azurerm_storage_account.shared_storage_account.primary_connection_string
    BLOB_CONTAINER_NAME                = "taxonomy"
    JSON_NAME                          = "taxonomy.json" 
  }
}

## Function taxonomy
module "taxonomy_function" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v6.20.0"

  resource_group_name = data.azurerm_resource_group.shared_rg.name
  name                = "${local.project}-taxonomy-fn"

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
    registry_username = local.taxonomy_docker_settings.DOCKER_REGISTRY_SERVER_USERNAME
    registry_password = local.taxonomy_docker_settings.DOCKER_REGISTRY_SERVER_PASSWORD
  }

  client_certificate_mode        = "Optional"

  cors = {
    allowed_origins = []
  }

  app_service_plan_name = "${local.project}-taxonomy-fn-plan"
  app_service_plan_info = {
    kind                         = var.taxonomy_function.kind
    sku_size                     = var.taxonomy_function.sku_size
    maximum_elastic_worker_count = var.taxonomy_function.maximum_elastic_worker_count
    worker_count                 = 1
    zone_balancing_enabled       = false
  }

  storage_account_name = replace(format("%s-taxonomy-sa", local.project), "-", "")

  app_settings = local.function_taxonomy_app_settings

  allowed_subnets = [data.azurerm_subnet.apim_vnet.id]
  allowed_ips     = []

  tags = var.tags
}

module "taxonomy_function_slot_staging" {
  count = var.env_short == "p" ? 1 : 0

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot?ref=v6.9.0"

  app_service_plan_id                      = module.taxonomy_function.app_service_plan_id
  function_app_id                          = module.taxonomy_function.id
  storage_account_name                     = module.taxonomy_function.storage_account_name
  storage_account_access_key               = module.taxonomy_function.storage_account.primary_access_key
  name                                     = "staging"
  resource_group_name                      = data.azurerm_resource_group.shared_rg.name
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
    registry_username = local.taxonomy_docker_settings.DOCKER_REGISTRY_SERVER_USERNAME
    registry_password = local.taxonomy_docker_settings.DOCKER_REGISTRY_SERVER_PASSWORD
  }

  allowed_subnets = [data.azurerm_subnet.apim_vnet.id]
  allowed_ips     = []

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "taxonomy_function" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "${module.taxonomy_function.name}-autoscale"
  resource_group_name = data.azurerm_resource_group.shared_rg.name
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


