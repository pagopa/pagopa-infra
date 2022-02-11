resource "azurerm_resource_group" "reporting_rg" {
  name     = format("%s-reporting-rg", local.project)
  location = var.location

  tags = var.tags
}

# Subnet to host reporting_batch function
module "reporting_batch_function_snet" {
  count                                          = var.cidr_subnet_reporting_batch != null ? 1 : 0
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-reporting-batch-snet", local.project)
  address_prefixes                               = var.cidr_subnet_reporting_batch
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

## Function reporting_batch
module "reporting_batch_function" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v1.0.84"

  resource_group_name                      = azurerm_resource_group.reporting_rg.name
  prefix                                   = var.prefix
  env_short                                = var.env_short
  name                                     = "gpdrbatch"
  location                                 = var.location
  health_check_path                        = "info"
  subnet_out_id                            = module.reporting_batch_function_snet[0].id
  runtime_version                          = "~3"
  always_on                                = var.reporting_batch_function_always_on
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key
  # worker_runtime                           = "java"
  # linux_fx_version  =  format("DOCKER|%s/reporting-batch:%s", module.acr[0].login_server, "latest")


  app_service_plan_info = {
    kind                         = var.reporting_batch_function_kind
    sku_tier                     = var.reporting_batch_function_sku_tier
    sku_size                     = var.reporting_batch_function_sku_size
    maximum_elastic_worker_count = 0
  }

  app_settings = {
    // Keepalive fields are all optionals
    FETCH_KEEPALIVE_ENABLED             = "true"
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
    FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
    FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"

    # custom configuration
    FLOW_SA_CONNECTION_STRING = azurerm_storage_account.flows.primary_connection_string
    FLOWS_TABLE               = azurerm_storage_table.flow.name
    FLOWS_QUEUE               = azurerm_storage_queue.flow.name
    ORGANIZATIONS_QUEUE       = azurerm_storage_queue.organization.name

    GPD_HOST  = "TODO" # azurerm_api_management_api.gpd_api_v1.service_url
    NODO_HOST = azurerm_api_management_api.apim_nodo_per_pa_api_v1.service_url

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITE_ENABLE_SYNC_UPDATE_SITE     = true

    # ACR
    DOCKER_REGISTRY_SERVER_URL      = "https://${module.acr[0].login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = module.acr[0].admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = module.acr[0].admin_password
  }

  allowed_subnets = [module.apim_snet.id]

  allowed_ips = []

  tags = var.tags
}

