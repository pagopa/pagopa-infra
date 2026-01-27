resource "azurerm_resource_group" "printit_pdf_engine_app_service_rg" {
  name     = "${local.project}-pdf-engine-rg"
  location = var.location

  tags = module.tag_config.tags
}

data "azurerm_container_registry" "container_registry" {
  name                = "pagopa${var.env_short}itncoreacr"
  resource_group_name = "pagopa-${var.env_short}-itn-acr-rg"
}

################
# node
################

module "printit_pdf_engine_app_service" {
  source = "./.terraform/modules/__v4__/IDH/app_service_webapp"

  count = var.is_feature_enabled.pdf_engine ? 1 : 0

  env                 = var.env
  idh_resource_tier   = var.idh_app_service_resource_tier
  product_name        = var.prefix
  resource_group_name = azurerm_resource_group.printit_pdf_engine_app_service_rg.name
  location            = var.location

  # App service plan
  name                  = "${local.project}-app-pdf-engine"
  app_service_plan_name = "${local.project}-plan-pdf-engine"

  always_on                = var.app_service_pdf_engine_always_on
  docker_image             = "${data.azurerm_container_registry.container_registry.login_server}/pagopapdfengine"
  docker_image_tag         = "latest"
  docker_registry_url      = "https://${data.azurerm_container_registry.container_registry.login_server}"
  docker_registry_username = data.azurerm_container_registry.container_registry.admin_username
  docker_registry_password = data.azurerm_container_registry.container_registry.admin_password

  health_check_path            = "/info"
  health_check_maxpingfailures = 2

  app_settings                 = local.printit_pdf_engine_app_settings
  private_endpoint_dns_zone_id = data.azurerm_private_dns_zone.internal.id

  allowed_subnet_ids = [data.azurerm_subnet.apim_vnet.id]
  allowed_ips        = []

  embedded_subnet = {
    vnet_name    = data.azurerm_virtual_network.vnet.name
    vnet_rg_name = data.azurerm_virtual_network.vnet.resource_group_name
    enabled      = true
  }

  autoscale_settings = {
    max_capacity                  = 1
    scale_up_requests_threshold   = 250
    scale_down_requests_threshold = 150
  }

  tags = module.tag_config.tags
}

module "printit_pdf_engine_slot_staging" {
  count = var.env_short != "d" && var.is_feature_enabled.pdf_engine ? 1 : 0

  source = "./.terraform/modules/__v4__/app_service_slot"

  # App service plan
  # app_service_plan_id = module.printit_pdf_engine_app_service.plan_id
  app_service_id   = module.printit_pdf_engine_app_service[0].id
  app_service_name = module.printit_pdf_engine_app_service[0].name

  # App service
  name                = "staging"
  resource_group_name = azurerm_resource_group.printit_pdf_engine_app_service_rg.name
  location            = var.location

  always_on         = true
  docker_image      = "${data.azurerm_container_registry.container_registry.login_server}/pagopapdfengine"
  docker_image_tag  = "latest"
  health_check_path = "/info"


  # App settings
  app_settings = local.printit_pdf_engine_app_settings

  allowed_subnets = [data.azurerm_subnet.apim_vnet.id]
  allowed_ips     = []
  subnet_id       = data.azurerm_subnet.printit_pdf_engine_app_service_snet[0].id

  tags = module.tag_config.tags
}

