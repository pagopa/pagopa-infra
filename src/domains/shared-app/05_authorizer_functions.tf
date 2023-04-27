# Subnet to host authorizer function
module "authorizer_functions_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v4.3.2"
  name                                           = "${local.project}-authorizer-fn-snet"
  address_prefixes                               = [var.cidr_subnet_authorizer_functions]
  resource_group_name                            = local.vnet_resource_group_name
  virtual_network_name                           = data.azurerm_virtual_network.vnet.name
  enforce_private_link_endpoint_network_policies = true

  service_endpoints = [
    "Microsoft.Web",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

data "azurerm_resource_group" "shared_rg" {
  name = "${local.project}-rg"
}

module "authorizer_function_app" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v4.3.2"

  resource_group_name = data.azurerm_resource_group.shared_rg.name
  name                = "${local.project}-authorizer-fn"
  location            = var.location
  health_check_path   = "info"
  subnet_id           = module.authorizer_functions_snet.id
  runtime_version     = "~4"
  os_type             = "linux"
  linux_fx_version    = "DOCKER|${data.azurerm_container_registry.acr.login_server}/pagopaplatformauthorizer:latest"

  system_identity_enabled = true

  always_on                                = var.authorizer_function_always_on
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_name = "${local.project}-plan-authorizer-fn"
  app_service_plan_info = {
    kind                         = var.authorizer_functions_app_sku.kind
    sku_tier                     = var.authorizer_functions_app_sku.sku_tier
    sku_size                     = var.authorizer_functions_app_sku.sku_size
    maximum_elastic_worker_count = 0
  }

  storage_account_name = replace(format("%s-auth-st", local.project), "-", "")

  app_settings = {
    linux_fx_version                    = "JAVA|11"
    FUNCTIONS_WORKER_RUNTIME            = "java"
    FUNCTIONS_WORKER_PROCESS_COUNT      = 4
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITE_ENABLE_SYNC_UPDATE_SITE     = true

    DOCKER_REGISTRY_SERVER_URL      = "https://${data.azurerm_container_registry.acr.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = data.azurerm_container_registry.acr.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = data.azurerm_container_registry.acr.admin_password

    COSMOS_CONN_STRING         = data.azurerm_key_vault_secret.authorizer_cosmos_connection_string.value
    REFRESH_CONFIGURATION_PATH = data.azurerm_key_vault_secret.authorizer_refresh_configuration_url.value
  }

  allowed_subnets = [data.azurerm_subnet.apim_vnet.id]

  allowed_ips = []

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "authorizer_function" {
  count = var.env_short != "d" ? 1 : 0

  name                = "${module.authorizer_function_app.name}-autoscale"
  resource_group_name = data.azurerm_resource_group.shared_rg.name
  location            = var.location
  target_resource_id  = module.authorizer_function_app.app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.authorizer_functions_autoscale.default
      minimum = var.authorizer_functions_autoscale.minimum
      maximum = var.authorizer_functions_autoscale.maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.authorizer_function_app.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 4000
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.authorizer_function_app.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 3000
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT20M"
      }
    }
  }
}

data "azurerm_container_registry" "acr" {
  name                = local.acr_name
  resource_group_name = local.acr_resource_group_name
}
