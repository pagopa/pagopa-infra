resource "azurerm_resource_group" "reporting_fdr_rg" {

  name     = "${local.product}-reporting-fdr-rg"
  location = var.location

  tags = module.tag_config.tags
}

# Subnet to host reporting-fdr function
module "reporting_fdr_function_snet" {
  count  = var.cidr_subnet_reporting_fdr != null ? 1 : 0
  source = "./.terraform/modules/__v3__/subnet"

  name                                      = "${local.product}-reporting-fdr-snet"
  address_prefixes                          = var.cidr_subnet_reporting_fdr
  resource_group_name                       = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name                      = data.azurerm_virtual_network.vnet.name
  private_endpoint_network_policies_enabled = var.private_endpoint_network_policies_enabled
  service_endpoints                         = ["Microsoft.Storage"]
  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "reporting_fdr_function" {
  source = "./.terraform/modules/__v3__/function_app"

  resource_group_name = azurerm_resource_group.reporting_fdr_rg.name
  name                = "${local.product}-fn-reportingfdr"
  location            = var.location
  health_check_path   = "/api/info"
  subnet_id           = module.reporting_fdr_function_snet[0].id
  # runtime_version fn app is ~3 only in production (temporarily)
  runtime_version                          = var.fn_app_runtime_version
  always_on                                = var.reporting_fdr_function_always_on
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = var.app_service_plan_info

  # Storage account
  storage_account_info = var.reporting_fdr_storage_account_info

  # acr
  docker = {
    image_name        = var.image_name
    image_tag         = var.image_tag
    registry_password = data.azurerm_container_registry.login_server.admin_password
    registry_url      = data.azurerm_container_registry.login_server.login_server
    registry_username = data.azurerm_container_registry.login_server.admin_username
  }

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "java"

    // Keepalive fields are all optionals
    FETCH_KEEPALIVE_ENABLED             = "true"
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
    FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
    FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"

    # custom configuration
    FLOW_SA_CONNECTION_STRING = data.azurerm_storage_account.fdr_flows_sa.primary_connection_string
    FLOWS_XML_BLOB            = data.azurerm_storage_container.fdr_rend_flow.name

    EHUB_FDR_CONNECTION_STRING = data.azurerm_eventhub_authorization_rule.events_03.primary_connection_string
    EHUB_FDR_NAME              = "nodo-dei-pagamenti-fdr"
    OUTPUT_BLOB                = data.azurerm_storage_container.fdr_rend_flow_out.name

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITE_ENABLE_SYNC_UPDATE_SITE     = true

    APP_ENVIRONMENT = var.env

  }

  allowed_subnets = [data.azurerm_subnet.apim_snet.id]

  allowed_ips = []

  tags = module.tag_config.tags
}

resource "azurerm_monitor_autoscale_setting" "reporting_fdr_function" {

  name                = "${module.reporting_fdr_function.name}-autoscale"
  resource_group_name = azurerm_resource_group.reporting_fdr_rg.name
  location            = var.location
  target_resource_id  = module.reporting_fdr_function.app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.reporting_fdr_function_autoscale_default
      minimum = var.reporting_fdr_function_autoscale_minimum
      maximum = var.reporting_fdr_function_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.reporting_fdr_function.id
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
        metric_resource_id       = module.reporting_fdr_function.id
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

