locals {
  pagopa_proxy_config = {
    WEBSITE_NODE_DEFAULT_VERSION = "18.16.0"
    WEBSITE_RUN_FROM_PACKAGE     = "1"
    #WEBSITE_VNET_ROUTE_ALL       = "1"
    WEBSITE_DNS_SERVER = "168.63.129.16"

    # Monitoring
    APPINSIGHTS_INSTRUMENTATIONKEY = data.azurerm_application_insights.application_insights.instrumentation_key

    # proxy-specific env vars
    PAGOPA_HOST                = format("https://api.%s.%s", var.dns_zone_prefix, var.external_domain)
    PAGOPA_PORT                = 443
    PAGOPA_WS_NODO_PER_PSP_URI = "/nodo/nodo-per-psp/v1"
    PAGOPA_WS_NODE_FOR_PSP_URI = "/nodo/node-for-psp/v1"
    PAGOPA_WS_NODE_FOR_IO_URI  = "/nodo/node-for-io/v1"
    NM3_ENABLED                = true
    NODE_CONNECTIONS_CONFIG    = data.azurerm_key_vault_secret.pagopaproxy_node_clients_config.value

    REDIS_DB_URL      = format("redis://%s", data.azurerm_redis_cache.pagopa_proxy_redis.hostname)
    REDIS_DB_PORT     = data.azurerm_redis_cache.pagopa_proxy_redis.ssl_port
    REDIS_DB_PASSWORD = data.azurerm_redis_cache.pagopa_proxy_redis.primary_access_key
    REDIS_USE_CLUSTER = false
  }
  pagopa_proxy_node_version = "18-lts"
}

data "azurerm_key_vault_secret" "pagopaproxy_node_clients_config" {
  name         = "pagopaproxy-node-clients-config"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_resource_group" "pagopa_proxy_rg" {
  name = format("%s-pagopa-proxy-rg", local.parent_project)
}

data "azurerm_redis_cache" "pagopa_proxy_redis" {
  name                = format("%s-pagopa-proxy-redis", local.parent_project)
  resource_group_name = data.azurerm_resource_group.pagopa_proxy_rg.name
}



module "pagopa_proxy_app_service" {
  source = "./.terraform/modules/__v3__/app_service"

  depends_on = [
    module.pagopa_proxy_snet
  ]
  ip_restriction_default_action = var.pagopa_proxy_ip_restriction_default_action
  resource_group_name           = data.azurerm_resource_group.pagopa_proxy_rg.name
  location                      = var.location

  # App service plan vars
  plan_name = format("%s-plan-pagopa-proxy", local.parent_project)
  plan_type = "internal"
  sku_name  = var.pagopa_proxy_plan_sku

  node_version = local.pagopa_proxy_node_version

  vnet_integration = var.pagopa_proxy_vnet_integration

  # App service plan
  name                = format("%s-app-pagopa-proxy", local.parent_project)
  client_cert_enabled = false
  always_on           = var.env_short == "p" ? true : false
  health_check_path   = "/ping"

  # App settings
  app_settings = local.pagopa_proxy_config

  allowed_subnets = [data.azurerm_subnet.apim_snet.id]
  allowed_ips     = []
  subnet_id       = module.pagopa_proxy_snet.id

  tags = module.tag_config.tags
}


module "pagopa_proxy_app_service_slot_staging" {
  count = var.env_short == "p" ? 1 : 0

  source = "./.terraform/modules/__v3__/app_service_slot"

  # App service plan
  #  app_service_plan_id = module.pagopa_proxy_app_service.plan_id
  app_service_id   = module.pagopa_proxy_app_service.id
  app_service_name = module.pagopa_proxy_app_service.name

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
  subnet_id       = module.pagopa_proxy_snet.id

  tags = module.tag_config.tags
}

resource "azurerm_monitor_autoscale_setting" "pagopa_proxy_app_service_autoscale" {
  name                = format("%s-autoscale-pagopa-proxy", local.parent_project)
  resource_group_name = data.azurerm_resource_group.pagopa_proxy_rg.name
  location            = data.azurerm_resource_group.pagopa_proxy_rg.location
  target_resource_id  = module.pagopa_proxy_app_service.plan_id

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
        metric_resource_id       = module.pagopa_proxy_app_service.id
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
        metric_resource_id       = module.pagopa_proxy_app_service.id
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
