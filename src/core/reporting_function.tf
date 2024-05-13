resource "azurerm_resource_group" "reporting_fdr_rg" {

  name     = format("%s-reporting-fdr-rg", local.project)
  location = var.location

  tags = var.tags
}

# Subnet to host reporting-fdr function
module "reporting_fdr_function_snet" {
  count                                          = var.cidr_subnet_reporting_fdr != null ? 1 : 0
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.90"
  name                                           = format("%s-reporting-fdr-snet", local.project)
  address_prefixes                               = var.cidr_subnet_reporting_fdr
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

module "reporting_fdr_function" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v2.2.0"

  resource_group_name                      = azurerm_resource_group.reporting_fdr_rg.name
  name                                     = format("%s-fn-reportingfdr", local.project)
  location                                 = var.location
  health_check_path                        = "info"
  subnet_id                                = module.reporting_fdr_function_snet[0].id
  runtime_version                          = "~3"
  os_type                                  = "linux"
  always_on                                = var.reporting_fdr_function_always_on
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key

  storage_account_info = var.reporting_fdr_storage_account_info

  app_service_plan_info = {
    kind                         = var.reporting_fdr_function_kind
    sku_tier                     = var.reporting_fdr_function_sku_tier
    sku_size                     = var.reporting_fdr_function_sku_size
    maximum_elastic_worker_count = 0
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
    FLOW_SA_CONNECTION_STRING  = module.fdr_flows_sa.primary_connection_string
    FLOWS_XML_BLOB             = azurerm_storage_container.fdr_rend_flow.name
    EHUB_FDR_CONNECTION_STRING = module.event_hub01.keys["nodo-dei-pagamenti-fdr.nodo-dei-pagamenti-tx"].primary_connection_string
    EHUB_FDR_NAME              = "nodo-dei-pagamenti-fdr"
    OUTPUT_BLOB                = azurerm_storage_container.fdr_rend_flow_out.name

    # acr
    DOCKER_REGISTRY_SERVER_URL      = "https://${module.container_registry.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = module.container_registry.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = module.container_registry.admin_password

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITE_ENABLE_SYNC_UPDATE_SITE     = true

  }

  allowed_subnets = [module.apim_snet.id]

  allowed_ips = []

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "reporting_fdr_function" {

  name                = format("%s-autoscale", module.reporting_fdr_function.name)
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
