# Subnet to host reporting_batch function
module "reporting_function_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-reporting-snet", local.project)
  address_prefixes                               = var.cidr_subnet_reporting_common
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
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v2.7.0"

  resource_group_name                      = azurerm_resource_group.gpd_rg.name
  name                                     = format("%s-fn-gpd-batch", local.project)
  location                                 = var.location
  health_check_path                        = "info"
  subnet_id                                = module.reporting_function_snet.id
  runtime_version                          = "~3"
  os_type                                  = "linux"
  always_on                                = var.reporting_batch_function_always_on
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key
  app_service_plan_id                      = azurerm_app_service_plan.gpd_reporting_service_plan.id
  app_settings = {

locals {
  function_batch_app_settings = {

    FUNCTIONS_WORKER_RUNTIME = "java"
    // Keepalive fields are all optionals
    FETCH_KEEPALIVE_ENABLED             = "true"
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
    FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
    FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"

    # custom configuration
    FLOW_SA_CONNECTION_STRING = module.flows.primary_connection_string
    FLOWS_TABLE               = azurerm_storage_table.reporting_flows_table.name
    FLOWS_QUEUE               = azurerm_storage_queue.reporting_flows_queue.name
    ORGANIZATIONS_QUEUE       = azurerm_storage_queue.reporting_organizations_queue.name
    ORGANIZATIONS_TABLE       = azurerm_storage_table.reporting_organizations_table.name
    # GPD_HOST             = format("https://api.%s.%s/%s/%s",var.dns_zone_prefix, var.external_domain, module.apim_api_gpd_api.path, module.apim_api_gpd_api.api_version )
    GPD_HOST             = format("https://api.%s.%s/%s/%s", var.dns_zone_prefix, var.external_domain, "gpd/api", "v1")
    NODO_HOST            = format("https://api.%s.%s/%s/%s", var.dns_zone_prefix, var.external_domain, azurerm_api_management_api.apim_nodo_per_pa_api_v1.path, azurerm_api_management_api.apim_nodo_per_pa_api_v1.version)
    PAA_ID_INTERMEDIARIO = var.gpd_paa_id_intermediario
    PAA_STAZIONE_INT     = var.gpd_paa_stazione_int
    PAA_PASSWORD         = data.azurerm_key_vault_secret.gpd_paa_pwd.value
    NCRON_SCHEDULE_BATCH = var.gpd_reporting_schedule_batch
    MAX_RETRY_QUEUING    = var.gpd_max_retry_queuing
    QUEUE_RETENTION_SEC  = var.gpd_queue_retention_sec
    QUEUE_DELAY_SEC      = var.gpd_queue_delay_sec

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

  depends_on = [
    azurerm_app_service_plan.gpd_reporting_service_plan
  ]
}

## Function reporting_service
module "reporting_service_function" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v2.7.0"

  resource_group_name = azurerm_resource_group.gpd_rg.name
  name                = format("%s-fn-gpd-service", local.project)
  location            = var.location
  health_check_path   = "info"
  subnet_id           = module.reporting_function_snet.id
  runtime_version     = "~3"
  os_type             = "linux"

  always_on                                = var.reporting_service_function_always_on
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key
  app_service_plan_id                      = azurerm_app_service_plan.gpd_reporting_service_plan.id
  app_settings = {
  function_service_app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "java"
    // Keepalive fields are all optionals
    FETCH_KEEPALIVE_ENABLED             = "true"
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
    FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
    FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"

    # custom configuration
    FLOW_SA_CONNECTION_STRING = module.flows.primary_connection_string
    FLOWS_QUEUE               = azurerm_storage_queue.reporting_flows_queue.name
    OPTIONS_QUEUE             = azurerm_storage_queue.reporting_options_queue.name
    FLOWS_XML_BLOB            = azurerm_storage_container.reporting_flows_container.name
    PAA_ID_INTERMEDIARIO      = var.gpd_paa_id_intermediario
    PAA_STAZIONE_INT          = var.gpd_paa_stazione_int
    PAA_PASSWORD              = data.azurerm_key_vault_secret.gpd_paa_pwd.value
    MAX_RETRY_QUEUING         = var.gpd_max_retry_queuing
    QUEUE_RETENTION_SEC       = var.gpd_queue_retention_sec
    QUEUE_DELAY_SEC           = var.gpd_queue_delay_sec

    # GPD_HOST             = format("https://api.%s.%s/%s/%s",var.dns_zone_prefix, var.external_domain, module.apim_api_gpd_api.path, module.apim_api_gpd_api.api_version )
    GPD_HOST  = format("https://api.%s.%s/%s/%s", var.dns_zone_prefix, var.external_domain, "gpd/api", "v1")
    NODO_HOST = format("https://api.%s.%s/%s/%s", var.dns_zone_prefix, var.external_domain, azurerm_api_management_api.apim_nodo_per_pa_api_v1.path, azurerm_api_management_api.apim_nodo_per_pa_api_v1.version)

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

  depends_on = [
    azurerm_app_service_plan.gpd_reporting_service_plan
  ]
}

## Function reporting_analysis
module "reporting_analysis_function" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v2.7.0"

  resource_group_name = azurerm_resource_group.gpd_rg.name
  name                = format("%s-fn-gpd-analysis", local.project)
  location            = var.location
  health_check_path   = "info"
  subnet_id           = module.reporting_function_snet.id
  runtime_version     = "~3"
  os_type             = "linux"

  always_on                                = var.reporting_analysis_function_always_on
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key
  app_service_plan_id                      = azurerm_app_service_plan.gpd_reporting_service_plan.id
  app_settings = {

  function_analysis_app_settings = {

    FUNCTIONS_WORKER_RUNTIME = "java"
    // Keepalive fields are all optionals
    FETCH_KEEPALIVE_ENABLED             = "true"
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
    FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
    FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"

    # custom configuration
    FLOW_SA_CONNECTION_STRING = module.flows.primary_connection_string
    FLOWS_TABLE               = azurerm_storage_table.reporting_flows_table.name
    FLOWS_CONTAINER           = azurerm_storage_container.reporting_flows_container.name

    # GPD_HOST             = format("https://api.%s.%s/%s/%s",var.dns_zone_prefix, var.external_domain, module.apim_api_gpd_api.path, module.apim_api_gpd_api.api_version )
    GPD_HOST = format("https://api.%s.%s/%s/%s", var.dns_zone_prefix, var.external_domain, "gpd/api", "v1")

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITE_ENABLE_SYNC_UPDATE_SITE     = true

    # ACR
    DOCKER_REGISTRY_SERVER_URL      = "https://${module.acr[0].login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = module.acr[0].admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = module.acr[0].admin_password
  }
}

## Function reporting_batch
module "reporting_batch_function" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v2.2.0"

  resource_group_name                      = azurerm_resource_group.gpd_rg.name
  name                                     = format("%s-fn-gpd-batch", local.project)
  location                                 = var.location
  health_check_path                        = "info"
  subnet_id                                = module.reporting_function_snet.id
  runtime_version                          = "~3"
  os_type                                  = "linux"
  always_on                                = var.reporting_batch_function_always_on
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key
  app_service_plan_id                      = azurerm_app_service_plan.gpd_reporting_service_plan.id
  app_settings                             = local.function_batch_app_settings

  allowed_subnets = [module.apim_snet.id]
  allowed_ips     = []

  tags = var.tags

  depends_on = [
    azurerm_app_service_plan.gpd_reporting_service_plan
  ]
}

module "reporting_batch_function_slot_staging" {
  count = var.env_short == "p" ? 1 : 0

  source = "git::https://github.com/pagopa/azurerm.git//function_app_slot?ref=v2.2.0"

  app_service_plan_id                      = azurerm_app_service_plan.gpd_reporting_service_plan.id
  function_app_name                        = module.reporting_batch_function.name
  function_app_id                          = module.reporting_batch_function.id
  storage_account_name                     = module.reporting_batch_function.storage_account_name
  storage_account_access_key               = module.reporting_batch_function.storage_account.primary_access_key
  os_type                                  = "linux"
  name                                     = "staging"
  resource_group_name                      = azurerm_resource_group.gpd_rg.name
  location                                 = var.location
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key
  always_on                                = var.reporting_batch_function_always_on
  health_check_path                        = "info"

  # App settings
  app_settings = local.function_batch_app_settings

  allowed_subnets = [module.apim_snet.id]
  allowed_ips     = []
  subnet_id       = module.reporting_function_snet.id

  tags = var.tags
}


## Function reporting_service
module "reporting_service_function" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v2.2.0"

  resource_group_name                      = azurerm_resource_group.gpd_rg.name
  name                                     = format("%s-fn-gpd-service", local.project)
  location                                 = var.location
  health_check_path                        = "info"
  subnet_id                                = module.reporting_function_snet.id
  runtime_version                          = "~3"
  os_type                                  = "linux"
  always_on                                = var.reporting_service_function_always_on
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key
  app_service_plan_id                      = azurerm_app_service_plan.gpd_reporting_service_plan.id
  app_settings                             = local.function_service_app_settings

  allowed_subnets = [module.apim_snet.id]
  allowed_ips     = []

  tags = var.tags

  depends_on = [
    azurerm_app_service_plan.gpd_reporting_service_plan
  ]
}


