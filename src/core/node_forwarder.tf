resource "azurerm_resource_group" "node_forwarder_rg" {
  name     = format("%s-node-forwarder-rg", local.project)
  location = var.location

  tags = var.tags
}

# Subnet to host the node forwarder
module "node_forwarder_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.90"
  name                                           = format("%s-node-forwarder-snet", local.project)
  address_prefixes                               = var.cidr_subnet_node_forwarder
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name
  enforce_private_link_endpoint_network_policies = true

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "node_forwarder_app_service" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v2.8.0"

  vnet_integration    = false
  resource_group_name = azurerm_resource_group.node_forwarder_rg.name
  location            = var.location

  # App service plan vars
  plan_name     = format("%s-plan-node-forwarder", local.project)
  plan_kind     = "Linux"
  plan_sku_tier = var.node_forwarder_tier
  plan_sku_size = var.node_forwarder_size
  plan_reserved = true # Mandatory for Linux plan

  # App service plan
  name                = format("%s-app-node-forwarder", local.project)
  client_cert_enabled = false
  always_on           = var.node_forwarder_always_on
  linux_fx_version  = format("DOCKER|%s/pagopanodeforwarder:%s", module.container_registry.login_server, "latest")
  health_check_path = "/node-forwarder/api/v1/info" # TODO verify

  app_settings = {
    # Monitoring
    APPINSIGHTS_INSTRUMENTATIONKEY                  = azurerm_application_insights.application_insights.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING           = format("InstrumentationKey=%s", azurerm_application_insights.application_insights.instrumentation_key)
    APPINSIGHTS_PROFILERFEATURE_VERSION             = "1.0.0"
    APPINSIGHTS_SNAPSHOTFEATURE_VERSION             = "1.0.0"
    APPLICATIONINSIGHTS_CONFIGURATION_CONTENT       = ""
    ApplicationInsightsAgent_EXTENSION_VERSION      = "~3"
    DiagnosticServices_EXTENSION_VERSION            = "~3"
    InstrumentationEngine_EXTENSION_VERSION         = "disabled"
    SnapshotDebugger_EXTENSION_VERSION              = "disabled"
    XDT_MicrosoftApplicationInsights_BaseExtensions = "disabled"
    XDT_MicrosoftApplicationInsights_Mode           = "recommended"
    XDT_MicrosoftApplicationInsights_PreemptSdk     = "disabled"
    WEBSITE_HEALTHCHECK_MAXPINGFAILURES             = 10
    TIMEOUT_DELAY                                   = 300
    # Integration with private DNS (see more: https://docs.microsoft.com/en-us/answers/questions/85359/azure-app-service-unable-to-resolve-hostname-of-vi.html)
    WEBSITE_ADD_SITENAME_BINDINGS_IN_APPHOST_CONFIG = "1"
    WEBSITE_RUN_FROM_PACKAGE                        = "1"
    WEBSITE_VNET_ROUTE_ALL                          = "1"
    WEBSITE_DNS_SERVER                              = "168.63.129.16"
    # Spring Environment
    LOGGING_LEVEL              = var.node_forwarder_logging_level

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 8080
    # WEBSITE_SWAP_WARMUP_PING_PATH       = "/actuator/health"
    # WEBSITE_SWAP_WARMUP_PING_STATUSES   = "200"
    DOCKER_REGISTRY_SERVER_URL      = "https://${module.container_registry.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = module.container_registry.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = module.container_registry.admin_password

  }

  allowed_subnets = [module.apim_snet.id]
  allowed_ips     = []

  subnet_id = module.node_forwarder_snet.id

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "node_forwarder_app_service_autoscale" {
  name                = format("%s-autoscale-node-forwarder", local.project)
  resource_group_name = azurerm_resource_group.node_forwarder_rg.name
  location            = azurerm_resource_group.node_forwarder_rg.location
  target_resource_id  = module.node_forwarder_app_service.plan_id

  profile {
    name = "default"

    capacity {
      default = 1
      minimum = 1
      maximum = 3
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.node_forwarder_app_service.id
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
        metric_resource_id       = module.node_forwarder_app_service.id
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
