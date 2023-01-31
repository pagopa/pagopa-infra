resource "azurerm_resource_group" "ecommerce_functions_rg" {
  name     = format("%s-ecommerce-fn-rg", local.project)
  location = var.location

  tags = var.tags
}

# Subnet to host ecommerce function
module "ecommerce_function_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v4.3.2"
  name                                           = format("%s-ecommerce-fn-snet", local.project)
  address_prefixes                               = [var.cidr_subnet_ecommerce_functions]
  resource_group_name                            = azurerm_resource_group.ecommerce_functions_rg.name
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

module "ecommerce_function_app" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v4.3.2"

  resource_group_name = azurerm_resource_group.ecommerce_functions_rg.name
  name                = format("%s-fn", local.project)
  location            = var.location
  health_check_path   = "info"
  subnet_id           = module.ecommerce_function_snet.id
  runtime_version     = "~4"
  os_type             = "linux"
  linux_fx_version    = "Java|17"

  always_on                                = var.ecommerce_function_always_on
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_name = format("%s-plan-fn", local.project)
  app_service_plan_info = {
    kind                         = var.ecommerce_functions_app_sku.kind
    sku_tier                     = var.ecommerce_functions_app_sku.sku_tier
    sku_size                     = var.ecommerce_functions_app_sku.sku_size
    maximum_elastic_worker_count = 0
  }

  storage_account_name = replace(format("%s-sa-fn", local.project), "-", "")

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME       = "java"
    FUNCTIONS_WORKER_PROCESS_COUNT = 4

    // Keepalive fields are all optionals
    FETCH_KEEPALIVE_ENABLED             = "true"
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
    FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
    FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"
  }

  allowed_subnets = []

  allowed_ips = []

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "ecommerce_function" {
  count = var.env_short != "d" ? 1 : 0

  name                = format("%s-autoscale", module.ecommerce_function_app.name)
  resource_group_name = azurerm_resource_group.ecommerce_functions_rg.name
  location            = var.location
  target_resource_id  = module.ecommerce_function_app.app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.ecommerce_functions_autoscale.default
      minimum = var.ecommerce_functions_autoscale.minimum
      maximum = var.ecommerce_functions_autoscale.maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.ecommerce_function_app.id
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
        metric_resource_id       = module.ecommerce_function_app.id
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