module "reporting_service_function_slot_staging" {
  count = var.env_short == "p" ? 1 : 0

  source = "git::https://github.com/pagopa/azurerm.git//function_app_slot?ref=v2.2.0"

  app_service_plan_id                      = azurerm_app_service_plan.gpd_reporting_service_plan.id
  function_app_name                        = module.reporting_service_function.name
  function_app_id                          = module.reporting_service_function.id
  storage_account_name                     = module.reporting_service_function.storage_account_name
  storage_account_access_key               = module.reporting_service_function.storage_account.primary_access_key
  os_type                                  = "linux"
  name                                     = "staging"
  resource_group_name                      = azurerm_resource_group.gpd_rg.name
  location                                 = var.location
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key
  always_on                                = var.reporting_service_function_always_on
  health_check_path                        = "info"

  # App settings
  app_settings = local.function_service_app_settings

  allowed_subnets = [module.apim_snet.id]
  allowed_ips     = []
  subnet_id       = module.reporting_function_snet.id

  tags = var.tags
}


## Function reporting_analysis
module "reporting_analysis_function" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v2.2.0"

  resource_group_name                      = azurerm_resource_group.gpd_rg.name
  name                                     = format("%s-fn-gpd-analysis", local.project)
  location                                 = var.location
  health_check_path                        = "info"
  subnet_id                                = module.reporting_function_snet.id
  runtime_version                          = "~3"
  os_type                                  = "linux"
  always_on                                = var.reporting_analysis_function_always_on
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key
  app_service_plan_id                      = azurerm_app_service_plan.gpd_reporting_service_plan.id
  app_settings                             = local.function_analysis_app_settings

  allowed_subnets = [module.apim_snet.id]
  allowed_ips     = []

  tags = var.tags

  depends_on = [
    azurerm_app_service_plan.gpd_reporting_service_plan
  ]
}

