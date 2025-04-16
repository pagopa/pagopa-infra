resource "azurerm_resource_group" "ecommerce_functions_rg" {
  name     = format("%s-fn-rg", local.project)
  location = var.location

  tags = var.tags
}

# Subnet to host ecommerce reporting function
module "ecommerce_reporting_functions_snet" {
  source                                        = "./.terraform/modules/__v3__/subnet"
  name                                          = "${local.project}-reporting-fn-snet"
  address_prefixes                              = [var.cidr_subnet_ecommerce_functions]
  resource_group_name                           = local.vnet_resource_group_name
  virtual_network_name                          = data.azurerm_virtual_network.vnet.name
  private_link_service_network_policies_enabled = true

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

module "ecommerce_reporting_function_app" {
  source = "./.terraform/modules/__v3__/function_app"

  resource_group_name = azurerm_resource_group.ecommerce_functions_rg.name
  name                = "${local.project}-reporting-fn"
  location            = var.location
  health_check_path   = "info"
  subnet_id           = module.ecommerce_reporting_functions_snet.id
  runtime_version     = "~4"

  always_on                                = var.ecommerce_function_always_on
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_name = "${local.project}-plan-reporting-fn"
  app_service_plan_info = {
    kind                         = "Linux"
    worker_count                 = 4
    sku_tier                     = var.ecommerce_functions_app_sku.sku_tier
    sku_size                     = var.ecommerce_functions_app_sku.sku_size
    maximum_elastic_worker_count = 0
    zone_balancing_enabled       = true
  }

  storage_account_name = replace("pagopa-${var.env}-${var.location_short}-ecommtx-sa-fn", "-", "")

  app_settings = {
    linux_fx_version         = "JAVA|21"
    FUNCTIONS_WORKER_RUNTIME = "java"
  }

  allowed_subnets = [data.azurerm_subnet.apim_vnet.id]

  allowed_ips = []

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "ecommerce_reporting_function" {
  count = var.env_short != "d" ? 1 : 0

  name                = "${module.ecommerce_reporting_function_app.name}-autoscale"
  resource_group_name = azurerm_resource_group.ecommerce_functions_rg.name
  location            = var.location
  target_resource_id  = module.ecommerce_reporting_function_app.app_service_plan_id

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
        metric_resource_id       = module.ecommerce_reporting_function_app.id
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
        metric_resource_id       = module.ecommerce_reporting_function_app.id
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