# autoscaling
resource "azurerm_monitor_autoscale_setting" "reporting_batch_function" {
  name                = format("%s-%s-autoscale", local.project, module.reporting_batch_function.name)
  resource_group_name = azurerm_resource_group.reporting_rg.name
  location            = var.location
  target_resource_id  = module.reporting_batch_function.app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.reporting_batch_function_autoscale_default
      minimum = var.reporting_batch_function_autoscale_minimum
      maximum = var.reporting_batch_function_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.reporting_batch_function.id
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
        metric_resource_id       = module.reporting_batch_function.id
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


# Subnet to host reporting_service function
module "reporting_service_function_snet" {
  count                                          = var.cidr_subnet_reporting_service != null ? 1 : 0
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-reporting-service-snet", local.project)
  address_prefixes                               = var.cidr_subnet_reporting_service
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

## Function reporting_service
module "reporting_service_function" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v1.0.84"

  resource_group_name                      = azurerm_resource_group.reporting_rg.name
  prefix                                   = var.prefix
  env_short                                = var.env_short
  name                                     = "gpdrservice"
  location                                 = var.location
  health_check_path                        = "info"
  subnet_out_id                            = module.reporting_service_function_snet[0].id
  runtime_version                          = "~3"
  always_on                                = var.reporting_service_function_always_on
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key
  # worker_runtime                           = "java"
  # linux_fx_version  =  format("DOCKER|%s/reporting-service:%s", module.acr[0].login_server, "latest")


  app_service_plan_info = {
    kind                         = var.reporting_service_function_kind
    sku_tier                     = var.reporting_service_function_sku_tier
    sku_size                     = var.reporting_service_function_sku_size
    maximum_elastic_worker_count = 0
  }

  app_settings = {
    // Keepalive fields are all optionals
    FETCH_KEEPALIVE_ENABLED             = "true"
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
    FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
    FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"

    # custom configuration
    FLOW_SA_CONNECTION_STRING = azurerm_storage_account.flows.primary_connection_string
    FLOWS_QUEUE               = azurerm_storage_queue.flow.name
    OPTIONS_QUEUE             = azurerm_storage_queue.option.name
    FLOWS_XML_BLOB            = azurerm_storage_container.flow.name

    GPD_HOST  = "TODO" # azurerm_api_management_api.gpd_api_v1.service_url
    NODO_HOST = azurerm_api_management_api.apim_nodo_per_pa_api_v1.service_url

    AUX_DIGIT = 3

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITE_ENABLE_SYNC_UPDATE_SITE     = true

    # ACR
    DOCKER_REGISTRY_SERVER_URL      = "https://${module.acr[0].login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = module.acr[0].admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = module.acr[0].admin_password
  }

  allowed_subnets = [module.apim_snet.id]

  allowed_ips = []

  tags = var.tags
}

# autoscaling
resource "azurerm_monitor_autoscale_setting" "reporting_service_function" {
  name                = format("%s-%s-autoscale", local.project, module.reporting_service_function.name)
  resource_group_name = azurerm_resource_group.reporting_rg.name
  location            = var.location
  target_resource_id  = module.reporting_service_function.app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.reporting_service_function_autoscale_default
      minimum = var.reporting_service_function_autoscale_minimum
      maximum = var.reporting_service_function_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.reporting_service_function.id
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
        metric_resource_id       = module.reporting_service_function.id
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


# Subnet to host reporting_analysis function
module "reporting_analysis_function_snet" {
  count                                          = var.cidr_subnet_reporting_analysis != null ? 1 : 0
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-reporting-analysis-snet", local.project)
  address_prefixes                               = var.cidr_subnet_reporting_analysis
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

## Function reporting_analysis
module "reporting_analysis_function" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v1.0.84"

  resource_group_name                      = azurerm_resource_group.reporting_rg.name
  prefix                                   = var.prefix
  env_short                                = var.env_short
  name                                     = "gpdranalysis"
  location                                 = var.location
  health_check_path                        = "info"
  subnet_out_id                            = module.reporting_analysis_function_snet[0].id
  runtime_version                          = "~3"
  always_on                                = var.reporting_analysis_function_always_on
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key
  # worker_runtime                           = "java"
  # linux_fx_version  =  format("DOCKER|%s/reporting-service:%s", module.acr[0].login_server, "latest")


  app_service_plan_info = {
    kind                         = var.reporting_analysis_function_kind
    sku_tier                     = var.reporting_analysis_function_sku_tier
    sku_size                     = var.reporting_analysis_function_sku_size
    maximum_elastic_worker_count = 0
  }

  app_settings = {
    // Keepalive fields are all optionals
    FETCH_KEEPALIVE_ENABLED             = "true"
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
    FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
    FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"

    # custom configuration
    FLOW_SA_CONNECTION_STRING = azurerm_storage_account.flows.primary_connection_string
    FLOWS_TABLE               = azurerm_storage_table.flow.name
    FLOWS_CONTAINER           = azurerm_storage_container.flow.name

    GPD_HOST  = "TODO" # azurerm_api_management_api.gpd_api_v1.service_url
    NODO_HOST = azurerm_api_management_api.apim_nodo_per_pa_api_v1.service_url

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITE_ENABLE_SYNC_UPDATE_SITE     = true

    # ACR
    DOCKER_REGISTRY_SERVER_URL      = "https://${module.acr[0].login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = module.acr[0].admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = module.acr[0].admin_password
  }

  allowed_subnets = [module.apim_snet.id]

  allowed_ips = []

  tags = var.tags
}

# autoscaling
resource "azurerm_monitor_autoscale_setting" "reporting_analysis_function" {
  name                = format("%s-%s-autoscale", local.project, module.reporting_analysis_function.name)
  resource_group_name = azurerm_resource_group.reporting_rg.name
  location            = var.location
  target_resource_id  = module.reporting_analysis_function.app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.reporting_analysis_function_autoscale_default
      minimum = var.reporting_analysis_function_autoscale_minimum
      maximum = var.reporting_analysis_function_autoscale_maximum
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
        metric_resource_id       = module.reporting_analysis_function.id
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


## Storage Account
resource "azurerm_storage_account" "flows" {
  name                      = replace(format("%s-flow-sa", local.project), "-", "")
  resource_group_name       = azurerm_resource_group.reporting_rg.name
  location                  = var.location
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
  account_tier              = "Standard"

  account_replication_type = "LRS"

  tags = var.tags
}


## table storage
resource "azurerm_storage_table" "flow" {
  name                 = format("%stable", azurerm_storage_account.flows.name)
  storage_account_name = azurerm_storage_account.flows.name
}

## queue storage flows
resource "azurerm_storage_queue" "flow" {
  name                 = format("%squeue", azurerm_storage_account.flows.name)
  storage_account_name = azurerm_storage_account.flows.name
}

## queue storage organization
resource "azurerm_storage_queue" "organization" {
  name                 = format("%squeue", azurerm_storage_account.flows.name)
  storage_account_name = azurerm_storage_account.flows.name
}

## queue storage flows
resource "azurerm_storage_queue" "option" {
  name                 = format("%squeue", azurerm_storage_account.flows.name)
  storage_account_name = azurerm_storage_account.flows.name
}

## blob container flows
resource "azurerm_storage_container" "flow" {
  name                  = format("%sflowscontainer", azurerm_storage_account.flows.name)
  storage_account_name  = azurerm_storage_account.flows.name
  container_access_type = "private"
}