module "reporting_analysis_function_slot_staging" {
  count = var.env_short == "p" ? 1 : 0

  source = "git::https://github.com/pagopa/azurerm.git//function_app_slot?ref=v2.2.0"

  app_service_plan_id                      = azurerm_app_service_plan.gpd_reporting_service_plan.id
  function_app_name                        = module.reporting_analysis_function.name
  function_app_id                          = module.reporting_analysis_function.id
  storage_account_name                     = module.reporting_analysis_function.storage_account_name
  storage_account_access_key               = module.reporting_analysis_function.storage_account.primary_access_key
  os_type                                  = "linux"
  name                                     = "staging"
  resource_group_name                      = azurerm_resource_group.gpd_rg.name
  location                                 = var.location
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key

  always_on         = var.reporting_analysis_function_always_on
  health_check_path = "info"

  # App settings
  app_settings = local.function_service_app_settings

  allowed_subnets = [module.apim_snet.id]
  allowed_ips     = []
  subnet_id       = module.reporting_function_snet.id

  tags = var.tags
}


# autoscaling
resource "azurerm_monitor_autoscale_setting" "reporting_function" {
  name                = format("%s-autoscale", module.reporting_batch_function.name)
  resource_group_name = azurerm_resource_group.gpd_rg.name
  location            = var.location
  target_resource_id  = azurerm_app_service_plan.gpd_reporting_service_plan.id

  profile {
    name = "default"

    capacity {
      default = var.reporting_function_autoscale_default
      minimum = var.reporting_function_autoscale_minimum
      maximum = var.reporting_function_autoscale_maximum
    }


    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_app_service_plan.gpd_reporting_service_plan.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT1M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
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
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_app_service_plan.gpd_reporting_service_plan.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }

    # rule {
    #   metric_trigger {
    #     metric_name              = "Requests"
    #     metric_resource_id       = module.reporting_batch_function.id
    #     metric_namespace         = "microsoft.web/sites"
    #     time_grain               = "PT1M"
    #     statistic                = "Average"
    #     time_window              = "PT5M"
    #     time_aggregation         = "Average"
    #     operator                 = "GreaterThan"
    #     threshold                = 4000
    #     divide_by_instance_count = false
    #   }

    #   scale_action {
    #     direction = "Increase"
    #     type      = "ChangeCount"
    #     value     = "2"
    #     cooldown  = "PT5M"
    #   }
    # }

    # rule {
    #   metric_trigger {
    #     metric_name              = "Requests"
    #     metric_resource_id       = module.reporting_batch_function.id
    #     metric_namespace         = "microsoft.web/sites"
    #     time_grain               = "PT1M"
    #     statistic                = "Average"
    #     time_window              = "PT5M"
    #     time_aggregation         = "Average"
    #     operator                 = "LessThan"
    #     threshold                = 3000
    #     divide_by_instance_count = false
    #   }

    #   scale_action {
    #     direction = "Decrease"
    #     type      = "ChangeCount"
    #     value     = "1"
    #     cooldown  = "PT20M"
    #   }
    # }

    # rule {
    #   metric_trigger {
    #     metric_name              = "Requests"
    #     metric_resource_id       = module.reporting_service_function.id
    #     metric_namespace         = "microsoft.web/sites"
    #     time_grain               = "PT1M"
    #     statistic                = "Average"
    #     time_window              = "PT5M"
    #     time_aggregation         = "Average"
    #     operator                 = "GreaterThan"
    #     threshold                = 4000
    #     divide_by_instance_count = false
    #   }

    #   scale_action {
    #     direction = "Increase"
    #     type      = "ChangeCount"
    #     value     = "2"
    #     cooldown  = "PT5M"
    #   }
    # }

    # rule {
    #   metric_trigger {
    #     metric_name              = "Requests"
    #     metric_resource_id       = module.reporting_service_function.id
    #     metric_namespace         = "microsoft.web/sites"
    #     time_grain               = "PT1M"
    #     statistic                = "Average"
    #     time_window              = "PT5M"
    #     time_aggregation         = "Average"
    #     operator                 = "LessThan"
    #     threshold                = 3000
    #     divide_by_instance_count = false
    #   }

    #   scale_action {
    #     direction = "Decrease"
    #     type      = "ChangeCount"
    #     value     = "1"
    #     cooldown  = "PT20M"
    #   }
    # }

    # rule {
    #   metric_trigger {
    #     metric_name              = "Requests"
    #     metric_resource_id       = module.reporting_analysis_function.id
    #     metric_namespace         = "microsoft.web/sites"
    #     time_grain               = "PT1M"
    #     statistic                = "Average"
    #     time_window              = "PT5M"
    #     time_aggregation         = "Average"
    #     operator                 = "GreaterThan"
    #     threshold                = 4000
    #     divide_by_instance_count = false
    #   }

    #   scale_action {
    #     direction = "Increase"
    #     type      = "ChangeCount"
    #     value     = "2"
    #     cooldown  = "PT5M"
    #   }
    # }

    # rule {
    #   metric_trigger {
    #     metric_name              = "Requests"
    #     metric_resource_id       = module.reporting_analysis_function.id
    #     metric_namespace         = "microsoft.web/sites"
    #     time_grain               = "PT1M"
    #     statistic                = "Average"
    #     time_window              = "PT5M"
    #     time_aggregation         = "Average"
    #     operator                 = "LessThan"
    #     threshold                = 3000
    #     divide_by_instance_count = false
    #   }

    #   scale_action {
    #     direction = "Decrease"
    #     type      = "ChangeCount"
    #     value     = "1"
    #     cooldown  = "PT20M"
    #   }
    # }
  }
}