resource "azurerm_monitor_autoscale_setting" "autoscale_app_service_printit_pdf_engine_autoscale" {
  count   = var.env_short != "d" && var.is_feature_enabled.pdf_engine ? 1 : 0
  enabled = var.app_service_pdf_engine_autoscale_enabled

  name                = "${local.project}-autoscale-pdf-engine"
  resource_group_name = azurerm_resource_group.printit_pdf_engine_app_service_rg.name
  location            = azurerm_resource_group.printit_pdf_engine_app_service_rg.location
  target_resource_id  = module.printit_pdf_engine_app_service[0].plan_id

  profile {
    name = "default"

    capacity {
      default = 3
      minimum = var.env_short == "p" ? 3 : 1
      maximum = 10
    }

    # Requests
    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.printit_pdf_engine_app_service[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 2000
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
        metric_resource_id       = module.printit_pdf_engine_app_service[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 1000
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT20M"
      }
    }

    # HttpResponseTime

    # Supported metrics for Microsoft.Web/sites
    # 👀 https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-web-sites-metrics
    rule {
      metric_trigger {
        metric_name              = "HttpResponseTime"
        metric_resource_id       = module.printit_pdf_engine_app_service[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 5 #sec
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
        metric_name              = "HttpResponseTime"
        metric_resource_id       = module.printit_pdf_engine_app_service[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 2 #sec
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT20M"
      }
    }

    # CpuPercentage

    # Supported metrics for Microsoft.Web/sites
    # 👀 https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-web-sites-metrics
    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.printit_pdf_engine_app_service[0].plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 75
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
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.printit_pdf_engine_app_service[0].plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 30 #sec
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


###############
#java
###############
module "printit_pdf_engine_app_service_java" {
  source = "./.terraform/modules/__v4__/IDH/app_service_webapp"
  count  = var.is_feature_enabled.pdf_engine ? 1 : 0

  env               = var.env
  idh_resource_tier = var.idh_app_service_resource_tier
  product_name      = var.prefix

  resource_group_name = azurerm_resource_group.printit_pdf_engine_app_service_rg.name
  location            = var.location

  # App service plan
  name                  = "${local.project}-app-pdf-engine-java"
  app_service_plan_name = "${local.project}-plan-pdf-engine-java"

  always_on                = var.app_service_pdf_engine_always_on
  docker_image             = "${data.azurerm_container_registry.container_registry.login_server}/pagopapdfenginejava"
  docker_image_tag         = "latest"
  docker_registry_url      = "https://${data.azurerm_container_registry.container_registry.login_server}"
  docker_registry_username = data.azurerm_container_registry.container_registry.admin_username
  docker_registry_password = data.azurerm_container_registry.container_registry.admin_password

  health_check_path            = "/info"
  health_check_maxpingfailures = 2

  app_settings                 = local.printit_pdf_engine_app_settings_java
  private_endpoint_dns_zone_id = data.azurerm_private_dns_zone.internal.id

  allowed_subnet_ids = [data.azurerm_subnet.apim_vnet.id]
  allowed_ips        = []

  embedded_subnet = {
    vnet_name    = data.azurerm_virtual_network.vnet.name
    vnet_rg_name = data.azurerm_virtual_network.vnet.resource_group_name
    enabled      = true
  }

  autoscale_settings = {
    max_capacity                  = 1
    scale_up_requests_threshold   = 250
    scale_down_requests_threshold = 150
  }

  tags = module.tag_config.tags
}

module "printit_pdf_engine_java_slot_staging" {
  count = var.env_short != "d" && var.is_feature_enabled.pdf_engine ? 1 : 0

  source = "./.terraform/modules/__v4__/app_service_slot"

  # App service plan
  # app_service_plan_id = module.printit_pdf_engine_app_service.plan_id
  app_service_id   = module.printit_pdf_engine_app_service_java[0].id
  app_service_name = module.printit_pdf_engine_app_service_java[0].name

  # App service
  name                = "staging"
  resource_group_name = azurerm_resource_group.printit_pdf_engine_app_service_rg.name
  location            = var.location

  always_on         = true
  docker_image      = "${data.azurerm_container_registry.container_registry.login_server}/pagopapdfenginejava"
  docker_image_tag  = "latest"
  health_check_path = "/info"


  # App settings
  app_settings = local.printit_pdf_engine_app_settings_java

  allowed_subnets = [data.azurerm_subnet.apim_vnet.id]
  allowed_ips     = []
  subnet_id       = data.azurerm_subnet.printit_pdf_engine_app_service_snet[0].id

  tags = module.tag_config.tags


}

resource "azurerm_monitor_autoscale_setting" "autoscale_app_service_printit_pdf_engine_java_autoscale" {
  count = var.env_short != "d" && var.is_feature_enabled.pdf_engine ? 1 : 0


  name                = "${local.project}-autoscale-pdf-engine-java"
  resource_group_name = azurerm_resource_group.printit_pdf_engine_app_service_rg.name
  location            = azurerm_resource_group.printit_pdf_engine_app_service_rg.location
  target_resource_id  = module.printit_pdf_engine_app_service_java[0].plan_id
  enabled             = var.app_service_pdf_engine_autoscale_enabled

  profile {
    name = "default"

    capacity {
      default = 3
      minimum = var.env_short == "p" ? 3 : 1
      maximum = 10
    }

    # Requests
    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.printit_pdf_engine_app_service_java[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 2000
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
        metric_resource_id       = module.printit_pdf_engine_app_service_java[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 1000
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT20M"
      }
    }

    # HttpResponseTime

    # Supported metrics for Microsoft.Web/sites
    # 👀 https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-web-sites-metrics
    rule {
      metric_trigger {
        metric_name              = "HttpResponseTime"
        metric_resource_id       = module.printit_pdf_engine_app_service_java[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 5 #sec
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
        metric_name              = "HttpResponseTime"
        metric_resource_id       = module.printit_pdf_engine_app_service_java[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 2 #sec
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT20M"
      }
    }

    # CpuPercentage

    # Supported metrics for Microsoft.Web/sites
    # 👀 https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-web-sites-metrics
    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.printit_pdf_engine_app_service_java[0].plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 75
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
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.printit_pdf_engine_app_service_java[0].plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 30 #sec
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

moved {
  from = module.printit_pdf_engine_app_service[0].azurerm_linux_web_app.this
  to   = module.printit_pdf_engine_app_service[0].module.main_slot.azurerm_linux_web_app.this
}

moved {
  from = module.printit_pdf_engine_app_service[0].azurerm_service_plan.this[0]
  to   = module.printit_pdf_engine_app_service[0].module.main_slot.azurerm_service_plan.this[0]
}

moved {
  from = module.printit_pdf_engine_app_service_java[0].azurerm_linux_web_app.this
  to   = module.printit_pdf_engine_app_service_java[0].module.main_slot.azurerm_linux_web_app.this
}

moved {
  from = module.printit_pdf_engine_app_service_java[0].azurerm_service_plan.this[0]
  to   = module.printit_pdf_engine_app_service_java[0].module.main_slot.azurerm_service_plan.this[0]
}