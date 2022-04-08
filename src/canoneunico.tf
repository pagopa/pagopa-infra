resource "azurerm_resource_group" "canoneunico_rg" {
  name     = format("%s-canoneunico-rg", local.project)
  location = var.location

  tags = var.tags
}

# canone unico service plan

resource "azurerm_app_service_plan" "canoneunico_service_plan" {
  name                = format("%s-plan-canoneunico", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.canoneunico_rg.name

  kind     = var.canoneunico_plan_kind
  reserved = var.canoneunico_plan_kind == "Linux" ? true : false

  sku {
    tier = var.canoneunico_plan_sku_tier
    size = var.canoneunico_plan_sku_size
  }

  tags = var.tags
}

# Subnet to host canone unico function
module "canoneunico_function_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-canoneunico-snet", local.project)
  address_prefixes                               = var.cidr_subnet_canoneunico_common
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

## Function canone unico
module "canoneunico_function" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v2.2.0"

  resource_group_name                      = azurerm_resource_group.canoneunico_rg.name
  name                                     = format("%s-fn-canoneunico", local.project)
  location                                 = var.location
  health_check_path                        = "info"
  subnet_id                                = module.canoneunico_function_snet.id
  runtime_version                          = "~3"
  os_type                                  = "linux"
  always_on                                = var.canoneunico_function_always_on
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key
  app_service_plan_id                      = azurerm_app_service_plan.canoneunico_service_plan.id
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
    CU_SA_CONNECTION_STRING    = module.cu_sa.primary_connection_string
    DEBT_POSITIONS_TABLE       = azurerm_storage_table.cu_debtposition_table.name
    ORGANIZATIONS_CONFIG_TABLE = azurerm_storage_table.cu_ecconfig_table.name
    IUVS_TABLE                 = azurerm_storage_table.cu_iuvs_table.name
    DEBT_POSITIONS_QUEUE       = azurerm_storage_queue.cu_debtposition_queue.name
    INPUT_CSV_BLOB             = azurerm_storage_container.in_csv_blob_container.name
    OUTPUT_CSV_BLOB            = azurerm_storage_container.out_csv_blob_container.name
    ERROR_CSV_BLOB             = azurerm_storage_container.err_csv_blob_container.name
    GPD_HOST                   = format("https://api.%s.%s/%s/%s", var.dns_zone_prefix, var.external_domain, "gpd/api", "v1")
    NCRON_SCHEDULE_BATCH       = var.canoneunico_schedule_batch
    IUV_GENERATION_TYPE        = "seq"
    CU_SEGREGATION_CODE        = "47"
    CU_AUX_DIGIT               = "3"
    MAX_ATTEMPTS               = 3
    QUEUE_TIME_TO_LIVE         = 7200                                // 2h
    QUEUE_DELAY                = var.canoneunico_queue_message_delay // 2m

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
    azurerm_app_service_plan.canoneunico_service_plan
  ]
}

# autoscaling
resource "azurerm_monitor_autoscale_setting" "canoneunico_function" {
  name                = format("%s-autoscale", module.canoneunico_function.name)
  resource_group_name = azurerm_resource_group.canoneunico_rg.name
  location            = var.location
  target_resource_id  = azurerm_app_service_plan.canoneunico_service_plan.id

  profile {
    name = "default"

    capacity {
      default = var.canoneunico_function_autoscale_default
      minimum = var.canoneunico_function_autoscale_minimum
      maximum = var.canoneunico_function_autoscale_maximum
    }


    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_app_service_plan.canoneunico_service_plan.id
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
        metric_resource_id = azurerm_app_service_plan.canoneunico_service_plan.id
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

module "cu_sa" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v2.0.13"

  name                       = replace(format("%s-canoneunico-sa", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = "LRS"
  access_tier                = "Hot"
  versioning_name            = "versioning"
  enable_versioning          = var.canoneunico_enable_versioning
  resource_group_name        = azurerm_resource_group.canoneunico_rg.name
  location                   = var.location
  advanced_threat_protection = var.canoneunico_advanced_threat_protection
  allow_blob_public_access   = false

  blob_properties_delete_retention_policy_days = var.canoneunico_delete_retention_days

  tags = var.tags
}


## table#1 storage (EC Config)
resource "azurerm_storage_table" "cu_ecconfig_table" {
  name                 = format("%secconfigtable", module.cu_sa.name)
  storage_account_name = module.cu_sa.name
}

## table#2 storage (Debt Position)
resource "azurerm_storage_table" "cu_debtposition_table" {
  name                 = format("%sdebtpostable", module.cu_sa.name)
  storage_account_name = module.cu_sa.name
}

## table#3 storage (IUVs Table)
resource "azurerm_storage_table" "cu_iuvs_table" {
  name                 = format("%siuvstable", module.cu_sa.name)
  storage_account_name = module.cu_sa.name
}

## queue#1 storage (Debt Position)
resource "azurerm_storage_queue" "cu_debtposition_queue" {
  name                 = format("%sdebtposqueue", module.cu_sa.name)
  storage_account_name = module.cu_sa.name
}

## blob container (Input CSV Blob)
resource "azurerm_storage_container" "in_csv_blob_container" {
  name                  = format("%sincsvcontainer", module.cu_sa.name)
  storage_account_name  = module.cu_sa.name
  container_access_type = "private"
}

## blob container (Output CSV Blob)
resource "azurerm_storage_container" "out_csv_blob_container" {
  name                  = format("%soutcsvcontainer", module.cu_sa.name)
  storage_account_name  = module.cu_sa.name
  container_access_type = "private"
}

## blob container (Error CSV Blob)
resource "azurerm_storage_container" "err_csv_blob_container" {
  name                  = format("%serrcsvcontainer", module.cu_sa.name)
  storage_account_name  = module.cu_sa.name
  container_access_type = "private"
}

##Alert
resource "azurerm_monitor_scheduled_query_rules_alert" "canoneunico_gpd_error" {
  count = var.env_short != "d" ? 1 : 0

  name                = format("%s-gpd-problem-alert", module.canoneunico_function.name)
  resource_group_name = azurerm_resource_group.canoneunico_rg.name
  location            = var.location

  action {
    action_group           = [azurerm_monitor_action_group.email.id, azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = azurerm_application_insights.application_insights.id
  description    = "CU Problem with GPD"
  enabled        = true
  query = format(<<-QUERY
  traces
    | where cloud_RoleName == "%s"
    | order by timestamp desc
    | where message contains "CuCreateDebtPositionFunction"
    | where message contains "Update entity with ERROR status"
  QUERY
    , module.canoneunico_function.name
  )
  severity    = 2
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}


resource "azurerm_monitor_scheduled_query_rules_alert" "canoneunico_parsing_csv_error" {
  count = var.env_short != "d" ? 1 : 0

  name                = format("%s-cu-csv-parsing-alert", module.canoneunico_function.name)
  resource_group_name = azurerm_resource_group.canoneunico_rg.name
  location            = var.location

  action {
    action_group           = [azurerm_monitor_action_group.email.id, azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = azurerm_application_insights.application_insights.id
  description    = "CU CSV parsing problem"
  enabled        = true
  query = format(<<-QUERY
  traces
    | where cloud_RoleName == "%s"
    | order by timestamp desc
    | where message contains "[CuCsvParsingFunction Error] Validation Error"
  QUERY
    , module.canoneunico_function.name
  )
  severity    = 2
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}