module "flows" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v2.7.0"

  name                       = replace(format("%s-flow-sa", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = "LRS"
  access_tier                = "Hot"
  versioning_name            = "versioning"
  enable_versioning          = var.gpd_enable_versioning
  resource_group_name        = azurerm_resource_group.gpd_rg.name
  location                   = var.location
  advanced_threat_protection = var.gpd_reporting_advanced_threat_protection
  allow_blob_public_access   = false

  blob_properties_delete_retention_policy_days = var.gpd_reporting_delete_retention_days

  tags = var.tags
}


## table#1 storage
resource "azurerm_storage_table" "reporting_organizations_table" {
  name                 = format("%sorgstable", module.flows.name)
  storage_account_name = module.flows.name
}

## table#2 storage
resource "azurerm_storage_table" "reporting_flows_table" {
  name                 = format("%stable", module.flows.name)
  storage_account_name = module.flows.name
}


## queue#1 storage flows
resource "azurerm_storage_queue" "reporting_flows_queue" {
  name                 = format("%squeueflows", module.flows.name)
  storage_account_name = module.flows.name
}

## queue#2 storage organization
resource "azurerm_storage_queue" "reporting_organizations_queue" {
  name                 = format("%squeueorg", module.flows.name)
  storage_account_name = module.flows.name
}

## queue#3 storage flows
resource "azurerm_storage_queue" "reporting_options_queue" {
  name                 = format("%squeueopt", module.flows.name)
  storage_account_name = module.flows.name
}

## blob container flows
resource "azurerm_storage_container" "reporting_flows_container" {
  name                  = format("%sflowscontainer", module.flows.name)
  storage_account_name  = module.flows.name
  container_access_type = "private"
}
