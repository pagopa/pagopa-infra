module "pagopa_proxy_app_service_ha" {
  source = "./.terraform/modules/__v3__/app_service"
  count  = var.pagopa_proxy_ha_enabled ? 1 : 0
  depends_on = [
    module.pagopa_proxy_snet_ha
  ]
  ip_restriction_default_action = var.pagopa_proxy_ip_restriction_default_action

  resource_group_name = data.azurerm_resource_group.pagopa_proxy_rg.name
  location            = var.location

  # App service plan vars
  plan_name = format("%s-plan-pagopa-proxy-ha", local.parent_project)
  plan_type = "internal"
  sku_name  = var.pagopa_proxy_plan_sku

  node_version = local.pagopa_proxy_node_version

  zone_balancing_enabled = var.pagopa_proxy_zone_balance_enabled

  vnet_integration = var.pagopa_proxy_vnet_integration

  # App service plan
  name                = format("%s-app-pagopa-proxy-ha", local.parent_project)
  client_cert_enabled = false
  always_on           = var.env_short == "p" ? true : false
  health_check_path   = "/ping"

  # App settings
  app_settings = local.pagopa_proxy_config

  allowed_subnets = [data.azurerm_subnet.apim_snet.id]
  allowed_ips     = []
  subnet_id       = module.pagopa_proxy_snet_ha.id

  tags = module.tag_config.tags
}


module "pagopa_proxy_app_service_slot_staging_ha" {
  count = var.env_short == "p" && var.pagopa_proxy_ha_enabled ? 1 : 0

  source = "./.terraform/modules/__v3__/app_service_slot"

  # App service plan
  #  app_service_plan_id = module.pagopa_proxy_app_service.plan_id
  app_service_id   = module.pagopa_proxy_app_service_ha[0].id
  app_service_name = module.pagopa_proxy_app_service_ha[0].name

  # App service
  name                = "staging"
  resource_group_name = data.azurerm_resource_group.pagopa_proxy_rg.name
  location            = data.azurerm_resource_group.pagopa_proxy_rg.location

  always_on = true
  #  linux_fx_version  = "NODE|18-lts"
  health_check_path = "/ping"
  node_version      = local.pagopa_proxy_node_version

  # App settings
  app_settings = local.pagopa_proxy_config

  vnet_integration = var.pagopa_proxy_vnet_integration

  allowed_subnets = [data.azurerm_subnet.apim_snet.id, data.azurerm_subnet.azdoa_snet.id]
  allowed_ips     = []
  subnet_id       = module.pagopa_proxy_snet_ha.id

  tags = module.tag_config.tags
}

resource "azurerm_monitor_autoscale_setting" "pagopa_proxy_app_service_autoscale_ha" {
  count               = var.pagopa_proxy_ha_enabled ? 1 : 0
  name                = format("%s-autoscale-pagopa-proxy-ha", local.parent_project)
  resource_group_name = data.azurerm_resource_group.pagopa_proxy_rg.name
  location            = data.azurerm_resource_group.pagopa_proxy_rg.location
  target_resource_id  = module.pagopa_proxy_app_service_ha[0].plan_id

  profile {
    name = "default"

    capacity {
      default = var.pagopa_proxy_autoscale_default
      minimum = var.pagopa_proxy_autoscale_minimum
      maximum = var.pagopa_proxy_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.pagopa_proxy_app_service_ha[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 3000
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
        metric_resource_id       = module.pagopa_proxy_app_service_ha[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 2500
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
