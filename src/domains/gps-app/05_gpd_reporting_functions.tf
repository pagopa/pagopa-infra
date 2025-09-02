data "azurerm_container_registry" "acr" {
  name                = local.acr_name
  resource_group_name = local.acr_resource_group_name
}

resource "azurerm_resource_group" "gpd_rg" {
  name     = format("%s-gpd-rg", local.project)
  location = var.location

  tags = module.tag_config.tags
}

resource "azurerm_app_service_plan" "gpd_reporting_service_plan" {
  name                = format("%s-plan-gpd-reporting", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.gpd_rg.name

  kind     = var.reporting_functions_app_sku.kind
  reserved = var.reporting_functions_app_sku.kind == "Linux" ? true : false

  sku {
    tier     = var.reporting_functions_app_sku.sku_tier
    size     = var.reporting_functions_app_sku.sku_size
    capacity = 1
  }

  tags = module.tag_config.tags
}

locals {
  function_analysis_app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "java"
    // Keepalive fields are all optionals
    FETCH_KEEPALIVE_ENABLED             = "true"
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
    FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
    FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"


    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITE_ENABLE_SYNC_UPDATE_SITE     = true

    # FDR1-FDR3 Integration
    FDR3_APIM_SUBSCRIPTION_KEY  = azurerm_key_vault_secret.fdr3_subscription_key.value
    FDR1_APIM_SUBSCRIPTION_KEY  = azurerm_key_vault_secret.fdr1_subscription_key.value
    FDR1_BASE_URL               = format("https://api.%s.%s/%s/%s", var.apim_dns_zone_prefix, var.external_domain, "fdr-nodo/service-internal", "v1")
    FDR3_BASE_URL               = format("https://api.%s.%s/%s/%s", var.apim_dns_zone_prefix, var.external_domain, "fdr-org/service", "v1")
    FDR3_FLOW_LIST_DEPTH        = "2"
    FDR3_LIST_ELEMENTS_FOR_PAGE = "30000"

    # ACR
    DOCKER_REGISTRY_SERVER_URL      = "https://${data.azurerm_container_registry.acr.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = data.azurerm_container_registry.acr.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = data.azurerm_container_registry.acr.admin_password
  }
}


## Function reporting_analysis
module "reporting_analysis_function" {
  source = "./.terraform/modules/__v3__/function_app"

  resource_group_name  = azurerm_resource_group.gpd_rg.name
  name                 = format("%s-fn-gpd-analysis", local.product_location)
  storage_account_name = replace("${local.product_location}gpdanalysisst", "-", "")
  location             = var.location
  health_check_path    = "/info"
  # dotnet_version    = var.reporting_analysis_dotnet_version
  subnet_id       = module.reporting_function_snet.id
  runtime_version = "~4"
  docker = {
    registry_url      = local.function_analysis_app_settings.DOCKER_REGISTRY_SERVER_URL
    image_name        = var.reporting_analysis_image
    image_tag         = "latest"
    registry_username = local.function_analysis_app_settings.DOCKER_REGISTRY_SERVER_USERNAME
    registry_password = local.function_analysis_app_settings.DOCKER_REGISTRY_SERVER_PASSWORD
  }
  storage_account_info = var.fn_app_storage_account_info
  ## DEDICATED SERVICE PLAN
  #  app_service_plan_name = "${local.project}-plan-analysis-fn"
  #  app_service_plan_info = {
  #    kind = var.reporting_functions_app_sku.kind
  #    sku_tier = var.reporting_functions_app_sku.sku_tier
  #    sku_size = var.reporting_functions_app_sku.sku_size
  #    maximum_elastic_worker_count = null
  #    worker_count                 = 1
  #    zone_balancing_enabled       = false
  #  }
  always_on                                = var.reporting_analysis_function_always_on
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key
  app_service_plan_id                      = azurerm_app_service_plan.gpd_reporting_service_plan.id
  app_settings                             = local.function_analysis_app_settings

  allowed_subnets = [data.azurerm_subnet.apim_snet.id]
  allowed_ips     = []

  tags = module.tag_config.tags

  depends_on = [
    azurerm_app_service_plan.gpd_reporting_service_plan
  ]
}

module "reporting_analysis_function_slot_staging" {
  count = var.env_short == "p" ? 1 : 0

  source = "./.terraform/modules/__v3__/function_app_slot"

  app_service_plan_id                      = azurerm_app_service_plan.gpd_reporting_service_plan.id
  function_app_id                          = module.reporting_analysis_function.id
  storage_account_name                     = module.reporting_analysis_function.storage_account_name
  storage_account_access_key               = module.reporting_analysis_function.storage_account.primary_access_key
  name                                     = "staging"
  resource_group_name                      = azurerm_resource_group.gpd_rg.name
  location                                 = var.location
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  always_on         = var.reporting_analysis_function_always_on
  health_check_path = "/info"
  runtime_version   = "~4"

  # App settings
  app_settings = local.function_analysis_app_settings

  docker = {
    registry_url      = local.function_analysis_app_settings.DOCKER_REGISTRY_SERVER_URL
    image_name        = var.reporting_analysis_image
    image_tag         = "latest"
    registry_username = local.function_analysis_app_settings.DOCKER_REGISTRY_SERVER_USERNAME
    registry_password = local.function_analysis_app_settings.DOCKER_REGISTRY_SERVER_PASSWORD
  }

  allowed_subnets = [data.azurerm_subnet.apim_snet.id]
  allowed_ips     = []
  subnet_id       = module.reporting_function_snet.id

  tags = module.tag_config.tags
}

# autoscaling - reporting_batch & reporting_service & reporting_analysis ( shared service plan )
resource "azurerm_monitor_autoscale_setting" "reporting_function" {
  name                = format("gpd-reporting-autoscale")
  resource_group_name = azurerm_resource_group.gpd_rg.name
  location            = var.location
  target_resource_id  = azurerm_app_service_plan.gpd_reporting_service_plan.id
  enabled             = var.reporting_function

  profile {
    name = "default"

    capacity {
      default = var.reporting_function_autoscale_default
      minimum = var.reporting_function_autoscale_minimum
      maximum = var.reporting_function_autoscale_maximum
    }

    # reporting_analysis on http requests
    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.reporting_analysis_function.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 250
        divide_by_instance_count = false
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
        metric_name              = "Requests"
        metric_resource_id       = module.reporting_analysis_function.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 250
        divide_by_instance_count = false
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
